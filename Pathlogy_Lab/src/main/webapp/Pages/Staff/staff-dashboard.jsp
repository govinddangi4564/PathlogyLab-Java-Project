<%@page import="com.pathology.model.User"%>
<%@page import="com.pathology.dao.ReportDao"%>
<%@page import="com.pathology.dao.PatientDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">

<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Staff Dashboard | PathLab</title>

<link
	href="https://fonts.googleapis.com/css2?family=Sora:wght@300;400;500;600;700&display=swap"
	rel="stylesheet">
<link
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css"
	rel="stylesheet">
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css"
	rel="stylesheet">

<style>
body {
	font-family: "Sora", sans-serif;
	margin: 0;
	background: radial-gradient(circle at 10% 10%, #fef9c3 0%, #ecfeff 38%, #f8fafc 100%
		);
	color: #0f172a;
}

.main-content {
	margin-left: 265px;
	padding: 28px;
	min-height: calc(100vh - 72px);
	animation: contentFade 0.6s ease;
}

@
keyframes contentFade {from { opacity:0;
	transform: translateY(14px);
}

to {
	opacity: 1;
	transform: translateY(0);
}

}
.page-head {
	margin-bottom: 20px;
}

.page-head h2 {
	font-weight: 700;
	font-size: 1.9rem;
	margin-bottom: 6px;
}

.page-head p {
	margin: 0;
	color: #475569;
	font-size: 0.95rem;
}

.stats-grid {
	display: grid;
	grid-template-columns: repeat(auto-fit, minmax(220px, 1fr));
	gap: 16px;
	margin-bottom: 22px;
}

.stat-card {
	border-radius: 18px;
	padding: 18px;
	color: #fff;
	position: relative;
	overflow: hidden;
	box-shadow: 0 14px 24px rgba(15, 23, 42, 0.12);
}

.stat-card::after {
	content: "";
	position: absolute;
	top: -24px;
	right: -24px;
	width: 92px;
	height: 92px;
	border-radius: 50%;
	background: rgba(255, 255, 255, 0.14);
}

.stat-icon {
	width: 40px;
	height: 40px;
	border-radius: 12px;
	background: rgba(255, 255, 255, 0.2);
	display: flex;
	align-items: center;
	justify-content: center;
	margin-bottom: 12px;
	font-size: 1rem;
}

.stat-label {
	font-size: 0.84rem;
	font-weight: 500;
	opacity: 0.9;
	margin: 0;
}

.stat-value {
	font-size: 1.85rem;
	font-weight: 700;
	margin: 4px 0;
	line-height: 1.1;
}

.stat-meta {
	font-size: 0.78rem;
	opacity: 0.95;
	margin: 0;
}

.tone-a {
	background: linear-gradient(135deg, #0f766e 0%, #14b8a6 100%);
}

.tone-b {
	background: linear-gradient(135deg, #0369a1 0%, #38bdf8 100%);
}

.tone-c {
	background: linear-gradient(135deg, #854d0e 0%, #f59e0b 100%);
}

.tone-d {
	background: linear-gradient(135deg, #b91c1c 0%, #ef4444 100%);
}

.panel {
	background: rgba(255, 255, 255, 0.88);
	border: 1px solid #dde8f4;
	border-radius: 16px;
	padding: 18px;
	box-shadow: 0 10px 30px rgba(15, 23, 42, 0.06);
	height: 100%;
}

.panel h5 {
	margin-bottom: 12px;
	font-weight: 700;
	font-size: 1.02rem;
	color: #0f172a;
}

.activity-list {
	list-style: none;
	padding: 0;
	margin: 0;
}

.activity-list li {
	display: flex;
	justify-content: space-between;
	gap: 10px;
	padding: 10px 0;
	border-bottom: 1px dashed #cbd5e1;
	font-size: 0.9rem;
	color: #334155;
}

.activity-list li:last-child {
	border-bottom: none;
	padding-bottom: 2px;
}

.activity-time {
	color: #64748b;
	font-size: 0.79rem;
	white-space: nowrap;
}

.quick-actions {
	display: flex;
	flex-wrap: wrap;
	gap: 10px;
}

.quick-actions .btn {
	border-radius: 10px;
	padding: 9px 14px;
	font-size: 0.85rem;
	font-weight: 600;
}

@media ( max-width : 992px) {
	.main-content {
		margin-left: 0;
		padding: 20px;
	}
	.page-head h2 {
		font-size: 1.6rem;
	}
}
</style>
<link rel="stylesheet" type="text/css"
	href="<%=request.getContextPath()%>/Css/app-theme.css">
</head>

<body data-staff-page="dashboard">

	<%@ include file="../Components/auth.jsp"%>

	<%
	String role = (String) mySession.getAttribute("role");
	if ("STAFF".equals(role)) {
	%>
	<jsp:include page="staffSidebar.jsp" />

	<%
	PatientDao pDao = new PatientDao();
	ReportDao rDao = new ReportDao();
	int totalPatient = pDao.totalPatients();
	int totalReport = rDao.totalReports();
	int pendingReport = rDao.totalPendingReports();
	%>

	<div class="main-content">

		<%@ include file="../Components/message.jsp"%>

		<div class="page-head">
			<div class="d-flex justify-content-between align-items-start">
				<div>
					<h2>
						<%=u.getName()%>
					</h2>
					<p>Track report flow, monitor pending work, and manage patient
						records quickly from one place.</p>
				</div>
				<button onclick="history.back()"
					class="btn btn-outline-secondary btn-sm">
					<i class="fas fa-arrow-left me-2"></i>Back
				</button>
			</div>
		</div>

		<div class="stats-grid">
			<div class="stat-card tone-a">
				<div class="stat-icon">
					<i class="fa-solid fa-users"></i>
				</div>
				<p class="stat-label">Registered Patients</p>
				<p class="stat-value">
					<%=totalPatient%>
				</p>
				<p class="stat-meta">Updated from central patient records</p>
			</div>

			<div class="stat-card tone-b">
				<div class="stat-icon">
					<i class="fa-solid fa-file-lines"></i>
				</div>
				<p class="stat-label">Reports Uploaded</p>
				<p class="stat-value">
					<%=totalReport%>
				</p>
				<p class="stat-meta">Complete historical report volume</p>
			</div>

			<div class="stat-card tone-c">
				<div class="stat-icon">
					<i class="fa-solid fa-hourglass-half"></i>
				</div>
				<p class="stat-label">Pending Reports</p>
				<p class="stat-value">
					<%=pendingReport%>
				</p>
				<p class="stat-meta">Awaiting review and final publishing</p>
			</div>

			<div class="stat-card tone-d">
				<div class="stat-icon">
					<i class="fa-solid fa-triangle-exclamation"></i>
				</div>
				<p class="stat-label">Priority Queue</p>
				<p class="stat-value">0</p>
				<p class="stat-meta">Auto-derived from pending report count</p>
			</div>
		</div>

		<div class="row g-3">
			<div class="col-lg-8">
				<div class="panel">
					<h5>Recent Lab Floor Activity</h5>
					<ul class="activity-list">
						<li><span>CBC report prepared for emergency patient</span><span
							class="activity-time">08:40 AM</span></li>
						<li><span>Lipid profile validated and sent for
								approval</span><span class="activity-time">09:25 AM</span></li>
						<li><span>Technician updated sample barcode mismatch</span><span
							class="activity-time">10:05 AM</span></li>
						<li><span>Radiology PDF attached to patient report</span><span
							class="activity-time">11:20 AM</span></li>
					</ul>
				</div>
			</div>

			<div class="col-lg-4">
				<div class="panel">
					<h5>Quick Actions</h5>
					<div class="quick-actions">
						<a href="<%=request.getContextPath()%>/Pages/uploadReport.jsp"
							class="btn btn-success">Upload Report</a> <a
							href="<%=request.getContextPath()%>/viewAllReports"
							class="btn btn-outline-primary">Review Reports</a> <a
							href="<%=request.getContextPath()%>/viewPatients"
							class="btn btn-outline-dark">View Patients</a> <a
							href="<%=request.getContextPath()%>/Pages/changePassword.jsp"
							class="btn btn-outline-secondary">Change Password</a>
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