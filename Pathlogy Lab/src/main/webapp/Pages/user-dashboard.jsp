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

<style>
:root {
	--primary-color: #0b7a75;
	--primary-hover: #0a6662;
	--secondary-color: #64748b;
	--glass-bg: rgba(255, 255, 255, 0.92);
	--glass-border: rgba(255, 255, 255, 0.3);
	--card-shadow: 0 20px 40px rgba(0, 0, 0, 0.08);
	--input-focus: rgba(11, 122, 117, 0.2);
	--user-sidebar-bg: #07111e;
	--user-sidebar-panel: #0c1726;
	--user-sidebar-hover: #15263c;
	--user-sidebar-active: #0b7a75;
	--user-sidebar-text: #ced9e8;
	--user-sidebar-text-active: #ffffff;
	--user-topbar-bg: rgba(248, 250, 252, 0.96);
	--user-icon-muted: #86bdf8;
	--user-divider: #1b2a40;
	--sidebar-width: 260px;
}

body {
	background: radial-gradient(circle at top right, #f0f9ff 0%, #e0f2fe 50%, #f1f5f9
		100%);
	font-family: 'Outfit', sans-serif;
	min-height: 100vh;
	color: #1e293b;
	margin: 0;
	overflow-x: hidden;
}

/* Sidebar Styling (Adapted from Admin Sidebar) */
.sidebar {
	width: var(--sidebar-width);
	height: 100vh;
	position: fixed;
	top: 0;
	left: 0;
	background: linear-gradient(180deg, var(--user-sidebar-panel) 0%,
		var(--user-sidebar-bg) 100%);
	padding: 24px 16px;
	box-shadow: 8px 0 24px rgba(2, 6, 23, 0.22);
	border-right: 1px solid rgba(255, 255, 255, 0.04);
	z-index: 1000;
	display: flex;
	flex-direction: column;
	transition: transform 0.3s ease;
}

.sidebar-header {
	padding: 0 12px 28px 12px;
	border-bottom: 1px solid var(--user-divider);
	margin-bottom: 24px;
}

.sidebar-header h3 {
	color: #fff;
	font-weight: 700;
	font-size: 1.35rem;
	margin: 0;
	display: flex;
	align-items: center;
}

.sidebar-header h3 i {
	color: var(--user-sidebar-active);
	margin-right: 12px;
}

.nav-label {
	color: #7f91ad;
	font-size: 0.75rem;
	font-weight: 600;
	text-transform: uppercase;
	letter-spacing: 1px;
	padding: 0 12px;
	margin: 15px 0 10px 0;
	display: block;
}

.sidebar a {
	text-decoration: none;
	color: var(--user-sidebar-text);
	display: flex;
	align-items: center;
	padding: 12px 16px;
	border-radius: 12px;
	margin-bottom: 4px;
	transition: all 0.25s ease;
	font-weight: 500;
}

.sidebar a i {
	width: 24px;
	font-size: 1.1rem;
	margin-right: 12px;
	color: var(--user-icon-muted);
}

.sidebar a:hover {
	background-color: var(--user-sidebar-hover);
	color: var(--user-sidebar-text-active);
	transform: translateX(4px);
}

.sidebar a.active {
	background-color: var(--user-sidebar-active);
	color: #ffffff;
	box-shadow: 0 8px 15px rgba(11, 122, 117, 0.25);
}

.bottom-nav {
	margin-top: auto;
	padding-top: 20px;
	border-top: 1px solid var(--user-divider);
}

.logout-link {
	color: #fda4af !important;
}

.logout-link i {
	color: #fda4af !important;
}

/* Topbar Styling */
.topbar {
	margin-left: var(--sidebar-width);
	height: 70px;
	display: flex;
	justify-content: space-between;
	align-items: center;
	padding: 0 32px;
	border-bottom: 1px solid #e2e8f0;
	background: var(--user-topbar-bg);
	backdrop-filter: blur(8px);
	position: sticky;
	top: 0;
	z-index: 999;
}

.mobile-toggle {
	display: none;
	font-size: 1.5rem;
	cursor: pointer;
	color: var(--user-sidebar-bg);
}

.topbar-right {
	display: flex;
	align-items: center;
	gap: 20px;
	margin-left: auto;
}

.icon-btn {
	border: none;
	background: #f1f5f9;
	width: 40px;
	height: 40px;
	border-radius: 10px;
	display: flex;
	align-items: center;
	justify-content: center;
	color: #64748b;
	position: relative;
	cursor: pointer;
}

.notification span {
	position: absolute;
	top: -2px;
	right: -2px;
	background: #ef4444;
	color: #fff;
	border-radius: 50%;
	font-size: 10px;
	width: 18px;
	height: 18px;
	display: flex;
	align-items: center;
	justify-content: center;
	border: 2px solid #fff;
}

.profile-section {
	display: flex;
	align-items: center;
	gap: 12px;
	padding-left: 20px;
	border-left: 1px solid #e2e8f0;
}

.profile-info {
	text-align: right;
}

.profile-name {
	font-weight: 600;
	font-size: 0.9rem;
	color: #1e293b;
	line-height: 1.2;
}

.profile-role {
	font-size: 0.75rem;
	color: #64748b;
}

.profile-img {
	width: 40px;
	height: 40px;
	border-radius: 10px;
	background: linear-gradient(135deg, #ccfbf1 0%, #99f6e4 100%);
	display: flex;
	align-items: center;
	justify-content: center;
	color: #0f766e;
}

/* Dashboard Content */
.main-content {
	margin-left: var(--sidebar-width);
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
.dashboard-header {
	margin-bottom: 2rem;
}

.dashboard-header h2 {
	font-weight: 700;
	color: #0f172a;
	font-size: 2rem;
}

.dashboard-header p {
	color: var(--secondary-color);
	font-size: 1.1rem;
}

/* Glass Card */
.glass-card {
	background: var(--glass-bg);
	backdrop-filter: blur(12px);
	-webkit-backdrop-filter: blur(12px);
	border: 1px solid var(--glass-border);
	border-radius: 24px;
	box-shadow: var(--card-shadow);
	padding: 2.5rem;
	position: relative;
	overflow: hidden;
}

.glass-card-header {
	display: flex;
	align-items: center;
	margin-bottom: 1.5rem;
	border-bottom: 1px solid #e2e8f0;
	padding-bottom: 1.5rem;
}

.glass-card-header .icon-circle {
	width: 60px;
	height: 60px;
	background: linear-gradient(135deg, #e6fffb 0%, #d1fae5 100%);
	border-radius: 50%;
	display: flex;
	align-items: center;
	justify-content: center;
	color: var(--primary-color);
	font-size: 1.5rem;
	margin-right: 1.5rem;
	box-shadow: 0 10px 20px rgba(11, 122, 117, 0.1);
}

.glass-card-header h4 {
	margin: 0;
	font-weight: 700;
	color: #0f172a;
}

.glass-card-header p {
	margin: 0;
	color: var(--secondary-color);
	font-size: 0.95rem;
}

/* Detail Grid */
.detail-grid {
	display: grid;
	grid-template-columns: repeat(auto-fill, minmax(250px, 1fr));
	gap: 1.5rem;
}

.detail-item {
	background: #f8fafc;
	padding: 1.25rem;
	border-radius: 16px;
	border: 1px solid #e2e8f0;
	transition: all 0.3s ease;
}

.detail-item:hover {
	border-color: var(--primary-color);
	box-shadow: 0 4px 12px rgba(11, 122, 117, 0.05);
	transform: translateY(-2px);
}

.detail-label {
	font-size: 0.85rem;
	text-transform: uppercase;
	letter-spacing: 0.5px;
	color: #64748b;
	font-weight: 600;
	margin-bottom: 0.5rem;
	display: flex;
	align-items: center;
}

.detail-label i {
	margin-right: 8px;
	color: var(--primary-color);
	font-size: 1rem;
}

.detail-value {
	font-size: 1.1rem;
	font-weight: 600;
	color: #1e293b;
	word-break: break-all;
}

.status-badge {
	display: inline-block;
	padding: 6px 12px;
	border-radius: 20px;
	font-size: 0.85rem;
	font-weight: 600;
	background: #dcfce7;
	color: #166534;
}

@media ( max-width : 992px) {
	.sidebar {
		transform: translateX(-100%);
	}
	.sidebar.active {
		transform: translateX(0);
	}
	.topbar, .main-content {
		margin-left: 0;
	}
	.mobile-toggle {
		display: block;
	}
	.topbar {
		padding: 0 20px;
	}
	.profile-info {
		display: none;
	}
}
</style>
</head>

<body>

	<!-- Sidebar -->
	<div class="sidebar" id="userSidebar">
		<div class="sidebar-header">
			<h3>
				<i class="fa-solid fa-microscope"></i> PathLab
			</h3>
		</div>

		<span class="nav-label">Main Menu</span> <a href="#" class="active">
			<i class="fa-solid fa-user"></i> My Profile
		</a> <a href="#"> <i class="fa-solid fa-file-medical"></i> My Reports
		</a> <a href="#"> <i class="fa-solid fa-calendar-check"></i>
			Appointments
		</a> <span class="nav-label">Settings</span> <a href="#"> <i
			class="fa-solid fa-lock"></i> Change Password
		</a>

		<div class="bottom-nav">
			<a href="#" class="logout-link"> <i
				class="fa-solid fa-right-from-bracket"></i> Logout
			</a>
		</div>
	</div>

	<!-- Topbar -->
	<div class="topbar">
		<div class="mobile-toggle" onclick="toggleSidebar()">
			<i class="fa-solid fa-bars"></i>
		</div>

		<div class="topbar-right">
			<div class="notification">
				<button class="icon-btn" type="button">
					<i class="fa-solid fa-bell"></i> <span>2</span>
				</button>
			</div>

			<div class="profile-section">
				<div class="profile-info">
					<div class="profile-name">John Doe</div>
					<div class="profile-role">Registered Patient</div>
				</div>
				<div class="profile-img">
					<i class="fa-solid fa-user-circle"></i>
				</div>
			</div>
		</div>
	</div>

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