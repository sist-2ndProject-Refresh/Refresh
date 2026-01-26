const {createPinia} = Pinia
const {createApp,onMounted,ref} = Vue

const AdminReportApp = createApp({
	setup(){
	const store = useAdminReportStore()
	onMounted(()=>{
		store.reportListData()
	})
	return {
		store,
	}
	}
	
})

AdminReportApp.use(createPinia())
AdminReportApp.mount('#adminReport')