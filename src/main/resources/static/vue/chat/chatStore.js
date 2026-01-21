const {defineStore} = Pinia
const {nextTick} = Vue

const userChatStore=defineStore('chat',{
	state:()=>({
		stomp:null,
		users:[],
		messages:[],
		chatroomId:null,
		loginUser:'',
		chatBodyEl:null,
		msg:''
	}),
	actions:{
		enterRoom(roomId) {
			this.chatroomId=roomId
			this.messages=[]
		},
		connect() {
			const socket=new SockJS('/chat-ws')
			this.stomp=Stomp.over(socket)
			
			this.stomp.connect({},()=>{
				this.stomp.subscribe('/topic/users',msg=>{
					this.users=JSON.parse(msg.body)
						.filter(u => u!==this.loginUser) // 본인 제외
				})
			})
		},
		subscribeRoom() {
			if(!this.chatroomId)
				return
			
			this.stomp.subscribe('/topic/chatroom/${this.chatroomId}',msg => {
				this.messages.push(JSON.parse(msg.body))
				this.scrollToBottom()
			})
		},
		async scrollToBottom() {
			await nextTick()
			if(this.chatBodyEl) {
				this.chatBodyEl.scrollTop=this.chatBodyEl.scrollHeight
			}
		},
		send() {
			if(this.msg===''||this.chatroomId)
				return
			
			this.stomp.send('/app/chat.send', {}, 
				JSON.stringify({
					chatroom_id:this.chatroomId,
					sender:this.loginUser,
					content:this.msg
				})
			)
			this.msg=''
			this.scrollToBottom()
		}
	}
}) 