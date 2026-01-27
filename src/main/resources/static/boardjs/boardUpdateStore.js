const { defineStore } = Pinia;

const useBoardUpdateStore = defineStore("boardUpdateStore", {
  state: () => ({
    vo: {}, 
    updateResult: "",
    sessionId: "" 
  }),
  actions: {
    async getDetailForUpdate(no) {
      try {
        const res = await axios.get('http://localhost:8080/board/detail_vue', {
          params: { no: no }
        });
        
        const data = res.data;

        if (data.mem_id !== this.sessionId) {
          alert("본인이 작성한 글만 수정할 수 있습니다.");
          location.href = "/board/list";
          return;
        }

        this.vo = data;
      } catch (error) {
        console.error("데이터 로드 실패:", error);
      }
    },
   
    async updateBoardData() {
      if(!this.vo.title.trim() || !this.vo.content.trim()) {
        alert("제목과 내용을 모두 입력해줘!");
        return;
      }

      try {
        const res = await axios.put('http://localhost:8080/board/update_ok_vue', this.vo);
        
        if (res.data.msg === "yes") {
          alert("게시글이 수정되었습니다.");
          location.href = "/board/detail?no=" + this.vo.id; 
        } else {
          alert("수정 권한이 없거나 실패했습니다.");
        }
      } catch (error) {
        console.error("수정 실패:", error);
        alert("수정 중 오류가 발생했습니다.");
      }
    }
  }
});