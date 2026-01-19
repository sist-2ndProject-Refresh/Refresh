const {defineStore} = Pinia

const useDeleteStore = defineStore('trade_delete',{
	actions:{
		async tradeDelete(deleteNo){
			await api.delete('/product/delete_vue/', {
				params:{no: deleteNo}
			})
			if (window.opener) 
			{
				window.opener.location.href="/product/list";				
			}
			window.close();
			alert("삭제가 완료되었습니다.")
		}
	}
})