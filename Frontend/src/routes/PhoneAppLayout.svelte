<script>
	export let title = '';
</script>

<style>
	.phone-app-design {
		background-color: white;
		box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        height: calc(100% - 70px); /* Adjust the height to accommodate the footer navbar */
	}

	.fixed-width-height {
		width: 60vh; /* Adjust the width as needed */
		height: 90vh; /* Adjust the height as needed */
		margin: 0 auto; /* Center the container horizontally */
        position: relative; /* Add position relative */
	}

    .navbar {
        position: absolute;
        bottom: 0;
        left: 0;
        right: 0;
        z-index: 1000;
        border-radius: 0;
    }

    .navbar-nav {
        width: 100%;
        justify-content: space-around;
    }
</style>

<div class="" style="margin-top:5vh;">
	<div class="phone-app-design fixed-width-height overflow-auto">
		<slot />
         <!-- Footer navbar -->
         <!-- <nav class="navbar fixed-bottom navbar-light bg-light">
            <div class="container d-flex justify-content-center">
              <ul class="navbar-nav flex-row">
                <li class="nav-item">
                  <a class="nav-link" href="/home">
                    <i class="fa fa-home" style=""></i>
                  </a>
                </li>
                <li class="nav-item">
                  <a class="nav-link" href="/profile">
                    <i class="fa fa-user"></i>
                  </a>
                </li>
                <li class="nav-item">
                  <a class="nav-link" href="/book-scooter">
                    <i class="fa fa-motorcycle"></i>
                  </a>
                </li>
              </ul>
            </div>
          </nav> -->
          
	</div>
</div>


