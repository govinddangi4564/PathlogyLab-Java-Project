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
.page-title {
	font-weight: 700;
	font-size: 1.8rem;
	margin-bottom: 6px;
}

.page-subtitle {
	color: #64748b;
	margin-bottom: 24px;
}

.cards-grid {
	display: grid;
	grid-template-columns: repeat(auto-fit, minmax(210px, 1fr));
	gap: 18px;
	margin-bottom: 24px;
}

.stat-card {
	background: #fff;
	border: 1px solid #e2e8f0;
	border-radius: 16px;
	padding: 18px;
	box-shadow: 0 10px 24px rgba(15, 23, 42, 0.05);
}

.stat-card .label {
	font-size: 0.88rem;
	color: #64748b;
	margin-bottom: 8px;
}

.stat-card .value {
	font-size: 1.6rem;
	font-weight: 700;
	margin-bottom: 0;
	color: #0f172a;
}

.stat-card .meta {
	font-size: 0.82rem;
	color: #0b7a75;
	font-weight: 600;
}

.panel {
	background: #fff;
	border: 1px solid #e2e8f0;
	border-radius: 16px;
	padding: 18px;
	box-shadow: 0 10px 24px rgba(15, 23, 42, 0.05);
}

.panel h5 {
	font-weight: 700;
	margin-bottom: 14px;
}

.activity-list {
	list-style: none;
	padding-left: 0;
	margin-bottom: 0;
}

.activity-list li {
	display: flex;
	justify-content: space-between;
	gap: 10px;
	padding: 11px 0;
	border-bottom: 1px dashed #e2e8f0;
	font-size: 0.92rem;
}

.activity-list li:last-child {
	border-bottom: none;
}

.activity-time {
	color: #64748b;
	white-space: nowrap;
}

.quick-actions {
	display: flex;
	gap: 10px;
	flex-wrap: wrap;
}

.quick-actions .btn {
	border-radius: 10px;
}
</style>
</head>

<body data-admin-page="dashboard">

	<%@ include file="adminSidebar.jsp"%>



	<%
	PatientDao pdao = new PatientDao();
	ReportDao rdao = new ReportDao();
	
	int patient = pdao.totalPatients();
	int report = rdao.totalReports();
	int pendingReport = rdao.totalPendingReports();
	%>


	<div class="main-content">
		<h2 class="page-title">Admin Dashboard</h2>
		<p class="page-subtitle">Quick summary of report operations and
			patient records.</p>

		<div class="cards-grid">
			<div class="stat-card">
				<p class="label mb-0">Total Patients</p>
				<p class="value">
					<%=patient%>
				</p>
				<div class="meta">+8 this week</div>
			</div>
			<div class="stat-card">
				<p class="label mb-0">Total Reports</p>
				<p class="value">
					<%=report%>
				</p>
				<div class="meta">95% delivery success</div>
			</div>
			<div class="stat-card">
				<p class="label mb-0">Today's Uploads</p>
				<p class="value">null
				</p>
				<div class="meta">12 pending review</div>
			</div>
			<div class="stat-card">
				<p class="label mb-0">Pending Reports</p>
				<p class="value"><%=pendingReport %></p>
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
						<a href="uploadReport.jsp" class="btn btn-primary btn-sm">Upload
							Report</a> <a href="viewAllReports.jsp"
							class="btn btn-outline-primary btn-sm">Review Reports</a> <a
							href="getCandidate" class="btn btn-outline-secondary btn-sm">Patient
							List</a>
					</div>
				</div>
			</div>
		</div>
	</div>

	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/js/bootstrap.bundle.min.js"></script>

</body>

</html>