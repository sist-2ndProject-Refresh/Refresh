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

        async fetchUserRegion(mem_id) {
            try {

                const res = await axios.get('/board/getUserAddr_vue', {
                    params: { id: mem_id }
                });
                
                const fullAddr = res.data; 

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

                console.log("자동 설정된 지역:", this.region);
            } catch (error) {
                console.error("사용자 주소 정보를 가져오는데 실패했습니다.", error);
            }
        },

        async boardInsert(refs) {
            const { regRef, catRef, titRef, contRef } = refs;

            if (!this.mem_id || this.mem_id === 'null') {
                alert("로그인이 필요한 서비스입니다.");
                location.href = "/member/login";
                return;
            }

            if (this.title.trim() === '') {
                alert("제목을 입력해 주세요.");
                if (titRef && titRef.focus) titRef.focus();
                else if (titRef && titRef.value) titRef.value.focus();
                return;
            }
            if (this.region === '') {
                alert("지역을 선택해 주세요.");
                if (regRef && regRef.focus) regRef.focus();
                else if (regRef && regRef.value) regRef.value.focus();
                return;
            }
            if (this.category === '') {
                alert("카테고리를 선택해 주세요.");
                if (catRef && catRef.focus) catRef.focus();
                else if (catRef && catRef.value) catRef.value.focus();
                return;
            }
            if (this.content.trim() === '') {
                alert("내용을 입력해 주세요.");
                if (contRef && contRef.focus) contRef.focus();
                else if (contRef && contRef.value) contRef.value.focus();
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

                if (res.data.msg === 'yes') {
                    alert("게시글이 성공적으로 등록되었습니다!");
                    location.href = "/board/list"; 
                } else {
                    alert('글쓰기 등록에 실패했습니다.');
                }
            } catch (error) {
                console.error("통신 에러 발생:", error);
                alert('서버와 연결할 수 없습니다.');
            }
        }
    }
});