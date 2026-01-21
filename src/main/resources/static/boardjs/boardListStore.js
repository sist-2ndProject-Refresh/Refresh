const useBoardListStore = () => {
	const { defineStore } = Pinia;

	return defineStore('board_list', {
		state: () => ({
			list: [],
			curpage: 1,
			totalpage: 0,
			pageSize: 20,
			vo: {},

			selectedRegion: '전체',   
			selectedCategory: '전체'  
		}),

		getters: {
		    filteredList(state) {
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
					this.list = res.data.list;
					this.curpage = res.data.curpage;
					this.totalpage = res.data.totalpage;
				} catch (err) {
					console.error("데이터 수신 에러:", err);
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
			},
			async boardDetail(no) {
				const res = await axios.get('http://localhost:8080/board/detail_vue', {
					params: { no: no }
				})
				this.vo = res.data
			}
		}
	})();
};