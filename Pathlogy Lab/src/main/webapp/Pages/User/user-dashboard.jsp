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


</head>

<body>

	<%@ include file="userSidebar.jsp" %>

	<!-- Main Content -->
	<div class="main-content">
		<div class="dashboard-header">
			<h2>Welcome Back, John!</h2>
			<p>View and manage your personal details and medical reports.</p>
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
						<!-- User ID -->
						<div class="detail-item">
							<div class="detail-label">
								<i class="fa-solid fa-hashtag"></i> Patient ID
							</div>
							<div class="detail-value">USR-98542</div>
						</div>

						<!-- Name -->
						<div class="detail-item">
							<div class="detail-label">
								<i class="fa-solid fa-user"></i> Full Name
							</div>
							<div class="detail-value">John Doe</div>
						</div>

						<!-- Email -->
						<div class="detail-item">
							<div class="detail-label">
								<i class="fa-solid fa-envelope"></i> Email Address
							</div>
							<div class="detail-value">johndoe@example.com</div>
						</div>

						<!-- Mobile -->
						<div class="detail-item">
							<div class="detail-label">
								<i class="fa-solid fa-phone"></i> Mobile Number
							</div>
							<div class="detail-value">+1 (555) 123-4567</div>
						</div>

						<!-- Role -->
						<div class="detail-item">
							<div class="detail-label">
								<i class="fa-solid fa-shield-halved"></i> Account Role
							</div>
							<div class="detail-value">
								<span class="status-badge">USER</span>
							</div>
						</div>

						<!-- Created At -->
						<div class="detail-item">
							<div class="detail-label">
								<i class="fa-solid fa-calendar-alt"></i> Joined Date
							</div>
							<div class="detail-value">15 Oct 2023, 10:30 AM</div>
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