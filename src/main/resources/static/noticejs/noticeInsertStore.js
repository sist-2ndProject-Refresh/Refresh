const useNoticeInsertStore = Pinia.defineStore('notice_insert', {
	state: () => ({
		not_title: '',
		not_content: ''
	}),

	actions: {
		// 공지사항 등록
		async noticeInsert() {
			// 유효성 검사
			if (!this.not_title?.trim()) {
				alert('제목을 입력해주세요.');
				return;
			}

			if (!this.not_content?.trim()) {
				alert('내용을 입력해주세요.');
				return;
			}

			try {
				const { data } = await axios.post('/notice/insert_vue', {
					not_title: this.not_title,
					not_content: this.not_content
				});

				if (data === 'yes' || data.msg === 'yes') {
					alert('공지사항이 등록되었습니다.');
					location.href = '/notice/list';
				} else {
					alert('글쓰기 권한이 없거나 입력에 실패했습니다.');
				}
			} catch (error) {
				console.error('통신 에러 발생:', error);
				alert('서버와 연결할 수 없습니다.');
			}
		}
	}
});