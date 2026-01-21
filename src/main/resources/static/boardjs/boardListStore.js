// boardListStore.js
const useBoardListStore = () => {
	// const : 상수를 선언할때 쓴다. 이함수를 통해 공지사항 데이터 창고를 불러옴
	const { defineStore } = Pinia;

	return defineStore('board_list', { 	// defineStore : 창고를 정의한다
		state: () => ({ //state : 창고 안에 보관할 실제 데이터
			list: [], // 게시글 목록 (여러 개니까 빈 배열 []로 시작)
			curpage: 1, // 현재 보고 있는 페이지 번호 (처음엔 1)
			totalpage: 0, // 전체 페이지 개수 (처음엔 0)
			pageSize: 20,
			vo: {} // 상세보기 할 게시글 하나 (객체 {}로 시작)
		}),
		actions: { // actions : 데이터를 가져오거나 수정하는 함수들의 기능
			async dataRecv() { // 데이터 받아오기 
				// async: "비동기적으로 동작하겠다"라는 선언 데이터를 가져올 때까지 
				// 화면이 멈추지 않게 해준다
				try {
					const res = await axios.get('http://localhost:8080/board/list_vue', {
						// await : "서버에서 응답이 올 때까지 여기서 잠시 기다려라"는 명령
						// axios.get : RestController 주소로 데이터를 요청함
						params: { page: this.curpage }
						// params : 주소 뒤에 ?page=1 처럼 파라미터를 붙여준다
						// this.curpage : 현재 창고에 저장된 페이지 번호를 서버에 알려줌
					});
					this.list = res.data.list;
					// 서버가 보내준 데이터(res.data)를 창고의 list에 저장
					this.curpage = res.data.curpage;
					this.totalpage = res.data.totalpage;

				} catch (err) {
					console.error("데이터 수신 에러:", err);
				}
			},
			prev() {
				if (this.curpage > 1) this.curpage--;
				// 현재 페이지가 1보다 크면 숫자를 1 줄인다
				this.dataRecv();
			},
			next() {
				if (this.curpage < this.totalpage) this.curpage++;
				// 현재 페이지가 마지막 페이지보다 작으면 숫자를 1 늘린다
				this.dataRecv();
			},
			async boardDetail(no) {
				// 상세보기 데이터 가져오기 no: 클릭한 게시물의 번호
				const res = await axios.get('http://localhost:8080/board/detail_vue', {
					params: {
						no: no
					}
				})
				this.vo = res.data
				// 서버에서 가져온 상세 게시글 정보를 창고의 vo에 집어 넣는다
			}

		}


	})();
};