import { defineStore } from 'pinia'
import { ref, computed } from 'vue'

export const useBoardStore = defineStore('board', () => {
	// 1. 데이터 저장소
	const posts = ref([])           // SQL에서 받아올 게시글들
	const region = ref('')          // 사용자가 선택한 지역 (v-model)
	const selectedCategory = ref('전체') // 사용자가 선택한 카테고리 (v-model)

	// 2. ⭐ 핵심: 필터링 로직 (두 조건 동시 만족)
	const filteredPosts = computed(() => {
		return posts.value.filter(post => {
			// 지역 조건: 선택 안했거나(전체), 데이터의 지역과 일치하거나
			const matchRegion = !region.value || post.region === region.value;
			// 카테고리 조건: '전체'거나, 데이터의 카테고리와 일치하거나
			const matchCategory = selectedCategory.value === '전체' || post.category === selectedCategory.value;

			return matchRegion && matchCategory;
		});
	})

	return { posts, region, selectedCategory, filteredPosts }
})