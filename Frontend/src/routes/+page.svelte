<script>
	import PhoneAppLayout from './PhoneAppLayout.svelte';
</script>

<PhoneAppLayout>
	<div class="text-center p-3">
		<h1 class="mb-5">Welcome to TrotiNet</h1>
		<img
			class="mx-auto"
			src="/trotinet.jpg"
			alt="TrotiNet logo"
		/>
		<button
			class="btn btn-secondary py-3"
			type="button"
			on:click={() => (window.location.href = '/login')}>Login/Register</button
		>
	</div>
</PhoneAppLayout>

<style>
	h1 {

	}
	img {
		width: 100%;
		height: 100%;
	}
	button {
		width: 70%;
	}
</style>
