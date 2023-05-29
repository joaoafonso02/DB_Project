<script>
	let message = '';
	let outerDivPaddingTop = message ? 'padding-top: 70px;' : '';

	let l_username = '',
		l_password = '';
	async function do_login() {
		if (!l_username) {
			message = 'Need a Username to Sign In!';
			return;
		}
		if (!l_password) {
			message = 'Need a Password to Sign In!';
			return;
		}

		let response = await fetch('http://localhost:5001/post_login', {
			method: 'POST',
			headers: {
				'Content-Type': 'application/json'
			},
			body: JSON.stringify({ username: l_username, password: l_password })
		});
		let data = await response.json();
		if (data.status != 'ok') {
			message = data.message;
			return;
		}
		localStorage.setItem('utoken', data.token);
		localStorage.setItem('username', l_username);
		window.location.href = '/map';
	}

	let r_username = '',
		r_password1 = '',
    r_password2 = '',
		r_email = '';
	async function do_register() {
		if (!r_username) {
			message = 'Need a Username to Register!';
			return;
		}
		if (!r_password1 || !r_password2) {
			message = 'Need a Password to Register!';
			return;
		}
    if (r_password1 != r_password2) {
			message = 'Need Matching Passwords to Register!';
			return;
		}
		if (!r_email) {
			message = 'Need a Email to Register!';
			return;
		}

		let response = await fetch('http://localhost:5001/post_register', {
			method: 'POST',
			headers: {
				'Content-Type': 'application/json'
			},
			body: JSON.stringify({ username: r_username, password: r_password1, email: r_email })
		});
		let data = await response.json();
		if (data.status != 'ok') {
			message = data.message;
			return;
		}
		localStorage.setItem('utoken', data.token);
		localStorage.setItem('username', r_username);
		window.location.href = '/map';
	}

  $: message, outerDivPaddingTop = message ? 'padding-top: 70px;' : '';
</script>

<div class="text-center position-relative h-100 w-100 d-flex" style={outerDivPaddingTop}>
	{#if message}
		<div class="position-absolute top-0 w-100 p-3 px-5">
			<div class="btn btn-danger w-100 p-2">{message}</div>
		</div>
	{/if}
	<div class="w-100 px-5 m-auto">
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
							bind:value={l_username}
						/>
					</div>
					<div class="form-outline mb-4">
						<label class="form-label" for="loginPassword">Password</label>
						<input
							id="formSigninPassword"
							type="password"
							class="form-control"
							style="text-align: center;"
							bind:value={l_password}
						/>
					</div>
					<div class="row mb-4">
						<div class="col-md-6 d-flex justify-content-center">
							<div class="form-check mb-3 mb-md-0">
								<input class="form-check-input" type="checkbox" value="" id="loginCheck" checked />
								<label class="form-check-label" for="loginCheck">Remember me</label>
							</div>
						</div>
						<div class="col-md-6 d-flex justify-content-center">
							<a href="#!">Forgot password?</a>
						</div>
					</div>
					<div id="formSignin">
						<button type="submit" class="btn btn-primary btn-block mb-4" on:click={do_login}
							>Sign in</button
						>
					</div>
				</form>
			</div>
			<div class="tab-pane fade" id="register" role="tabpanel" aria-labelledby="register-tab">
				<form>
					<div class="form-outline mb-4">
						<label class="form-label mt-3" for="registerUsername">Username</label>
						<input id="formSignupUsername" type="text" class="form-control" bind:value={r_username}/>
					</div>
					<div class="form-outline mb-4">
						<label class="form-label" for="registerEmail">Email</label>
						<input id="formSignupEmail" type="email" class="form-control"bind:value={r_email} />
					</div>
					<div class="form-outline mb-4">
						<label class="form-label" for="registerPassword">Password</label>
						<input id="formSignupPassword1" type="password" class="form-control" bind:value={r_password1}/>
					</div>
					<div class="form-outline mb-4">
						<label class="form-label" for="registerRepeatPassword">Repeat password</label>
						<input id="formSignupPassword2" type="password" class="form-control" bind:value={r_password2}/>
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
					<button id="formSignup" class="btn btn-primary btn-block mb-3" on:click={do_register}>Register</button>
				</form>
			</div>
		</div>
	</div>
</div>

<style>
	.nav-item {
		width: 50%;
	}
	.nav-item .active {
		font-size: 190%;
		padding: 0;
	}
	.nav-item :not(.active) {
		background: #eee;
		color: black;
		font-size: 100%;
		padding: 10px;
	}
</style>
