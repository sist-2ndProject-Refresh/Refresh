<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>공지사항 등록</title>
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

        .btn-action {
            padding: 10px 30px;
            font-size: 1rem;
            font-weight: 600;
            border-radius: 5px;
        }
    </style>
</head>
<body>
    <section class="product-details spad" id="notice_insert">
        <div class="container">
            <table class="table" style="border-top: 2px solid #333;">
                <tbody>
                    <!-- 제목 -->
                    <tr>
                        <td class="form-label">제목</td>
                        <td colspan="3" class="text-left">
                            <input type="text" v-model="store.not_title" 
                                   class="form-input" placeholder="제목을 입력해 주세요">
                        </td>
                    </tr>

                    <!-- 내용 -->
                    <tr>
                        <td class="form-label">내용</td>
                        <td colspan="3" class="text-left">
                            <textarea rows="12" v-model="store.not_content" 
                                      class="form-textarea" placeholder="내용을 입력해 주세요"></textarea>
                        </td>
                    </tr>

                    <!-- 버튼 -->
                    <tr>
                        <td colspan="4" class="text-center" 
                            style="padding-top: 30px; border-top: none; border-bottom: none;">
                            <button @click="store.noticeInsert()" 
                                    class="btn btn-success btn-action me-2">
                                글 등록하기
                            </button>
                            <button @click="history.back()" 
                                    class="btn btn-secondary btn-action">
                                취소
                            </button>
                        </td>
                    </tr>
                </tbody>
            </table>
        </div>
    </section>

    <script src="https://cdnjs.cloudflare.com/ajax/libs/vue/3.3.4/vue.global.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/vue-demi/0.14.5/index.iife.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/pinia/2.1.3/pinia.iife.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/axios/1.4.0/axios.min.js"></script>
    <script src="/noticejs/noticeInsertStore.js"></script>

    <script>
    (function() {
        const { createApp, onMounted } = Vue;
        const { createPinia } = Pinia;

        createApp({
            setup() {
                const store = useNoticeInsertStore();

                onMounted(() => {
                    store.mem_id = 'admin';
                });

                return { store };
            }
        }).use(createPinia()).mount("#notice_insert");
    })();
    </script>
</body>
</html>
