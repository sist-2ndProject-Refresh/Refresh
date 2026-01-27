const useBoardDeleteStore = Pinia.defineStore("boardDeleteStore", {
  state: () => ({
    deleteResult: "",
    isDeleting: false,
    sessionId: "" 
  }),
  actions: {
    async deleteBoardData(no, writerId) {
      
      if (!this.sessionId || this.sessionId === 'null') {
        alert("로그인이 필요합니다.");
        location.href = "/member/login";
        return;
      }

      if (this.sessionId !== writerId) {
        alert("본인이 작성한 글만 삭제할 수 있습니다.");
        return;
      }

      if (!confirm("정말로 이 게시글을 삭제하시겠습니까?")) {
        return;
      }

      this.isDeleting = true;
      try {
        const response = await axios.delete('http://localhost:8080/board/delete_vue/' + no);
        
        this.deleteResult = response.data.msg;

        if (this.deleteResult === "yes") {
          alert("게시글이 성공적으로 삭제되었습니다.");
          location.href = "/board/list";
        } else {
          alert("삭제 권한이 없거나 실패했습니다.");
        }
      } catch (error) {
        console.error("삭제 에러:", error);
        if (error.response && error.response.status === 403) {
            alert("삭제 권한이 없습니다.");
        } else {
            alert("서버 통신 중 오류가 발생했습니다.");
        }
      } finally {
        this.isDeleting = false;
      }
    }
  }
});