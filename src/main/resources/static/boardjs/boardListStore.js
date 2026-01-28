const useBoardListStore = Pinia.defineStore('board_list', {
    state: () => ({
        list: [],
        curpage: 1,
        totalpage: 0,
        vo: {},
        prev: null,
        next: null,
        fd: '',
        selectedRegion: '전체',
        selectedCategory: '전체',
        sessionId: null,
        timer: null,
        replyList: [],
        replyMsg: '',  
        reReplyMsg: '', 
        openReplyId: null, 
        editReplyId: null, 
        editReplyMsg: ''  
    }),

    getters: {
        filteredList(state) {
            if (!state.list || !Array.isArray(state.list)) return [];
            return state.list.filter(vo => {
                const regionMatch = state.selectedRegion === '전체' || vo.region === state.selectedRegion;
                const categoryMatch = state.selectedCategory === '전체' || vo.category === state.selectedCategory;
                return regionMatch && categoryMatch;
            });
        }
    },

    actions: {
        toggleReplyInput(id) {
            this.editReplyId = null; 
            if (this.openReplyId === id) {
                this.openReplyId = null;
            } else {
                this.openReplyId = id;
                this.reReplyMsg = ''; 
            }
        },

        toggleEditInput(id, msg) {
            this.openReplyId = null; 
            if (this.editReplyId === id) {
                this.editReplyId = null;
            } else {
                this.editReplyId = id;
                this.editReplyMsg = msg; 
            }
        },

        async dataRecv() {
            try {
                const res = await axios.get('http://localhost:8080/board/list_vue', {
                    params: { page: this.curpage, fd: this.fd }
                });
                this.list = res.data.list || [];
                this.curpage = res.data.curpage || 1;
                this.totalpage = res.data.totalpage || 0;
            } catch (err) {
                console.error("목록 데이터 수신 에러:", err);
            }
        },

        async boardDetail(no) {
            try {
                const res = await axios.get('http://localhost:8080/board/detail_vue', {
                    params: { no: no }
                });
                this.vo = res.data.vo;
                this.prev = res.data.prev;
                this.next = res.data.next;
                this.replyList = res.data.replyList || []; 
                this.openReplyId = null;
                this.editReplyId = null; 
            } catch (err) {
                console.error("상세보기 데이터 수신 에러:", err);
            }
        },

        async replyInsert() {
            if (!this.replyMsg.trim()) {
                alert("내용을 입력해주세요!");
                return;
            }
            if (!this.sessionId) {
                alert("로그인이 필요합니다.");
                return;
            }
            try {
                const res = await axios.post('http://localhost:8080/board/reply_insert_vue?pId=0', {
                    bno: this.vo.id,
                    mem_id: this.sessionId,
                    msg: this.replyMsg
                });
                if (res.data.msg === 'yes') {
                    this.replyMsg = '';
                    this.boardDetail(this.vo.id);
                }
            } catch (err) {
                console.error("댓글 등록 에러:", err);
            }
        },

        async replyUpdate(id) {
            if (!this.editReplyMsg.trim()) {
                alert("수정할 내용을 입력해주세요!");
                return;
            }
            try {
                const res = await axios.post('http://localhost:8080/board/reply_update_vue', {
                    id: id,
                    msg: this.editReplyMsg
                });
                if (res.data.msg === 'yes') {
                    this.editReplyId = null; 
                    this.boardDetail(this.vo.id); 
                }
            } catch (err) {
                console.error("댓글 수정 에러:", err);
            }
        },

        async reReplyInsert(pId) {
            if (!this.reReplyMsg.trim()) {
                alert("답글 내용을 입력해주세요!");
                return;
            }
            if (!this.sessionId) {
                alert("로그인이 필요합니다.");
                return;
            }
            try {
                const res = await axios.post(`http://localhost:8080/board/reply_insert_vue?pId=${pId}`, {
                    bno: this.vo.id,
                    mem_id: this.sessionId,
                    msg: this.reReplyMsg
                });
                if (res.data.msg === 'yes') {
                    this.reReplyMsg = '';
                    this.openReplyId = null;
                    this.boardDetail(this.vo.id);
                }
            } catch (err) {
                console.error("답글 등록 에러:", err);
            }
        },

        async replyDelete(id) {
            if (!confirm("댓글을 삭제하시겠습니까?")) return;
            try {
                const res = await axios.delete(`http://localhost:8080/board/reply_delete_vue/${id}`);
                if (res.data.msg === 'yes') {
                    this.boardDetail(this.vo.id);
                }
            } catch (err) {
                console.error("댓글 삭제 에러:", err);
            }
        },

        search() {
            this.curpage = 1;
            if (this.timer) clearTimeout(this.timer);
            this.timer = setTimeout(() => {
                this.dataRecv();
            }, 300);
        },

        prevPage() {
            if (this.curpage > 1) {
                this.curpage--;
                this.dataRecv();
            }
        },

        nextPage() {
            if (this.curpage < this.totalpage) {
                this.curpage++;
                this.dataRecv();
            }
        }
    }
});