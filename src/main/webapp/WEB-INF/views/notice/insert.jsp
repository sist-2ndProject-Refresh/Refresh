<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<section class="product-details spad" id="board_insert">
		<div class="container">
			<div class="row">
				<table class="table" style="border-top: 2px solid #333;">
					<tbody>

						<tr>
							<td class="text-center"
								style="vertical-align: middle; background-color: #f9f9f9; font-weight: 700; color: #333;">이름</td>
							<td colspan="3" class="text-left"><input type="text"
								ref="memRef" v-model="store.mem_id"
								style="width: 250px; height: 40px; border: 1px solid #ddd; border-radius: 4px; padding: 0 10px;"
								placeholder="작성자 이름을 입력하세요"></td>
						</tr>

						<tr>
							<td class="text-center"
								style="vertical-align: middle; background-color: #f9f9f9; font-weight: 700; color: #333;">제목</td>
							<td colspan="3" class="text-left"><input type="text"
								ref="titRef" v-model="store.title"
								style="width: 100%; height: 40px; border: 1px solid #ddd; border-radius: 4px; padding: 0 10px;"
								placeholder="제목을 입력해 주세요"></td>
						</tr>

						<tr>
							<td class="text-center"
								style="vertical-align: middle; background-color: #f9f9f9; font-weight: 700; color: #333;">내용</td>
							<td colspan="3" class="text-left"><textarea rows="12"
									ref="contRef" v-model="store.content"
									style="width: 100%; border: 1px solid #ddd; border-radius: 4px; padding: 15px; resize: none;"
									placeholder="내용을 입력해 주세요"></textarea></td>
						</tr>

						<tr>
							<td colspan="4" class="text-center" style="padding-top: 30px; border-top: none; border-bottom: none;">
								<button class="btn-sm btn-success"
									style="padding: 10px 30px; font-size: 1rem; font-weight: 600; margin-right: 10px; border-radius: 5px;"
									@click="store.boardInsert({regRef, catRef, memRef, titRef, contRef})">글
									등록하기</button>
								<button class="btn-sm btn-info"
									style="padding: 10px 30px; font-size: 1rem; font-weight: 600; background-color: #888; border: none; border-radius: 5px;"
									onclick="javascript:history.back()">취소</button>
							</td>
						</tr>
					</tbody>
				</table>
			</div>
		</div>
	</section>
	<script src="https://unpkg.com/vue@3/dist/vue.global.js"></script>

	<script src="https://unpkg.com/vue-demi@0.14.6/lib/index.iife.js"></script>

	<script src="https://unpkg.com/pinia@2.1.7/dist/pinia.iife.js"></script>

	<script src="https://unpkg.com/axios/dist/axios.min.js"></script>

	<script src="/noticejs/noticeInsertStore.js"></script>
	<script>
    const { createApp, ref } = Vue;
    const { createPinia } = Pinia;


    const pinia = createPinia();

    const app = createApp({
        setup() {
          
            const store = useNoticeInsertStore();
            const memRef = ref(null); 
            const titRef = ref(null);
            const contRef = ref(null);
            
            return {
                store,
                memRef,
                titRef,
                contRef,
            }
        }
    });


    app.use(pinia);
    

    app.mount("#notice_insert");
</script>
</body>
</html>