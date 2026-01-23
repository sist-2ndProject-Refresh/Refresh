const {defineStore} = Pinia

const useDeleteStore = defineStore('rental_delete',{
	actions:{
		async rentalDelete(deleteNo){
			await api.delete('/rental/delete_vue/', {
				params:{no: deleteNo}
			})
			if (window.opener) 
			{
				window.opener.location.href="/rental/list";				
			}
			window.close();
			alert("삭제가 완료되었습니다.")
		}
	}
})