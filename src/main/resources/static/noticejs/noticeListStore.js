const useNoticeListStore = Pinia.defineStore('notice_list', {
	state: () => ({
		list: [],
		curpage: 1,
		totalpage: 0,
		fd: '',
		startPage: 1,
		endPage: 1,
		vo: {},
		prevVo: null,
		nextVo: null
	}),

	actions: {
		// 공지사항 목록 조회
		async dataRecv() {
			try {
				const { data } = await axios.get('/notice/list_vue', {
					params: {
						page: this.curpage,
						fd: this.fd
					}
				});

				this.list = data.list || [];
				this.curpage = data.curpage || 1;
				this.totalpage = data.totalpage || 0;

				// 페이지 범위 계산
				this.startPage = Math.floor((this.curpage - 1) / 10) * 10 + 1;
				this.endPage = Math.min(this.startPage + 9, this.totalpage);
			} catch (err) {
				console.error('목록 조회 에러:', err);
			}
		},

		// 공지사항 상세 조회
		async noticeDetail(no) {
			try {
				const { data } = await axios.get('/notice/detail_vue', {
					params: { no }
				});

				this.vo = data.vo;
				this.prevVo = data.prevVo;
				this.nextVo = data.nextVo;
			} catch (err) {
				console.error('상세 조회 에러:', err);
			}
		},

		// 검색
		search() {
			this.curpage = 1;
			this.dataRecv();
		},

		// 이전 페이지 블록
		prev() {
			if (this.startPage > 1) {
				this.curpage = this.startPage - 1;
				this.dataRecv();
			}
		},

		// 다음 페이지 블록
		next() {
			if (this.endPage < this.totalpage) {
				this.curpage = this.endPage + 1;
				this.dataRecv();
			}
		}
	}
});