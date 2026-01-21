// Pinia 스토어 정의
const useBoardDeleteStore = Pinia.defineStore("boardDeleteStore", {
  state: () => ({
    deleteResult: "",
    isDeleting: false
  }),
  actions: {
    async deleteBoardData(no) {
      if (!confirm("정말로 이 게시글을 삭제하시겠습니까?")) {
        return;
      }

      this.isDeleting = true;
      try {
        // Spring Boot의 @DeleteMapping("/board/delete_vue/{no}") 호출
        const response = await axios.delete('http://localhost:8080/board/delete_vue/' + no);
        
        this.deleteResult = response.data.msg;

        if (this.deleteResult === "yes") {
          alert("게시글이 성공적으로 삭제되었습니다.");
          location.href = "/board/list"; // 목록으로 이동
        } else {
          alert("삭제에 실패했습니다.");
        }
      } catch (error) {
        console.error("삭제 에러:", error);
        alert("서버 통신 중 오류가 발생했습니다.");
      } finally {
        this.isDeleting = false;
      }
    }
  }
});