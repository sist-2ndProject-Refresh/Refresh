const {defineStore} = Pinia
const {nextTick} = Vue

const useChatStore=defineStore('chat',{
	state:()=>({
		stomp:null,
		users:[],
		messages:[],
		chatroomList:[],
		chatroomId:null,
		loginUser:'',
		chatBodyEl:null,
		roomSubscribe:null,
		msg:'',
		type:'',
		name:'',
		imageurl:'',
		price:0
	}),
	getters:{
		messageType(state) {
			return state.messages.filter(m => m.type==='CHAT')
		},
		systemMessage(state) {
			return state.messages.filter(m => m.type==='SYSTEM')
		}
	},
	actions:{
		enterRoom(roomId,productId) {
			this.chatroomId=roomId
			this.messages=[]
			this.chatTradeData(chatroomId)
		},
		connect() {
			const socket=new SockJS('/chat-ws')
			this.stomp=Stomp.over(socket)
			
			this.stomp.connect({},()=>{
				this.roomSubscribe=this.stomp.subscribe('/topic/users',msg=>{
					this.users=JSON.parse(msg.body)
						.filter(u => u!==this.loginUser) 
				})
				this.subscribeRoom()
			})
		},
		subscribeRoom() {
			if(!this.chatroomId)
				return
			
			this.stomp.subscribe('/topic/chatroom/' + this.chatroomId, async msg => {
				this.messages.push(JSON.parse(msg.body))
				await nextTick()
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
			if(this.msg===''||!this.chatroomId)
				return
			
			this.stomp.send('/app/chat.send', {}, 
				JSON.stringify({
					chatroom_id:this.chatroomId,
					sender:this.loginUser,
					content:this.msg,
					type:'CHAT'
				})
				
			)
			this.msg=''
			this.scrollToBottom()
		},
		async chatTradeData(chatroomId) {
			const res=await axios.get('/chat/product_data_vue/',{
				params:{
					chatroomId:chatroomId
				}
			})
			this.name=res.data.name
			this.imageurl=res.data.imageurl
			this.price=res.data.price
			
			await nextTick()
			this.scrollToBottom()
		},
		async messageList() {
			const res=await axios.get('/chat/message_data/',{
				params:{
					chatroom_id:this.chatroomId
				}
			})
			this.messages=res.data
			this.scrollToBottom()
		},
		async chatRoomList() {
			const res=await axios.get('/chat/chat_list/')
			this.chatroomList=res.data
		},
		async selectRoom(room) {
			this.chatroomId=room.cvo.chatroom_id
			this.messages=[]
			
			await this.messageList()
			await this.chatTradeData(this.chatroomId)
			this.subscribeRoom()
		},
		async chatRoomOut() {
			await axios.post('/chat/room_delete',new URLSearchParams({
				chatroomId:this.chatroomId,
				buyerId:this.loginUser
			})
		)
			
			this.roomSubscribe.unsubscribe()
			
			this.chatroomId=null
			// this.messages=[]
			this.msg=''
			this.chatRoomList()
		}
	}
}) 