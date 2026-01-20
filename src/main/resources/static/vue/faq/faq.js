const {createPinia} = Pinia
const {createApp,onMounted,ref} = Vue

const faqApp = createApp({
	setup(){
	const store = useFAQStore()
	
	return {
		store
	}
	}
	
})

faqApp.use(createPinia())
faqApp.mount('#faq_container')