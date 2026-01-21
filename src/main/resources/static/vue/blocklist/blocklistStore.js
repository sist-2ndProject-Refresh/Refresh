const { defineStore } = Pinia

const useBlockListStore = defineStore('block_list', {
    actions: {
        async blocking(other_no, type) {
            console.log("other_no: " + other_no)
            console.log("type: " + type)
            await api.post('/blocklist/block_insert_vue/', {}, {
                params: { 
					other_no: other_no, 
					type: type
				}
            })
            if (window.opener) {
				let link = type == 1 ? "/product/list" : "/rental/list"
                window.opener.location.href = link
            }
            alert("차단이 완료되었습니다.")
            window.close();
        }
    }

})