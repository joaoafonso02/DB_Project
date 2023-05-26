<script>
	export let title = '';
</script>

<div class="" style="margin-top:5vh;">
	<div class="phone-app-design fixed-width-height overflow-auto">
		<slot />
	</div>
</div>

<style>
	.phone-app-design {
		background-color: white;
		padding: 20px;
		box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
	}

	.fixed-width-height {
		width: 60vh; /* Adjust the width as needed */
		height: 90vh; /* Adjust the height as needed */
		margin: 0 auto; /* Center the container horizontally */
	}
</style>
