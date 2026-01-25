const {createPinia} = Pinia
const {createApp,onMounted,ref} = Vue

const faqApp = createApp({
	setup(){
	const store = useFAQStore()
	const titleRef =ref(null)
	const subTitleRef =ref(null)
	const subjectRef = ref(null)
	const submsgRef = ref(null)
	const msgRef = ref(null)
	onMounted(()=>{
		store.FAQListData(1)
		store.reporter = USERNO
	})
	return {
		store,
		titleRef,
		subTitleRef,
		subjectRef,
		submsgRef,
		msgRef
	}
	}
	
})

faqApp.use(createPinia())
faqApp.mount('#faq_area')