<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

<head>
    <meta charset="UTF-8">
    <title>목록</title>
</head>

<body>
    <section class="breadcrumb-section set-bg" data-setbg="../images/breadcrumb.jpg">
        <div class="container">
            <div class="row">
                <div class="col-lg-12 text-left">
                    <h1 style="font-size: 3.5rem; font-weight: 800; color: #111; letter-spacing: -0.03em; margin-bottom: 15px;">
                        지역 커뮤니티</h1>

                    <div class="category-container">
                        <button class="category-item active">전체</button>
                        <button class="category-item">서울</button>
                        <button class="category-item">경기/인천</button>
                        <button class="category-item">부산/경상</button>
                        <button class="category-item">대전/충청</button>
                        <button class="category-item">기타 지역</button>
                    </div>
                    <style>
                        .category-container {
                            display: flex;
                            gap: 12px;
                            flex-wrap: wrap;
                            margin-bottom: 30px;
                            padding: 5px;
                        }

                        .category-item {
                            padding: 12px 24px;
                            border: none;
                            border-radius: 50px;
                            background-color: #f5f5f5;
                            color: #666;
                            font-weight: 700;
                            font-size: 1rem;
                            cursor: pointer;


                            transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
                            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.05);
                            position: relative;
                            overflow: hidden;
                        }

                        .category-item:hover {
                            background-color: #ffffff;
                            color: #111;
                            transform: translateY(-3px) scale(1.05);
                            box-shadow: 0 10px 20px rgba(0, 0, 0, 0.1);
                        }

                        .category-item:active {
                            transform: translateY(-1px) scale(0.95);
                            box-shadow: 0 5px 10px rgba(0, 0, 0, 0.1);
                            transition: all 0.1s;
                        }

                        .category-item.active {
                            background-color: #111;
                            color: #fff;
                            box-shadow: 0 10px 20px rgba(0, 0, 0, 0.2);
                        }
                    </style>
                    <div class="breadcrumb__option d-flex justify-content-between align-items-center" style="font-size: 1.2rem; color: #888;">
                        <span> <a href="/" class="text-decoration-none text-muted">Home</a>
                            &nbsp; > &nbsp; 지역 커뮤니티
                        </span>

                        <div class="d-flex align-items-center">
                            <select class="form-select me-3" v-model="store.selectedCategory" @change="store.changeCategory()" style="width: 80px; border-radius: 500px; font-size: 1.2rem; font-weight: 600; height: 45px; border: 1px solid #ccc;">
                                <option value="전체">전체</option>
                                <option value="일상">일상</option>
                                <option value="질문">질문</option>
                                <option value="맛집">맛집추천</option>
                                <option value="소식">동네소식</option>
                                <option value="모임/동호회">모임/동호회</option>
                            </select> <a href="/board/insert" class="btn btn-dark px-3 py-2 shadow-sm" style="border-radius: 15px; font-size: 1.2rem; font-weight: 600; min-width: 100px; line-height: 2.0;">
                                글 작성 </a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <section class="product-details spad" id="board_list">
        <div class="container">
            <div class="row">
                <table class="table table-hover">
                    <thead>
                        <tr>
                            <th width="5%" class="text-center">번호</th>
                            <th width="40%" class="text-center">제목</th>
                            <th width="5%" class="text-center">이름</th>
                            <th width="10%" class="text-center">작성일</th>
                            <th width="5%" class="text-center">조회수</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr v-for="vo in store.list" :key="vo.id">
                            <!-- v-for: 반복 명령문-->
                            <!-- vo in store.list: store.list에 잇는 데이터 개수만큼 <tr>줄을 반복해서
 				 			찍어내라는 뜻 vo는 반복할 떄 쓰는 임시 이름표이다 -->
                            <!-- :key="vo.not_id"
 				 			:(콜론): 데이터 바인딩을 의미함
 				 			   key: Vue가 각 줄을 식별하기 위한 고유 신분증 글 번호(not_id)를 주로 사용함 -->
                            <td class="text-center">{{vo.id}}</td>
                            <td class="text-left"><a :href="'http://localhost:8080/board/detail?no=' + vo.id">
                                    {{vo.title}} </a></td>
                            <td class="text-center">{{vo.mem_id}}</td>
                            <td class="text-center">{{vo.date}}</td>
                            <td class="text-center">{{vo.hit}}</td>
                        </tr>

                        <tr v-if="store.list.length === 0">
                            <!-- v-if:조건문 -->
                            <td colspan="5" class="text-center">등록된 게시글이 없습니다.</td>
                        </tr>

                        <td colspan="5" class="text-center pt-4"><span @click="store.prev()" style="cursor: pointer"> [이전] </span> <span v-for="page in store.totalpage" :key="page" @click="store.curpage = page; store.dataRecv()" :class="{ 'fw-bold text-dark': store.curpage === page }" style="cursor: pointer; margin: 0 8px;"> {{ page }} </span> <span @click="store.next()" style="cursor: pointer"> [다음] </span></td>
                    </tbody>
                </table>
            </div>
        </div>
    </section>

    <script src="https://cdnjs.cloudflare.com/ajax/libs/vue/3.3.4/vue.global.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/vue-demi/0.14.5/index.iife.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/pinia/2.1.3/pinia.iife.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/axios/1.4.0/axios.min.js"></script>

    <script src="/boardjs/boardListStore.js"></script>

    <script>
        (function() {
            const {
                createApp,
                onMounted
            } = Vue;
            const {
                createPinia
            } = Pinia;

            const app = createApp({
                setup() {

                    const store = useBoardListStore();

                    onMounted(() => {
                        store.dataRecv();
                    });

                    return {
                        store
                    };
                }
            });

            const pinia = createPinia();
            app.use(pinia);
            app.mount("#board_list");
        })();
    </script>
</body>

</html>