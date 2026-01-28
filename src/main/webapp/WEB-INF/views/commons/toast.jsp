<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://cdn.jsdelivr.net/npm/sockjs-client@1/dist/sockjs.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/stompjs@2.3.3/lib/stomp.min.js"></script>
<style type="text/css">
.me-auto {
	font-size: 16px;	
}
.toast-body {
	font-size: 14px;
	color: black;
}
.toast-header {
	background-color: #90ee90; 
}
</style>
</head>
<body>
	<div class="toast-container position-fixed bottom-0 end-0 p-3">
		<div id="notifyToast" class="toast">
			<div class="toast-header text-white">
				<strong class="me-auto">알림</strong>
				<button type="button" class="btn-close" data-bs-dismiss="toast"></button>
			</div>
			<div class="toast-body" id="toastMsg">
				
			</div>
		</div>
	</div>
	<script>
    const socket=new SockJS('/chat-ws')
    const stomp=Stomp.over(socket)

    stomp.connect({}, function() {
        stomp.subscribe('/topic/notify/'+USER_ID, function(msg) {
            showToast(msg.body)
        })
    })

    function showToast(message) {
        const toast=document.getElementById('notifyToast')
        const toastMsg=document.getElementById('toastMsg')
        
        toastMsg.innerText=message
        toast.classList.add('show')
        
        setTimeout(() => {
        	hideToast()
        }, 10000)
    }

    function hideToast() {
        const toast=document.getElementById('notifyToast')
        toast.classList.remove()
    }
</script>
</body>
</html>