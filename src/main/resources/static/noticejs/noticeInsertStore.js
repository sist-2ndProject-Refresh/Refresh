const { defineStore } = Pinia

const useNoticeInsertStore = defineStore('notice_insert', {
						/*	 Pinia에서 애플리케이션의 상태를 중앙에서 관리하기 위한 함수
							 첫번째 인자인 'notice_insert는 고유한 이름이 됨*/
	state: () => ({
		mem_id: '',
		not_title: '',
		not_content: '',
		// 컴포넌트에 전체에 공유할 데이터 그자체 작성자의 id, 제목, 내용이 상태로
		// 정의 되어있음
	}),
	actions: {
		async noticeInsert({ memRef, titRef, contRef }) {
		// async : 함수가 비동기적으로 작동함을 선언
		// ref : 참조의 약자
			if (this.mem_id === '') {
				// this.### === '' : 현재 값이 비어있는 상태인가?를 묻는 조건
				memRef.value.focus()
				// .value: vue의 ref 객체 내부의 실제 HTML 요소에 접근하기 위한 속성
				// .focus() : 해당 입력창으로 커서를 강제로 이동시키는 함수
				return
			}
			if (this.not_title === '') {
				titRef.value.focus()
				return
			}
			if (this.not_content === '') {
				contRef.value.focus()
				return
			}

			try {

				const res = await axios.post('http://localhost:8080/notice/insert_vue/', {
							// await : 비동기 작업이 완료될 때까지 다음줄로 넘어가지 않고 기다리게 함
					mem_id: this.mem_id,
					not_title: this.not_title,
					not_content: this.not_content
				})

				// 3. 응답 처리
				// 서버에서 ResponseEntity(HttpStatus.OK)를 보냈으므로 상태 코드로도 확인 가능합니다.
				if (res.status === 200 || res.data.msg === 'yes') {
					location.href = "/notice/list"
				} else {
					alert('글쓰기 입력에 실패했습니다')
				}
			} catch (error) {
				console.error("통신 에러 발생:", error)
				alert('서버와 연결할 수 없습니다.')
			}
		}
	}
})