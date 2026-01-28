<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>지역 커뮤니티 수정하기</title>
</head>
<body>
	<section class="product-details spad" id="board_update">
		<div class="container">
			<div class="row">
				<div class="section-title mb-4">
					<h2 style="font-weight: 800;">게시글 수정하기</h2>
				</div>

				<table class="table" style="border-top: 2px solid #333;"
					v-if="store.vo">
					<tbody>
						<tr>
							<td class="text-center"
								style="vertical-align: middle; background-color: #f9f9f9; font-weight: 700; color: #333; width: 15%;">제목</td>
							<td colspan="3" class="text-left"><input type="text"
								ref="titRef" v-model="store.vo.title"
								style="width: 100%; height: 40px; border: 1px solid #ddd; border-radius: 4px; padding: 0 10px;"
								placeholder="제목을 입력해 주세요"></td>
						</tr>

						<tr>
							<td class="text-center"
								style="vertical-align: middle; background-color: #f9f9f9; font-weight: 700; color: #333;">카테고리</td>
							<td class="text-left"><select v-model="store.vo.category"
								ref="catRef"
								style="width: 100%; height: 40px; border: 1px solid #ddd; border-radius: 4px; padding: 0 10px;">
									<option value="" disabled>카테고리 선택</option>
									<option value="일상/잡담">일상/잡담</option>
									<option value="맛집추천">맛집추천</option>
									<option value="동네소식">동네소식</option>
									<option value="모임/동호회">모임/동호회</option>
							</select></td>
							<td class="text-center"
								style="vertical-align: middle; background-color: #f9f9f9; font-weight: 700; color: #333; width: 15%;">지역</td>
							<td class="text-left"
								style="vertical-align: middle; padding-left: 15px;"><span
								style="font-size: 1.4rem; color: #333;"> {{
									store.vo.region }} </span></td>
						</tr>

						<tr>
							<td class="text-center"
								style="vertical-align: middle; background-color: #f9f9f9; font-weight: 700; color: #333;">내용</td>
							<td colspan="3" class="text-left"><textarea rows="12"
									ref="contRef" v-model="store.vo.content"
									style="width: 100%; border: 1px solid #ddd; border-radius: 4px; padding: 15px; resize: none;"
									placeholder="내용을 입력해 주세요"></textarea></td>
						</tr>

						<tr>
							<td colspan="4" class="text-center"
								style="padding-top: 30px; border-top: none; border-bottom: none;">
								<button class="btn btn-primary"
									style="padding: 10px 30px; font-size: 1rem; font-weight: 600; margin-right: 10px; border-radius: 5px; background-color: #007bff; border: none;"
									@click="store.updateBoardData({titRef, catRef, contRef})">
									수정 완료</button>
								<button class="btn btn-secondary"
									style="padding: 10px 30px; font-size: 1rem; font-weight: 600; border-radius: 5px;"
									@click="history.back()">취소</button>
							</td>
						</tr>
					</tbody>
				</table>
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
	<script src="/boardjs/boardUpdateStore.js"></script>

	<script>
        (function() {
            const { createApp, ref, onMounted } = Vue;
            const { createPinia } = Pinia;

            const app = createApp({
                setup() {
                    const store = useBoardUpdateStore();
                    const titRef = ref(null);
                    const catRef = ref(null); 
                    const contRef = ref(null);

                    onMounted(async () => {
                        const serverSessionId = "${sessionScope.username}";
                        store.sessionId = serverSessionId;

                        const urlParams = new URLSearchParams(window.location.search);
                        const no = urlParams.get('no');
                        
                        if(no) {
                            await store.getDetailForUpdate(no);
                        }
                    });
                    
                    return {
                        store,
                        titRef,
                        catRef,  
                        contRef,
                    }
                }
            });

            const pinia = createPinia();
            app.use(pinia);
            app.mount("#board_update");
        })();
    </script>
</body>
</html>