const { defineStore } = Pinia;

const useBoardListStore = defineStore('board_list', {
	state: () => ({
		list: [],
		curpage: 1,
		totalpage: 0,
		vo: {},
		selectedRegion: '전체',
		selectedCategory: '전체',
		sessionId: null
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
		async dataRecv() {
			try {
				const res = await axios.get('http://localhost:8080/board/list_vue', {
					params: { page: this.curpage }
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
				console.log("상세보기 데이터 로드 성공:", this.vo);
			} catch (err) {
				console.error("상세보기 데이터 수신 에러:", err);
				alert("데이터를 불러오는 중 오류가 발생했습니다.");
			}
		}
	}
});