<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Forgot Password | Pathology Lab</title>

<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-sRIl4kxILFvY47J16cr9ZwB07vP4J8+LH7qKQnuqkuIAvNWLzeN8tE5YBujZqJLB"
	crossorigin="anonymous">
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link
	href="https://fonts.googleapis.com/css2?family=Manrope:wght@400;500;600;700;800&family=Sora:wght@500;600;700&display=swap"
	rel="stylesheet">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.6.0/css/all.min.css"
	integrity="sha512-Kc323vGBEqzTmouAECnVceyQqyqdsSiqLQISBL29aUW0yAj8NmCah0bV3yQX4DJLGcJ8rP+M5iP4Y1wFgmfA=="
	crossorigin="anonymous" referrerpolicy="no-referrer" />

<style>
:root {
	--brand-teal: #0b7a75;
	--brand-cyan: #14b8a6;
	--brand-ink: #0f172a;
	--brand-muted: #475569;
	--brand-soft: #e2f7f3;
}

body {
	font-family: 'Manrope', sans-serif;
	background: radial-gradient(circle at 20% 20%, rgba(20, 184, 166, 0.14),
		transparent 35%),
		radial-gradient(circle at 80% 10%, rgba(249, 115, 22, 0.11),
		transparent 35%), linear-gradient(180deg, #f8fffe 0%, #ffffff 100%);
	color: var(--brand-ink);
	min-height: 100vh;
}

h1, h2, h3, h4, h5 {
	font-family: 'Sora', sans-serif;
}

.auth-wrap {
	min-height: 100vh;
	display: flex;
	align-items: center;
	padding: 40px 0;
}

.auth-card {
	background: #fff;
	border: 1px solid rgba(11, 122, 117, 0.2);
	border-radius: 22px;
	box-shadow: 0 18px 45px rgba(11, 122, 117, 0.12);
}

.form-panel {
	padding: 36px;
}

.form-label {
	font-weight: 600;
}

.form-control {
	border-radius: 12px;
	padding: 11px 14px;
	border: 1px solid rgba(11, 122, 117, 0.25);
}

.form-control:focus {
	border-color: var(--brand-cyan);
	box-shadow: 0 0 0 0.2rem rgba(20, 184, 166, 0.18);
}

.btn-brand {
	background: linear-gradient(90deg, var(--brand-teal) 0%,
		var(--brand-cyan) 100%);
	color: #fff;
	border: none;
	padding: 10px 20px;
	font-weight: 700;
	border-radius: 12px;
}

.btn-brand:hover {
	color: #fff;
}

.back-link {
	text-decoration: none;
	font-weight: 600;
	color: var(--brand-teal);
}

.signup-text {
	margin-top: 14px;
	text-align: center;
	color: var(--brand-muted);
	font-size: 0.95rem;
}

.signup-text a {
	color: var(--brand-teal);
	font-weight: 700;
	text-decoration: none;
}

.signup-text a:hover {
	text-decoration: underline;
}

@media ( max-width : 992px) {
	.form-panel {
		padding: 26px;
	}
}
</style>
</head>

<body>
	<%
	String msg = (String) session.getAttribute("msg");
	if (msg != null) {
	%>
	<div id="alertMsg"
		class="alert alert-success alert-dismissible fade show" role="alert">
		<%=msg%>
		<button type="button" class="btn-close" data-bs-dismiss="alert"></button>
	</div>
	<%
	session.removeAttribute("msg");
	}
	%>

	<div class="auth-wrap">
		<div class="container">
			<div class="row justify-content-center">
				<div class="col-md-8 col-lg-6 col-xl-5">
					<div class="auth-card">
						<div class="form-panel">
							<div
								class="d-flex justify-content-between align-items-center mb-3">
								<h4 class="fw-bold mb-0">Reset Password</h4>
								<a class="back-link" href="login.jsp">← Back</a>
							</div>

							<form method="post"
								action="${pageContext.request.contextPath}/sendOtp">
								<p class="text-muted mb-4" style="font-size: 0.95rem;">Enter
									your registered email. We will send you an OTP to verify your
									identity.</p>
								<div class="mb-3">
									<label class="form-label" for="email">Email Address</label> <input
										type="email" class="form-control" id="email" name="email"
										placeholder="Enter your email" required>
								</div>

								<button class="btn btn-brand w-100 mt-2" type="submit">Send
									OTP</button>
							</form>

							<p class="signup-text mb-0 mt-4">
								Remembered your password? <a href="login.jsp">Login</a>
							</p>
						</div>
					</div>
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