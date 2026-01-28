const useBoardInsertStore = Pinia.defineStore('board_insert', {
	state: () => ({
		mem_id: '',
		title: '',
		content: '',
		region: '',
		category: ''
	}),

	actions: {
		// 사용자 지역 정보 조회 및 설정
		async fetchUserRegion(mem_id) {
			try {
				const { data } = await axios.get('http://localhost:8080/board/getUserAddr_vue', {
					params: { id: mem_id }
				});

				const fullAddr = data || "";

				// 지역 자동 설정
				if (fullAddr.includes("서울")) {
					this.region = "서울";
				} else if (fullAddr.includes("경기") || fullAddr.includes("인천")) {
					this.region = "경기/인천";
				} else if (fullAddr.includes("부산") || fullAddr.includes("경남") || fullAddr.includes("경북")) {
					this.region = "부산/경상";
				} else if (fullAddr.includes("대전") || fullAddr.includes("충남") || fullAddr.includes("충북") || fullAddr.includes("세종")) {
					this.region = "대전/충청";
				} else if (fullAddr.includes("광주") || fullAddr.includes("전남") || fullAddr.includes("전북")) {
					this.region = "광주/전라";
				} else {
					this.region = "기타 지역";
				}
			} catch (error) {
				console.error("주소 로드 실패:", error);
				this.region = "기타 지역";
			}
		},

		// 게시글 등록
		async boardInsert() {
			// 로그인 확인
			if (!this.mem_id || this.mem_id === 'null') {
				alert("로그인이 필요합니다.");
				location.href = "/member/login";
				return;
			}

			// 유효성 검사
			if (!this.title?.trim()) {
				alert("제목을 입력해 주세요.");
				return;
			}

			if (!this.category) {
				alert("카테고리를 선택해 주세요.");
				return;
			}

			if (!this.content?.trim()) {
				alert("내용을 입력해 주세요.");
				return;
			}

			// 지역 정보 확인
			if (!this.region) {
				console.warn("지역 정보 누락, '기타 지역'으로 설정");
				this.region = "기타 지역";
			}

			try {
				const { data } = await axios.post('http://localhost:8080/board/insert_vue', {
					mem_id: this.mem_id,
					title: this.title,
					content: this.content,
					region: this.region,
					category: this.category
				});

				if (data.msg === 'yes') {
					alert("게시글이 성공적으로 등록되었습니다!");
					location.href = "/board/list";
				} else {
					alert("등록에 실패했습니다.");
				}
			} catch (error) {
				console.error("서버 통신 에러:", error.response?.data || error.message);
				alert('서버와 연결할 수 없습니다. 백엔드 매핑을 확인하세요.');
			}
		}
	}
});