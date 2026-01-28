<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>공지사항 수정</title>
<style>
[v-cloak] {
	display: none;
}

.notice-container {
	max-width: 1100px;
	margin: 40px auto;
	padding: 20px;
}

.form-input-title {
	width: 100%;
	font-size: 1.5rem;
	font-weight: bold;
	padding: 15px;
	border: 1px solid #ddd;
	border-radius: 8px;
	margin-bottom: 20px;
}

.form-textarea {
	width: 100%;
	min-height: 500px;
	font-size: 1.1rem;
	line-height: 1.6;
	padding: 20px;
	border: 1px solid #ddd;
	border-radius: 8px;
	resize: vertical;
}

.btn-group {
	gap: 12px;
	margin-top: 30px;
}

.btn-lg-custom {
	padding: 12px 40px;
	font-weight: 600;
	border-radius: 8px;
}
</style>
</head>
<body>
	<section id="notice_update" class="py-5" v-cloak>
		<div v-if="vo && vo.not_id" class="container notice-container">
			<h2 class="mb-4 fw-bold">공지사항 수정</h2>

			<div class="mb-4">
				<label class="form-label fw-bold">제목</label> <input type="text"
					class="form-input-title" v-model.trim="vo.not_title">
			</div>

			<div class="mb-4">
				<label class="form-label fw-bold">내용</label>
				<textarea class="form-textarea" v-model.trim="vo.not_content"></textarea>
			</div>

			<div class="text-end d-flex justify-content-end btn-group">
				<button @click="handleUpdate" class="btn btn-primary btn-lg-custom">
					수정완료</button>
				<button @click="goBack" class="btn btn-secondary btn-lg-custom">취소</button>
			</div>
		</div>

		<div v-else class="text-center py-5">
			<div class="spinner-border text-primary"></div>
			<p class="mt-2">로딩 중...</p>
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
	<script src="/noticejs/noticeUpdateStore.js"></script>

	<script>
    (function() {
        const { createApp, onMounted, ref } = Vue;
        const { createPinia, storeToRefs } = Pinia;

        const app = createApp({
            setup() {
                const store = useNoticeUpdateStore();
                const { vo } = storeToRefs(store);
                const isSubmitting = ref(false);

                const handleUpdate = async () => {
                    if (!vo.value.not_title || !vo.value.not_content) {
                        alert("제목과 내용을 입력해 주세요.");
                        return;
                    }

                    if (confirm("수정하시겠습니까?")) {
                        isSubmitting.value = true;
                        try {
                            const res = await store.updateNoticeData();
                            if (res === "yes") {
                                alert("수정되었습니다.");
                                location.href = "/notice/list"; 
                            } else {
                                alert("수정 실패");
                            }
                        } catch (e) {
                            alert("오류 발생");
                        } finally {
                            isSubmitting.value = false;
                        }
                    }
                };

                const goBack = () => confirm("취소하시겠습니까?") && history.back();

                onMounted(() => {
                    const no = new URLSearchParams(window.location.search).get('no');
                    no ? store.getDetailForUpdate(no) : (alert("잘못된 접근"), location.href="/notice/list");
                });

                return { vo, handleUpdate, goBack, isSubmitting };
            }
        });

        app.use(createPinia()).mount("#notice_update");
    })();
    </script>
</body>
</html>