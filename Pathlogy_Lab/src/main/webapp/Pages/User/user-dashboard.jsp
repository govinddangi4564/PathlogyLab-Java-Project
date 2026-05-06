<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">

<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>User Dashboard | PathLab</title>

<!-- Google Fonts -->
<link
	href="https://fonts.googleapis.com/css2?family=Outfit:wght@300;400;500;600;700&display=swap"
	rel="stylesheet">
<!-- Bootstrap CSS -->
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css"
	rel="stylesheet">
<!-- Font Awesome -->
<link
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css"
	rel="stylesheet">


<link rel="stylesheet" type="text/css"
	href="<%=request.getContextPath()%>/Css/app-theme.css">
</head>

<body data-user-page="dashboard">
	<%@ include file="userSidebar.jsp"%>

	<!-- Main Content -->
	<div class="main-content">
		<%@ include file="../Components/message.jsp"%>
		<div class="dashboard-header">
			<div class="d-flex justify-content-between align-items-start">
				<div>
					<h2>
						Welcome Back,
						<%=u.getName()%>
					</h2>
					<p>View and manage your personal details and medical reports.</p>
				</div>
				<button onclick="history.back()"
					class="btn btn-outline-secondary btn-sm">
					<i class="fas fa-arrow-left me-2"></i>Back
				</button>
			</div>
		</div>

		<div class="row">
			<div class="col-12">
				<div class="glass-card">
					<div class="glass-card-header">
						<div class="icon-circle">
							<i class="fa-solid fa-id-card"></i>
						</div>
						<div>
							<h4>Personal Information</h4>
							<p>Your registered profile details with PathLab</p>
						</div>
					</div>

					<div class="detail-grid">
						<!-- Name -->
						<div class="detail-item">
							<div class="detail-label">
								<i class="fa-solid fa-user"></i> Full Name
							</div>
							<div class="detail-value">
								<%=u.getName()%>
							</div>
						</div>

						<!-- Email -->
						<div class="detail-item">
							<div class="detail-label">
								<i class="fa-solid fa-envelope"></i> Email Address
							</div>
							<div class="detail-value">
								<%=u.getEmail()%>
							</div>
						</div>

						<!-- Mobile -->
						<div class="detail-item">
							<div class="detail-label">
								<i class="fa-solid fa-phone"></i> Mobile Number
							</div>
							<div class="detail-value">
								<%=u.getMobile()%>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>

	<script>
		function toggleSidebar() {
			document.getElementById('userSidebar').classList.toggle('active');
		}
	</script>
</body>

</html>