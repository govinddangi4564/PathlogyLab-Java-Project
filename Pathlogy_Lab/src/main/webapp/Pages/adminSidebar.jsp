<%@page
	import="org.apache.jasper.compiler.NewlineReductionServletWriter"%>
<%@page import="com.pathology.model.User"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
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

<link rel="stylesheet" type="text/css"
	href="<%=request.getContextPath()%>/Css/sidebar.css">

<link rel="stylesheet" type="text/css"
	href="<%=request.getContextPath()%>/Css/app-theme.css">
</head>

<body>

	<%
	User us = (User) session.getAttribute("userObj");
	%>

	<div class="sidebar role-admin" id="adminSidebar">
		<div class="sidebar-header">
			<h3>
				<i class="fa-solid fa-microscope"></i> PathLab Admin
			</h3>
			<div class="role-badge">Administrator Access</div>
		</div>

		<span class="nav-label">Overview</span> <a
			href="<%=request.getContextPath()%>/Pages/admin-dashboard.jsp"
			data-admin-link="dashboard"> <i class="fa-solid fa-gauge-high"></i>
			Dashboard
		</a> <a href="<%=request.getContextPath()%>/Pages/uploadReport.jsp"
			data-admin-link="upload"> <i class="fa-solid fa-cloud-arrow-up"></i>
			Upload Report
		</a> <a href="<%=request.getContextPath()%>/viewAllReports"
			data-admin-link="reports"> <i class="fa-solid fa-file-lines"></i>
			View Reports
		</a> <span class="nav-label">Management</span> <a
			href="<%=request.getContextPath()%>/Pages/managePatients.jsp"
			data-admin-link="patients"> <i class="fa-solid fa-users"></i>Manage 
			Patients
		</a> <a href="<%=request.getContextPath()%>/Pages/manageStaff.jsp"
			data-admin-link="staff"> <i class="fa-solid fa-users"></i> Manage
			Staff
		</a>

		<div class="bottom-nav">
			<div class="role-quick-links">
				<a href="#"><i class="fa-solid fa-sliders"></i> System Controls</a>
				<a href="#"><i class="fa-solid fa-chart-line"></i> Analytics</a>
			</div>
			<a href="#"><i class="fa-solid fa-gear"></i> Settings</a> <a
				href="<%=request.getContextPath()%>/logout" class="logout-link"
				class="btn btn-outline-danger btn-sm"
				onclick="return confirm('Are you sure you want to Logout ?');">
				<i class="fa-solid fa-right-from-bracket"></i> Logout
			</a>
		</div>
	</div>

	<div class="topbar role-admin">
		<div class="mobile-toggle" onclick="toggleSidebar()">
			<i class="fa-solid fa-bars"></i>
		</div>

		<div class="topbar-title">Admin Command Center</div>

		<div class="topbar-right">
			<div class="notification">
				<button class="icon-btn" type="button">
					<i class="fa-solid fa-bell"></i> <span>3</span>
				</button>
			</div>

			<div class="profile-section">
				<div class="profile-info">
					<div class="profile-name"><%=us.getName()%></div>
					<div class="profile-role"><%=us.getRole()%></div>
				</div>
				<div class="profile-img role-admin">
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
						const currentPath = window.location.pathname.toLowerCase();
						const pageAttr = (document.body.getAttribute('data-admin-page') || '')
							.toLowerCase();

						document.querySelectorAll('[data-admin-link]').forEach(link => {
							const linkType = (link.getAttribute('data-admin-link') || '')
								.toLowerCase();
							const linkHref = (link.getAttribute('href') || '').toLowerCase();

							if (pageAttr === linkType || currentPath.includes(linkHref)) {
								link.classList.add('active');
							}
						});
					})();
				</script>
</body>

</html>
