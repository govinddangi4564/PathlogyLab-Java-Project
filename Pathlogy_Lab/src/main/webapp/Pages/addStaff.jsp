<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Add Staff</title>

<link
	href="https://fonts.googleapis.com/css2?family=Outfit:wght@300;400;500;600;700&display=swap"
	rel="stylesheet">
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css"
	rel="stylesheet">
<link
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css"
	rel="stylesheet">

<style>
:root {
	--primary-color: #0b7a75;
	--primary-hover: #0a6662;
	--secondary-color: #64748b;
	--glass-bg: rgba(255, 255, 255, 0.92);
	--glass-border: rgba(255, 255, 255, 0.3);
	--card-shadow: 0 20px 40px rgba(0, 0, 0, 0.08);
	--input-focus: rgba(11, 122, 117, 0.2);
}

body {
	background: radial-gradient(circle at top right, #f0f9ff 0%, #e0f2fe 50%, #f1f5f9
		100%);
	font-family: 'Outfit', sans-serif;
	min-height: 100vh;
	color: #1e293b;
}

.main-content {
	padding: 32px;
	animation: fadeIn 0.8s ease-out;
}

@
keyframes fadeIn {from { opacity:0;
	transform: translateY(20px);
}

to {
	opacity: 1;
	transform: translateY(0);
}

}
.staff-container {
	max-width: 920px;
	margin: 0 auto;
}

.glass-card {
	background: var(--glass-bg);
	backdrop-filter: blur(12px);
	-webkit-backdrop-filter: blur(12px);
	border: 1px solid var(--glass-border);
	border-radius: 24px;
	box-shadow: var(--card-shadow);
	padding: 3rem;
	position: relative;
	overflow: hidden;
}

.glass-card::before {
	content: '';
	position: absolute;
	top: 0;
	left: 0;
	width: 100%;
	height: 6px;
	background: linear-gradient(90deg, #0b7a75, #14b8a6, #0b7a75);
}

.header-section {
	text-align: center;
	margin-bottom: 3rem;
}

.header-section h2 {
	font-weight: 700;
	color: #0f172a;
	margin-top: 1rem;
	font-size: 2rem;
}

.header-section p {
	color: var(--secondary-color);
	font-size: 1.05rem;
}

.icon-circle {
	width: 70px;
	height: 70px;
	background: linear-gradient(135deg, #e6fffb 0%, #d1fae5 100%);
	border-radius: 50%;
	display: flex;
	align-items: center;
	justify-content: center;
	margin: 0 auto;
	color: var(--primary-color);
	font-size: 1.8rem;
	box-shadow: 0 10px 20px rgba(11, 122, 117, 0.1);
}

.form-label {
	font-weight: 500;
	margin-bottom: 0.6rem;
	color: #475569;
	font-size: 0.95rem;
}

.form-control, .form-select {
	border-radius: 12px;
	padding: 12px 16px;
	border: 1.5px solid #e2e8f0;
	background-color: #f8fafc;
	transition: all 0.3s ease;
	font-size: 1rem;
}

.form-control:focus, .form-select:focus {
	background-color: #fff;
	border-color: var(--primary-color);
	box-shadow: 0 0 0 4px var(--input-focus);
	outline: none;
}

.btn-submit {
	background: linear-gradient(90deg, #0b7a75, #14b8a6);
	color: white;
	border: none;
	padding: 14px 40px;
	border-radius: 14px;
	font-weight: 600;
	font-size: 1.05rem;
	letter-spacing: 0.5px;
	transition: all 0.3s ease;
	box-shadow: 0 10px 20px rgba(11, 122, 117, 0.2);
	margin-top: 1.5rem;
}

.btn-submit:hover {
	transform: translateY(-2px);
	box-shadow: 0 15px 30px rgba(11, 122, 117, 0.3);
	color: white;
}

.btn-submit:active {
	transform: translateY(0);
}

.back-btn {
	display: inline-block;
	margin-bottom: 16px;
	text-decoration: none;
	font-weight: 500;
	color: #0b7a75;
}

.back-btn:hover {
	color: #0a6662;
}

@media ( max-width : 992px) {
	.main-content {
		margin-left: 0;
		padding: 20px;
	}
	.sidebar {
		display: none;
	}
	.glass-card {
		padding: 2rem 1.4rem;
	}
}
</style>
<link rel="stylesheet" type="text/css"
	href="<%=request.getContextPath()%>/Css/app-theme.css">
</head>

<body data-admin-page="staff">

	<%@ include file="Components/auth.jsp"%>
	<%@ include file="Components/loader.jsp"%>

	<%
	String role = (String) mySession.getAttribute("role");
	if ("ADMIN".equals(role)) {
	%>
	<jsp:include page="adminSidebar.jsp" />

	<div class="main-content">

		<%@ include file="Components/message.jsp"%>

		<a class="back-btn" href="admin-dashboard.jsp"><i
			class="fa-solid fa-arrow-left"></i> Back</a>

		<div class="staff-container">
			<div class="glass-card">
				<div class="header-section">
					<div class="d-flex justify-content-between align-items-start mb-3">
						<button onclick="history.back()"
							class="btn btn-outline-secondary btn-sm">
							<i class="fas fa-arrow-left me-2"></i>Back
						</button>
					</div>
					<div class="icon-circle">
						<i class="fa-solid fa-user-plus"></i>
					</div>
					<h2>Add Staff</h2>
					<p>Create a staff account for report upload and management.</p>
				</div>

				<form id="addStaffForm"
					action="<%=request.getContextPath()%>/addStaff" method="post">
					<div class="row g-4">
						<div class="col-md-6">
							<label class="form-label">Full Name</label> <input type="text"
								name="fullName" class="form-control"
								placeholder="Enter Staff Name" required>
						</div>

						<div class="col-md-6">
							<label class="form-label">Email Address</label> <input
								type="email" name="email" class="form-control"
								placeholder="Enter Staff Email" required>
						</div>

						<div class="col-md-6">
							<label class="form-label">Mobile Number</label> <input type="tel"
								name="mobile" class="form-control"
								placeholder="Enter Staff Mobile Number" maxlength="15">
						</div>

						<div class="col-md-6">
							<label class="form-label">Password</label> <input type="password"
								name="password" class="form-control"
								placeholder="Set Temporary Password" required>
						</div>

						<div class="col-md-6">
							<label class="form-label">Role</label> <select
								class="form-select" name="role">
								<option value="STAFF" selected>STAFF</option>
								<option value="ADMIN">ADMIN</option>
							</select>

						</div>
					</div>

					<div class="text-center">
						<button type="submit" class="btn btn-submit">Create Staff
							Account</button>
					</div>
				</form>
			</div>
		</div>
	</div>

	<script>
		document.getElementById("addStaffForm").addEventListener("submit",
				function() {
					showLoader();
				});
	</script>

	<%
	} else {
	response.sendRedirect(request.getContextPath() + "/Pages/unauthorizedUser.jsp");
	return;
	}
	%>

</body>

</html>