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

<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/Css/sidebar.css">

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
</body>
</html>