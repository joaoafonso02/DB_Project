<script>
	import { onMount } from 'svelte';

	// let title = 'Login';

	// onMount(() => {
	//   document.title = title;
	// });

	// let credentials = {usr: "admin", password: "1234"};

	// function submitSignin(){
	//     let usr = document.querySelector("#formSigninUsername").value;
	//     let password = document.querySelector("#formSigninPassword").value;
	//     const users = credentials;
	//     console.log(credentials.length);
	//         console.log("EW");
	//         if(users['usr'] == usr && users['password'] == password){
	//             window.location.href='/';
	//         }
	//         else {
	//             showAlert("Unknown username or password, try again!");
	//         }
	// }

	let message = '';

	// function showAlert(msg) {
	//     setTimeout(() => {
	//         message = "";
	//     }, 3000);
	//     message = msg;
	// }
</script>

<div class="text-center position-relative h-100 w-100">
	{#if message}
		<div class="position-absolute top-0 w-100 p-3">
			<div class="btn btn-danger w-100 p-2">{message}</div>
		</div>
	{/if}
	<div class="w-100 p-5">
		<ul class="nav nav-tabs" id="myTab" role="tablist">
			<li class="nav-item" role="presentation">
				<button
					class="nav-link w-100 rounder-top active"
					id="login-tab"
					data-bs-toggle="tab"
					data-bs-target="#login"
					type="button"
					role="tab"
					aria-controls="login"
					aria-selected="true">Login</button
				>
			</li>
			<li class="nav-item" role="presentation">
				<button
					class="nav-link w-100 rounder-top"
					id="register-tab"
					data-bs-toggle="tab"
					data-bs-target="#register"
					type="button"
					role="tab"
					aria-controls="register"
					aria-selected="false">Register</button
				>
			</li>
		</ul>
		<div class="tab-content rounded-bottom p-3" id="myTabContent">
			<div class="tab-pane fade show active" id="login" role="tabpanel" aria-labelledby="login-tab">
				<form>
					<br />
					<div class="form-outline mb-4">
						<label class="form-label" for="loginName">Username</label>
						<input
							id="formSigninUsername"
							type="text"
							class="form-control"
							style="text-align: center;"
						/>
					</div>
					<div class="form-outline mb-4">
						<label class="form-label" for="loginPassword">Password</label>
						<input
							id="formSigninPassword"
							type="password"
							class="form-control"
							style="text-align: center;"
						/>
					</div>
					<div class="row mb-4">
						<div class="col-md-6 d-flex justify-content-center">
							<div class="form-check mb-3 mb-md-0">
								<input class="form-check-input" type="checkbox" value="" id="loginCheck" checked />
								<label class="form-check-label" for="loginCheck"> Remember me </label>
							</div>
						</div>
						<div class="col-md-6 d-flex justify-content-center">
							<a href="#!">Forgot password?</a>
						</div>
					</div>
					<div id="formSignin">
						<button type="submit" class="btn btn-primary btn-block mb-4">Sign in</button>
					</div>
				</form>
        <form>
					<br />
					<div class="form-outline mb-4">
						<label class="form-label" for="loginName">Username</label>
						<input
							id="formSigninUsername"
							type="text"
							class="form-control"
							style="text-align: center;"
						/>
					</div>
					<div class="form-outline mb-4">
						<label class="form-label" for="loginPassword">Password</label>
						<input
							id="formSigninPassword"
							type="password"
							class="form-control"
							style="text-align: center;"
						/>
					</div>
					<div class="row mb-4">
						<div class="col-md-6 d-flex justify-content-center">
							<div class="form-check mb-3 mb-md-0">
								<input class="form-check-input" type="checkbox" value="" id="loginCheck" checked />
								<label class="form-check-label" for="loginCheck"> Remember me </label>
							</div>
						</div>
						<div class="col-md-6 d-flex justify-content-center">
							<a href="#!">Forgot password?</a>
						</div>
					</div>
					<div id="formSignin">
						<button type="submit" class="btn btn-primary btn-block mb-4">Sign in</button>
					</div>
				</form>
			</div>
			<div class="tab-pane fade" id="register" role="tabpanel" aria-labelledby="register-tab">
				<form>
					<div class="form-outline mb-4">
						<label class="form-label mt-3" for="registerUsername">Username</label>
						<input id="formSignupUsername" type="text" class="form-control" />
					</div>
					<div class="form-outline mb-4">
						<label class="form-label" for="registerEmail">Email</label>
						<input id="formSignupEmail" type="email" class="form-control" />
					</div>
					<div class="form-outline mb-4">
						<label class="form-label" for="registerPassword">Password</label>
						<input id="formSignupPassword1" type="password" class="form-control" />
					</div>
					<div class="form-outline mb-4">
						<label class="form-label" for="registerRepeatPassword">Repeat password</label>
						<input id="formSignupPassword2" type="password" class="form-control" />
					</div>
					<div class="form-check d-flex justify-content-center mb-4">
						<input
							id="formSignupCheck"
							class="form-check-input me-2"
							type="checkbox"
							value=""
							checked
							aria-describedby="registerCheckHelpText"
						/>
						<label class="form-check-label" for="registerCheck"
							>I have read and agree to the terms</label
						>
					</div>
					<button id="formSignup" class="btn btn-primary btn-block mb-3">Register</button>
				</form>
			</div>
		</div>
	</div>
</div>

<style>
	.nav-item {
		width: 50%;
		border-style: in;
	}
	.nav-item .active {
		background: #fafafa;
		border-color: black;
		border-bottom: 0;
    font-size: 190%;
    padding: 0;
	}
	.nav-item :not(.active) {
		background: #d0d0d0;
    color: black;
		border-bottom: 1px solid black;
    font-size: 100%;
    padding: 10px;
	}
	.tab-content {
		background: #fafafa;
		border: 1px solid black;
		border-top: 0;
	}
</style>
