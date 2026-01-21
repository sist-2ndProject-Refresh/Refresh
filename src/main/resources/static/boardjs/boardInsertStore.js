const { defineStore } = Pinia

const useBoardInsertStore = defineStore('board_insert', {
    state: () => ({
        mem_id: '',
        title: '',
        content: '',
        region: '',   // insert.jsp의 <select v-model="store.region">과 연결
        category: ''  // insert.jsp의 <select v-model="store.category">와 연결
    }),
    actions: {
        // JSP에서 보낸 5개의 ref 객체들을 받아서 유효성 검사 진행
        async boardInsert({ regRef, catRef, memRef, titRef, contRef }) {
            
            // 1. 유효성 검사 (비어있는 값이 있으면 해당 위치로 포커스)
            if (this.mem_id === '') {
                memRef.value.focus();
                return;
            }
            if (this.title === '') {
                titRef.value.focus();
                return;
            }
            if (this.region === '') {
                alert("지역을 선택해 주세요.");
                regRef.value.focus();
                return;
            }
            if (this.category === '') {
                alert("카테고리를 선택해 주세요.");
                catRef.value.focus();
                return;
            }
            if (this.content === '') {
                contRef.value.focus();
                return;
            }

            try {
                // 2. 서버 전송 (이제 region과 category에는 '서울', '일상' 같은 한글이 담겨 있음)
                const res = await axios.post('http://localhost:8080/board/insert_vue', {
                    mem_id: this.mem_id,
                    title: this.title,
                    content: this.content,
                    region: this.region,     
                    category: this.category  
                });

                // 3. 결과 처리
                if (res.status === 200 || res.data.msg === 'yes') {
                    alert("게시글이 성공적으로 등록되었습니다!");
                    location.href = "/board/list"; // 목록 페이지로 이동
                } else {
                    alert('글쓰기 입력에 실패했습니다.');
                }
            } catch (error) {
                console.error("통신 에러 발생:", error);
                alert('서버와 연결할 수 없습니다.');
            }
        }
    }
});