const { defineStore } = Pinia

const useNoticeInsertStore = defineStore('notice_insert', {
    state: () => ({
        not_title: '',
        not_content: '',
    }),
    actions: {
        async noticeInsert({ titRef, contRef }) {
            if (this.not_title.trim() === '') {
                titRef.value.focus()
                return
            }
            if (this.not_content.trim() === '') {
                contRef.value.focus()
                return
            }

            try {
                const res = await axios.post('/notice/insert_vue', {
                    not_title: this.not_title,
                    not_content: this.not_content
                })

                if (res.data === 'yes') {
                    location.href = "/notice/list"
                } else {
                    alert('글쓰기 권한이 없거나 입력에 실패했습니다.')
                }
            } catch (error) {
                console.error("통신 에러 발생:", error)
                alert('서버와 연결할 수 없습니다.')
            }
        }
    }
})