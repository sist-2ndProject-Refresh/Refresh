const { defineStore } = Pinia;
const useBoardUpdateStore = defineStore("boardUpdateStore", {
  state: () => ({
    vo: {}, 
    updateResult: ""
  }),
  actions: {
    async getDetailForUpdate(no) {
      try {
        const res = await axios.get('http://localhost:8080/board/detail_vue', {
          params: { no: no }
        });
        this.vo = res.data;
      } catch (error) {
        console.error("데이터 로드 실패:", error);
      }
    },
   
    async updateBoardData() {
      try {
        const res = await axios.put('http://localhost:8080/board/update_ok_vue', this.vo);
        if (res.data.msg === "yes") {
          alert("게시글이 수정되었습니다.");
          location.href = "/board/detail?no=" + this.vo.id; 
        }
      } catch (error) {
        console.error("수정 실패:", error);
        alert("수정 중 오류가 발생했습니다.");
      }
    }
  }
});