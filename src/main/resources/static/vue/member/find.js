const {createApp} = Vue 
const {createPinia} = Pinia
const findApp = createApp({
	setup(){
		const store = memberStore()
		return {
			store
		}
	}
})
findApp.use(createPinia())
findApp.mount('.container')