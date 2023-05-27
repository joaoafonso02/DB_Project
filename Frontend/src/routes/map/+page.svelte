<script>
  import { onMount } from 'svelte';

  let title = 'TrotiNet Map';
  let map;
  let choosingDestination = true;
  let destinationMarker;
  let distance = null;
  let chosenTroti = null;

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

    const modal = document.getElementById("myModal");
    const openModal = document.getElementById("openModal");
    const closeModal = document.getElementsByClassName("close")[0];

    

    openModal.onclick = function () {
      modal.style.display = "block";
    };

    closeModal.onclick = function () {
      modal.style.display = "none";
    };

    window.onclick = function (event) {
      if (event.target == modal) {
        modal.style.display = "none";
      }
    };
    

    map = L.map('map').setView([40.6339, -8.6599], 16);

    L.tileLayer('https://tile.openstreetmap.org/{z}/{x}/{y}.png', {
      attribution: '&copy; <a href="https://www.openstreetmap.org/copyright">OpenStreetMap</a> contributors'
    }).addTo(map);

    // adding trotinets
    let trotiNumber = 1;

    function createTrotis(icon, lat, lng, count) {
      for (let i = 0; i < count; i++) {
        let troti = L.marker([lat + Math.random() / 800, lng + Math.random() / 200], { icon: icon }).addTo(map);
        let trotiBattery = Math.floor(Math.random() * 100);
        troti.bindPopup('Troti #' + trotiNumber + '<br>' + getBatteryIcon(trotiBattery));
        troti.openPopup();
        trotiNumber++;

        troti.on('click', function () {
          chosenTroti = troti;
          console.log('Chosen Troti:', trotiNumber);
          document.getElementById('destination').innerHTML = 'Choose Destination';
        });
      }
    }

    createTrotis(trotiIcon, 40.6339, -8.6599, 9);
    createTrotis(trotiIcon, 40.6433, -8.6401, 8);


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

    // remove leflet control zoom
    map.removeControl(map.zoomControl);

    let destinationButton = document.getElementById('destination');
    let confirmButton = document.getElementById('confirm'); 
    let cancelButton = document.getElementById('cancel');
    
    map.on('click', function (e) {
  if (choosingDestination) {
    if (destinationMarker) {
      map.removeLayer(destinationMarker);
    }
    destinationMarker = L.marker(e.latlng).addTo(map);

    if (chosenTroti) {
      let trotiLatLng = chosenTroti.getLatLng();
      let distance = trotiLatLng.distanceTo(e.latlng);
      document.getElementById('destination').innerHTML = 'Destination: ' + distance.toFixed(0) + ' meters';
      let tripPrice = calculateTripPrice(distance); // Calculate trip price

      let confirmButton = document.createElement('button');
      confirmButton.classList.add('btn', 'btn-primary');
      confirmButton.textContent = 'Confirm Destination';

      let popupContent = document.createElement('div');
      popupContent.style.textAlign = 'center';
      popupContent.style.fontSize = '15px';
      popupContent.innerHTML = 'Trip Price: ' + tripPrice.toFixed(2) + '€<br>';
      popupContent.appendChild(confirmButton);

      destinationMarker.bindPopup(popupContent);

      destinationMarker.openPopup();

      document.getElementById('destination').innerHTML = 'Destination: ' + distance.toFixed(0) + ' meters';
      document.getElementById('tripPrice').innerHTML = 'Estimated Trip Price: €' + tripPrice.toFixed(2);

      confirmButton.addEventListener('click', function () {
        let modal = document.getElementById("myModal");
        modal.style.display = "block";
      });
    } else {
      console.log('No Troti chosen!');
    }
    document.getElementById('destination').style.display = 'block';
  }
});




    function calculateTripPrice(distance) {
      return (distance / 1000) * 0.5; // 50 cents / km
    }
  });

</script>

<div class="position-relative h-100 w-100">
  <h1 id="mapElements" style="text-align:center;">
    <i class="fa fa-user" style="position: absolute; left: 2vh; cursor: pointer;"></i>
    {title}
    <i class="fa fa-users" style="position: absolute; right: 7vh; cursor: pointer;"></i> 
    <i class="fa fa-qrcode" style="position: absolute; right: 2vh; cursor: pointer;" id="openModal"></i>
  </h1>
  <div id="map" style="height: calc(100%);"></div>
 
  <div id="destinationContainer" class="destination-container">
    <label on:click="{() => choosingDestination = true}" class="choose-destination-button" id="destination">Choose Troti</label>
  </div>
  <div id="confirmContainer" class="confirm-container">
    <button on:click="{() => choosingDestination = false}" class="confirm-button" id="confirm" style="display:none">Confirm</button>
  </div>
  
</div>


<div id="myModal" class="modal">
  <div class="modal-content center">
    <span class="close">&times;</span>
    <h2>Payment!</h2>
    <p id="tripPrice"></p> <!-- Added paragraph element to display trip price -->
    <footer>
      <button class="btn btn-primary mt-4" id="confirmButton">Confirm Destination</button>
      <button class="btn btn-danger mt-4" id="cancelButton">Cancel Destination</button>
    </footer>
  </div>
</div>



<!-- 
<div class="position-relative h-100 w-100">
  
  <div id="map" style="height: calc(100%);"></div>
  <h1 id="mapElements" style="text-align:center; bottom:1vh;">
    <i class="fa fa-user" style="position: absolute; left:2vh;"></i>
    {title}
    <i class="fa fa-qrcode" style="position: absolute; right: 2vh;"></i>
 
  </h1>
</div> -->



<style>
  #map {
    height: 100%;
  }

  #mapElements {
    padding: 5px;
    position: absolute;
    width: 100%;
    z-index: 1000;
    background: rgba(255, 255, 255, 0.4);
  }

  .modal {
    display: none;
    position: fixed;
    z-index: 1;
    left: 0;
    top: 0;
    width: 100%;
    height: 100%;
    overflow: auto;
    background-color: rgba(0, 0, 0, 0.5);
    z-index: 1000;
  }

  .modal-content {
    display: flex;
    flex-direction: column;
    align-items: center;
    justify-content: center;
    width: 30%;
    height: 60%;
    margin: auto;
    top: 50%;
    transform: translateY(-50%);
    padding: 20px;
    background-color: white;
  }

  .close {
    position: absolute;
    top: 10px;
    right: 20px;
    font-size: 28px;
    font-weight: bold;
    cursor: pointer;
  }

  .modal-img {
    max-width: 100%;
    max-height: 100%;
  }

  .destination-container {
  position: absolute;
  bottom: 10px;
  left: 50%;
  transform: translateX(-50%);
  z-index: 1000;
}


.choose-destination-button {
  padding: 10px 20px;
  font-size: 16px;
  background-color: #4CAF50;
  color: white;
  border: none;
  /* make it on the bottom */

}


</style>