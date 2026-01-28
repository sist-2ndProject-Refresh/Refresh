const { defineStore } = Pinia;

const useNoticeUpdateStore = defineStore("noticeUpdateStore", {
  state: () => ({
    vo: null
  }),
  actions: {
    async getDetailForUpdate(no) {
      try {
        const res = await axios.get('/notice/detail_vue', { params: { no } });
        this.vo = res.data.vo || res.data;
      } catch (e) { console.error(e); }
    },
   
    async updateNoticeData() {
      if (!this.vo || !this.vo.not_id) return "no-id";
      try {
        const res = await axios.put('/notice/update_ok_vue', this.vo);
        return res.data.msg;
      } catch (e) { return "error"; }
    }
  }
});