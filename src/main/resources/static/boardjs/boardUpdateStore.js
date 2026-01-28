const useBoardUpdateStore = Pinia.defineStore("boardUpdateStore", {
  state: () => ({
    vo: {
      id: 0,
      title: '',
      content: '',
      mem_id: '',
      region: '',
      category: ''
    }, 
    updateResult: "",
    sessionId: "" 
  }),
  actions: {
    async getDetailForUpdate(no) {
      try {
        const res = await axios.get('http://localhost:8080/board/detail_vue', {
          params: { no: no }
        });
        const boardVo = res.data.vo ? res.data.vo : res.data;

        console.log("수정 데이터 확인:", boardVo);
        console.log("내 세션 ID:", this.sessionId);

		        if (this.sessionId && String(boardVo.mem_id).trim() !== String(this.sessionId).trim()) {
          alert("본인이 작성한 글만 수정할 수 있습니다.");
          location.href = "/board/list";
          return;
        }

        this.vo = boardVo;
      } catch (error) {
        console.error("데이터 로드 실패:", error);
        alert("데이터를 가져오는 중 오류가 발생했습니다.");
      }
    },
   
    async updateBoardData() {
      if(!this.vo.title || !this.vo.title.trim()) {
        alert("제목을 입력해 주세요.");
        return;
      }
      if(!this.vo.content || !this.vo.content.trim()) {
        alert("내용을 입력해 주세요.");
        return;
      }

      try {
        const res = await axios.put('http://localhost:8080/board/update_ok_vue', this.vo);
        
        if (res.data.msg === "yes") {
          alert("게시글이 성공적으로 수정되었습니다.");
          location.href = "/board/detail?no=" + this.vo.id; 
        } else {
          alert("수정 권한이 없거나 실패했습니다.");
        }
      } catch (error) {
        console.error("수정 실패:", error);
        alert("서버 통신 중 오류가 발생했습니다.");
      }
    }
  }
});