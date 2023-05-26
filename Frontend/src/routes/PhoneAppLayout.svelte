<script>
</script>

<div class="phone-app">
	<div class="phone-app-design overflow-auto d-flex align-items-center">
		<slot />
	</div>
</div>

<style>
	.phone-app {
		margin-top: 5vh;
	}

	.phone-app-design {
		background-color: white;
		box-shadow: 0 0 30px rgba(0, 0, 0, 0.4);
    width: 60vh; /* Adjust the width as needed */
		height: 90vh; /* Adjust the height as needed */
		margin: 0 auto; /* Center the container horizontally */
	}
</style>
