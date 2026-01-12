const {defineStore} = Pinia

const useInsertStore = defineStore('trade_insert', {
	state:() => ({
		name: '',
		description: '',
		price: 0,
		qty: 0,
		condition: '',
		imagecount: 1,
		imageurl: '',
		category: 0,
		lat: 0,
		lon: 0,
		address: '',
		trades: ''
	}), 
	actions:{
		async tradeInsertData() {
			const res = await api.post('/product/insert_vue/', {
				
			})
		}
	}
})