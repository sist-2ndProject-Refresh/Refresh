<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>지역 커뮤니티 글쓰기</title>
<style>
.form-label {
	vertical-align: middle;
	background-color: #f9f9f9;
	font-weight: 700;
	color: #333;
	text-align: center;
}

.form-input {
	width: 100%;
	height: 40px;
	border: 1px solid #ddd;
	border-radius: 4px;
	padding: 0 10px;
}

.form-textarea {
	width: 100%;
	border: 1px solid #ddd;
	border-radius: 4px;
	padding: 15px;
	resize: none;
}
</style>
</head>
<body>
	<section class="product-details spad" id="board_insert">
		<div class="container">
			<table class="table" style="border-top: 2px solid #333;">
				<tbody>
					<tr>
						<td class="form-label">제목</td>
						<td colspan="3" class="text-left"><input type="text"
							v-model="store.title" class="form-input"
							placeholder="제목을 입력해 주세요"></td>
					</tr>

					<tr>
						<td width="15%" class="form-label">카테고리</td>
						<td width="35%" class="text-left"><select
							v-model="store.category" class="form-input">
								<option value="" disabled selected hidden>카테고리 선택</option>
								<option value="일상/잡담">일상/잡담</option>
								<option value="맛집추천">맛집추천</option>
								<option value="동네소식">동네소식</option>
								<option value="모임/동호회">모임/동호회</option>
						</select></td>
					</tr>

					<tr>
						<td class="form-label">내용</td>
						<td colspan="3" class="text-left"><textarea rows="12"
								v-model="store.content" class="form-textarea"
								placeholder="내용을 입력해 주세요"></textarea></td>
					</tr>

					<tr>
						<td colspan="4" class="text-center"
							style="padding-top: 30px; border-top: none; border-bottom: none;">
							<button class="btn btn-success" @click="store.boardInsert()"
								style="padding: 10px 30px; font-size: 1rem; font-weight: 600; margin-right: 10px; border-radius: 5px;">
								글 등록하기</button>
							<button class="btn btn-secondary" @click="history.back()"
								style="padding: 10px 30px; font-size: 1rem; font-weight: 600; border-radius: 5px;">
								취소</button>
						</td>
					</tr>
				</tbody>
			</table>
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
	<script src="/boardjs/boardInsertStore.js"></script>

	<script>
    (function() {
        const { createApp, onMounted } = Vue;
        const { createPinia } = Pinia;

        createApp({
            setup() {
                const store = useBoardInsertStore();

                onMounted(() => {
                    const sessionId = "${sessionScope.username}";
                    
                    if (sessionId && sessionId !== "null") {
                        store.mem_id = sessionId;
                        store.fetchUserRegion(sessionId);
                    } else {
                        alert("로그인이 필요한 서비스입니다.");
                        location.href = "/member/login";
                    }
                });

                return { store };
            }
        }).use(createPinia()).mount("#board_insert");
    })();
    </script>
</body>
</html>
