const {createApp,ref} = Vue
const {createPinia} = Pinia

const findReportApp = createApp({
	setup(){
		const store = usefindReportStore()
		const fdRef = ref(null)
		return{
			store,
			fdRef
		}
	}
	
})
findReportApp.use(createPinia())
findReportApp.mount('#findReport')