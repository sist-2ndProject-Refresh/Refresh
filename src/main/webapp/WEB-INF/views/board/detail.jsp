<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>지역 커뮤니티 상세</title>
<style>
.article-title {
    font-size: 3.5rem; 
    font-weight: 800; 
    color: #111; 
    letter-spacing: -0.03em; 
    margin-bottom: 15px;
    word-break: break-all;
}

.article-content {
    font-size: 1.8rem;
    line-height: 2.0;
    white-space: pre-wrap;
    color: #222;
    letter-spacing: -0.01em;
    min-height: 500px;
    padding: 40px 0;
}

.info-bar-section {
    border-bottom: 2px solid #111;
    padding-bottom: 20px;
}

.info-label {
    letter-spacing: 1px; 
    font-size: 1.1rem; 
    margin-bottom: 4px;
    color: #888;
    text-uppercase: true;
    font-weight: bold;
}

.info-value {
    font-size: 2.0rem; 
    line-height: 1.2;
    font-weight: 700;
    color: #111;
}

.prev-next-box {
    border-top: 1px solid #eee;
    border-bottom: 1px solid #eee;
    background-color: #f9f9f9;
    margin-top: 50px;
}
.nav-row {
    display: flex;
    align-items: center;
    padding: 15px 25px;
}
.nav-row:not(:last-child) {
    border-bottom: 1px solid #eee;
}
.nav-indicator {
    width: 120px;
    font-weight: 800;
    color: #999;
    font-size: 1.1rem;
}
.nav-link-text {
    color: #333;
    text-decoration: none;
    font-weight: 600;
    font-size: 1.3rem;
    flex-grow: 1;
}
.nav-link-text:hover {
    text-decoration: underline;
    color: #000;
}
</style>
</head>
<body>
    <section class="breadcrumb-section py-5" id="board_detail" style="background: transparent;">
        <div class="container" style="max-width: 1500px;" v-if="store.vo">
            <div class="row">
                <div class="col-lg-12 text-left px-0">
                    <div class="breadcrumb__text">
                        <h1 class="article-title">{{ store.vo.title }}</h1>
                        <div class="breadcrumb__option" style="font-size: 1.2rem; color: #888;">
                            <span> 
                                <a href="/board/list" class="text-decoration-none text-muted">지역 커뮤니티</a> 
                                &nbsp; > &nbsp; <span class="text-dark">{{ store.vo.region }}</span>
                                &nbsp; > &nbsp; {{ store.vo.category }}
                            </span>
                        </div>
                    </div>
                </div>
            </div>

            <div class="content-wrapper mt-5">
                <div class="info-bar-section mb-5">
                    <div class="d-flex align-items-end px-0">
                        <div class="d-flex align-items-baseline" style="gap: 60px;">
                            <div class="info-item">
                                <div class="info-label">번호</div>
                                <div class="info-value">{{ store.vo.id }}</div>
                            </div>
                            <div class="info-item">
                                <div class="info-label">지역</div>
                                <div class="info-value">{{ store.vo.region || '전국' }}</div>
                            </div>
                            <div class="info-item">
                                <div class="info-label">작성자</div>
                                <div class="info-value">{{ store.vo.mem_id }}</div>
                            </div>
                            <div class="info-item">
                                <div class="info-label">작성일</div>
                                <div class="info-value">{{ store.vo.time ? store.vo.time.split('T')[0] : '-' }}</div>
                            </div>
                        </div>
                        <div class="ms-auto text-end">
                            <div class="info-label">조회수</div>
                            <div class="info-value">{{ store.vo.hit }}</div>
                        </div>
                    </div>
                </div>

                <div class="article-body">
                    <div class="article-content">
                        {{ store.vo.content }}
                    </div>
                </div>

                <div class="prev-next-box">
                    <div class="nav-row" v-if="store.next">
                        <span class="nav-indicator">▲ 다음글</span>
                        <a :href="'/board/detail?no=' + store.next.id" class="nav-link-text">
                            {{ store.next.title }}
                        </a>
                    </div>
                    <div class="nav-row" v-if="store.prev">
                        <span class="nav-indicator">▼ 이전글</span>
                        <a :href="'/board/detail?no=' + store.prev.id" class="nav-link-text">
                            {{ store.prev.title }}
                        </a>
                    </div>
                </div>

                <div class="d-flex justify-content-end mt-5 pt-4 border-top gap-3">
                    <template v-if="store.sessionId === store.vo.mem_id">
                        <a :href="'/board/update?no=' + store.vo.id"
                           class="btn btn-outline-dark px-5 py-3 shadow-sm"
                           style="border-radius: 60px; font-size: 1.4rem; font-weight: 600;">수정</a>
                        
                        <button type="button" 
                           @click="deleteStore.deleteBoardData(store.vo.id, store.vo.mem_id)"
                           class="btn btn-outline-danger px-5 py-3 shadow-sm"
                           style="border-radius: 60px; font-size: 1.4rem; font-weight: 600;">삭제</button>
                    </template>
                    <a href="/board/list" class="btn btn-dark px-5 py-3 shadow-sm"
                       style="border-radius: 60px; font-size: 1.4rem; font-weight: 600;">목록으로</a>
                </div>
            </div>
        </div>
    </section>

    <script src="https://cdnjs.cloudflare.com/ajax/libs/vue/3.3.4/vue.global.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/vue-demi/0.14.5/index.iife.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/pinia/2.1.3/pinia.iife.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/axios/1.4.0/axios.min.js"></script>

    <script src="/boardjs/boardListStore.js"></script>
    <script src="/boardjs/boardDeleteStore.js"></script>

    <script>
    (function() {
        const { createApp, onMounted, watch } = Vue;
        const { createPinia } = Pinia;

        const app = createApp({
            setup() {
                const store = useBoardListStore();
                const deleteStore = useBoardDeleteStore();
                
                const getNoFromUrl = () => new URLSearchParams(location.search).get('no');

                onMounted(() => {
                    const myId = "${sessionScope.username}";
                    store.sessionId = myId;
                    deleteStore.sessionId = myId; 

                    const no = getNoFromUrl();
                    if(no) {
                        store.boardDetail(no);
                    } else {
                        alert("잘못된 접근입니다.");
                        location.href = "/board/list";
                    }
                });

                watch(() => location.search, () => {
                    const no = getNoFromUrl();
                    if(no) store.boardDetail(no);
                });
                
                return { store, deleteStore };
            }
        });

        const pinia = createPinia();
        app.use(pinia);
        app.mount("#board_detail");
    })();
    </script>
</body>
</html>