const useNoticeListStore = Pinia.defineStore('notice_list', {
    state: () => ({
        list: [],
        curpage: 1,
        totalpage: 0,
        fd: '',
        startPage: 1,
        endPage: 1,
        vo: {},
        prevVo: null,
        nextVo: null
    }),
    actions: {
        async dataRecv() {
            try {
                const res = await axios.get('/notice/list_vue', {
                    params: {
                        page: this.curpage,
                        fd: this.fd
                    }
                });
                this.list = res.data.list;
                this.curpage = res.data.curpage;
                this.totalpage = res.data.totalpage;
                this.startPage = Math.floor((this.curpage - 1) / 10) * 10 + 1;
                this.endPage = this.startPage + 9;
                if (this.endPage > this.totalpage) this.endPage = this.totalpage;
            } catch (err) {
                console.error(err);
            }
        },
        async noticeDetail(no) {
            try {
                const res = await axios.get('/notice/detail_vue', {
                    params: { no: no }
                });
                this.vo = res.data.vo;
                this.prevVo = res.data.prevVo;
                this.nextVo = res.data.nextVo;
            } catch (err) {
                console.error(err);
            }
        },
        search() {
            this.curpage = 1;
            this.dataRecv();
        },
        prev() {
            if (this.startPage > 1) {
                this.curpage = this.startPage - 1;
                this.dataRecv();
            }
        },
        next() {
            if (this.endPage < this.totalpage) {
                this.curpage = this.endPage + 1;
                this.dataRecv();
            }
        }
    }
});