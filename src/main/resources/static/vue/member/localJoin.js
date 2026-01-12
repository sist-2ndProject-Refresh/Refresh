const {createApp,onMounted} = Vue 
const {createPinia} = Pinia
const memberJoinApp = createApp({
	setup(){
		const store = memberStore()
		onMounted(()=>{
			store.userData.provider = 'local'
		})
		return {
			store
		}
	}
})
memberJoinApp.use(createPinia())
memberJoinApp.mount('#join_container')