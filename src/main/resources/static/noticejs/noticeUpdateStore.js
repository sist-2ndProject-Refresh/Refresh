const { defineStore } = Pinia;

const useNoticeUpdateStore = defineStore("noticeUpdateStore", {
  state: () => ({
    vo: {}, 
    updateResult: ""
  }),
  actions: {
    async getDetailForUpdate(no) {
      try {
        const res = await axios.get('/notice/detail_vue', {
          params: { no: no }
        });
        this.vo = res.data;
      } catch (error) {
        console.error("데이터 로드 실패:", error);
      }
    },
   
    async updateNoticeData() {
      if(!this.vo.not_title || this.vo.not_title.trim() === "") {
          alert("제목을 입력해주세요.");
          return;
      }

      try {
        const res = await axios.put('/notice/update_ok_vue', this.vo);
        if (res.data.msg === "yes") {
          alert("공지사항이 수정되었습니다.");
          location.href = "/notice/detail?no=" + this.vo.not_id;
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