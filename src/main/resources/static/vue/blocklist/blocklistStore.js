const { defineStore } = Pinia

const useBlockListStore = defineStore('block_list', {
    actions: {
        async blocking(other_no) {
            console.log(other_no)
            await api.post('/blocklist/block_insert_vue/', {}, {
                params: { other_no: other_no }
            })
            if (window.opener) {
                window.opener.location.href = "/product/list";
            }
            alert("차단이 완료되었습니다.")
            window.close();
        }
    }

})