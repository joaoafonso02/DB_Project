<script>
  import PhoneAppLayout from '../PhoneAppLayout.svelte';
  import { onMount } from 'svelte';

  let title = 'TrotiNet Map';
  let map;

  onMount(() => {
    document.title = title;

    let userIcon = L.icon({
      iconUrl: '/user.png',
      iconSize: [40, 40],
      iconAnchor: [25, 50],
      popupAnchor: [0, -50]
    });

    let trotiIcon = L.icon({
      iconUrl: '/scooter.png',
      iconSize: [40, 40],
      iconAnchor: [25, 50],
      popupAnchor: [0, -50]
    });
    

    map = L.map('map').setView([40.6339, -8.6599], 16);

    L.tileLayer('https://tile.openstreetmap.org/{z}/{x}/{y}.png', {
      attribution: '&copy; <a href="https://www.openstreetmap.org/copyright">OpenStreetMap</a> contributors'
    }).addTo(map);

    // adding trotinets
    let trotiNumber = 1;

    for (let i = 0; i <= 8; i++) {
        let troti = L.marker([40.6339 + Math.random() / 800, -8.6599 + Math.random() / 200], { icon: trotiIcon }).addTo(map);
        let trotiBattery = Math.floor(Math.random() * 100);
        troti.bindPopup('Troti #' + trotiNumber + '<br>' + getBatteryIcon(trotiBattery));
        troti.openPopup();
        trotiNumber++;
      }

    for (let i = 0; i <= 7; i++) {
      let troti = L.marker([40.6433 + Math.random() / 800, -8.6401 - Math.random() / 200], { icon: trotiIcon }).addTo(map);
      let trotiBattery = Math.floor(Math.random() * 100);
      troti.bindPopup('Troti #' + trotiNumber + ' near Aveiro Train Station!' + '<br>' + getBatteryIcon(trotiBattery));
      troti.openPopup();
      trotiNumber++;
    }

    L.marker([40.633202429864595, -8.6593], { icon: userIcon }).addTo(map)
      .bindPopup('You are here!')
      .openPopup();

    function getBatteryIcon(batteryLevel) {
      if (batteryLevel >= 60 && batteryLevel <= 100) {
        return '<i class="fa fa-battery-full" style="font-size: 20px; color:green;text-align:center"></i>';
      } else if (batteryLevel >= 21 && batteryLevel <= 59) {
        return '<i class="fa fa-battery-half" style="font-size: 20px; color:orange;text-align:center"></i>';
      } else if (batteryLevel >= 0 && batteryLevel <= 20) {
        return '<i class="fa fa-battery-empty" style="font-size: 20px; color:red;text-align:center"></i>';
      }
    }

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

