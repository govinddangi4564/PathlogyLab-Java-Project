<%@page import="com.pathology.model.User"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page session="false"%>
<!DOCTYPE html>
<html lang="en">

<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link
	href="https://fonts.googleapis.com/css2?family=Outfit:wght@300;400;500;600;700&display=swap"
	rel="stylesheet">
<link
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css"
	rel="stylesheet">

<style>
:root {
	--admin-sidebar-bg: #07111e;
	--admin-sidebar-panel: #0c1726;
	--admin-sidebar-hover: #15263c;
	--admin-sidebar-active: #0f766e;
	--admin-sidebar-text: #ced9e8;
	--admin-sidebar-text-active: #ffffff;
	--admin-topbar-bg: rgba(248, 250, 252, 0.96);
	--admin-icon-muted: #86bdf8;
	--admin-divider: #1b2a40;
	--sidebar-width: 260px;
}

body {
	margin: 0;
	font-family: 'Outfit', sans-serif;
	background-color: #f8fafc;
	overflow-x: hidden;
}

/* Sidebar Styling */
.sidebar {
	width: var(--sidebar-width);
	height: 100vh;
	position: fixed;
	top: 0;
	left: 0;
	background: linear-gradient(180deg, var(--admin-sidebar-panel) 0%,
		var(--admin-sidebar-bg) 100%);
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
	border-bottom: 1px solid var(--admin-divider);
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
	color: var(--admin-sidebar-active);
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
	color: var(--admin-sidebar-text);
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
	color: var(--admin-icon-muted);
}

.sidebar a:hover {
	background-color: var(--admin-sidebar-hover);
	color: var(--admin-sidebar-text-active);
	transform: translateX(4px);
}

.sidebar a.active {
	background-color: var(--admin-sidebar-active);
	color: #ffffff;
	box-shadow: 0 8px 15px rgba(15, 118, 110, 0.25);
}

.bottom-nav {
	margin-top: auto;
	padding-top: 20px;
	border-top: 1px solid var(--admin-divider);
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
	background: var(--admin-topbar-bg);
	backdrop-filter: blur(8px);
	position: sticky;
	top: 0;
	z-index: 999;
}

.mobile-toggle {
	display: none;
	font-size: 1.5rem;
	cursor: pointer;
	color: var(--admin-sidebar-bg);
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

.main-content {
	margin-left: var(--sidebar-width);
	padding: 32px;
	min-height: calc(100vh - 70px);
}

/* Responsive Design */
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

	<%
	HttpSession session = request.getSession(false);

	if (session == null || session.getAttribute("userObj") == null) {
		response.sendRedirect(request.getContextPath() + "/login");
		return;
	}

	User u = (User) session.getAttribute("userObj");
	String name = u.getName();

	// Prevent back button after logout
	response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
	%>

	<div class="sidebar" id="adminSidebar">
		<div class="sidebar-header">
			<h3>
				<i class="fa-solid fa-microscope"></i> PathLab
			</h3>
		</div>

		<span class="nav-label">Overview</span> <a
			href="${pageContext.request.contextPath}/Pages/admin-dashboard.jsp"
			data-admin-link="dashboard"> <i class="fa-solid fa-gauge-high"></i>
			Dashboard
		</a> <a href="${pageContext.request.contextPath}/Pages/uploadReport.jsp"
			data-admin-link="upload"> <i class="fa-solid fa-cloud-arrow-up"></i>
			Upload Report
		</a> <a href="${pageContext.request.contextPath}/viewAllReports"
			data-admin-link="view-reports"> <i class="fa-solid fa-file-lines"></i>
			View Reports
		</a> <span class="nav-label">Management</span> <a
			href="${pageContext.request.contextPath}/Pages/managePatients.jsp"
			data-admin-link="patients"> <i class="fa-solid fa-users"></i>
			Patients
		</a>

		<div class="bottom-nav">
			<a href="#"><i class="fa-solid fa-gear"></i> Settings</a> <a
				href="${pageContext.request.contextPath}/logout" class="logout-link">
				<i class="fa-solid fa-right-from-bracket"></i> Logout
			</a>
		</div>
	</div>

	<div class="topbar">
		<div class="mobile-toggle" onclick="toggleSidebar()">
			<i class="fa-solid fa-bars"></i>
		</div>

		<div class="topbar-right">
			<div class="notification">
				<button class="icon-btn" type="button">
					<i class="fa-solid fa-bell"></i> <span>3</span>
				</button>
			</div>

			<div class="profile-section">
				<div class="profile-info">
					<div class="profile-name">
						<!-- name -->
					</div>
					<div class="profile-role">Super Admin</div>
				</div>
				<div class="profile-img">
					<i class="fa-solid fa-user-shield"></i>
				</div>
			</div>
		</div>
	</div>

	<script>
					// 1. Mobile Sidebar Toggle
					function toggleSidebar() {
						document.getElementById('adminSidebar').classList.toggle('active');
					}

					// 2. Active Link Handler
					(function () {
						// Detect current page from URL or Body Attribute
						const currentPath = window.location.pathname;
						const pageAttr = document.body.getAttribute('data-admin-page');

						document.querySelectorAll('[data-admin-link]').forEach(link => {
							const linkType = link.getAttribute('data-admin-link');
							const linkHref = link.getAttribute('href');

							if (pageAttr === linkType || currentPath.includes(linkHref)) {
								link.classList.add('active');
							}
						});
					})();
				</script>