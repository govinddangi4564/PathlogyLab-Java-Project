<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
response.setStatus(403);
%>
<!DOCTYPE html>
<html>

<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Unauthorized Access | Pathology Lab</title>

<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-sRIl4kxILFvY47J16cr9ZwB07vP4J8+LH7qKQnuqkuIAvNWLzeN8tE5YBujZqJLB"
	crossorigin="anonymous">
<link
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.6.0/css/all.min.css"
	rel="stylesheet"
	integrity="sha512-Kc323vGBEqzTmouAECnVceyQqyqdsSiqLQISBL29aUW0yAj8NmCah0bV3yQX4DJLGcJ8rP+M5iP4Y1wFgmfA=="
	crossorigin="anonymous" referrerpolicy="no-referrer" />
<link rel="stylesheet" type="text/css"
	href="<%=request.getContextPath()%>/Css/app-theme.css">

<style>
.unauth-wrap {
	min-height: 100vh;
	display: flex;
	align-items: center;
	padding: 32px 0;
}

.unauth-card {
	max-width: 640px;
	margin: 0 auto;
	padding: 32px;
	background: rgba(255, 255, 255, 0.96);
	border: 1px solid #d8e5f3;
	border-radius: 22px;
	box-shadow: 0 18px 38px rgba(15, 23, 42, 0.1);
	text-align: center;
}

.status-code {
	font-size: 0.86rem;
	letter-spacing: 0.12em;
	text-transform: uppercase;
	color: #7c2d12;
	font-weight: 700;
	margin-bottom: 10px;
}

.lock-icon {
	width: 78px;
	height: 78px;
	border-radius: 50%;
	display: inline-flex;
	align-items: center;
	justify-content: center;
	font-size: 1.9rem;
	color: #b45309;
	background: linear-gradient(135deg, #ffedd5 0%, #fed7aa 100%);
	box-shadow: 0 14px 28px rgba(180, 83, 9, 0.2);
	margin-bottom: 16px;
}

.unauth-title {
	font-size: 1.9rem;
	font-weight: 800;
	color: #111827;
	margin-bottom: 10px;
}

.unauth-text {
	font-size: 1rem;
	color: #475569;
	margin-bottom: 22px;
}

.action-row {
	display: flex;
	gap: 10px;
	justify-content: center;
	flex-wrap: wrap;
}

.btn-soft {
	background: #eef2ff;
	border: 1px solid #c7d2fe;
	color: #3730a3;
	font-weight: 700;
	border-radius: 12px;
	padding: 10px 16px;
}

.btn-soft:hover {
	background: #e0e7ff;
	color: #312e81;
}

@media ( max-width : 576px) {
	.unauth-card {
		padding: 24px;
	}
	.unauth-title {
		font-size: 1.6rem;
	}
}
</style>
</head>

<body>
	<div class="unauth-wrap">
		<div class="container">
			<div class="unauth-card">
				<div class="status-code">Error 403</div>
				<div class="lock-icon">
					<i class="fa-solid fa-lock"></i>
				</div>
				<h1 class="unauth-title">Access Denied</h1>
				<p class="unauth-text">You are not allowed to access this page,
					button, or task. Please log in with an account that has permission.</p>

				<div class="action-row">
					<a class="btn btn-brand"
						href="<%=request.getContextPath()%>/Pages/login.jsp"> <i
						class="fa-solid fa-right-to-bracket"></i> Login
					</a> <a class="btn btn-soft"
						href="<%=request.getContextPath()%>/index.jsp"> <i
						class="fa-solid fa-house"></i> Home
					</a>
					<button class="btn btn-soft" type="button"
						onclick="history.back();">
						<i class="fa-solid fa-arrow-left"></i> Go Back
					</button>
				</div>
			</div>
		</div>
	</div>

	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/js/bootstrap.bundle.min.js"
		integrity="sha384-FKyoEForCGlyvwx9Hj09JcYn3nv7wiPVlz7YYwJrWVcXK/BmnVDxM+D2scQbITxI"
		crossorigin="anonymous"></script>
</body>

</html>