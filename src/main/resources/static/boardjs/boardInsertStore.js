const { defineStore } = Pinia

const useBoardInsertStore = defineStore('board_insert', {
    state: () => ({
        mem_id: '',
        title: '',
        content: '',
        region: '',   
        category: ''  
    }),
    actions: {
        async boardInsert({ regRef, catRef, memRef, titRef, contRef }) {
            
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
                const res = await axios.post('http://localhost:8080/board/insert_vue', {
                    mem_id: this.mem_id,
                    title: this.title,
                    content: this.content,
                    region: this.region,     
                    category: this.category  
                });

                if (res.status === 200 || res.data.msg === 'yes') {
                    alert("게시글이 성공적으로 등록되었습니다!");
                    location.href = "/board/list"; 
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