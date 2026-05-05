<%@page import="com.pathology.model.User"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">

<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Staff Navigation | PathLab</title>

<link
	href="https://fonts.googleapis.com/css2?family=Sora:wght@300;400;500;600;700&display=swap"
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

	String role = (String) session.getAttribute("role");

	if ("STAFF".equals(role)) {
	%>

	<div class="sidebar role-staff" id="staffSidebar">
		<div class="sidebar-header">
			<h3>
				<i class="fa-solid fa-flask-vial"></i> PathLab Staff
			</h3>
			<div class="role-badge">Staff Operations</div>
		</div>

		<span class="nav-label">Overview</span> <a
			href="<%=request.getContextPath()%>/Pages/Staff/staff-dashboard.jsp"
			data-staff-link="dashboard"> <i class="fa-solid fa-gauge-high"></i>
			Dashboard
		</a> <a href="<%=request.getContextPath()%>/Pages/uploadReport.jsp"
			data-staff-link="upload"> <i class="fa-solid fa-cloud-arrow-up"></i>
			Upload Report
		</a> <a href="<%=request.getContextPath()%>/viewAllReports"
			data-staff-link="reports"> <i class="fa-solid fa-file-medical"></i>
			View Reports
		</a> <span class="nav-label">Management</span> <a
			href="<%=request.getContextPath()%>/Pages/managePatients.jsp"
			data-staff-link="patients"> <i class="fa-solid fa-users"></i>
			Patients
		</a> <a
			href="<%=request.getContextPath()%>/viewAppointmentReport?key=todayOrAfter"
			data-admin-link="appointments"> <i class="fa-solid fa-file-lines"></i>
			Appointments
		</a> <a href="<%=request.getContextPath()%>/Pages/changePassword.jsp"
			data-staff-link="password"> <i class="fa-solid fa-key"></i>
			Change Password
		</a>

		<div class="bottom-nav">
			<div class="role-quick-links">
				<a href="#"><i class="fa-solid fa-vial-circle-check"></i>
					Today's Queue</a> <a href="#"><i class="fa-solid fa-user-check"></i>
					Verified Cases</a>
			</div>
			<a href="<%=request.getContextPath()%>/logout" class="logout-link"
				onclick="return confirm('Are you sure you want to logout?');"> <i
				class="fa-solid fa-right-from-bracket"></i> Logout
			</a>
		</div>
	</div>

	<div class="topbar role-staff">
		<div class="mobile-toggle" onclick="toggleSidebar()">
			<i class="fa-solid fa-bars"></i>
		</div>

		<div class="topbar-title">Staff Operations Console</div>

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
				<div class="profile-img role-staff">
					<i class="fa-solid fa-user-shield"></i>
				</div>
			</div>
		</div>
	</div>

	<script>
		function toggleSidebar() {
			document.getElementById("staffSidebar").classList.toggle("active");
		}

		(function() {
			const pageAttr = (document.body.getAttribute("data-staff-page")
					|| document.body.getAttribute("data-admin-page") || "")
					.toLowerCase();
			const currentPath = window.location.pathname.toLowerCase();

			document.querySelectorAll("[data-staff-link]").forEach(
					function(link) {
						const key = link.getAttribute("data-staff-link");
						const href = (link.getAttribute("href") || "")
								.toLowerCase();

						if (pageAttr === key
								|| (href && currentPath.includes(href))) {
							link.classList.add("active");
						}
					});
		})();
	</script>

	<%
	} else {
	response.sendRedirect(request.getContextPath() + "/Pages/unauthorizedUser.jsp");
	return;
	}
	%>

</body>

</html>
