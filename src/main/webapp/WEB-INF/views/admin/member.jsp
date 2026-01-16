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
				<h3 class="m-5 fw-bold">회원관리</h3>
			</div>

			<div class="card">
				<div class="card-body">
					<h5 class="fw-bold mb-3">회원 검색</h5>

					<div class="row g-2 mb-3">
						<div class="col-12 col-md-1">
							<select class="form-select">
								<option>전체</option>
								<option>1</option>
								<option>2</option>
								<option>3</option>
							</select>
						</div>
						<div class="col-12 col-md-6">
							<input type="text" class="form-control" placeholder="닉네임/아이디 검색">
						</div>
						<div class="col-12 col-md-3">
							<button type="button" class="btn btn-xs btn-primary">검색</button>
						</div>
					</div>
					<br>
					<div class="table-responsive">
						<table class="table table-hover align-middle">
							<thead class="table-light">
								<tr>
									<th style="width: 90px;">번호</th>
									<th>이메일</th>
									<th>닉네임</th>
									<th style="width: 150px;">가입일</th>
									<th style="width: 120px;">상태</th>
								</tr>
							</thead>
							<tbody>
								<tr>
									<td>1</td>
									<td>test1@gmail.com</td>
									<td>새해복</td>
									<td>2026-01-01</td>
								</tr>
								<tr>
									<td>2</td>
									<td>test2@gmail.com</td>
									<td>마니</td>
									<td>2026-01-01</td>
								</tr>
							</tbody>
						</table>
					</div>

					<div class="text-muted small">
					
					</div>
				</div>
			</div>

		</div>
	</div>

</body>
</html>
