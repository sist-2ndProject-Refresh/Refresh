// noticeListStore.js
const useNoticeListStore = Pinia.defineStore('notice_list', { // defineStore : 창고를 정의한다
    state: () => ({ // state : 창고 안에 보관할 실제 데이터
        list: [], // 게시글 목록
        curpage: 1, // 현재 페이지
        totalpage: 0, // 전체 페이지
        pageSize: 8, // 아까 매퍼에서 8개씩 가져오기로 했으니 8로 맞추는 게 좋아!
        vo: {} // 상세보기 게시글
    }),
    actions: { // actions : 데이터를 가져오거나 수정하는 함수들
        async dataRecv() { 
            try {
                // axios 호출 시 주소는 상대 경로('/notice/list_vue')만 써도 돼!
                const res = await axios.get('/notice/list_vue', {
                    params: { page: this.curpage }
                });
                // 서버가 보내준 데이터를 창고(state)에 저장
                this.list = res.data.list;
                this.curpage = res.data.curpage;
                this.totalpage = res.data.totalpage;

            } catch (err) {
                console.error("데이터 수신 에러:", err);
            }
        },
        prev() {
            if (this.curpage > 1) {
                this.curpage--;
                this.dataRecv();
            }
        },
        next() {
            if (this.curpage < this.totalpage) {
                this.curpage++;
                this.dataRecv();
            }
        },
        async noticeDetail(no) {
            try {
                const res = await axios.get('/notice/detail_vue', {
                    params: { no: no }
                });
                this.vo = res.data;
            } catch (err) {
                console.error("상세보기 에러:", err);
            }
        }
    }
});