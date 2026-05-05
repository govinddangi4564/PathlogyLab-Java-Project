<%@page import="com.pathology.dao.ReportDao"%>
<%@page import="com.pathology.dao.PatientDao"%>
<%@page import="com.pathology.dao.UserDao"%>
<%@page import="com.mysql.cj.Session"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Admin Dashboard | Pathology Lab</title>

<link
	href="https://fonts.googleapis.com/css2?family=Outfit:wght@300;400;500;600;700&display=swap"
	rel="stylesheet">
<link
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css"
	rel="stylesheet">
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css"
	rel="stylesheet">

<style>
body {
	background: radial-gradient(circle at 20% 8%, #e0f2fe 0%, #f6f9ff 38%, #eef3fa 100%);
	font-family: 'Outfit', sans-serif;
}

.dashboard-wrap {
	max-width: 1320px;
	margin: 0 auto;
	animation: dashboardEnter 0.5s ease;
}

.hero {
	padding: 1.5rem;
	border-radius: 22px;
	background: linear-gradient(135deg, #0f172a 0%, #1e293b 52%, #312e81 100%);
	color: #fff;
	box-shadow: 0 20px 36px rgba(15, 23, 42, 0.18);
	margin-bottom: 1.1rem;
	display: flex;
	justify-content: space-between;
	gap: 16px;
	flex-wrap: wrap;
}

.hero .badge-chip {
	background: rgba(255, 255, 255, 0.14);
	border: 1px solid rgba(255, 255, 255, 0.28);
	padding: 6px 12px;
	border-radius: 999px;
	font-size: 0.75rem;
	font-weight: 600;
	letter-spacing: 0.4px;
	text-transform: uppercase;
	display: inline-flex;
	align-items: center;
	gap: 6px;
	margin-bottom: 0.75rem;
}

.page-title {
	font-weight: 700;
	font-size: 2rem;
	margin-bottom: 6px;
}

.hero .page-title {
	color: #f8fbff;
}

.page-subtitle {
	color: #dbeafe;
	margin-bottom: 0;
	max-width: 700px;
}

.hero .page-subtitle {
	color: #dbeafe;
}

.hero-meta {
	display: flex;
	gap: 12px;
	align-items: center;
	flex-wrap: wrap;
}

.hero-meta .meta-pill {
	background: rgba(255, 255, 255, 0.16);
	border: 1px solid rgba(255, 255, 255, 0.24);
	border-radius: 12px;
	padding: 10px 14px;
	font-size: 0.85rem;
	font-weight: 500;
	white-space: nowrap;
}

.cards-grid {
	display: grid;
	grid-template-columns: repeat(auto-fit, minmax(220px, 1fr));
	gap: 14px;
	margin-bottom: 1rem;
}

.stat-card {
	position: relative;
	border-radius: 18px;
	padding: 18px;
	box-shadow: 0 14px 30px rgba(15, 23, 42, 0.08);
	overflow: hidden;
	color: #0f172a;
	border: 1px solid rgba(148, 163, 184, 0.24);
	background: #fff;
}

.stat-card::after {
	content: "";
	position: absolute;
	top: -28px;
	right: -24px;
	width: 96px;
	height: 96px;
	border-radius: 50%;
	background: rgba(255, 255, 255, 0.32);
}

.stat-card .icon {
	width: 40px;
	height: 40px;
	border-radius: 12px;
	display: flex;
	align-items: center;
	justify-content: center;
	margin-bottom: 10px;
	font-size: 0.98rem;
	background: rgba(255, 255, 255, 0.42);
	border: 1px solid rgba(255, 255, 255, 0.4);
}

.stat-card .label {
	font-size: 0.85rem;
	font-weight: 600;
	margin-bottom: 6px;
	opacity: 0.95;
}

.stat-card .value {
	font-size: 1.8rem;
	font-weight: 700;
	margin-bottom: 1px;
	line-height: 1.15;
}

.stat-card .meta {
	font-size: 0.8rem;
	font-weight: 600;
	opacity: 0.95;
}

.card-patients {
	background: linear-gradient(135deg, #dbeafe 0%, #bfdbfe 100%);
	color: #1e3a8a;
}

.card-reports {
	background: linear-gradient(135deg, #dcfce7 0%, #bbf7d0 100%);
	color: #166534;
}

.card-uploads {
	background: linear-gradient(135deg, #fef3c7 0%, #fde68a 100%);
	color: #92400e;
}

.card-pending {
	background: linear-gradient(135deg, #fee2e2 0%, #fecaca 100%);
	color: #991b1b;
}

.panel {
	background: rgba(255, 255, 255, 0.88);
	border: 1px solid #dbe6f2;
	border-radius: 18px;
	padding: 18px;
	box-shadow: 0 12px 26px rgba(15, 23, 42, 0.06);
	height: 100%;
	backdrop-filter: blur(8px);
}

.panel h5 {
	font-weight: 700;
	margin-bottom: 14px;
	color: #0f172a;
	font-size: 1.02rem;
}

.activity-list {
	list-style: none;
	padding-left: 0;
	margin-bottom: 0;
}

.activity-list li {
	display: flex;
	justify-content: space-between;
	gap: 12px;
	padding: 12px 0;
	border-bottom: 1px dashed #dbe6f2;
	font-size: 0.92rem;
	color: #1e293b;
}

.activity-list li:last-child {
	border-bottom: none;
	padding-bottom: 4px;
}

.activity-time {
	color: #64748b;
	white-space: nowrap;
	font-size: 0.8rem;
}

.quick-actions {
	display: grid;
	grid-template-columns: 1fr;
	gap: 10px;
}

.quick-actions .btn {
	border-radius: 12px;
	font-weight: 600;
	padding: 10px 12px;
	text-align: left;
	display: flex;
	align-items: center;
	gap: 8px;
}

.btn-upload {
	background: #2563eb;
	border-color: #2563eb;
	color: #fff;
}

.btn-upload:hover {
	background: #1d4ed8;
	border-color: #1d4ed8;
	color: #fff;
}

.btn-review {
	border-color: #93c5fd;
	color: #1e40af;
	background: #eff6ff;
}

.btn-review:hover {
	background: #dbeafe;
	border-color: #60a5fa;
	color: #1d4ed8;
}

.btn-patients {
	border-color: #a7f3d0;
	color: #065f46;
	background: #ecfdf5;
}

.btn-patients:hover {
	background: #d1fae5;
	border-color: #6ee7b7;
	color: #047857;
}

@
keyframes dashboardEnter {from { opacity:0;
	transform: translateY(14px);
}

to {
	opacity: 1;
	transform: translateY(0);
}

}
@media ( max-width : 992px) {
	.hero {
		padding: 1.25rem;
	}
	.page-title {
		font-size: 1.65rem;
	}
}
</style>
<link rel="stylesheet" type="text/css"
	href="<%=request.getContextPath()%>/Css/app-theme.css">
</head>

<body data-admin-page="dashboard">

	<%@ include file="Components/auth.jsp"%>

	<%
	String role = (String) mySession.getAttribute("role");

	if ("ADMIN".equals(role)) {
	%>
	<jsp:include page="adminSidebar.jsp" />

	<%
	PatientDao pdao = new PatientDao();
	ReportDao rdao = new ReportDao();
	int patient = pdao.totalPatients();
	int report = rdao.totalReports();
	int pendingReport = rdao.totalPendingReports();
	int todayUpload = rdao.todayUploadedReports();
	%>


	<div class="main-content">
		<div class="dashboard-wrap">

			<%@ include file="Components/message.jsp"%>

			<div class="hero">
				<div>
					<div class="badge-chip">
						<i class="fa-solid fa-shield-halved"></i> Admin Control Panel
					</div>
					<h2 class="page-title">Admin Dashboard</h2>
					<p class="page-subtitle">Monitor report operations, review
						pending work, and keep patient records under control from one
						command view.</p>
				</div>
				<div class="hero-meta">
					<div class="meta-pill">
						<i class="fa-solid fa-database"></i> Live System Snapshot
					</div>
					<div class="meta-pill">
						<i class="fa-solid fa-clock"></i> Last update: just now
					</div>
				</div>
			</div>

			<div class="cards-grid">
				<div class="stat-card card-patients">
					<div class="icon">
						<i class="fa-solid fa-users"></i>
					</div>
					<p class="label mb-0">Total Patients</p>
					<p class="value">
						<%=patient%>
					</p>
					<div class="meta">+8 this week</div>
				</div>
				<div class="stat-card card-reports">
					<div class="icon">
						<i class="fa-solid fa-file-lines"></i>
					</div>
					<p class="label mb-0">Total Reports</p>
					<p class="value">
						<%=report%>
					</p>
					<div class="meta">95% delivery success</div>
				</div>
				<div class="stat-card card-uploads">
					<div class="icon">
						<i class="fa-solid fa-cloud-arrow-up"></i>
					</div>
					<p class="label mb-0">Today's Uploads</p>
					<p class="value"><%=todayUpload%></p>
					<div class="meta">12 pending review</div>
				</div>
				<div class="stat-card card-pending">
					<div class="icon">
						<i class="fa-solid fa-hourglass-half"></i>
					</div>
					<p class="label mb-0">Pending Reports</p>
					<p class="value">
						<%=pendingReport%>
					</p>
					<div class="meta">Needs action today</div>
				</div>
			</div>

			<div class="row g-3">
				<div class="col-lg-8">
					<div class="panel">
						<h5>Recent Admin Activity</h5>
						<ul class="activity-list">
							<li><span>CBC report uploaded for Rahul Sharma</span><span
								class="activity-time">09:20 AM</span></li>
							<li><span>X-Ray report approved and published</span><span
								class="activity-time">10:15 AM</span></li>
							<li><span>User profile updated for Priya Nair</span><span
								class="activity-time">11:40 AM</span></li>
							<li><span>2 reports marked for re-check</span><span
								class="activity-time">12:05 PM</span></li>
						</ul>
					</div>
				</div>
				<div class="col-lg-4">
					<div class="panel h-100">
						<h5>Quick Actions</h5>
						<div class="quick-actions">
							<a href="uploadReport.jsp" class="btn btn-upload btn-sm"><i
								class="fa-solid fa-upload"></i> Upload Report</a> <a
								href="<%=request.getContextPath()%>/viewAllReports"
								class="btn btn-review btn-sm"><i
								class="fa-solid fa-file-medical"></i> Review Reports</a> <a
								href="<%=request.getContextPath()%>/viewPatients"
								class="btn btn-patients btn-sm"><i class="fa-solid fa-users"></i>
								Patient List</a>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>

	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/js/bootstrap.bundle.min.js"></script>

	<%
	} else {
	response.sendRedirect(request.getContextPath() + "/Pages/unauthorizedUser.jsp");
	return;
	}
	%>


</body>

</html>