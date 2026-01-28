const useBoardListStore = Pinia.defineStore('board_list', {
	state: () => ({
		list: [],
		curpage: 1,
		totalpage: 0,
		vo: {},
		prev: null,
		next: null,
		fd: '',
		selectedRegion: '전체',
		selectedCategory: '전체',
		sessionId: null,
		timer: null,
		replyList: [],
		replyMsg: '',
		reReplyMsg: '',
		openReplyId: null,
		editReplyId: null,
		editReplyMsg: ''
	}),

	getters: {
		filteredList(state) {
			if (!state.list?.length) return [];
			return state.list.filter(vo => {
				const regionMatch = state.selectedRegion === '전체' || vo.region === state.selectedRegion;
				const categoryMatch = state.selectedCategory === '전체' || vo.category === state.selectedCategory;
				return regionMatch && categoryMatch;
			});
		}
	},

	actions: {
		// 답글 입력창 토글
		toggleReplyInput(id) {
			this.editReplyId = null;
			this.openReplyId = this.openReplyId === id ? null : id;
			if (this.openReplyId === id) this.reReplyMsg = '';
		},

		// 댓글 수정 입력창 토글
		toggleEditInput(id, msg) {
			this.openReplyId = null;
			this.editReplyId = this.editReplyId === id ? null : id;
			if (this.editReplyId === id) this.editReplyMsg = msg;
		},

		// 게시글 목록 조회
		async dataRecv() {
			try {
				const { data } = await axios.get('http://localhost:8080/board/list_vue', {
					params: { page: this.curpage, fd: this.fd }
				});
				this.list = data.list || [];
				this.curpage = data.curpage || 1;
				this.totalpage = data.totalpage || 0;
			} catch (err) {
				console.error("목록 데이터 수신 에러:", err);
			}
		},

		// 게시글 상세 조회
		async boardDetail(no) {
			try {
				const { data } = await axios.get('http://localhost:8080/board/detail_vue', {
					params: { no }
				});
				this.vo = data.vo;
				this.prev = data.prev;
				this.next = data.next;
				this.replyList = data.replyList || [];
				this.openReplyId = null;
				this.editReplyId = null;
			} catch (err) {
				console.error("상세보기 데이터 수신 에러:", err);
			}
		},

		// 댓글 등록
		async replyInsert() {
			if (!this.replyMsg.trim()) {
				alert("내용을 입력해주세요!");
				return;
			}
			if (!this.sessionId) {
				alert("로그인이 필요합니다.");
				return;
			}
			try {
				const { data } = await axios.post('http://localhost:8080/board/reply_insert_vue?pId=0', {
					bno: this.vo.id,
					mem_id: this.sessionId,
					msg: this.replyMsg
				});
				if (data.msg === 'yes') {
					this.replyMsg = '';
					await this.boardDetail(this.vo.id);
				}
			} catch (err) {
				console.error("댓글 등록 에러:", err);
			}
		},

		// 댓글 수정
		async replyUpdate(id) {
			if (!this.editReplyMsg.trim()) {
				alert("수정할 내용을 입력해주세요!");
				return;
			}
			try {
				const { data } = await axios.post('http://localhost:8080/board/reply_update_vue', {
					id,
					msg: this.editReplyMsg
				});
				if (data.msg === 'yes') {
					this.editReplyId = null;
					await this.boardDetail(this.vo.id);
				}
			} catch (err) {
				console.error("댓글 수정 에러:", err);
			}
		},

		// 답글 등록
		async reReplyInsert(pId) {
			if (!this.reReplyMsg.trim()) {
				alert("답글 내용을 입력해주세요!");
				return;
			}
			if (!this.sessionId) {
				alert("로그인이 필요합니다.");
				return;
			}
			try {
				const { data } = await axios.post(`http://localhost:8080/board/reply_insert_vue?pId=${pId}`, {
					bno: this.vo.id,
					mem_id: this.sessionId,
					msg: this.reReplyMsg
				});
				if (data.msg === 'yes') {
					this.reReplyMsg = '';
					this.openReplyId = null;
					await this.boardDetail(this.vo.id);
				}
			} catch (err) {
				console.error("답글 등록 에러:", err);
			}
		},

		// 댓글 삭제
		async replyDelete(id) {
			if (!confirm("댓글을 삭제하시겠습니까?")) return;
			try {
				const { data } = await axios.delete(`http://localhost:8080/board/reply_delete_vue/${id}`);
				if (data.msg === 'yes') {
					await this.boardDetail(this.vo.id);
				}
			} catch (err) {
				console.error("댓글 삭제 에러:", err);
			}
		},

		// 검색 (디바운싱)
		search() {
			this.curpage = 1;
			if (this.timer) clearTimeout(this.timer);
			this.timer = setTimeout(() => this.dataRecv(), 300);
		},

		// 이전 페이지
		prevPage() {
			if (this.curpage > 1) {
				this.curpage--;
				this.dataRecv();
			}
		},

		// 다음 페이지
		nextPage() {
			if (this.curpage < this.totalpage) {
				this.curpage++;
				this.dataRecv();
			}
		}
	}
});