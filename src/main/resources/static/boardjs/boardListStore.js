const { defineStore } = Pinia;

const useBoardListStore = defineStore('board_list', {
	state: () => ({
		list: [],
		curpage: 1,
		totalpage: 0,
		vo: {},
		fd: '',
		selectedRegion: '전체',
		selectedCategory: '전체',
		sessionId: null,
		timer: null
	}),
	getters: {
		filteredList(state) {
			if (!state.list || !Array.isArray(state.list)) return [];
			return state.list.filter(vo => {
				const regionMatch = state.selectedRegion === '전체' || vo.region === state.selectedRegion;
				const categoryMatch = state.selectedCategory === '전체' || vo.category === state.selectedCategory;
				return regionMatch && categoryMatch;
			});
		}
	},
	actions: {
		search() {
			this.curpage = 1;
			if (this.timer) clearTimeout(this.timer);
			this.timer = setTimeout(() => {
				this.dataRecv();
			}, 300);
		},

		async dataRecv() {
			try {
				const res = await axios.get('http://localhost:8080/board/list_vue', {
					params: {
						page: this.curpage,
						fd: this.fd
					}
				});
				this.list = res.data.list || [];
				this.curpage = res.data.curpage || 1;
				this.totalpage = res.data.totalpage || 0;
			} catch (err) {
				console.error("목록 데이터 수신 에러:", err);
			}
		},

		async boardDetail(no) {
			try {
				const res = await axios.get('http://localhost:8080/board/detail_vue', {
					params: { no: no }
				});
				this.vo = res.data;
			} catch (err) {
				console.error("상세보기 데이터 수신 에러:", err);
			}
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
		}
	}
}); 