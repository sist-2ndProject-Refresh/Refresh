const {createPinia} = Pinia
const {createApp,onMounted,ref} = Vue

const faqApp = createApp({
	setup(){
	const store = useFAQStore()
	onMounted(()=>{
		store.FAQListData(1)
		store.reporter = USERNO
	})
	return {
		store
	}
	}
	
})

faqApp.use(createPinia())
faqApp.mount('#faq_area')