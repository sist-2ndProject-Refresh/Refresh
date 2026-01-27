<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>공지사항 등록</title>
</head>
<body>
<section class="product-details spad" id="notice_insert">
		<div class="container">
			<div class="row">
				<table class="table" style="border-top: 2px solid #333;">
					<tbody>

						<tr>
							<td class="text-center"
								style="vertical-align: middle; background-color: #f9f9f9; font-weight: 700; color: #333;">제목</td>
							<td colspan="3" class="text-left"> 
                                <input type="text"
								ref="titRef" v-model="store.not_title"
								style="width: 100%; height: 40px; border: 1px solid #ddd; border-radius: 4px; padding: 0 10px;"
								placeholder="제목을 입력해 주세요">
                            </td>
						</tr>

						<tr>
							<td class="text-center"
								style="vertical-align: middle; background-color: #f9f9f9; font-weight: 700; color: #333;">내용</td>
							<td colspan="3" class="text-left">
                                <textarea rows="12"
									ref="contRef" v-model="store.not_content"
									style="width: 100%; border: 1px solid #ddd; border-radius: 4px; padding: 15px; resize: none;"
									placeholder="내용을 입력해 주세요"></textarea>
                            </td>
						</tr>

						<tr>
							<td colspan="4" class="text-center" style="padding-top: 30px; border-top: none; border-bottom: none;">
                                <button class="btn-sm btn-success"
									style="padding: 10px 30px; font-size: 1rem; font-weight: 600; margin-right: 10px; border-radius: 5px;"
									@click="store.noticeInsert({titRef, contRef})">글 등록하기</button>
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
    const { createApp, ref, onMounted } = Vue;
    const { createPinia } = Pinia;

    const app = createApp({
        setup() {
            const store = useNoticeInsertStore();
            const titRef = ref(null);
            const contRef = ref(null);

            onMounted(() => {
                store.mem_id = 'admin';
            });
            
            return {
                store,
                titRef,
                contRef,
            }
        }
    });

    const pinia = createPinia();
    app.use(pinia);
    app.mount("#notice_insert");
</script>
</body>
</html>