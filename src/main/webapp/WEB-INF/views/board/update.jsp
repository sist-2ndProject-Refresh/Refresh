<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>지역 커뮤니티 수정</title>
</head>
<body>
    <section class="product-details spad" id="board_update" v-if="store.vo && store.vo.id">
        <div class="container">
            <div class="row">
                <h2 class="mb-4" style="font-weight: 800;">게시글 수정</h2>
                <table class="table" style="border-top: 2px solid #333;">
                    <tbody>
                        <tr>
                            <td class="text-center" style="vertical-align: middle; background-color: #f9f9f9; font-weight: 700; color: #333;">이름</td>
                            <td colspan="3" class="text-left">
                                <input type="text" ref="memRef" v-model="store.vo.mem_id" readonly
                                    style="width: 250px; height: 40px; border: 1px solid #ddd; border-radius: 4px; padding: 0 10px; background-color: #eee;">
                            </td>
                        </tr>

                        <tr>
                            <td class="text-center" style="vertical-align: middle; background-color: #f9f9f9; font-weight: 700; color: #333;">제목</td>
                            <td colspan="3" class="text-left">
                                <input type="text" ref="titRef" v-model="store.vo.title"
                                    style="width: 100%; height: 40px; border: 1px solid #ddd; border-radius: 4px; padding: 0 10px;"
                                    placeholder="제목을 입력해 주세요">
                            </td>
                        </tr>

                        <tr>
                            <td width="15%" class="text-center" style="vertical-align: middle; background-color: #f9f9f9; font-weight: 700; color: #333;">지역 설정</td>
                            <td width="35%" class="text-left">
                                <select v-model="store.vo.region" ref="regRef"
                                    style="width: 100%; height: 40px; border: 1px solid #ddd; border-radius: 4px; padding: 0 10px;">
                                    <option value="">지역을 선택하세요</option>
                                    <option value="서울">서울</option>
                                    <option value="경기/인천">경기/인천</option>
                                    <option value="부산/경상">부산/경상</option>
                                    <option value="대전/충청">대전/충청</option>
                                    <option value="기타 지역">기타 지역</option>
                                </select>
                            </td>
                            <td width="15%" class="text-center" style="vertical-align: middle; background-color: #f9f9f9; font-weight: 700; color: #333;">카테고리</td>
                            <td width="35%" class="text-left">
                                <select v-model="store.vo.category" ref="catRef"
                                    style="width: 100%; height: 40px; border: 1px solid #ddd; border-radius: 4px; padding: 0 10px;">
                                    <option value="">카테고리 선택</option>
                                    <option value="일상/잡담">일상/잡담</option>
                                    <option value="맛집추천">맛집추천</option>
                                    <option value="동네소식">동네소식</option>
                                    <option value="모임/동호회">모임/동호회</option>
                                </select>
                            </td>
                        </tr>

                        <tr>
                            <td class="text-center" style="vertical-align: middle; background-color: #f9f9f9; font-weight: 700; color: #333;">내용</td>
                            <td colspan="3" class="text-left">
                                <textarea rows="12" ref="contRef" v-model="store.vo.content"
                                    style="width: 100%; border: 1px solid #ddd; border-radius: 4px; padding: 15px; resize: none;"
                                    placeholder="내용을 입력해 주세요"></textarea>
                            </td>
                        </tr>

                        <tr>
                            <td colspan="4" class="text-center" style="padding-top: 30px; border-top: none; border-bottom: none;">
                                <button class="btn btn-primary"
                                    style="padding: 10px 30px; font-size: 1rem; font-weight: 600; margin-right: 10px; border-radius: 5px;"
                                    @click="store.updateBoardData({regRef, catRef, titRef, contRef})">수정 완료</button>
                                <button class="btn btn-secondary"
                                    style="padding: 10px 30px; font-size: 1rem; font-weight: 600; border-radius: 5px;"
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
    <script src="/boardjs/boardUpdateStore.js"></script>

    <script>
        const { createApp, ref, onMounted } = Vue;
        const { createPinia } = Pinia;

        const app = createApp({
            setup() {
                const store = useBoardUpdateStore();
                
                const memRef = ref(null); 
                const titRef = ref(null);
                const regRef = ref(null); 
                const catRef = ref(null); 
                const contRef = ref(null);

                const params = new URLSearchParams(location.search);
                const no = params.get('no');

                onMounted(() => {
                    if(no) {
                        store.getDetailForUpdate(no);
                    }
                });
                
                return {
                    store,
                    memRef,
                    titRef,
                    regRef,  
                    catRef,  
                    contRef,
                }
            }
        });

        const pinia = createPinia();
        app.use(pinia);
        app.mount("#board_update");
    </script>
</body>
</html>