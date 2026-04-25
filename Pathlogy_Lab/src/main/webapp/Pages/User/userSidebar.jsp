<%@page import="com.pathology.model.User"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

<head>
<meta charset="UTF-8">
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
	<%@ include file="../Components/auth.jsp"%>

	<%
	String name = u.getName();
	String role = u.getRole();
	String email = u.getEmail();
	request.setAttribute("email", email);
	%>

	<div class="sidebar role-user" id="userSidebar">
		<div class="sidebar-header">
			<h3>
				<i class="fa-solid fa-microscope"></i> PathLab User
			</h3>
			<div class="role-badge">Patient Portal</div>
		</div>

		<span class="nav-label">Main Menu</span> <a
			href="<%=request.getContextPath()%>/Pages/User/user-dashboard.jsp"
			data-user-link="dashboard"> <i class="fa-solid fa-user"></i>
			Dashboard
		</a> <a href="<%=request.getContextPath()%>/userViewReports"
			data-user-link="reports"> <i class="fa-solid fa-file-medical"></i>
			My Reports
		</a> <a href="#" data-user-link="appointments"> <i
			class="fa-solid fa-calendar-check"></i> Appointments
		</a> <span class="nav-label">Settings</span> <a
			href="<%=request.getContextPath()%>/Pages/changePassword.jsp"
			data-user-link="password"> <i class="fa-solid fa-lock"></i>
			Change Password
		</a>

		<div class="bottom-nav">
			<div class="role-quick-links">
				<a href="#"><i class="fa-solid fa-file-waveform"></i> Test
					Timeline</a> <a href="#"><i class="fa-solid fa-headset"></i> Help
					Desk</a>
			</div>
			<a href="<%=request.getContextPath()%>/logout" class="logout-link"
				class="btn btn-outline-danger btn-sm"
				onclick="return confirm('Are you sure you want to Logout ?');">
				<i class="fa-solid fa-right-from-bracket"></i> Logout
			</a>
		</div>
	</div>

	<div class="topbar role-user">
		<div class="mobile-toggle" onclick="toggleSidebar()">
			<i class="fa-solid fa-bars"></i>
		</div>

		<div class="topbar-title">Patient Self Service</div>

		<div class="topbar-right">
			<div class="notification">
				<button class="icon-btn" type="button">
					<i class="fa-solid fa-bell"></i> <span>3</span>
				</button>
			</div>

			<div class="profile-section">
				<div class="profile-info">
					<div class="profile-name">
						<%=name%>
					</div>
					<div class="profile-role">
						<%=role%>
					</div>
				</div>
				<div class="profile-img role-user">
					<i class="fa-solid fa-user-shield"></i>
				</div>
			</div>
		</div>
	</div>

	<script>
					// 1. Mobile Sidebar Toggle
					function toggleSidebar() {
						document.getElementById('userSidebar').classList.toggle('active');
					}

					// 2. Active Link Handler
					(function () {
						// Detect current page from URL or Body Attribute
						const currentPath = window.location.pathname.toLowerCase();
						const pageAttr = (document.body.getAttribute('data-user-page')
							|| document.body.getAttribute('data-admin-page') || '')
							.toLowerCase();

						document.querySelectorAll('[data-user-link]').forEach(link => {
							const linkType = (link.getAttribute('data-user-link') || '')
								.toLowerCase();
							const linkHref = (link.getAttribute('href') || '')
								.toLowerCase();

							if (pageAttr === linkType || currentPath.includes(linkHref)) {
								link.classList.add('active');
							}
						});
					})();
				</script>
</body>

</html>
