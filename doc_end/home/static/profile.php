<!DOCTYPE html>
<html lang="en">

<head>
	<meta charset="utf-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
	<meta name="description" content="Responsive Admin &amp; Dashboard Template based on Bootstrap 5">
	<meta name="author" content="AdminKit">
	<meta name="keywords" content="adminkit, bootstrap, bootstrap 5, admin, dashboard, template, responsive, css, sass, html, theme, front-end, ui kit, web">

	<link rel="preconnect" href="https://fonts.gstatic.com">
	<link rel="shortcut icon" href="img/icons/icon-48x48.png" />

	<link rel="canonical" href="https://demo-basic.adminkit.io/pages-profile.html" />

	<title>Profile | AdminKit Demo</title>
	<style>
		.img-account-profile {
			height: 10rem;
			width: 10rem;
			border-radius: 10rem;
		}

		.rounded-circle {
			border-radius: 50% !important;
		}

		.card {
			box-shadow: 0 0.15rem 1.75rem 0 rgb(33 40 50 / 15%);
		}

		.card .card-header {
			font-weight: 500;
		}

		.card-header:first-child {
			border-radius: 0.35rem 0.35rem 0 0;
		}

		.card-header {
			padding: 1rem 1.35rem;
			margin-bottom: 0;
			background-color: rgba(33, 40, 50, 0.03);
			border-bottom: 1px solid rgba(33, 40, 50, 0.125);
		}

		.form-control,
		.dataTable-input {
			display: block;
			width: 100%;
			padding: 0.875rem 1.125rem;
			font-size: 0.875rem;
			font-weight: 400;
			line-height: 1;
			color: #69707a;
			background-color: #fff;
			background-clip: padding-box;
			border: 1px solid #c5ccd6;
			-webkit-appearance: none;
			-moz-appearance: none;
			appearance: none;
			border-radius: 0.35rem;
			transition: border-color 0.15s ease-in-out, box-shadow 0.15s ease-in-out;
		}
	</style>
	<link href="css/app.css" rel="stylesheet">
	<link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;600&display=swap" rel="stylesheet">
</head>
<?php session_start();
if (!(isset($_SESSION['loginStatus']) && isset($_SESSION['user_data']))) {
	header('Location: ../../login/', true);
} else {
	$user_data = $_SESSION['user_data'];
}
?>

<body>
	<div class="wrapper">
		<div class="main">
			<nav class="navbar navbar-expand navbar-light navbar-bg">
				<h1 class="p-0 m-0"><a href="./index.php">MyDoctor</a></h1>
				<div class="navbar-collapse collapse">
					<ul class="navbar-nav navbar-align">
						<li class="nav-item dropdown">
							<a class="nav-icon dropdown-toggle" href="#" id="alertsDropdown" data-bs-toggle="dropdown">
								<div class="position-relative">
									<i class="align-middle" data-feather="bell"></i>
									<span class="indicator">4</span>
								</div>
							</a>
							<div class="dropdown-menu dropdown-menu-lg dropdown-menu-end py-0" aria-labelledby="alertsDropdown">
								<div class="dropdown-menu-header">
									4 New Notifications
								</div>
								<div class="list-group">
									<a href="#" class="list-group-item">
										<div class="row g-0 align-items-center">
											<div class="col-2">
												<i class="text-danger" data-feather="alert-circle"></i>
											</div>
											<div class="col-10">
												<div class="text-dark">Update completed</div>
												<div class="text-muted small mt-1">Restart server 12 to complete the
													update.</div>
												<div class="text-muted small mt-1">30m ago</div>
											</div>
										</div>
									</a>
									<a href="#" class="list-group-item">
										<div class="row g-0 align-items-center">
											<div class="col-2">
												<i class="text-warning" data-feather="bell"></i>
											</div>
											<div class="col-10">
												<div class="text-dark">Lorem ipsum</div>
												<div class="text-muted small mt-1">Aliquam ex eros, imperdiet vulputate
													hendrerit et.</div>
												<div class="text-muted small mt-1">2h ago</div>
											</div>
										</div>
									</a>
									<a href="#" class="list-group-item">
										<div class="row g-0 align-items-center">
											<div class="col-2">
												<i class="text-primary" data-feather="home"></i>
											</div>
											<div class="col-10">
												<div class="text-dark">Login from 192.186.1.8</div>
												<div class="text-muted small mt-1">5h ago</div>
											</div>
										</div>
									</a>
									<a href="#" class="list-group-item">
										<div class="row g-0 align-items-center">
											<div class="col-2">
												<i class="text-success" data-feather="user-plus"></i>
											</div>
											<div class="col-10">
												<div class="text-dark">New connection</div>
												<div class="text-muted small mt-1">Christina accepted your request.
												</div>
												<div class="text-muted small mt-1">14h ago</div>
											</div>
										</div>
									</a>
								</div>
								<div class="dropdown-menu-footer">
									<a href="#" class="text-muted">Show all notifications</a>
								</div>
							</div>
						</li>
						<li class="nav-item dropdown">
							<a class="nav-icon dropdown-toggle" href="#" id="messagesDropdown" data-bs-toggle="dropdown">
								<div class="position-relative">
									<i class="align-middle" data-feather="message-square"></i>
								</div>
							</a>
							<div class="dropdown-menu dropdown-menu-lg dropdown-menu-end py-0" aria-labelledby="messagesDropdown">
								<div class="dropdown-menu-header">
									<div class="position-relative">
										4 New Messages
									</div>
								</div>
								<div class="list-group">
									<a href="#" class="list-group-item">
										<div class="row g-0 align-items-center">
											<div class="col-2">
												<img src="img/avatars/avatar-5.jpg" class="avatar img-fluid rounded-circle" alt="Vanessa Tucker">
											</div>
											<div class="col-10 ps-2">
												<div class="text-dark">Vanessa Tucker</div>
												<div class="text-muted small mt-1">Nam pretium turpis et arcu. Duis arcu
													tortor.</div>
												<div class="text-muted small mt-1">15m ago</div>
											</div>
										</div>
									</a>
									<a href="#" class="list-group-item">
										<div class="row g-0 align-items-center">
											<div class="col-2">
												<img src="img/avatars/avatar-2.jpg" class="avatar img-fluid rounded-circle" alt="William Harris">
											</div>
											<div class="col-10 ps-2">
												<div class="text-dark">William Harris</div>
												<div class="text-muted small mt-1">Curabitur ligula sapien euismod
													vitae.</div>
												<div class="text-muted small mt-1">2h ago</div>
											</div>
										</div>
									</a>
									<a href="#" class="list-group-item">
										<div class="row g-0 align-items-center">
											<div class="col-2">
												<img src="img/avatars/avatar-4.jpg" class="avatar img-fluid rounded-circle" alt="Christina Mason">
											</div>
											<div class="col-10 ps-2">
												<div class="text-dark">Christina Mason</div>
												<div class="text-muted small mt-1">Pellentesque auctor neque nec urna.
												</div>
												<div class="text-muted small mt-1">4h ago</div>
											</div>
										</div>
									</a>
									<a href="#" class="list-group-item">
										<div class="row g-0 align-items-center">
											<div class="col-2">
												<img src="img/avatars/avatar-3.jpg" class="avatar img-fluid rounded-circle" alt="Sharon Lessman">
											</div>
											<div class="col-10 ps-2">
												<div class="text-dark">Sharon Lessman</div>
												<div class="text-muted small mt-1">Aenean tellus metus, bibendum sed,
													posuere ac, mattis non.</div>
												<div class="text-muted small mt-1">5h ago</div>
											</div>
										</div>
									</a>
								</div>
								<div class="dropdown-menu-footer">
									<a href="#" class="text-muted">Show all messages</a>
								</div>
							</div>
						</li>
						<li class="nav-item dropdown">
							<a class="nav-icon dropdown-toggle d-inline-block d-sm-none" href="#" data-bs-toggle="dropdown">
								<i class="align-middle" data-feather="settings"></i>
							</a>
							<a class="nav-link dropdown-toggle d-none d-sm-inline-block" href="#" data-bs-toggle="dropdown">
								<img class="avatar img-fluid rounded me-1" src="<?php echo isset($user_data['IMG_URL']) ? $user_data['IMG_URL'] : 'http://bootdey.com/img/Content/avatar/avatar1.png' ?>" alt=""><span class="text-dark"><?php echo $_SESSION['user_data']['NAME'] ?></span>
							</a>
							<div class="dropdown-menu dropdown-menu-end">
								<a class="dropdown-item" href="#"><i class="align-middle me-1" data-feather="user"></i> Profile</a>
								<a class="dropdown-item" href="./index.php"><i class="align-middle me-1" data-feather="pie-chart"></i> Analytics</a>
								<div class="dropdown-divider"></div>
								<a class="dropdown-item" href="index.html"><i class="align-middle me-1" data-feather="settings"></i> Settings & Privacy</a>
								<a class="dropdown-item" href="#"><i class="align-middle me-1" data-feather="help-circle"></i> Help Center</a>
								<div class="dropdown-divider"></div>
								<a class="dropdown-item" href="#">Log out</a>
							</div>
						</li>
					</ul>
				</div>
			</nav>

			<main class="content">
				<div class="container-fluid p-0">
					<div class="mb-3">
						<h1 class="h3 d-inline align-middle">Profile</h1>
					</div>
					<div class="row">
						<div class="col-xl-4">
							<!-- Profile picture card-->
							<div class="card mb-4 mb-xl-0">
								<div class="card-header">Profile Picture</div>
								<div class="card-body text-center">
									<!-- Profile picture image-->
									<img class="img-account-profile mb-2" height="100" width="100" src="<?php echo isset($user_data['IMG_URL']) ? $user_data['IMG_URL'] : 'http://bootdey.com/img/Content/avatar/avatar1.png' ?>" alt="">
									<!-- Profile picture help block-->
									<div class="small font-italic text-muted mb-4">JPG or PNG no larger than 5 MB</div>
									<!-- Profile picture upload button-->
									<form action="../../../api/doctor/upload_image.php" method="post" id="fileForm">
										<input id="fileInput" type="file" accept="image/*" style="display: none;" oninput="submitForm()">
										<input type="hidden" name="email" value="<?php echo $user_data['EMAIL'] ?>">
										<input type="hidden" name="image" id="imageFile">
										<input type="hidden" name="type" value="" id="fileType">
										<button onclick="document.getElementById('fileInput').click()" class="btn btn-primary" type="button">Upload new image</button>
										<script>
											const toBase64 = file => new Promise((resolve, reject) => {
												const reader = new FileReader();
												reader.readAsDataURL(file);
												reader.onload = () => resolve(reader.result);
												reader.onerror = error => reject(error);
											});
											const submitForm = async () => {
												var fileName = document.getElementById('fileInput').value;
												var file = document.getElementById('fileInput').files[0];
												extension = fileName.substring(fileName.lastIndexOf('.') + 1);
												document.getElementById('fileType').value = extension;
												var baseUrl = await toBase64(file);
												document.getElementById('imageFile').value = baseUrl.split(',')[1];
												document.getElementById('fileForm').submit();
											}
										</script>
									</form>
								</div>
							</div>
						</div>
						<div class="col-xl-8">
							<!-- Account details card-->
							<div class="card mb-4">
								<div class="card-header">Account Details</div>
								<div class="card-body">
									<form action="../../../api/doctor/update_doc_details.php" method="post">
										<!-- Form Group (username)-->
										<div class="mb-3">
											<label class="small mb-1" for="inputUsername">Username (how your name will appear to other users on the site)</label>
											<input class="form-control" id="inputUsername" name="uname" type="text" placeholder="Enter your username" value="<?php echo $user_data['NAME'] ?>">
										</div>
										<!-- Form Row        -->
										<div class="row gx-3 mb-3">
											<!-- Form Group (organization name)-->
											<div class="col-md-6 h-full d-flex align-items-center">
												<label class="small" for="inputOrgName">Speciality</label>
												<a class="nav-link dropdown-toggle d-none d-sm-inline-block" href="#" data-bs-toggle="dropdown">
													<span class="text-dark" id="specialitySpan"><?php echo $_SESSION['user_data']['SPECIALITY'] ?></span>
												</a>
												<input type="hidden" name="speciality" id="specialityInp" value="<?php echo $_SESSION['user_data']['SPECIALITY'] ?>">
												<div class="dropdown-menu dropdown-menu-end border">
													<a onclick="setSelected('Surgeon')" class="dropdown-item">Surgeon</a>
													<a onclick="setSelected('Dentist')" class="dropdown-item"> Dentist</a>
													<a onclick="setSelected('Kidney')" class="dropdown-item">Kidney</a>
													<a onclick="setSelected('Allergist')" class="dropdown-item">Allergist</a>
												</div>
												<script>
													function setSelected(sel) {
														document.getElementById('specialitySpan').innerHTML=sel;
														document.getElementById('specialityInp').value=sel;
													}
												</script>
											</div>
											<!-- Form Group (location)-->
											<div class="col-md-6">
												<label class="small mb-1" for="inputLocation">Location</label>
												<input class="form-control" id="inputLocation" name="loc" type="text" placeholder="Enter your location" value="<?php echo $user_data['LOCATION'] ?>">
											</div>
										</div>
										<!-- Form Group (email address)-->
										<div class="mb-3">
											<label class="small mb-1" for="inputEmailAddress">Email address</label>
											<input readonly class="form-control" id="inputEmailAddress" name="email" type="email" placeholder="Enter your email address" value="<?php echo $user_data['EMAIL'] ?>">
										</div>
										<div class="mb-3">
											<label class="small mb-1" for="inputEmailAddress">Description</label>
											<input class="form-control" id="inputEmailAddress" name="desc"  type="text" placeholder="Enter your email address" value="<?php echo $user_data['DESCRIPTION'] ?>">
										</div>
										<!-- Form Row-->

										<!-- Save changes button-->
										<input  class="btn btn-primary" type="submit"></input>
									</form>
								</div>
							</div>
						</div>
					</div>

				</div>
			</main>
		</div>
	</div>

	<script src="js/app.js"></script>

</body>

</html>