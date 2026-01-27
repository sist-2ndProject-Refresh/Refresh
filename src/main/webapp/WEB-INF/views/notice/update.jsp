<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>공지사항 수정</title>
</head>
<body>
    <section id="notice_update" class="py-5" v-if="store.vo && store.vo.not_id">
        <div class="container" style="max-width: 1000px;">
            <h2 class="mb-4">공지사항 수정</h2>
            
            <div class="mb-3">
                <label class="form-label">제목</label>
                <input type="text" class="form-control" v-model="store.vo.not_title" 
                       style="width: 100%; height: 40px; border: 1px solid #ddd; border-radius: 4px; padding: 0 10px;">
            </div>

            <div class="mb-3">
                <label class="form-label">내용</label>
                <textarea class="form-control" rows="15" v-model="store.vo.not_content" 
                          style="width: 100%; border: 1px solid #ddd; border-radius: 4px; padding: 15px; resize: none;"></textarea>
            </div>

            <div class="text-end mt-4 gap-2 d-flex justify-content-end">
                <button @click="store.updateNoticeData()" class="btn btn-primary px-5" 
                        style="padding: 10px 30px; font-weight: 600;">수정완료</button>
                <button onclick="history.back()" class="btn btn-secondary px-5" 
                        style="padding: 10px 30px; font-weight: 600; background-color: #888; border: none;">취소</button>
            </div>
        </div>
    </section>

    <script src="https://cdnjs.cloudflare.com/ajax/libs/vue/3.3.4/vue.global.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/vue-demi/0.14.5/index.iife.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/pinia/2.1.3/pinia.iife.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/axios/1.4.0/axios.min.js"></script>
    
    <script src="/noticejs/noticeUpdateStore.js"></script>

    <script>
    (function() {
        const { createApp, onMounted } = Vue;
        const { createPinia } = Pinia;

        const app = createApp({
            setup() {
                const store = useNoticeUpdateStore();
                
                const params = new URLSearchParams(location.search);
                const no = params.get('no');

                onMounted(() => {
                    if(no) {
                        store.getDetailForUpdate(no);
                    } else {
                        alert("잘못된 접근입니다.");
                        location.href = "/notice/list";
                    }
                });

                return { store };
            }
        });

        const pinia = createPinia();
        app.use(pinia);
        app.mount("#notice_update");
    })();
    </script>
</body>
</html>