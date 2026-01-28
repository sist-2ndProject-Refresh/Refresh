<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>공지사항 상세</title>
    <style>
        .info-label {
            text-transform: uppercase;
            font-weight: bold;
            font-size: 1.1rem;
            margin-bottom: 2px;
            color: #888;
        }

        .info-value {
            font-weight: bold;
            font-size: 2.2rem;
            color: #111;
        }

        .article-content {
            font-size: 2.0rem;
            line-height: 1.8;
            white-space: pre-wrap;
            color: #1a1a1a;
            min-height: 400px;
            padding: 20px 0;
        }

        .nav-label {
            width: 100px;
            font-weight: 800;
            color: #888;
            font-size: 1.1rem;
        }

        .nav-link {
            color: #111;
            font-size: 1.3rem;
            font-weight: 500;
            text-decoration: none;
            transition: 0.2s;
        }

        .nav-link:hover {
            color: #007bff;
        }

        .btn-action {
            border-radius: 15px !important;
            font-size: 1.1rem !important;
            font-weight: 600 !important;
            padding: 8px 25px !important;
            min-width: 100px;
        }
    </style>
</head>
<body>
    <section class="py-5" id="notice_detail">
        <div class="container" style="max-width: 1500px;" v-if="store.vo?.not_id">
            
            <!-- 제목 -->
            <h1 style="font-size: 3.5rem; font-weight: 800; color: #111; letter-spacing: -0.03em; margin-bottom: 15px;">
                {{ store.vo.not_title }}
            </h1>
            <div style="font-size: 1.2rem; color: #888; margin-bottom: 3rem;">
                <a href="/notice/list" class="text-decoration-none text-muted">공지사항</a>
                > {{ store.vo.not_title }}
            </div>

            <!-- 정보 바 -->
            <div class="d-flex align-items-end pb-4 mb-5 border-bottom border-2">
                <div class="d-flex align-items-baseline" style="gap: 80px;">
                    <div>
                        <div class="info-label">번호</div>
                        <div class="info-value">{{ store.vo.not_id }}</div>
                    </div>
                    <div>
                        <div class="info-label">작성자</div>
                        <div class="info-value">{{ store.vo.mem_id }}</div>
                    </div>
                    <div>
                        <div class="info-label">작성일</div>
                        <div class="info-value">{{ store.vo.not_date }}</div>
                    </div>
                </div>
                <div class="ms-auto text-end">
                    <div class="info-label">조회수</div>
                    <div class="info-value">{{ store.vo.view_cnt }}</div>
                </div>
            </div>

            <!-- 본문 -->
            <div class="article-content mb-5">
                {{ store.vo.not_content }}
            </div>

            <!-- 이전글/다음글 -->
            <div class="border-top border-bottom py-4 mb-5">
                <div class="d-flex align-items-center mb-3">
                    <div class="nav-label">이전글 ▲</div>
                    <div v-if="store.prevVo?.not_id">
                        <a :href="'/notice/detail?no=' + store.prevVo.not_id" class="nav-link">
                            {{ store.prevVo.not_title }}
                        </a>
                    </div>
                    <div v-else class="text-muted" style="font-size: 1.2rem;">
                        이전 글이 없습니다.
                    </div>
                </div>
                
                <div class="d-flex align-items-center">
                    <div class="nav-label">다음글 ▼</div>
                    <div v-if="store.nextVo?.not_id">
                        <a :href="'/notice/detail?no=' + store.nextVo.not_id" class="nav-link">
                            {{ store.nextVo.not_title }}
                        </a>
                    </div>
                    <div v-else class="text-muted" style="font-size: 1.2rem;">
                        다음 글이 없습니다.
                    </div>
                </div>
            </div>

            <!-- 버튼 -->
            <div class="d-flex justify-content-end gap-2">
                <c:if test="${sessionScope.username == 'admin'}">
                    <a :href="'/notice/update?no=' + store.vo.not_id" 
                       class="btn btn-outline-dark btn-action">수정</a>
                    <button @click="deleteStore.deleteNoticeData(store.vo.not_id)" 
                            class="btn btn-outline-danger btn-action">삭제</button>
                </c:if>
                <a href="/notice/list" class="btn btn-dark btn-action">목록으로</a>
            </div>
        </div>
    </section>

    <script src="https://cdnjs.cloudflare.com/ajax/libs/vue/3.3.4/vue.global.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/vue-demi/0.14.5/index.iife.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/pinia/2.1.3/pinia.iife.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/axios/1.4.0/axios.min.js"></script>
    <script src="/noticejs/noticeListStore.js"></script>
    <script src="/noticejs/noticeDeleteStore.js"></script>

    <script>
    (function() {
        const { createApp, onMounted } = Vue;
        const { createPinia } = Pinia;

        createApp({
            setup() {
                const store = useNoticeListStore();
                const deleteStore = useNoticeDeleteStore();
                const getNo = () => new URLSearchParams(location.search).get('no');

                onMounted(() => {
                    const no = getNo();
                    if (no) store.noticeDetail(no);
                });

                return { store, deleteStore };
            }
        }).use(createPinia()).mount("#notice_detail");
    })();
    </script>
</body>
</html>
