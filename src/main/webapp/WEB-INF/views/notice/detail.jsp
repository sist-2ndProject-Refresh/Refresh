<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<section class="breadcrumb-section set-bg" data-setbg="../images/breadcrumb.jpg">
        <div class="container">
            <div class="row">
                <div class="col-lg-12 text-left">
                    <div class="breadcrumb__text">
                        <h2>공지사항</h2>
                        <div class="breadcrumb__option">
                           <span>내용보기</span>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>
    <section class="product-details spad" id="notice_detail">			 
        <div class="container">
            <div class="row">
             <table class="table">
              <tbody>
                <tr>
                 <th width=20% class="text-center success">번호</th>
                 <td width=30% class="text-center">{{store.vo.not_id}}</td>
                 <th width=20% class="text-center success">작성일</th>
                 <td width=30% class="text-center">{{store.vo.not_date}}</td>
                </tr>
                <tr>
                 <th width=20% class="text-center success">이름</th>
                 <td width=30% class="text-center">{{store.vo.mem_id}}</td>
                 <th width=20% class="text-center success">조회수</th>
                 <td width=30% class="text-center">{{store.vo.view_cnt}}</td>
                </tr>
                <tr>
                 <th width=20% class="text-center success">제목</th>
                 <td colspan="3" class="text-center">{{store.vo.not_title}}</td>
                </tr>
                <tr>
                 <td colspan="4" class="text-left"
                    valign="top" height="200">
                    <pre style="white-space: pre-wrap;border: none;background-color: white">{{store.vo.not_content}}</pre>
                 </td>
                </tr>
                <tr>
                  <td colspan="4" class="text-right">
                   <a href="/notice/list" class="btn btn-xs btn-success">목록</a>
                  </td>
                </tr>
              </tbody>
             </table>
            </div>
         </div>
     </section>
     
<script src="https://cdnjs.cloudflare.com/ajax/libs/vue/3.3.4/vue.global.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/vue-demi/0.14.5/index.iife.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/pinia/2.1.3/pinia.iife.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/axios/1.4.0/axios.min.js"></script>

<script src="/noticejs/noticeListStore.js"></script>

<script>
  (function() {
    const { createApp, onMounted } = Vue;
    const { createPinia } = Pinia;

    const app = createApp({
      setup() {
        
		   const store=useNoticeListStore()
		   // 전송데이터 읽기 
		   const params=new URLSearchParams(location.search)
		   // location.search: 브라우저 주소창의 ?no=10 같은 뒷부분을 가져온다
		   // URLSearchParams: 이 주소에서 특정 값을 쉽게 꺼내도록 도와주는 도구
		   const no=params.get('no')
		   // 주소창에서 no라는 이름으로 전달된 글 번호를 호출 
		   onMounted(()=>{
			   store.noticeDetail(no)
		   })
		   // onMounted: 화면이 나타자마자 실행하라는 뜻
		   return {
			   store
		   }
      }
    });

    const pinia = createPinia();
    app.use(pinia);
    app.mount("#notice_detail");
  })();
     </script>
</body>
</html>