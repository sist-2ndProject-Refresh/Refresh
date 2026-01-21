const { defineStore } = Pinia;

const useNoticeUpdateStore = defineStore("noticeUpdateStore", {
  state: () => ({
    vo: {}, // 서버에서 받아온 공지사항 데이터를 담는 객체
    updateResult: ""
  }),
  actions: {
    // 1. 기존 데이터를 가져오는 함수
    async getDetailForUpdate(no) {
      try {
        const res = await axios.get('http://localhost:8080/notice/detail_vue', {
          params: { no: no }
        });
        this.vo = res.data;
      } catch (error) {
        console.error("데이터 로드 실패:", error);
      }
    },
   
    // 2. 수정한 데이터를 서버로 보내는 함수
    async updateNoticeData() {
      try {
        const res = await axios.put('http://localhost:8080/notice/update_ok_vue', this.vo);
        if (res.data.msg === "yes") {
          alert("공지사항이 수정되었습니다.");
          // 수정 완료 후 상세 페이지로 이동 (not_id 사용)
          location.href = "/notice/detail?no=" + this.vo.not_id;
        }
      } catch (error) {
        console.error("수정 실패:", error);
        alert("수정 중 오류가 발생했습니다.");
      }
    }
  }
});