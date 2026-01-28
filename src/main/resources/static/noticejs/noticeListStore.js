const useNoticeListStore = Pinia.defineStore('notice_list', {
    state: () => ({
        list: [],
        curpage: 1,
        totalpage: 0,
        vo: {},           // 현재 글 상세 데이터
        prevVo: null,     // 이전글 데이터
        nextVo: null      // 다음글 데이터
    }),
    actions: {
        // 목록 불러오기 (혹시 호출될지 모르니 넣어둬야 함)
        async dataRecv() { 
            try {
                const res = await axios.get('/notice/list_vue', {
                    params: { page: this.curpage }
                });
                this.list = res.data.list;
                this.curpage = res.data.curpage;
                this.totalpage = res.data.totalpage;
            } catch (err) {
                console.error("목록 수신 에러:", err);
            }
        },
        // 상세보기 불러오기
		async noticeDetail(no) {
		    try {
		        const res = await axios.get('/notice/detail_vue', {
		            params: { no: no }
		        });
		        
		        // 서버에서 map.put("vo", vo) 등으로 보낸 데이터들 매핑
		        this.vo = res.data.vo;
		        this.prevVo = res.data.prevVo;
		        this.nextVo = res.data.nextVo;

		        console.log("데이터 로드 완료:", res.data);
		    } catch (err) {
		        console.error("상세보기 에러:", err);
		    }
		}
    }
});