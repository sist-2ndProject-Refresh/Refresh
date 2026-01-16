<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title></title>
</head>

<body>

	<div class="d-flex gap-4 p-4">
		<div class="border-end pe-3 flex-shrink-0 position-sticky"
			style="top: 20px; width: 245px; height: calc(100vh - 20px); overflow-y: auto;">
			<jsp:include page="/WEB-INF/views/admin/adminMenu.jsp" />
		</div>

		<div class="flex-grow-1">
			<div class="d-flex align-items-center justify-content-between mb-3">
				<h3 class="m-5 fw-bold">관리자 HOME</h3>
			</div>

			<div class="row g-3 mb-3">
				<div class="col-12 col-md-4">
					<div class="card h-100">
						<div class="card-body">
							<div class="text-muted small">신규 신고</div>
							<div class="fs-3 fw-bold mt-1">3</div>
						</div>
					</div>
				</div>
				<div class="col-12 col-md-4">
					<div class="card h-100">
						<div class="card-body">
							<div class="text-muted small">신규 가입자</div>
							<div class="fs-3 fw-bold mt-1">12</div>
						</div>
					</div>
				</div>
				<div class="col-12 col-md-4">
					<div class="card h-100">
						<div class="card-body">
							<div class="text-muted small">방문자 수</div>
							<div class="fs-3 fw-bold mt-1">248</div>
						</div>
					</div>
				</div>
			</div>

			<div class="card mb-3">
				<div class="card-body">
					<h5 class="fw-bold mb-2">new 최근 3개월</h5>
					<p class="text-muted small mb-2">총 거래액 그래프</p>
					<div
						class="border rounded-3 bg-light d-flex align-items-center justify-content-center"
						style="height: 300px;">그래프 영역</div>
				</div>
			</div>

			<div class="card">
				<div class="card-body">
					<h5 class="fw-bold mb-2">new 새로 올라온 신고</h5>
					<p class="text-muted small mb-2">테이블</p>
					<div
						class="border rounded-3 bg-light d-flex align-items-center justify-content-center"
						style="height: 140px;"></div>
				</div>
			</div>

		</div>
	</div>

</body>
</html>
