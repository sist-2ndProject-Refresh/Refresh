// noticeListStore.js
const useNoticeListStore = () => {
    // Pinia가 로드되었는지 확인 후 defineStore 추출
    const { defineStore } = Pinia;
    
    // 실제 스토어를 정의하고 반환
    return defineStore('notice_list', {
        state: () => ({
            list: [],
            curpage: 1,
            totalpage: 0,
            vo: {}
        }),
        actions: {
            async dataRecv() {
                try {
                    const res = await axios.get('http://localhost:8080/notice/list_vue', {
                        params: { page: this.curpage }
                    });
                    this.list = res.data.list;
                    this.curpage = res.data.curpage;
                    this.totalpage = res.data.totalpage;
                } catch (err) {
                    console.error("데이터 수신 에러:", err);
                }
            },
            prev() {
                if (this.curpage > 1) this.curpage--;
                this.dataRecv();
            },
            next() {
                if (this.curpage < this.totalpage) this.curpage++;
                this.dataRecv();
            },
			async noticeDetail(no){
				const res=await axios.get('http://localhost:8080/notice/detail_vue',{
					params:{
						no:no
					}
				})
				this.vo=res.data
			}
			
        }
		
		
    })();
};