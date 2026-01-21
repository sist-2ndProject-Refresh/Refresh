import { defineStore } from 'pinia'
import { ref, computed } from 'vue'

export const useBoardStore = defineStore('board', () => {

	const posts = ref([])           
	const region = ref('')          
	const selectedCategory = ref('전체') 


	const filteredPosts = computed(() => {
		return posts.value.filter(post => {
			const matchRegion = !region.value || post.region === region.value;
			const matchCategory = selectedCategory.value === '전체' || post.category === selectedCategory.value;

			return matchRegion && matchCategory;
		});
	})

	return { posts, region, selectedCategory, filteredPosts }
})