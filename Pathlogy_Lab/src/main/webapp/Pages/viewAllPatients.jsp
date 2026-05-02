<%@page import="com.pathology.dao.PatientDao" %>
	<%@page import="com.pathology.model.Patient" %>
		<%@page import="java.util.List" %>
			<%@page import="com.pathology.model.Report" %>
				<%@page import="java.sql.ResultSet" %>
					<%@page import="java.sql.Date" %>
						<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
							<!DOCTYPE html>
							<html>

							<head>
								<meta charset="UTF-8">
								<meta name="viewport" content="width=device-width, initial-scale=1">
								<title>Patient Records | Pathology Lab</title>

								<link
									href="https://fonts.googleapis.com/css2?family=Outfit:wght@300;400;500;600;700&display=swap"
									rel="stylesheet">
								<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css"
									rel="stylesheet">
								<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css"
									rel="stylesheet">

								<style>
									body {
										font-family: 'Outfit', sans-serif;
										background: #f8fafc;
									}

									.page-title {
										font-weight: 700;
										font-size: 1.8rem;
										margin-bottom: 4px;
										color: #0f172a;
									}

									.page-subtitle {
										color: #64748b;
										margin-bottom: 24px;
										font-size: 1rem;
									}

									.summary-box {
										background: #fff;
										border: 1px solid #e2e8f0;
										border-radius: 14px;
										padding: 14px;
									}

									.summary-box .title {
										font-size: 0.85rem;
										color: #64748b;
									}

									.summary-box .count {
										font-size: 1.35rem;
										font-weight: 700;
										margin: 2px 0 0;
									}

									.panel {
										background: #fff;
										border: 1px solid #e2e8f0;
										border-radius: 16px;
										padding: 24px;
										box-shadow: 0 10px 30px rgba(15, 23, 42, 0.04);
									}

									.table-header-row {
										display: flex;
										justify-content: space-between;
										align-items: center;
										margin-bottom: 20px;
									}

									.search-box {
										position: relative;
										width: 350px;
									}

									.search-box input {
										border-radius: 12px;
										padding-left: 40px;
										border: 1px solid #e2e8f0;
										box-shadow: inset 0 2px 4px rgba(0, 0, 0, 0.02);
									}

									.search-box i {
										position: absolute;
										left: 14px;
										top: 50%;
										transform: translateY(-50%);
										color: #94a3b8;
									}

									.table {
										margin-bottom: 0;
									}

									.table thead th {
										background: #f1f5f9;
										color: #475569;
										font-weight: 600;
										font-size: 0.85rem;
										text-transform: uppercase;
										letter-spacing: 0.5px;
										border: none;
										padding: 14px 16px;
									}

									.table thead th:first-child {
										border-top-left-radius: 12px;
										border-bottom-left-radius: 12px;
									}

									.table thead th:last-child {
										border-top-right-radius: 12px;
										border-bottom-right-radius: 12px;
									}

									.table tbody td {
										vertical-align: middle;
										padding: 16px;
										color: #1e293b;
										font-weight: 500;
										border-bottom: 1px solid #f1f5f9;
									}

									.table tbody tr {
										transition: all 0.2s ease;
									}

									.table tbody tr:last-child td {
										border-bottom: none;
									}

									.table tbody tr:hover {
										background: #f8fafc;
										transform: scale(1.002);
									}

									.patient-id {
										color: #0ea5e9;
										font-weight: 700;
										background: #e0f2fe;
										padding: 6px 12px;
										border-radius: 8px;
										font-size: 0.85rem;
									}

									.report-name {
										font-weight: 600;
										color: #334155;
										display: flex;
										align-items: center;
										gap: 10px;
									}

									.icon-file {
										color: #f43f5e;
										font-size: 1.2rem;
									}

									.date-text {
										color: #64748b;
										font-size: 0.9rem;
									}

									.badge-soft {
										padding: 6px 14px;
										border-radius: 20px;
										font-size: 0.75rem;
										font-weight: 700;
										display: inline-flex;
										align-items: center;
										gap: 6px;
									}

									.badge-published {
										background: #dcfce7;
										color: #166534;
									}

									.badge-pending {
										background: #fef3c7;
										color: #92400e;
									}

									.btn-action {
										border-radius: 8px;
										padding: 6px 14px;
										font-size: 0.85rem;
										font-weight: 600;
										transition: all 0.2s ease;
									}

									.btn-download {
										background: #f1f5f9;
										color: #0f172a;
										border: 1px solid #e2e8f0;
									}

									.btn-download:hover {
										background: #e2e8f0;
										color: #000;
									}

									.empty-state {
										text-align: center;
										padding: 40px 20px;
									}

									.empty-state i {
										font-size: 3rem;
										color: #cbd5e1;
										margin-bottom: 16px;
									}
								</style>
								<link rel="stylesheet" type="text/css"
									href="<%=request.getContextPath()%>/Css/app-theme.css">
							</head>

							<body data-admin-page="patients">

								<%@ include file="Components/auth.jsp" %>

									<% List<Patient> list = (List<Patient>) request.getAttribute("patientList");
											%>

											<% PatientDao dao=new PatientDao(); int totalPatient=dao.totalPatients(); %>

												<% String role=(String) mySession.getAttribute("role"); if
													("ADMIN".equalsIgnoreCase(role) || "STAFF" .equalsIgnoreCase(role))
													{ %>

													<% if ("STAFF".equals(role)) { %>
														<jsp:include page="Staff/staffSidebar.jsp" />
														<% } else if ("ADMIN".equals(role)) { %>
															<jsp:include page="adminSidebar.jsp" />
															<% } %>

																<div class="main-content">

																	<%@ include file="Components/message.jsp" %>

																		<div class="dashboard-header">
																			<h2 class="page-title">Patient Reports
																				Overview</h2>
																			<p class="page-subtitle">Track, download,
																				and review all patient
																				pathology reports.</p>
																		</div>

																		<div class="panel">
																			<div class="table-header-row">
																				<div class="summary-box">
																					<div class="title">Total Patients
																					</div>
																					<div class="count">
																						<%=totalPatient%>
																					</div>
																				</div>
																				<div class="search-box">
																					<form
																						action="<%=request.getContextPath()%>/searchPatient"
																						method="get">
																						<i
																							class="fa-solid fa-search"></i>
																						<input type="text" name="search"
																							class="form-control"
																							placeholder="Search by Patient ID, Patient Name, Email, Mobile...">
																					</form>
																				</div>

																				<div class="dropdown">
																					<button
																						class="btn btn-secondary dropdown-toggle"
																						data-bs-toggle="dropdown">Sort
																						By</button>
																					<ul class="dropdown-menu">
																						<li><a class="dropdown-item"
																								href="sortPatients?sort=id&order=asc">Newest
																								First</a></li>
																						<li><a class="dropdown-item"
																								href="sortPatients?sort=id&order=desc">Oldest
																								First</a></li>
																						<li><a class="dropdown-item"
																								href="sortPatients?sort=patient_name&order=asc">Name
																								(A <i
																									class="fa-solid fa-arrow-right"></i>
																								Z)
																							</a></li>
																						<li><a class="dropdown-item"
																								href="sortPatients?sort=patient_name&order=desc">Name
																								(Z <i
																									class="fa-solid fa-arrow-right"></i>
																								A)
																							</a></li>
																					</ul>
																				</div>
																				<div>
																					<button
																						class="btn btn-primary d-flex align-items-center gap-2"
																						style="border-radius: 10px; font-weight: 600;">
																						<i
																							class="fa-solid fa-filter"></i>
																						Filter Results
																					</button>
																				</div>
																				<div>
																					<a href="<%=request.getContextPath()%>/exportPatientsCSV"
																						class="btn btn-success d-flex align-items-center gap-2"
																						style="border-radius: 10px; font-weight: 600;">
																						<i
																							class="fa-solid fa-download"></i>
																						Export CSV
																					</a>
																				</div>
																			</div>

																			<div class="table-responsive">
																				<table
																					class="table table-hover align-middle mb-0">
																					<thead>
																						<tr>
																							<th>S.No.</th>
																							<th>Patient ID</th>
																							<th>Patient Name</th>
																							<th>Patient Email</th>
																							<th>Patient Mobile</th>
																							<th>Actions</th>
																						</tr>
																					</thead>

																					<% int count=1; if (list !=null) {
																						for (Patient p : list) { %>

																						<tbody id="reportTable">
																							<tr>
																								<td>
																									<%=count++%>
																								</td>
																								<td>
																									<%=p.getPatientId()%>
																								</td>
																								<td>
																									<%=p.getPatientName()%>
																								</td>
																								<td>
																									<%=p.getPatientEmail()%>
																								</td>
																								<td>
																									<%=p.getPatientMobile()%>
																								</td>

																								<td><a href="<%=request.getContextPath()%>/viewReport?pId=<%=p.getPatientId()%>"
																										class="btn btn-success btn-sm">
																										View Reports
																									</a>
																									<% if
																										("ADMIN".equalsIgnoreCase(role))
																										{ %> <a
																											href="deletePatient?pId=<%=p.getPatientId()%>"
																											class="btn btn-outline-danger btn-sm"
																											onclick="return confirm('Are you sure you want to delete this patient?');">
																											Delete
																											Patient </a>
																										<% } %>
																								</td>
																							</tr>
																						</tbody>

																						<% } } %>

																				</table>
																			</div>
																			<div class="pagination-wrap">
																				<nav aria-label="Reports pagination">
																					<ul
																						class="pagination justify-content-center mb-0">

																						<% if (totalPatient < 15) { }
																							else { for (int i=0, j=1; i
																							<=totalPatient; i=i + 15,
																							j++) { %>

																							<li
																								class="page-item active">
																								<a class="page-link"
																									href="<%=request.getContextPath()%>/viewAllPatientByOffset?offset=<%=i%>">
																									<%=j%>
																								</a></li>
																							<% } } %>
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
																	}, 3000);
																</script>

																<script
																	src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/js/bootstrap.bundle.min.js"></script>

																<% } else {
																	response.sendRedirect(request.getContextPath()
																	+ "/Pages/unauthorizedUser.jsp" ); return; } %>
							</body>

							</html>