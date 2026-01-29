<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>지역 커뮤니티 상세</title>
<style>
:root {
	--point-color: #ff2d55;
	--text-dark: #111;
	--text-gray: #888;
}

body {
	color: var(--text-dark);
}

[v-cloak] {
	display: none;
}

.article-title {
	font-size: 3.5rem;
	font-weight: 800;
	letter-spacing: -0.03em;
	margin-bottom: 15px;
	word-break: break-all;
}

.breadcrumb-text {
	font-size: 1.2rem;
	color: var(--text-gray);
	margin-bottom: 3rem;
}

.info-bar-section {
	border-bottom: 2px solid var(--text-dark);
	padding-bottom: 20px;
	margin-bottom: 3rem;
}

.info-group {
	display: flex;
	align-items: baseline;
	gap: 60px;
}

.info-label {
	font-size: 1.1rem;
	color: #bbb;
	text-transform: uppercase;
	font-weight: bold;
	margin-bottom: 4px;
}

.info-value {
	font-size: 2.0rem;
	font-weight: 700;
}

.article-content {
	font-size: 1.8rem;
	line-height: 2.0;
	white-space: pre-wrap;
	padding: 40px 0;
	min-height: 400px;
}

.interaction-header {
	display: flex;
	align-items: center;
	gap: 30px;
	margin-top: 3rem;
	padding-top: 3rem;
	margin-bottom: 1.5rem;
}

.stat-item {
	display: flex;
	align-items: center;
	font-weight: 800;
	font-size: 2.2rem;
}

.stat-emoji {
	margin-right: 10px;
	line-height: 1;
}

.stat-label {
	line-height: 1;
}

.stat-count {
	color: var(--point-color);
	margin-left: 10px;
	line-height: 1;
}

.btn-like-main {
	padding: 15px 50px;
	border-radius: 50px;
	font-size: 1.6rem;
	font-weight: 700;
	display: flex;
	align-items: center;
	gap: 10px;
	transition: all 0.2s;
	border: 2px solid var(--point-color);
}

.btn-like-outline {
	background: #fff;
	color: var(--point-color);
}

.btn-like-outline:hover {
	background: #fff0f3;
}

.btn-like-filled {
	background: var(--point-color);
	color: #fff;
}

.reply-item {
	position: relative;
	transition: background 0.2s;
	padding: 25px 15px;
	border-bottom: 1px solid #eee;
}

.reply-item:hover {
	background-color: #fcfcfc;
}

.re-reply-depth {
	background-color: #f9f9f9;
	border-radius: 12px;
}

.re-reply-line {
	position: absolute;
	left: -15px;
	top: 0;
	width: 15px;
	height: 25px;
	border-left: 2px solid #ddd;
	border-bottom: 2px solid #ddd;
	border-bottom-left-radius: 8px;
}

.reply-write-box {
	background: #f8f9fa;
	border-radius: 15px;
	border: 1px solid #eee;
	padding: 15px;
	margin-top: 15px;
}

.reply-textarea {
	border: none !important;
	background: transparent !important;
	resize: none;
	font-size: 1.4rem;
	padding: 10px;
}

.btn-reply-action {
	font-size: 1.1rem;
	font-weight: 600;
	color: #666;
	cursor: pointer;
	margin-left: 12px;
	text-decoration: none;
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

.bottom-actions {
	display: flex;
	justify-content: flex-end;
	gap: 15px;
	margin-top: 3rem;
	padding-top: 2rem;
	border-top: 1px solid #eee;
}

.btn-round {
	border-radius: 60px;
	padding: 12px 40px;
	font-size: 1.4rem;
	font-weight: 600;
}
</style>
</head>
<body>
	<section class="py-5" id="board_detail" v-cloak>
		<div class="container" style="max-width: 1500px;" v-if="store.vo">

			<h1 class="article-title">{{ store.vo.title }}</h1>
			<div class="breadcrumb-text">
				<a href="/board/list" class="text-decoration-none text-muted">지역
					커뮤니티</a> > <span class="text-dark">{{ store.vo.region }}</span> > {{
				store.vo.category }}
			</div>

			<div class="info-bar-section">
				<div class="d-flex align-items-end justify-content-between">
					<div class="info-group">
						<div>
							<div class="info-label">번호</div>
							<div class="info-value">{{ store.vo.id }}</div>
						</div>
						<div>
							<div class="info-label">작성자</div>
							<div class="info-value">{{ store.vo.mem_id }}</div>
						</div>
						<div>
							<div class="info-label">작성일</div>
							<div class="info-value">{{ store.vo.time ?
								store.vo.time.split('T')[0] : '-' }}</div>
						</div>
					</div>
					<div class="text-end">
						<div class="info-label">조회수</div>
						<div class="info-value">{{ store.vo.hit }}</div>
					</div>
				</div>
			</div>

			<div class="article-content">{{ store.vo.content }}</div>

			<div class="d-flex justify-content-center py-5 border-bottom">
				<button @click="store.toggleLike(store.vo.id)"
					class="btn btn-like-main"
					:class="store.vo.isLiked === 1 ? 'btn-like-filled' : 'btn-like-outline'">
					<span>👍</span> 좋아요 {{ store.vo.like_cnt || 0 }}
				</button>
			</div>

			<div class="interaction-header">
				<div class="stat-item">
					<span class="stat-emoji">👍</span><span class="stat-label">좋아요</span>
					<span class="stat-count">{{ store.vo.like_cnt || 0 }}</span>
				</div>
				<div class="stat-item">
					<span class="stat-emoji">💬</span><span class="stat-label">댓글</span>
					<span class="stat-count">{{ store.replyList?.length || 0 }}</span>
				</div>
			</div>

			<div v-for="reply in store.replyList" :key="reply.id"
				class="reply-item" :class="{'re-reply-depth': reply.group_tab > 0}"
				:style="{ marginLeft: (reply.group_tab > 5 ? 150 : reply.group_tab * 30) + 'px' }">

				<div v-if="reply.group_tab > 0" class="re-reply-line"></div>

				<div class="d-flex justify-content-between align-items-center mb-2">
					<div>
						<span v-if="reply.group_tab > 0" class="re-reply-icon">ㄴ</span> <span
							style="font-weight: 700; font-size: 1.4rem; margin-right: 15px;">{{
							reply.mem_id }}</span> <span style="color: #bbb; font-size: 1.1rem;">{{
							reply.time }}</span>
					</div>
					<div class="reply-actions">
						<span v-if="store.sessionId" class="btn-reply-action"
							@click="store.toggleReplyInput(reply.id)">답글</span>
						<template v-if="store.sessionId === reply.mem_id">
							<span class="btn-reply-action"
								@click="store.toggleEditInput(reply.id, reply.msg)">수정</span> <span
								class="btn-reply-action text-danger"
								@click="store.replyDelete(reply.id)">삭제</span>
						</template>
					</div>
				</div>

				<div v-if="store.editReplyId !== reply.id"
					style="font-size: 1.5rem; color: #444; line-height: 1.6; word-break: break-all;">
					{{ reply.msg }}</div>

				<div v-if="store.editReplyId === reply.id"
					class="reply-write-box shadow-sm">
					<textarea v-model="store.editReplyMsg"
						class="form-control reply-textarea" rows="2"></textarea>
					<div class="text-end mt-2">
						<button @click="store.replyUpdate(reply.id)"
							class="btn btn-primary btn-sm px-3 me-2">수정완료</button>
						<button @click="store.editReplyId = null"
							class="btn btn-light btn-sm px-3">취소</button>
					</div>
				</div>
				<div v-if="store.openReplyId === reply.id"
					class="reply-write-box shadow-sm">
					<textarea v-model="store.reReplyMsg"
						class="form-control reply-textarea" rows="2"
						:placeholder="reply.mem_id + '님에게 답글 남기기...'"></textarea>
					<div class="text-end mt-2">
						<button @click="store.reReplyInsert(reply.id)"
							class="btn btn-dark btn-sm px-3">답글 등록</button>
					</div>
				</div>
			</div>

			<div class="reply-write-box mb-5 shadow-sm mt-4"
				:style="!store.sessionId ? 'background-color: #f1f3f5;' : ''">
				<textarea v-model="store.replyMsg"
					class="form-control reply-textarea" rows="3"
					:disabled="!store.sessionId"
					:placeholder="store.sessionId ? '새로운 댓글을 입력해주세요.' : '댓글을 작성하려면 로그인이 필요합니다.'"></textarea>
				<div class="text-end mt-2">
					<button v-if="store.sessionId" @click="store.replyInsert()"
						class="btn btn-dark px-4 py-2" style="border-radius: 8px;">댓글
						등록</button>
					<button v-else disabled class="btn btn-secondary px-4 py-2"
						style="border-radius: 8px;">로그인 필요</button>
				</div>
			</div>

			<div class="prev-next-box">
				<div class="nav-row" v-if="store.next">
					<span class="nav-indicator">▲ 다음글</span><a
						:href="'/board/detail?no=' + store.next.id" class="nav-link-text">{{
						store.next.title }}</a>
				</div>
				<div class="nav-row" v-if="store.prev">
					<span class="nav-indicator">▼ 이전글</span><a
						:href="'/board/detail?no=' + store.prev.id" class="nav-link-text">{{
						store.prev.title }}</a>
				</div>
			</div>

			<div class="bottom-actions">
				<template v-if="store.sessionId === store.vo.mem_id">
					<a :href="'/board/update?no=' + store.vo.id"
						class="btn btn-outline-dark btn-round">수정</a>
					<button
						@click="deleteStore.deleteBoardData(store.vo.id, store.vo.mem_id)"
						class="btn btn-outline-danger btn-round">삭제</button>
				</template>
				<a href="/board/list" class="btn btn-dark btn-round">목록으로</a>
			</div>
		</div>
	</section>

	<script
		src="https://cdnjs.cloudflare.com/ajax/libs/vue/3.3.4/vue.global.min.js"></script>
	<script
		src="https://cdnjs.cloudflare.com/ajax/libs/vue-demi/0.14.5/index.iife.js"></script>
	<script
		src="https://cdnjs.cloudflare.com/ajax/libs/pinia/2.1.3/pinia.iife.js"></script>
	<script
		src="https://cdnjs.cloudflare.com/ajax/libs/axios/1.4.0/axios.min.js"></script>
	<script src="/boardjs/boardListStore.js"></script>
	<script src="/boardjs/boardDeleteStore.js"></script>

	<script>
    (function() {
        const { createApp, onMounted, watch } = Vue;
        const { createPinia } = Pinia;
        createApp({
            setup() {
                const store = useBoardListStore();
                const deleteStore = useBoardDeleteStore();
                const getNo = () => new URLSearchParams(location.search).get('no');
                onMounted(() => {
                    store.sessionId = deleteStore.sessionId = "${sessionScope.username}";
                    const no = getNo();
                    if (no) store.boardDetail(no);
                });
                watch(() => location.search, () => {
                    const no = getNo();
                    if (no) store.boardDetail(no);
                });
                return { store, deleteStore };
            }
        }).use(createPinia()).mount("#board_detail");
    })();
    </script>
</body>
</html>