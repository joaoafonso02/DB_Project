<script>
  import PhoneAppLayout from '../PhoneAppLayout.svelte';
  import { onMount } from 'svelte';

  let title = 'Map';

  onMount(() => {
    document.title = title;
  });

  let credentials = { usr: "admin", password: "1234" };

  function submitSignin() {
    let usr = document.querySelector("#formSigninUsername").value;
    let password = document.querySelector("#formSigninPassword").value;
    const users = credentials;
    console.log(credentials.length);
    console.log("EW");
    if (users['usr'] == usr && users['password'] == password) {
      window.location.href = '/';
    } else {
      showAlert("Unknown username or password, try again!");
    }
  }

  let message = "";

  function showAlert(msg) {
    setTimeout(() => {
      message = "";
    }, 3000);
    message = msg;
  }

  let map;

  onMount(() => {
    map = L.map('map').setView([40.6339, -8.6599], 16);

    L.tileLayer('https://tile.openstreetmap.org/{z}/{x}/{y}.png', {
      attribution: '&copy; <a href="https://www.openstreetmap.org/copyright">OpenStreetMap</a> contributors'
    }).addTo(map);

    L.marker([40.633002429864595, -8.6593]).addTo(map)
      .bindPopup('A pretty CSS popup.<br> Easily customizable.')
      .openPopup();
  });
</script>

<PhoneAppLayout {title}>
  <div id="mapElements">
    <h1 class="text-center my-5">{title}</h1>
  </div>
  <div id="map"></div>
</PhoneAppLayout>

<style>
  #map {
    height: 100%;
  }

  #mapElements {
    position: absolute;
    width: 100%;
    z-index: 1000;
  }
</style>

