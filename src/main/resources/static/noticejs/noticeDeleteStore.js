const useNoticeDeleteStore = Pinia.defineStore("noticeDeleteStore", {
	state: () => ({
		isDeleting: false
	}),

	actions: {
		// 공지사항 삭제
		async deleteNoticeData(no) {
			if (!confirm("정말로 이 공지사항을 삭제하시겠습니까?")) {
				return;
			}

			this.isDeleting = true;
			try {
				const { data } = await axios.delete(`/notice/delete_vue/${no}`);

				if (data.msg === "yes") {
					alert("공지사항이 삭제되었습니다.");
					location.href = "/notice/list";
				} else {
					alert("삭제 실패: 권한이 없거나 오류가 발생했습니다.");
				}
			} catch (error) {
				console.error("삭제 요청 에러:", error);
				alert("서버 통신 중 오류가 발생했습니다.");
			} finally {
				this.isDeleting = false;
			}
		}
	}
});