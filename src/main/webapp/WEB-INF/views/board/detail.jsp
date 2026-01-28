<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>지역 커뮤니티 상세</title>
<style>
/* 기존 스타일 유지 */
.article-title { font-size: 3.5rem; font-weight: 800; color: #111; letter-spacing: -0.03em; margin-bottom: 15px; word-break: break-all; }
.article-content { font-size: 1.8rem; line-height: 2.0; white-space: pre-wrap; color: #222; letter-spacing: -0.01em; min-height: 500px; padding: 40px 0; }
.info-bar-section { border-bottom: 2px solid #111; padding-bottom: 20px; }
.info-label { letter-spacing: 1px; font-size: 1.1rem; margin-bottom: 4px; color: #888; text-transform: uppercase; font-weight: bold; }
.info-value { font-size: 2.0rem; line-height: 1.2; font-weight: 700; color: #111; }

.reply-section { background-color: #fff; }
.reply-item { transition: background 0.2s; position: relative; }
.reply-item:hover { background-color: #fcfcfc; }

.re-reply-depth { border-left: 2px solid #eee; margin-left: 20px; padding-left: 20px; }
.re-reply-icon { color: #bbb; margin-right: 5px; }

.reply-write-box { background: #f8f9fa; border-radius: 15px; border: 1px solid #eee; margin-top: 15px; }
.reply-textarea { border: none !important; background: transparent !important; resize: none; font-size: 1.4rem; padding: 15px; }
.reply-textarea:focus { box-shadow: none; }
/* 비활성화된 입력창 스타일 추가 */
.reply-textarea:disabled { cursor: not-allowed; color: #aaa; }

.btn-reply-action { font-size: 1.1rem; font-weight: 600; color: #666; text-decoration: none; margin-left: 10px; cursor: pointer; }
.btn-reply-action:hover { color: #000; }

.prev-next-box { border-top: 1px solid #eee; border-bottom: 1px solid #eee; background-color: #f9f9f9; margin-top: 50px; }
.nav-row { display: flex; align-items: center; padding: 15px 25px; }
.nav-row:not(:last-child) { border-bottom: 1px solid #eee; }
.nav-indicator { width: 120px; font-weight: 800; color: #999; font-size: 1.1rem; }
.nav-link-text { color: #333; text-decoration: none; font-weight: 600; font-size: 1.3rem; flex-grow: 1; }
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
                    <div class="article-content">{{ store.vo.content }}</div>
                </div>

                <div class="reply-section mt-5 pt-5 border-top">
                    <h3 class="mb-4" style="font-weight: 800; font-size: 2.2rem;">
                        댓글 <span style="color: #ff2d55;">{{ store.replyList?.length || 0 }}</span>
                    </h3>

                    <div class="reply-list">
                        <div v-for="reply in store.replyList" :key="reply.id" 
                             class="reply-item py-4 border-bottom"
                             :class="{'re-reply-depth': reply.group_tab > 0}">
                            
                            <div class="d-flex justify-content-between align-items-center mb-2">
                                <div>
                                    <span v-if="reply.group_tab > 0" class="re-reply-icon">└</span>
                                    <span style="font-weight: 700; font-size: 1.4rem; margin-right: 15px;">{{ reply.mem_id }}</span>
                                    <span style="color: #bbb; font-size: 1.1rem;">{{ reply.time }}</span>
                                </div>
                                <div>
                                    <span v-if="store.sessionId" class="btn-reply-action" @click="store.toggleReplyInput(reply.id)">답글</span>
                                    
                                    <template v-if="store.sessionId === reply.mem_id">
                                        <span class="btn-reply-action" @click="store.toggleEditInput(reply.id, reply.msg)">수정</span>
                                        <span @click="store.replyDelete(reply.id)" class="btn-reply-action text-danger">삭제</span>
                                    </template>
                                </div>
                            </div>

                            <div v-if="store.editReplyId !== reply.id" style="font-size: 1.5rem; color: #444; line-height: 1.6;">{{ reply.msg }}</div>

                            <div v-if="store.editReplyId === reply.id" class="reply-write-box p-3 shadow-sm">
                                <textarea v-model="store.editReplyMsg" class="form-control reply-textarea" rows="2"></textarea>
                                <div class="text-end px-2 pb-1">
                                    <button @click="store.replyUpdate(reply.id)" class="btn btn-primary btn-sm px-3 me-2">수정완료</button>
                                    <button @click="store.editReplyId = null" class="btn btn-light btn-sm px-3">취소</button>
                                </div>
                            </div>

                            <div v-if="store.openReplyId === reply.id" class="reply-write-box p-3 shadow-sm">
                                <textarea v-model="store.reReplyMsg" class="form-control reply-textarea" rows="2" :placeholder="reply.mem_id + '님에게 답글 남기기...'"></textarea>
                                <div class="text-end px-2 pb-1">
                                    <button @click="store.reReplyInsert(reply.id)" class="btn btn-dark btn-sm px-3">답글 등록</button>
                                </div>
                            </div>
                        </div>

                        <div v-if="!store.replyList || store.replyList.length === 0" class="py-5 text-center text-muted" style="font-size: 1.3rem;">
                            아직 등록된 댓글이 없습니다.
                        </div>
                    </div>

                    <div class="reply-write-box p-3 mb-5 shadow-sm" :style="!store.sessionId ? 'background-color: #f1f3f5;' : ''">
                        <textarea v-model="store.replyMsg" 
                                  class="form-control reply-textarea" 
                                  rows="3" 
                                  :disabled="!store.sessionId"
                                  :placeholder="store.sessionId ? '새로운 댓글을 입력해주세요.' : '댓글을 작성하려면 로그인이 필요합니다.'"></textarea>
                        <div class="text-end px-2 pb-1">
                            <button v-if="store.sessionId" 
                                    @click="store.replyInsert()" 
                                    class="btn btn-dark px-4 py-2" 
                                    style="border-radius: 8px; font-weight: 600;">댓글 등록</button>
                            <button v-else 
                                    disabled 
                                    class="btn btn-secondary px-4 py-2" 
                                    style="border-radius: 8px; font-weight: 600;">로그인 필요</button>
                        </div>
                    </div>
                </div>

                <div class="prev-next-box mt-5">
                    <div class="nav-row" v-if="store.next">
                        <span class="nav-indicator">▲ 다음글</span>
                        <a :href="'/board/detail?no=' + store.next.id" class="nav-link-text">{{ store.next.title }}</a>
                    </div>
                    <div class="nav-row" v-if="store.prev">
                        <span class="nav-indicator">▼ 이전글</span>
                        <a :href="'/board/detail?no=' + store.prev.id" class="nav-link-text">{{ store.prev.title }}</a>
                    </div>
                </div>

                <div class="d-flex justify-content-end mt-5 pt-4 border-top gap-3">
                    <template v-if="store.sessionId === store.vo.mem_id">
                        <a :href="'/board/update?no=' + store.vo.id" class="btn btn-outline-dark px-5 py-3" style="border-radius: 60px; font-size: 1.4rem; font-weight: 600;">수정</a>
                        <button type="button" @click="deleteStore.deleteBoardData(store.vo.id, store.vo.mem_id)" class="btn btn-outline-danger px-5 py-3" style="border-radius: 60px; font-size: 1.4rem; font-weight: 600;">삭제</button>
                    </template>
                    <a href="/board/list" class="btn btn-dark px-5 py-3" style="border-radius: 60px; font-size: 1.4rem; font-weight: 600;">목록으로</a>
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
                    const user = "${sessionScope.username}";
                    store.sessionId = user;
                    deleteStore.sessionId = user; 
                    const no = getNoFromUrl();
                    if(no) store.boardDetail(no);
                });

                watch(() => location.search, () => {
                    const no = getNoFromUrl();
                    if(no) store.boardDetail(no);
                });

                return { store, deleteStore };
            }
        });
        app.use(createPinia()).mount("#board_detail");
    })();
    </script>
</body>
</html>