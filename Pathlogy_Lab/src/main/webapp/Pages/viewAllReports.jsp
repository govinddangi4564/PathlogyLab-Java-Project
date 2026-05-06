<%@page import="com.pathology.dao.ReportDao"%>
<%@page import="jakarta.websocket.Session"%>
<%@page import="java.util.List"%>
<%@page import="com.pathology.model.Report"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>View Reports | Admin Panel</title>

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
	font-family: 'Outfit', sans-serif;
	background: #f8f9fa;
}

.main-content {
	max-width: 1240px;
	margin: 0 auto;
	padding: 24px 16px 40px;
	float: none;
}

.page-header {
	text-align: center;
	margin-bottom: 20px;
}

.page-title {
	font-weight: 700;
	font-size: 1.8rem;
	margin-bottom: 6px;
}

.page-subtitle {
	color: #64748b;
	margin-bottom: 0;
	font-size: 0.95rem;
}

.summary-grid {
	margin: 0 auto 20px;
}

.summary-box {
	background: #fff;
	border: 1px solid #dee2e6;
	border-radius: 0.75rem;
	padding: 1rem;
	text-align: center;
}

.summary-box .title {
	font-size: 0.82rem;
	color: #6c757d;
	text-transform: uppercase;
	letter-spacing: 0.04em;
}

.summary-box .count {
	font-size: 1.5rem;
	font-weight: 700;
	margin-top: 4px;
}

.panel {
	background: #fff;
	border: 1px solid #dee2e6;
	border-radius: 0.75rem;
	padding: 1rem;
}

.filter-row .form-control, .filter-row .form-select {
	border-radius: 0.5rem;
	min-height: 42px;
}

.filter-row .btn {
	height: 42px;
}

.table thead th {
	background: #f8f9fa;
	color: #212529;
	font-weight: 600;
	font-size: 0.9rem;
	border-bottom: 1px solid #dee2e6;
}

.table tbody td {
	vertical-align: middle;
}

.table tbody tr:hover {
	background: #f8f9fa;
}

.badge-soft {
	padding: 0.4rem 0.75rem;
	border-radius: 50rem;
	font-size: 0.76rem;
	font-weight: 700;
}

.badge-published {
	background: #dcfce7;
	color: #166534;
}

.badge-pending {
	background: #fef3c7;
	color: #92400e;
}

.badge-soft {
	padding: 5px 10px;
	border-radius: 12px;
	font-size: 12px;
	font-weight: 600;
}

/* Pending - Yellow */
.badge-pending {
	background-color: #fff3cd;
	color: #856404;
}

/* Completed - Blue */
.badge-completed {
	background-color: #cce5ff;
	color: #004085;
}

/* Delivered - Green */
.badge-delivered {
	background-color: #d4edda;
	color: #155724;
}

.actions-wrap {
	display: flex;
	gap: 8px;
	align-items: center;
	flex-wrap: wrap;
	min-width: 300px;
}

.actions-wrap .btn {
	display: inline-flex;
	align-items: center;
	justify-content: center;
	gap: 6px;
	height: 34px;
	min-width: 110px;
	padding: 0 12px;
	white-space: nowrap;
	font-weight: 600;
	border-radius: 0.5rem;
}

.actions-wrap form {
	margin: 0;
}

.actions-wrap form .btn {
	width: 100%;
}

.pagination-wrap {
	display: flex;
	justify-content: center;
	align-items: center;
	gap: 14px;
	flex-wrap: wrap;
	padding-top: 1rem;
	border-top: 1px solid #dee2e6;
	margin-top: 1rem;
}

.pagination-summary {
	font-size: 0.9rem;
	color: #64748b;
}

.pagination {
	gap: 4px;
}

.pagination .page-link {
	color: #0d6efd;
	border-color: #dee2e6;
	font-weight: 600;
	border-radius: 0.5rem;
	min-width: 40px;
	text-align: center;
}

.pagination .page-item.active .page-link {
	background: #0d6efd;
	border-color: #0d6efd;
	color: #fff;
}

@media ( max-width : 768px) {
	.page-title {
		font-size: 1.4rem;
	}
	.page-subtitle {
		font-size: 0.92rem;
		margin-bottom: 14px;
	}
	.panel {
		padding: 1rem;
	}
	.summary-grid {
		margin-bottom: 1rem;
	}
	.table thead th {
		font-size: 0.78rem;
		white-space: nowrap;
	}
	.table tbody td {
		font-size: 0.82rem;
		white-space: nowrap;
	}
	.actions-wrap {
		min-width: 210px;
	}
	.actions-wrap .btn, .actions-wrap form {
		flex: 1 1 calc(50% - 8px);
		min-width: 0;
	}
	.actions-wrap form .btn {
		width: 100%;
	}
	.pagination-wrap {
		flex-direction: column;
		align-items: stretch;
	}
	.pagination-wrap .pagination {
		justify-content: center;
	}
	.pagination-summary {
		text-align: center;
	}
}

@media ( max-width : 480px) {
	.summary-grid {
		margin-bottom: 1rem;
	}
	.actions-wrap {
		min-width: 180px;
	}
	.actions-wrap .btn, .actions-wrap form {
		flex: 1 1 100%;
	}
}
</style>
<link rel="stylesheet" type="text/css"
	href="<%=request.getContextPath()%>/Css/app-theme.css">
</head>

<body data-admin-page="reports">

	<%@ include file="Components/auth.jsp"%>
	<%@ include file="Components/loader.jsp"%>

	<%
	String role = (String) mySession.getAttribute("role");
	if ("ADMIN".equalsIgnoreCase(role) || "STAFF".equalsIgnoreCase(role)) {
	%>

	<%
	if ("STAFF".equals(role)) {
	%>
	<jsp:include page="Staff/staffSidebar.jsp" />
	<%
	} else if ("ADMIN".equals(role)) {
	%>
	<jsp:include page="adminSidebar.jsp" />
	<%
	}
	%>

	<%
	List<Report> list = (List<Report>) request.getAttribute("reportList");
	%>

	<%
	ReportDao dao = new ReportDao();
	int totalReport = dao.totalReports();
	int pending = dao.totalPendingReports();
	int complete = dao.totalCompletedReports();
	int delivered = dao.totalDeliveredReports();
	%>

	<div class="main-content">

		<%@ include file="Components/message.jsp"%>

		<div class="page-header">
			<div class="d-flex justify-content-between align-items-start">
				<div>
					<h2 class="page-title">All Reports</h2>
					<p class="page-subtitle">Review uploaded records, check
						statuses, and take admin actions.</p>
				</div>
				<button onclick="history.back()"
					class="btn btn-outline-secondary btn-sm">
					<i class="fas fa-arrow-left me-2"></i>Back
				</button>
			</div>
		</div>

		<div class="summary-grid row g-3 justify-content-center">
			<div class="col-12 col-sm-6 col-xl-3">
				<div class="summary-box h-100">
					<div class="title">Total Reports</div>
					<div class="count">
						<%=totalReport%>
					</div>
				</div>
			</div>

			<div class="col-12 col-sm-6 col-xl-3">
				<div class="summary-box h-100">
					<div class="title">Pending Reports</div>
					<div class="count">
						<%=pending%>
					</div>
				</div>
			</div>
			<div class="col-12 col-sm-6 col-xl-3">
				<div class="summary-box h-100">
					<div class="title">Complete Reports</div>
					<div class="count">
						<%=complete%>
					</div>
				</div>
			</div>
			<div class="col-12 col-sm-6 col-xl-3">
				<div class="summary-box h-100">
					<div class="count">
						<%=delivered%>
					</div>
					<div class="title">Delivered reports</div>
				</div>
			</div>
		</div>

		<div class="panel card shadow-sm">
			<div class="row g-2 filter-row mb-3">
				<form action="<%=request.getContextPath()%>/filterReport"
					method="get" class="row g-2 w-100 align-items-end mx-0">

					<!-- Search Input -->
					<div class="col-12 col-sm-6 col-lg-4">
						<input type="text" id="searchInput" class="form-control"
							name="search"
							placeholder="Search by patient ID, report name or status">
					</div>

					<!-- Report Type -->
					<div class="col-6 col-sm-6 col-lg-2">
						<select class="form-select" name="type">
							<option value="">All Types</option>
							<option value="Blood Test">Blood Test</option>
							<option value="X-Ray">X-Ray</option>
							<option value="MRI Scan">MRI Scan</option>
							<option value="CT Scan">CT Scan</option>
							<option value="Ultrasound">Ultrasound</option>
							<option value="Urine Test">Urine Test</option>
							<option value="Biopsy">Biopsy</option>
							<option value="ECG">ECG</option>
							<option value="Other">Other</option>
						</select>
					</div>

					<!-- Status -->
					<div class="col-6 col-sm-6 col-lg-2">
						<select class="form-select" name="status">
							<option value="">All Status</option>
							<option value="Pending">Pending</option>
							<option value="Completed">Complete</option>
							<option value="Delivered">Delivered</option>
						</select>
					</div>

					<!-- Sort -->
					<div class="col-6 col-sm-6 col-lg-2">
						<select class="form-select" name="sort">
							<option value="">Sort By</option>
							<option value="date_desc">Newest First</option>
							<option value="date_asc">Oldest First</option>
							<option value="name_asc">Name (A → Z)</option>
							<option value="name_desc">Name (Z → A)</option>
						</select>
					</div>

					<!-- Button -->
					<div class="col-6 col-sm-6 col-lg-2 d-grid">
						<button type="submit" class="btn btn-outline-secondary">
							Filter</button>
					</div>

				</form>
			</div>


			<div class="table-responsive">
				<table class="table table-hover align-middle mb-0">
					<thead>
						<tr>
							<th>S.No</th>
							<th>Patient ID</th>
							<th>Patient Name</th>
							<th>Report Name</th>
							<th>Date</th>
							<th>Status</th>
							<th>Action</th>
						</tr>
					</thead>
					<tbody id="reportTable">

						<%
						int count = 1;
						if (list != null) {
							for (Report r : list) {
						%>
						<tr>
							<td><%=count++%></td>
							<td><%=r.getPatientId()%></td>
							<td><%=r.getPatientName()%></td>
							<td><%=r.getReportName()%></td>
							<td><%=r.getReportDate()%></td>
							<td>
								<%
								String status = r.getStatus();
								String badgeClass = "bg-secondary";
								if ("Pending".equalsIgnoreCase(status)) {
									badgeClass = "bg-warning text-dark";
								} else if ("Completed".equalsIgnoreCase(status)) {
									badgeClass = "bg-primary";
								} else if ("Delivered".equalsIgnoreCase(status)) {
									badgeClass = "bg-success";
								}
								%> <span
								class="badge rounded-pill <%=badgeClass%>"> <%=status%>
							</span>
							</td>

							<td>
								<div class="actions-wrap">

									<!-- Download -->
									<a href="downloadReport?file=<%=r.getReportPath()%>"
										class="btn btn-outline-success btn-sm"> <i
										class="fa-solid fa-download"></i><span>Download</span>
									</a>

									<!-- Delete -->
									<%
									if ("ADMIN".equalsIgnoreCase(role)) {
									%>
									<a href="deleteReport?id=<%=r.getId()%>"
										class="btn btn-outline-danger btn-sm"
										onclick="return confirm('Are you sure you want to delete this report?');">
										<i class="fa-solid fa-trash"></i><span>Delete</span>
									</a>
									<%
									}
									%>
									<!-- Send / Resend -->
									<form action="sendReport" method="post" class="m-0">
										<input type="hidden" name="id" value="<%=r.getId()%>">
										<button type="submit" class="btn btn-outline-primary btn-sm">
											<i class="fa-solid fa-paper-plane"></i><span> <%=r.isEmailSent() ? "Resend" : "Send"%>
											</span>
										</button>
									</form>

									<!-- Mark as Delivered -->
									<%
									String sts = r.getStatus();
									if ("ADMIN".equalsIgnoreCase(role) && "Completed".equalsIgnoreCase(sts)) {
									%>
									<form action="updateReportStatus" method="post" class="m-0">
										<input type="hidden" name="id" value="<%=r.getId()%>">
										<button type="submit" class="btn btn-outline-success btn-sm">
											<i class="fa-solid fa-circle-check"></i><span>Delivered</span>
										</button>
									</form>
									<%
									}
									%>

								</div>
							</td>
						</tr>

						<%
						}
						}
						%>
					</tbody>

				</table>
			</div>

			<div class="pagination-wrap">
				<nav aria-label="Reports pagination">
					<ul class="pagination justify-content-center mb-0">

						<%
						if (totalReport < 15) {
						} else {
							for (int i = 0, j = 1; i <= totalReport; i = i + 15, j++) {
						%>

						<li class="page-item active"><a class="page-link"
							href="<%=request.getContextPath()%>/viewAllReportsByOffset?offset=<%=i%>">
								<%=j%>
						</a></li>
						<%
						}
						}
						%>
					</ul>
				</nav>
			</div>
		</div>
	</div>

	<script>
																setTimeout(function () {
																	let alert = document.getElementById("alertMsg");
																	if (alert) {
																		alert.classList.remove("show");
																		alert.classList.add("fade");
																		setTimeout(() => alert.remove(), 500);
																	}
																}, 3000); // 3 seconds
															</script>

	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/js/bootstrap.bundle.min.js"></script>
	<script src="<%=request.getContextPath()%>/Js/admin-dashboard.js"></script>

	<%
	} else {
	response.sendRedirect(request.getContextPath() + "/Pages/unauthorizedUser.jsp");
	return;
	}
	%>

</body>

</html>