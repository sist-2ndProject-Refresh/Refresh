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
		msg:'',
		name:'',
		imageurl:'',
		price:0
	}),
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
				this.stomp.subscribe('/topic/users',msg=>{
					this.users=JSON.parse(msg.body)
						.filter(u => u!==this.loginUser) // 본인 제외
				})
				this.subscribeRoom()
			})
		},
		subscribeRoom() {
			if(!this.chatroomId)
				return
			
			this.stomp.subscribe('/topic/chatroom/' + this.chatroomId,msg => {
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
			if(this.msg===''||!this.chatroomId)
				return
			
			this.stomp.send('/app/chat.send', {}, 
				JSON.stringify({
					chatroom_id:this.chatroomId,
					sender:this.loginUser,
					content:this.msg
				})
				
			)
			console.log(this.msg)
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
		}
	}
}) 