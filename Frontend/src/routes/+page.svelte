<script>
	import PhoneAppLayout from './PhoneAppLayout.svelte';
	import { onMount } from 'svelte';
  
	let title = 'Welcome to TrotiNet';
  
	onMount(() => {
	  document.title = title;
	});
  </script>
  
  <PhoneAppLayout {title}>
	<img src="/trotinet.jpg" alt="TrotiNet logo" class="mx-auto mt-3" style="width: 100%; height: auto;" />
	<div class="container" style="max-width: 300px;">
	  <button type="button" class="btn btn-outline-primary btn-lg mt-3 w-100" on:click={()=>window.location.href='/login'}>Login/Register</button>
	</div>
  </PhoneAppLayout>
  