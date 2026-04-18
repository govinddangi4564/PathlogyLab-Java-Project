<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page session="false"%>
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

<link rel="stylesheet" type="text/css" href="../../Css/sidebar.css">

</head>

<body>

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
					document.getElementById('userSidebar').classList.toggle('active');
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