<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">

<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Book Appointment | PathLab</title>

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
:root {
	--bg-grad: radial-gradient(circle at 15% 10%, #dff2ff 0%, #f8fbff 35%, #edf4ff 100%
		);
	--panel-bg: rgba(255, 255, 255, 0.92);
	--border: #dbe6f2;
	--text: #0f172a;
	--muted: #64748b;
	--primary: #2563eb;
	--primary-dark: #1d4ed8;
	--danger: #be123c;
	--success: #047857;
	--shadow: 0 18px 36px rgba(15, 23, 42, 0.09);
}

body {
	font-family: "Outfit", sans-serif;
	background: var(--bg-grad);
	color: var(--text);
	min-height: 100vh;
}

.page-wrap {
	max-width: 980px;
	margin: 0 auto;
	padding: 36px 18px;
}

.booking-panel {
	background: var(--panel-bg);
	border: 1px solid var(--border);
	border-radius: 20px;
	box-shadow: var(--shadow);
	padding: 26px;
	backdrop-filter: blur(6px);
}

.panel-head {
	display: flex;
	align-items: center;
	gap: 14px;
	margin-bottom: 18px;
}

.icon-chip {
	width: 52px;
	height: 52px;
	border-radius: 14px;
	display: inline-flex;
	align-items: center;
	justify-content: center;
	color: var(--primary);
	background: linear-gradient(135deg, #e0ecff 0%, #bfdbfe 100%);
	font-size: 1.3rem;
}

.panel-title {
	font-size: 1.55rem;
	font-weight: 700;
	margin: 0;
}

.panel-subtitle {
	margin: 2px 0 0;
	color: var(--muted);
	font-size: 0.95rem;
}

.form-label {
	font-weight: 600;
	color: #334155;
	margin-bottom: 6px;
}

.form-control, .form-select {
	border-radius: 12px;
	border: 1px solid #d2ddeb;
	padding: 10px 12px;
	background: #fff;
}

.form-control:focus, .form-select:focus {
	border-color: var(--primary);
	box-shadow: 0 0 0 0.2rem rgba(37, 99, 235, 0.15);
}

.priority-wrap {
	display: flex;
	align-items: center;
	gap: 16px;
	flex-wrap: wrap;
	padding-top: 6px;
}

.priority-option {
	display: inline-flex;
	align-items: center;
	gap: 8px;
	font-weight: 500;
	color: #334155;
}

.priority-option input[type="radio"] {
	accent-color: var(--primary);
	transform: scale(1.1);
}

.error-text {
	color: var(--danger);
	min-height: 18px;
	font-size: 0.82rem;
	margin-top: 4px;
	display: block;
}

.btn-book {
	border: none;
	width: 100%;
	border-radius: 12px;
	padding: 12px 16px;
	font-weight: 700;
	color: #fff;
	background: linear-gradient(90deg, var(--primary) 0%, #3b82f6 100%);
	box-shadow: 0 12px 24px rgba(37, 99, 235, 0.24);
	transition: transform 0.2s ease, box-shadow 0.2s ease;
}

.btn-book:hover {
	transform: translateY(-1px);
	box-shadow: 0 14px 26px rgba(37, 99, 235, 0.27);
}

.message-box {
	display: none;
	margin-top: 14px;
	border-radius: 12px;
	border: 1px solid transparent;
	padding: 12px 14px;
	font-weight: 600;
	font-size: 0.92rem;
}

.message-box.error {
	display: block;
	color: #9f1239;
	background: #fff1f2;
	border-color: #fecdd3;
}

.message-box.success {
	display: block;
	color: #065f46;
	background: #ecfdf5;
	border-color: #a7f3d0;
}

.details-card {
	margin-top: 16px;
	border: 1px solid #dbe6f2;
	border-radius: 14px;
	padding: 16px;
	background: #f8fbff;
	display: none;
}

.details-title {
	font-size: 1rem;
	font-weight: 700;
	margin-bottom: 12px;
}

.details-grid {
	display: grid;
	grid-template-columns: repeat(2, minmax(0, 1fr));
	gap: 10px;
}

.detail-item {
	border: 1px solid #e2e8f0;
	border-radius: 10px;
	padding: 10px;
	background: #fff;
}

.detail-label {
	font-size: 0.78rem;
	color: var(--muted);
	margin-bottom: 2px;
}

.detail-value {
	font-weight: 600;
	color: #1e293b;
	font-size: 0.92rem;
}

@media ( max-width : 768px) {
	.booking-panel {
		padding: 18px;
	}
	.panel-title {
		font-size: 1.3rem;
	}
	.details-grid {
		grid-template-columns: 1fr;
	}
}
</style>
</head>

<body>
	<%@include file="userSidebar.jsp"%>
	<%@ include file="../Components/loader.jsp"%>

	<div class="page-wrap">
		<div class="booking-panel">
			<div class="panel-head">
				<div class="icon-chip">
					<i class="fa-solid fa-calendar-plus"></i>
				</div>
				<div>
					<h1 class="panel-title">Appointment Booking System</h1>
					<p class="panel-subtitle">Fill in your details to book a
						diagnostic test appointment.</p>
				</div>
			</div>

			<form id="appointmentForm" novalidate
				action="<%=request.getContextPath()%>/bookAppointment" method="post">
				<div class="row g-3">
					<div class="col-md-4">
						<label for="patientName" class="form-label">Patient Name</label> <input
							type="text" id="patientName" name="patientName"
							class="form-control" placeholder="Enter patient name"> <small
							id="patientNameError" class="error-text"></small>
					</div>

					<div class="col-md-4">
						<label for="patientEmail" class="form-label">Patient Email</label>
						<input type="email" id="patientEmail" name="patientEmail"
							class="form-control" placeholder="Enter email address"> <small
							id="patientEmailError" class="error-text"></small>
					</div>

					<div class="col-md-4">
						<label for="patientMobile" class="form-label">Patient
							Mobile</label> <input type="tel" id="patientMobile" name="patientMobile"
							class="form-control" placeholder="Enter mobile number"> <small
							id="patientMobileError" class="error-text"></small>
					</div>

					<div class="col-md-6">
						<label for="testName" class="form-label">Test Name</label> <select
							id="testName" name="testName" class="form-select">
							<option value="">Select test</option>
							<option value="Blood Test">Blood Test</option>
							<option value="X-Ray">X-Ray</option>
							<option value="MRI">MRI</option>
							<option value="CT Scan">CT Scan</option>
							<option value="ECG">ECG</option>
						</select> <small id="testNameError" class="error-text"></small>
					</div>

					<div class="col-md-6">
						<label for="appointmentDate" class="form-label">Appointment
							Date</label> <input type="date" id="appointmentDate"
							name="appointmentDate" class="form-control"> <small
							id="appointmentDateError" class="error-text"></small>
					</div>

					<div class="col-md-6">
						<label for="timeSlot" class="form-label">Time Slot</label> <select
							id="timeSlot" name="appointmentTime" class="form-select">
							<option value="">Select time slot</option>
							<option value="10:00">10:00-10:30</option>
							<option value="10:30">10:30-11:00</option>
							<option value="11:00">11:00-11:30</option>
							<option value="11:30">11:30-12:00</option>
							<option value="14:00">14:00-14:30</option>
							<option value="14:30">14:30-15:00</option>
						</select> <small id="timeSlotError" class="error-text"></small>
					</div>

					<div class="col-md-6">
						<label for="labLocation" class="form-label">Lab Location</label> <select
							id="labLocation" name="labLocation" class="form-select">
							<option value="">Select location</option>
							<option value="Central PathLab - Downtown">Central
								PathLab - Downtown</option>
							<option value="North Branch Lab">North Branch Lab</option>
							<option value="City Diagnostic Center">City Diagnostic
								Center</option>
							<option value="Home Sample Collection">Home Sample
								Collection</option>
						</select> <small id="labLocationError" class="error-text"></small>
					</div>

					<div class="col-12">
						<label class="form-label">Priority</label>
						<div class="priority-wrap">
							<label class="priority-option" for="priorityNormal"> <input
								type="radio" name="priority" id="priorityNormal" value="Normal"
								checked> Normal
							</label> <label class="priority-option" for="priorityUrgent"> <input
								type="radio" name="priority" id="priorityUrgent" value="Urgent">
								Urgent
							</label>
						</div>
						<small id="priorityError" class="error-text"></small>
					</div>

					<div class="col-12 mt-1">
						<button type="submit" class="btn-book">
							<i class="fa-solid fa-paper-plane me-2"></i>Book Appointment
						</button>
					</div>
				</div>
			</form>

			<div id="formMessage" class="message-box" role="alert"></div>

			<div id="detailsCard" class="details-card">
				<div class="details-title">Booked Appointment Details</div>
				<div class="details-grid" id="detailsGrid"></div>
			</div>
		</div>
	</div>

	<script>
                    const form = document.getElementById("appointmentForm");
                    const formMessage = document.getElementById("formMessage");
                    const detailsCard = document.getElementById("detailsCard");
                    const detailsGrid = document.getElementById("detailsGrid");

                    const fields = {
                        patientName: document.getElementById("patientName"),
                        patientEmail: document.getElementById("patientEmail"),
                        patientMobile: document.getElementById("patientMobile"),
                        testName: document.getElementById("testName"),
                        appointmentDate: document.getElementById("appointmentDate"),
                        timeSlot: document.getElementById("timeSlot"),
                        labLocation: document.getElementById("labLocation")
                    };

                    const errorEls = {
                        patientName: document.getElementById("patientNameError"),
                        patientEmail: document.getElementById("patientEmailError"),
                        patientMobile: document.getElementById("patientMobileError"),
                        testName: document.getElementById("testNameError"),
                        appointmentDate: document.getElementById("appointmentDateError"),
                        timeSlot: document.getElementById("timeSlotError"),
                        labLocation: document.getElementById("labLocationError"),
                        priority: document.getElementById("priorityError")
                    };

                    function setTodayAsMinDate() {
                        const today = new Date();
                        today.setHours(0, 0, 0, 0);
                        fields.appointmentDate.min = today.toISOString().split("T")[0];
                    }

                    function clearErrors() {
                        Object.values(errorEls).forEach((el) => {
                            el.textContent = "";
                        });
                    }

                    function showMessage(type, message) {
                        formMessage.className = "message-box " + type;
                        formMessage.textContent = message;
                    }

                    function getPriority() {
                        const selected = document.querySelector("input[name='priority']:checked");
                        return selected ? selected.value : "";
                    }

                    function collectFormData() {
                        return {
                            patientName: fields.patientName.value.trim(),
                            patientEmail: fields.patientEmail.value.trim(),
                            patientMobile: fields.patientMobile.value.trim(),
                            testName: fields.testName.value,
                            appointmentDate: fields.appointmentDate.value,
                            appointmentTime: fields.timeSlot.value,
                            labLocation: fields.labLocation.value,
                            priority: getPriority()
                        };
                    }

                    function isValidEmail(email) {
                        return /^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(email);
                    }

                    function isValidMobile(mobile) {
                        return /^[0-9]{10}$/.test(mobile);
                    }

                    function validate(data) {
                        let valid = true;
                        clearErrors();

                        if (!data.patientName) {
                            errorEls.patientName.textContent = "Patient name is required.";
                            valid = false;
                        }

                        if (!data.patientEmail) {
                            errorEls.patientEmail.textContent = "Patient email is required.";
                            valid = false;
                        } else if (!isValidEmail(data.patientEmail)) {
                            errorEls.patientEmail.textContent = "Please enter a valid email address.";
                            valid = false;
                        }

                        if (!data.patientMobile) {
                            errorEls.patientMobile.textContent = "Patient mobile is required.";
                            valid = false;
                        } else if (!isValidMobile(data.patientMobile)) {
                            errorEls.patientMobile.textContent = "Enter a valid 10-digit mobile number.";
                            valid = false;
                        }

                        if (!data.testName) {
                            errorEls.testName.textContent = "Please select a test name.";
                            valid = false;
                        }

                        if (!data.appointmentDate) {
                            errorEls.appointmentDate.textContent = "Please select an appointment date.";
                            valid = false;
                        } else {
                            const selectedDate = new Date(data.appointmentDate + "T00:00:00");
                            const today = new Date();
                            today.setHours(0, 0, 0, 0);

                            if (selectedDate < today) {
                                errorEls.appointmentDate.textContent = "Appointment date cannot be in the past.";
                                valid = false;
                            }
                        }

                        if (!data.appointmentTime) {
                            errorEls.timeSlot.textContent = "Please select a time slot.";
                            valid = false;
                        }

                        if (!data.labLocation) {
                            errorEls.labLocation.textContent = "Please select a lab location.";
                            valid = false;
                        }

                        if (!data.priority) {
                            errorEls.priority.textContent = "Please select priority.";
                            valid = false;
                        }

                        if (!valid) {
                            showMessage("error", "Please correct the highlighted errors.");
                        }

                        return valid;
                    }

                    function renderDetails(data) {
                        detailsGrid.innerHTML = ""
                            + "<div class='detail-item'><div class='detail-label'>Patient Name</div><div class='detail-value'>" + data.patientName + "</div></div>"
                            + "<div class='detail-item'><div class='detail-label'>Patient Email</div><div class='detail-value'>" + data.patientEmail + "</div></div>"
                            + "<div class='detail-item'><div class='detail-label'>Patient Mobile</div><div class='detail-value'>" + data.patientMobile + "</div></div>"
                            + "<div class='detail-item'><div class='detail-label'>Test Name</div><div class='detail-value'>" + data.testName + "</div></div>"
                            + "<div class='detail-item'><div class='detail-label'>Appointment Date</div><div class='detail-value'>" + data.appointmentDate + "</div></div>"
                            + "<div class='detail-item'><div class='detail-label'>Time Slot</div><div class='detail-value'>" + data.appointmentTime + "</div></div>"
                            + "<div class='detail-item'><div class='detail-label'>Lab Location</div><div class='detail-value'>" + data.labLocation + "</div></div>"
                            + "<div class='detail-item'><div class='detail-label'>Priority</div><div class='detail-value'>" + data.priority + "</div></div>";

                        detailsCard.style.display = "block";
                    }

                    form.addEventListener("submit", function (event) {
                        const data = collectFormData();

                        if (!validate(data)) {
                            event.preventDefault();
                            return;
                        }

                        renderDetails(data);
                        showMessage("success", "Appointment booked successfully.");
                    });

                    setTodayAsMinDate();
                </script>
</body>

</html>