const useBoardListStore = Pinia.defineStore('boardList', {
  state: () => ({

    boardList: [],        
    curpage: 1,
    totalpage: 0,
    fd: '',               
    selectedRegion: '전체', 
    selectedCategory: '전체',
    
    vo: null,             
    prev: null,           
    next: null,           
    replyList: [],        
    sessionId: '',
    

    openReplyId: null,
    editReplyId: null,
    replyMsg: '',
    reReplyMsg: '',
    editReplyMsg: ''
  }),

  getters: {

    filteredList: (state) => {
      let list = [...state.boardList]; 

      if (state.selectedRegion && state.selectedRegion !== '전체') {
        list = list.filter(item => item.region === state.selectedRegion);
      }

      if (state.selectedCategory && state.selectedCategory !== '전체') {
        list = list.filter(item => item.category === state.selectedCategory);
      }

      return list;
    }
  },

  actions: {
    
    async dataRecv() {
      try {
        const res = await axios.get('/board/list_vue', {
          params: { 
            page: this.curpage,
            fd: this.fd 
          }
        });
        this.boardList = res.data.list;
        this.totalpage = res.data.totalpage;
        console.log("받아온 목록 데이터:", this.boardList); 
      } catch (err) {
        console.error("데이터 수신 에러:", err);
      }
    },

    search() {
      this.curpage = 1;
      this.dataRecv();
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

    async boardDetail(no) {
      try {
        const res = await axios.get('/board/detail_vue', { params: { no } });
        this.vo = res.data.vo;
        this.prev = res.data.prev;
        this.next = res.data.next;
        this.replyList = res.data.replyList;
      } catch (err) {
        console.error("상세보기 에러:", err);
      }
    },
    
    async toggleLike(no) {
      if(!this.sessionId) { alert("로그인이 필요합니다."); return; }
      try {
        const res = await axios.post('/board/like_vue', { no });
        this.vo = res.data; 

      } catch (err) { console.error(err); }
    },

    async reReplyInsert(pId) {
      if (!this.reReplyMsg) { alert("답글 내용을 입력해주세요."); return; }
      try {
        const res = await axios.post('/board/reply_insert_vue', 
          { bno: this.vo.id, msg: this.reReplyMsg }, 
          { params: { pId: pId } }
        );
        if (res.data.msg === 'yes') {
          this.reReplyMsg = '';
          this.openReplyId = null;
          this.boardDetail(this.vo.id); 
        }
      } catch (err) { console.error(err); }
    },

    async replyInsert() {
      if (!this.replyMsg) { alert("댓글 내용을 입력해주세요."); return; }
      try {
        const res = await axios.post('/board/reply_insert_vue', 
          { bno: this.vo.id, msg: this.replyMsg }, 
          { params: { pId: 0 } }
        );
        if (res.data.msg === 'yes') {
          this.replyMsg = '';
          this.boardDetail(this.vo.id);
        }
      } catch (err) { console.error(err); }
    },

    async replyUpdate(id) {
      try {
        const res = await axios.post('/board/reply_update_vue', {
          id: id,
          msg: this.editReplyMsg
        });
        if (res.data.msg === 'yes') {
          this.editReplyId = null;
          this.boardDetail(this.vo.id);
        }
      } catch (err) { console.error(err); }
    },

    async replyDelete(id) {
      if (!confirm("댓글을 삭제하시겠습니까?")) return;
      try {
        const res = await axios.delete(`/board/reply_delete_vue/${id}`);
        if (res.data.msg === 'yes') {
          this.boardDetail(this.vo.id);
        }
      } catch (err) { console.error(err); }
    },

    toggleReplyInput(id) {
      this.openReplyId = this.openReplyId === id ? null : id;
      this.reReplyMsg = '';
    },
    toggleEditInput(id, msg) {
      this.editReplyId = this.editReplyId === id ? null : id;
      this.editReplyMsg = msg;
    }
  }
});