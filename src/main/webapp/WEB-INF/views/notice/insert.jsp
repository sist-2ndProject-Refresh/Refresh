<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<section class="breadcrumb-section set-bg"
		data-setbg="../images/breadcrumb.jpg">
		<div class="container">
			<div class="row">
				<div class="col-lg-12 text-left">
					<div class="breadcrumb__text">
						<h1
							style="font-size: 3.5rem; font-weight: 800; color: #111; letter-spacing: -0.03em; margin-bottom: 15px;">
							공지사항</h1>
						<div class="breadcrumb__option"
							style="font-size: 1.2rem; color: #888;">
							<span><a href="/notice/list"
								class="text-decoration-none text-muted">공지사항</a> &nbsp; > &nbsp;
								글 작성</span>
						</div>
					</div>
				</div>
			</div>
		</div>
	</section>
	<section class="product-details spad" id="notice_insert">
		<div class="container">
			<div class="row">
				<table class="table">
					<tbody>
						<tr>
							<td width=10% class="text-center">이름</td>
							<td width=90% class="text-left"><input type=text
								ref="memRef" v-model="store.mem_id" size="20"></td>
						</tr>
						<tr>
							<td width=10% class="text-center">제목</td>
							<td width=90% class="text-left"><input type=text
								ref="titRef" v-model="store.not_title" size="60"></td>
						</tr>
						<tr>
							<td width=10% class="text-center">내용</td>
							<td width=90% class="text-left"><textarea rows="10"
									cols="60" ref="contRef" v-model="store.not_content"
									style="resize: none;"></textarea></td>
						</tr>
						<tr>
							<td colspan="2" class="text-center">
								<button class="btn-sm btn-success"
									@click="store.noticeInsert({memRef,titRef,contRef})">글쓰기</button>
								<button class="btn-sm btn-info"
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