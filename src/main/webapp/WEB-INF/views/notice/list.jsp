<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>공지사항 목록</title>
<style>
    /* 페이징 스타일 (네가 원한 [이전] 1 2 3 [다음] 스타일) */
    .page-link-custom { cursor: pointer; margin: 0 8px; font-size: 1.1rem; color: #666; text-decoration: none; }
    .page-link-custom.active { font-weight: bold; color: #000 !important; text-decoration: underline; }
    
    .notice-table { border-top: 2px solid #333; }
    
    /* 상단 버튼과 검색바를 양 옆으로 배치 */
    .board-top-bar {
        display: flex;
        justify-content: space-between;
        align-items: center;
        margin-bottom: 15px;
    }
</style>
</head>
<body>
    <section class="breadcrumb-section set-bg" data-setbg="../images/breadcrumb.jpg">
        <div class="container">
            <div class="row">
                <div class="col-lg-12">
                    <h1 style="font-size: 3.5rem; font-weight: 800; color: #111; letter-spacing: -0.03em; margin-bottom: 15px;">공지사항</h1>
                    <div class="breadcrumb__option" style="font-size: 1.2rem; color: #888;">
                        <span><a href="/" class="text-decoration-none text-muted">Home</a> &nbsp; > &nbsp; 공지사항</span>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <section class="product-details spad" id="notice_list">
        <div class="container">
            <div class="board-top-bar">
                <div>
                    <c:if test="${sessionScope.username == 'admin'}">
                        <a href="/notice/insert" class="btn btn-dark px-3 py-2"
                            style="border-radius: 15px; font-size: 1.2rem; font-weight: 600; min-width: 100px; line-height: 2.0;">
                            글 작성 
                        </a>
                    </c:if>
                </div>
                
                <div class="d-flex" style="width: 300px;">
                    <input type="text" v-model="store.fd" @keyup.enter="store.search()" 
                           class="form-control me-1" placeholder="검색어를 입력하세요">
                    <button class="btn btn-secondary" @click="store.search()">검색</button>
                </div>
            </div>

            <div class="row">
                <div class="col-lg-12">
                    <table class="table table-hover notice-table">
                        <thead>
                            <tr class="text-center">
                                <th width="10%">번호</th>
                                <th width="50%">제목</th>
                                <th width="10%">작성자</th>
                                <th width="15%">작성일</th>
                                <th width="15%">조회수</th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr v-for="vo in store.list" :key="vo.not_id" class="text-center align-middle">
                                <td>{{vo.not_id}}</td>
                                <td class="text-left px-3">
                                    <a :href="'/notice/detail?no=' + vo.not_id" class="text-decoration-none text-dark">
                                        {{vo.not_title}} 
                                    </a>
                                </td>
                                <td>{{vo.mem_id}}</td>
                                <td>{{vo.not_date}}</td>
                                <td>{{vo.view_cnt}}</td>
                            </tr>
                            <tr v-if="store.list.length === 0">
                                <td colspan="5" class="py-5 text-center text-muted">등록된 공지사항이 없습니다.</td>
                            </tr>
                        </tbody>
                    </table>
                </div>
            </div>

            <div class="row mt-4" v-if="store.totalpage > 0">
                <div class="col-12 text-center">
                    <span @click="store.prev()" style="cursor: pointer" class="page-link-custom"> [이전] </span> 
                    
                    <span v-for="page in Array.from({length: store.endPage - store.startPage + 1}, (_, i) => store.startPage + i)" 
                        :key="page"
                        @click="store.curpage = page; store.dataRecv()"
                        :class="{ 'active': store.curpage === page }"
                        class="page-link-custom"> {{ page }} </span> 
                        
                    <span @click="store.next()" style="cursor: pointer" class="page-link-custom"> [다음] </span>
                </div>
            </div>
        </div>
    </section>

    <script src="https://cdnjs.cloudflare.com/ajax/libs/vue/3.3.4/vue.global.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/vue-demi/0.14.5/index.iife.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/pinia/2.1.3/pinia.iife.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/axios/1.4.0/axios.min.js"></script>
    <script src="/noticejs/noticeListStore.js"></script>
    <script>
      (function() {
        const { createApp, onMounted } = Vue;
        const { createPinia } = Pinia;
        const app = createApp({
          setup() {
            const store = useNoticeListStore(); 
            onMounted(() => { store.dataRecv(); });
            return { store };
          }
        });
        const pinia = createPinia();
        app.use(pinia);
        app.mount("#notice_list");
      })();
    </script>
</body>
</html>