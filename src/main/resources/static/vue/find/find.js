const {createApp,onMounted} = Vue
const {createPinia} = Pinia

const findApp = createApp({
	setup(){
		const store = useFindStore()
		onMounted(()=>{
			if(FD!=null && FD!='')
				store.fd = FD
			store.FindListData()
		})
		return{
			store
		}
	}
	
})
findApp.use(createPinia())
findApp.mount('#findContainer')