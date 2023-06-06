<script>
  import './map.css'
  import { onMount } from 'svelte';

  let title = 'TrotiNet Map';
  let map;
  let choosingDestination = true;
  let destinationMarker;
  let distance = null;
  let chosenTroti = null;
  let tripStarted = false;
  let paidTrip = false;
  let tripisOver= false;
  let message = 'Choose Troti';
  

  function showAlert(msg) {
    message = msg;
  }

  onMount(() => {
    let confirmButton = document.getElementById('confirmbutton');
    let confirmButton2 = document.getElementById('confirmbutton2');
    let cancelbutton  = document.getElementById('cancelbutton');
    let endTripButton = document.getElementById('endTrip');

    let modal = document.getElementById("myModal");
    let openModal = document.getElementById("openModal");
    let closeModal = document.getElementsByClassName("close")[0];

    let QRmodal = document.getElementById("QRCode");
    let QRopenModal = document.getElementById("QRCodeModal");
    let QRcloseModal = document.getElementsByClassName("close")[0];

    let trotiNumber = 1;

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

    let unavailableIcon = L.icon({
      iconUrl: '/unavailable.png',
      iconSize: [40, 40],
      iconAnchor: [25, 50],
      popupAnchor: [0, -50]
    });

    getTrotis(trotiIcon)

    let destinationIcon = L.icon({
      iconUrl: '/destination.jpeg',
      iconSize: [50, 50],
      iconAnchor: [25, 50],
      popupAnchor: [0, -50]
    });

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

    QRopenModal.onclick = function () {
      QRmodal.style.display = "block";
    };

    QRcloseModal.onclick = function () {
      QRmodal.style.display = "none";
    };

    window.onclick = function (event) {
      if (event.target == modal) {
        QRmodal.style.display = "none";
      }
    };
    

    map = L.map('map').setView([40.6339, -8.6469], 16);

    L.tileLayer('https://tile.openstreetmap.org/{z}/{x}/{y}.png', {
      attribution: '&copy; <a href="https://www.openstreetmap.org/copyright">OpenStreetMap</a> contributors'
    }).addTo(map);

 

    async function getTrotis(icon) {
      try {
        const response = await fetch('http://localhost:5004/get_trotis');
        const trotis = await response.json();

        trotis.forEach((troti) => {
          let lat = troti.trotiLat;
          let lng = troti.trotiLong;
          const trotiMarker = L.marker([lat, lng], { icon: icon }).addTo(map);

          // Customize the marker properties based on troti attributes
          const trotiBattery = troti.battery;
          const trotiNumber = troti.id;
          let trotiStatus = troti.availability_status;

          trotiMarker.bindPopup(
            `Troti #${trotiNumber}<br>${trotiStatus}<br>${getBatteryIcon(trotiBattery)} ${trotiBattery}%`
          );
          trotiMarker.openPopup();

          trotiMarker.trotiId = trotiNumber;

          trotiMarker.on('click', function () {
            chosenTroti = trotiMarker;
            console.log('Chosen Troti:', trotiMarker.trotiId);
            const message = 'Choose Destination';
            showAlert(message);
          });

        });
      } catch (error) {
        console.error('Error creating trotis:', error);
      }
    }

    // async function createTrotis(icon, lat, lng, count) {
    //   for (let i = 0; i < count; i++) {
    //     let troti = L.marker([lat + Math.random() / 600, lng + Math.random() / 200], { icon: icon }).addTo(map);
    //     let trotiBattery = Math.floor(Math.random() * 100);
    //     let insurance_id = Math.floor(Math.random() * (1000 - 40 + 1) + 40);
    //     let troti_id = Math.floor(Math.random() * 10000) + 50;
    //     // from 40 to 1000
    //     let alarm_id = Math.floor(Math.random() * (1000 - 40 + 1) + 40);
    //     let availability_status = "available";
    //     troti.bindPopup('Troti #' + trotiNumber + '<br>' + getBatteryIcon(trotiBattery) + " " + trotiBattery + '%');
    //     troti.openPopup();
    //     trotiNumber++;

    //     troti.on('click', function () {
    //       chosenTroti = troti;
    //       console.log('Chosen Troti:', trotiNumber);
    //       message = 'Choose Destination';
    //       showAlert(message);
    //     });

    //     // Send Troti attributes to the backend
    //     sendTrotiAttributes(troti_id + 40, trotiBattery, insurance_id, alarm_id, availability_status, lat, lng);
    //   }
    // }


    // async function  sendTrotiAttributes(troti_id, trotiBattery, insurance_id, alarm_id, availability_status, lat, lng) {
    //   try {
    //     let resp = await fetch('http://localhost:5004/post_trotis', {
    //       method: 'POST',
    //       headers: {
    //         'Content-Type': 'application/json'
    //       },
    //       body: JSON.stringify({
    //         trotiId: troti_id,
    //         trotiBattery: trotiBattery,
    //         insurance_id: insurance_id,
    //         alarm_id: alarm_id,
    //         availability_status: availability_status,
    //         trotiLat: lat,
    //         trotiLng: lng
    //       })
    //     });
    //     let data = await resp.json();
    //     console.log(data);
    //   } catch (error) {
    //     console.error('Error sending Troti attributes:', error);
    //   }
    // }


    // createTrotis(trotiIcon, 40.6339, -8.6579, 9);
    // createTrotis(trotiIcon, 40.6339, -8.6580, 2);
    // createTrotis(trotiIcon, 40.6339, -8.6580, 2);
    // createTrotis(trotiIcon, 40.6339, -8.6581, 2);

    


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

    confirmButton.addEventListener('click', async function () {
        await getTrotis(trotiIcon);
        simulateConfirmButtonClick();
    }); 

   
    async function simulateConfirmButtonClick() {
      tripStarted = true;
      console.log('Trip started');
      paidTrip = true;
      choosingDestination = false;
      modal.style.display = "none";
      QRmodal.style.display = "none";
      message = 'Trip just started! Have a nice ride!';

      // Get Troti ID and destination
      const response = await fetch('http://localhost:5004/get_trotis');
      const trotis = await response.json();

      let destination = destinationMarker.getLatLng();
      console.log('Troti ID: ', chosenTroti.trotiId);

      // Make an AJAX request to your backend endpoint to insert values
      fetch('http://localhost:5004/confirm_destination', {
          method: 'POST',
          headers: {
              'Content-Type': 'application/json',
          },
          body: JSON.stringify({
              trotiId: chosenTroti.trotiId,
              destination: destination,
          }),
      })
      .then(response => response.json())
      .then(data => {
          console.log('Confirmation inserted successfully:', data);
          chosenTroti.setIcon(unavailableIcon);
          chosenTroti.closePopup();
          chosenTroti.unbindPopup();
          chosenTroti.off('click');
          chosenTroti.on('click', function () {
              console.log('Troti is unavailable!');
          });

          unavailableIcon.options.riseOnHover = true;
          chosenTroti.setZIndexOffset(1000);
      })
      .catch(error => {
          console.error('Error inserting confirmation:', error);
      });


        
        setTimeout(() => {
          message = "";
          tripisOver = true;
          endTripButton.style.display = 'block';
        }, 3000);

        if (destinationMarker) {
          // change destination marker icon
          destinationMarker.setIcon(destinationIcon);
          let popupContent = document.createElement('div');
          popupContent.style.textAlign = 'center';
          popupContent.style.fontSize = '15px';
          popupContent.innerHTML = 'Your Destination';

          destinationMarker.bindPopup(popupContent);
          destinationMarker.openPopup();
        }
      }

      cancelbutton.addEventListener('click', function () {
        modal.style.display = "none";
        QRmodal.style.display = "none";
    });

    if (endTripButton) {
      endTripButton.addEventListener('click', function () {
        console.log('Trip ended');
        paidTrip = false;
        choosingDestination = true;
        tripisOver = false;
        endTripButton.style.display = 'none';
        message = 'Trip is over!';

        // Create rate popup
        let rateTextContent = document.createElement('div');
        rateTextContent.classList.add('rate-text');
        rateTextContent.innerHTML = 'Rate your trip:';
        rateTextContent.style.textAlign = 'center';
        rateTextContent.style.fontSize = '15px';
        rateTextContent.style.color = '#ff9d22';


        let ratePopupContent = document.createElement('div');
        ratePopupContent.classList.add('rate-popup');

        let starsContainer = document.createElement('div');
        starsContainer.classList.add('stars-container');

        for (let i = 1; i <= 5; i++) {
          let starInput = document.createElement('input');
          starInput.type = 'radio';
          starInput.name = 'rating';
          starInput.value = i;

          let starLabel = document.createElement('label');
          starLabel.htmlFor = 'rating-' + i;
          starLabel.classList.add('star');

          starsContainer.appendChild(starInput);
          starsContainer.appendChild(starLabel);
        }

        ratePopupContent.appendChild(rateTextContent);
        ratePopupContent.appendChild(starsContainer);
        

        // Display rate popup
        let ratePopup = L.popup()
          .setLatLng(chosenTroti.getLatLng())
          .setContent(ratePopupContent)
          .openOn(map);

        setTimeout(() => {
          ratePopup.remove();
          setTimeout(() => {
            message = 'Choose Troti';
          }, 3000);
        }, 5000);

        if (destinationMarker) {
          map.removeLayer(destinationMarker);
        }
        if (chosenTroti) {
          chosenTroti.closePopup();
        }
      });
    } 


    // QRCODE CONFIRM BUTTON
    confirmButton2.addEventListener('click', function () {
      QRmodal.style.display = "none";
    });

    // read code
    document.getElementById("qrcodeImage")?.addEventListener("click", function () {
      alert("Code Read! Choose your Troti and You're good to go!");
      QRmodal.style.display = "none";
    
    });


    function toggleSearchBar() {
      var searchContainer = document.querySelector(".search-container");

      if (searchContainer.style.display === "none") {
        searchContainer.style.display = "block";
      } else {
        searchContainer.style.display = "none";
      }
    }

    
    
    map.on('click', function (e) {
      if (choosingDestination) {
        if (destinationMarker) {
          map.removeLayer(destinationMarker);
        }
        destinationMarker = L.marker(e.latlng).addTo(map);

        if (chosenTroti) {
          console.log(chosenTroti.options.trotiId)
          let trotiLatLng = chosenTroti.getLatLng();
          let distance = trotiLatLng.distanceTo(e.latlng);
          message = 'Destination: ' + distance.toFixed(0) + ' meters';
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

          // get battery from chosen troti

          message = 'Destination in ' + distance.toFixed(0) + ' meters';
          document.getElementById('tripPrice').innerHTML = tripPrice.toFixed(2) + '€';
          document.getElementById('distanceTrip').innerHTML = distance.toFixed(0) + ' meters';
          

          confirmButton.addEventListener('click', function () {
            let modal = document.getElementById("myModal");
            modal.style.display = "block";
          });
        } else {
          console.log('No Troti chosen!');
        }
      }
    });

    function calculateTripPrice(distance) {
      return (distance / 1000) * 0.5; // 50 cents / km
    }
  });

</script>

<div class="position-relative h-100 w-100">
  <h1 id="mapElements" style="text-align:center;">
    <i class="fa fa-user" style="position: absolute; left: 2vh; cursor: pointer;" on:click={() => (window.location.href = '/profile')}></i>
    {title}
    <i class="fa fa-users" style="position: absolute; right: 7vh; cursor: pointer;" on:click={() => (window.location.href = '/chat')}></i> 
    <i class="fa fa-qrcode" style="position: absolute; right: 2vh; cursor: pointer;" id="QRCodeModal" ></i>
    <div id="openModal" style="display:none"></div>
  </h1>
  <div id="map" style="height: calc(100%);"></div>
  <div class="search-container" style="display: none;">
    <input type="text" id="trotiIdInput" placeholder="Enter Troti ID" />
    <button onclick="searchTroti()">Search</button>
  </div>

 
  <div id="destinationContainer" class="destination-container">
    {#if message}
        <div class="alert">{message}</div>
    {/if}

    <button class="end-trip-button" id="endTrip" style="display:none">End Trip</button>
  
  </div>
  <div id="confirmContainer" class="confirm-container">
    <button on:click="{() => choosingDestination = false}" class="confirm-button" id="confirm" style="display:none">Confirm</button>
  </div>

  
</div>


<div id="QRCode" class="modal">
  <div class="modal-content center">
    <span class="close">&times;</span>   
    <h2>Search and Scan Troti's QRCode</h2>
    <img src="qrcode.png" id="qrcodeImage" alt="QRCode" style="width:80%">
    <button class="button button--full mt-4" type="submit" id="confirmbutton2">Confirm</button>
  </div>
</div>


<div id="myModal" class="modal">
  <div class="modal-content center">
    <span class="close">&times;</span>    
    
    <div class="iphone">
      <header class="header">
        <h2>Checkout</h2>
      </header>
    
      <form class="form" >
        <div>

        <fieldset>
          <legend>Payment Method</legend>
    
          <div class="form__radios">
            <div class="form__radio">
              <label for="visa"><svg class="icon">
                  <use xlink:href="#icon-visa" />
                </svg>Visa Payment</label>
              <input checked id="visa" name="payment-method" type="radio" />
            </div>
    
            <div class="form__radio">
              <label for="paypal"><svg class="icon">
                  <use xlink:href="#icon-paypal" />
                </svg>PayPal</label>
              <input id="paypal" name="payment-method" type="radio" />
            </div>
    
            <div class="form__radio">
              <label for="mastercard"><svg class="icon">
                  <use xlink:href="#icon-mastercard" />
                </svg>Master Card</label>
              <input id="mastercard" name="payment-method" type="radio" />
            </div>
          </div>
        </fieldset>
    
        <div>
          <table  class="mt-4">
            <tbody>
             
            </tbody>
            <tfoot >
              <tr>
                <td>Price/km</td>
                <td align="right">0.5€</td>
              </tr>
              <tr>
                <td>Distance</td>
                <td align="right" id="distanceTrip"></td>
              </tr>
              <tr class="mt-4">
                <td class="mt-4"> Total</td>
                <td align="right" id="tripPrice"></td>
              </tr>
            </tfoot>
          </table>
        </div>
    
        <div>
          <button class="button button--full mt-4" type="submit" id="confirmbutton"><svg class="icon">
              <use xlink:href="#icon-shopping-bag" />
            </svg>Confirm Payment</button>
          
            <button class="button button--full mt-4" type="submit" id="cancelbutton"><svg class="icon">
              <use xlink:href="#icon-shopping-bag" />
            </svg>Cancel Payment</button>
        </div>
      </form>
    </div>
    
    <svg xmlns="http://www.w3.org/2000/svg" style="display: none">
    
      <symbol id="icon-shopping-bag" viewBox="0 0 24 24">
        <path d="M20 7h-4v-3c0-2.209-1.791-4-4-4s-4 1.791-4 4v3h-4l-2 17h20l-2-17zm-11-3c0-1.654 1.346-3 3-3s3 1.346 3 3v3h-6v-3zm-4.751 18l1.529-13h2.222v1.5c0 .276.224.5.5.5s.5-.224.5-.5v-1.5h6v1.5c0 .276.224.5.5.5s.5-.224.5-.5v-1.5h2.222l1.529 13h-15.502z" />
      </symbol>
    
      <symbol id="icon-mastercard" viewBox="0 0 504 504">
        <path d="m504 252c0 83.2-67.2 151.2-151.2 151.2-83.2 0-151.2-68-151.2-151.2 0-83.2 67.2-151.2 150.4-151.2 84.8 0 152 68 152 151.2z" fill="#ffb600" />
        <path d="m352.8 100.8c83.2 0 151.2 68 151.2 151.2 0 83.2-67.2 151.2-151.2 151.2-83.2 0-151.2-68-151.2-151.2" fill="#f7981d" />
        <path d="m352.8 100.8c83.2 0 151.2 68 151.2 151.2 0 83.2-67.2 151.2-151.2 151.2" fill="#ff8500" />
        <path d="m149.6 100.8c-82.4.8-149.6 68-149.6 151.2s67.2 151.2 151.2 151.2c39.2 0 74.4-15.2 101.6-39.2 5.6-4.8 10.4-10.4 15.2-16h-31.2c-4-4.8-8-10.4-11.2-15.2h53.6c3.2-4.8 6.4-10.4 8.8-16h-71.2c-2.4-4.8-4.8-10.4-6.4-16h83.2c4.8-15.2 8-31.2 8-48 0-11.2-1.6-21.6-3.2-32h-92.8c.8-5.6 2.4-10.4 4-16h83.2c-1.6-5.6-4-11.2-6.4-16h-70.4c2.4-5.6 5.6-10.4 8.8-16h53.6c-3.2-5.6-7.2-11.2-12-16h-29.6c4.8-5.6 9.6-10.4 15.2-15.2-26.4-24.8-62.4-39.2-101.6-39.2 0-1.6 0-1.6-.8-1.6z" fill="#ff5050" />
        <path d="m0 252c0 83.2 67.2 151.2 151.2 151.2 39.2 0 74.4-15.2 101.6-39.2 5.6-4.8 10.4-10.4 15.2-16h-31.2c-4-4.8-8-10.4-11.2-15.2h53.6c3.2-4.8 6.4-10.4 8.8-16h-71.2c-2.4-4.8-4.8-10.4-6.4-16h83.2c4.8-15.2 8-31.2 8-48 0-11.2-1.6-21.6-3.2-32h-92.8c.8-5.6 2.4-10.4 4-16h83.2c-1.6-5.6-4-11.2-6.4-16h-70.4c2.4-5.6 5.6-10.4 8.8-16h53.6c-3.2-5.6-7.2-11.2-12-16h-29.6c4.8-5.6 9.6-10.4 15.2-15.2-26.4-24.8-62.4-39.2-101.6-39.2h-.8" fill="#e52836" />
        <path d="m151.2 403.2c39.2 0 74.4-15.2 101.6-39.2 5.6-4.8 10.4-10.4 15.2-16h-31.2c-4-4.8-8-10.4-11.2-15.2h53.6c3.2-4.8 6.4-10.4 8.8-16h-71.2c-2.4-4.8-4.8-10.4-6.4-16h83.2c4.8-15.2 8-31.2 8-48 0-11.2-1.6-21.6-3.2-32h-92.8c.8-5.6 2.4-10.4 4-16h83.2c-1.6-5.6-4-11.2-6.4-16h-70.4c2.4-5.6 5.6-10.4 8.8-16h53.6c-3.2-5.6-7.2-11.2-12-16h-29.6c4.8-5.6 9.6-10.4 15.2-15.2-26.4-24.8-62.4-39.2-101.6-39.2h-.8" fill="#cb2026" />
        <g fill="#fff">
          <path d="m204.8 290.4 2.4-13.6c-.8 0-2.4.8-4 .8-5.6 0-6.4-3.2-5.6-4.8l4.8-28h8.8l2.4-15.2h-8l1.6-9.6h-16s-9.6 52.8-9.6 59.2c0 9.6 5.6 13.6 12.8 13.6 4.8 0 8.8-1.6 10.4-2.4z" />
          <path d="m210.4 264.8c0 22.4 15.2 28 28 28 12 0 16.8-2.4 16.8-2.4l3.2-15.2s-8.8 4-16.8 4c-17.6 0-14.4-12.8-14.4-12.8h32.8s2.4-10.4 2.4-14.4c0-10.4-5.6-23.2-23.2-23.2-16.8-1.6-28.8 16-28.8 36zm28-23.2c8.8 0 7.2 10.4 7.2 11.2h-17.6c0-.8 1.6-11.2 10.4-11.2z" />
          <path d="m340 290.4 3.2-17.6s-8 4-13.6 4c-11.2 0-16-8.8-16-18.4 0-19.2 9.6-29.6 20.8-29.6 8 0 14.4 4.8 14.4 4.8l2.4-16.8s-9.6-4-18.4-4c-18.4 0-36.8 16-36.8 46.4 0 20 9.6 33.6 28.8 33.6 6.4 0 15.2-2.4 15.2-2.4z" />
          <path d="m116.8 227.2c-11.2 0-19.2 3.2-19.2 3.2l-2.4 13.6s7.2-3.2 17.6-3.2c5.6 0 10.4.8 10.4 5.6 0 3.2-.8 4-.8 4s-4.8 0-7.2 0c-13.6 0-28.8 5.6-28.8 24 0 14.4 9.6 17.6 15.2 17.6 11.2 0 16-7.2 16.8-7.2l-.8 6.4h14.4l6.4-44c0-19.2-16-20-21.6-20zm3.2 36c0 2.4-1.6 15.2-11.2 15.2-4.8 0-6.4-4-6.4-6.4 0-4 2.4-9.6 14.4-9.6 2.4.8 3.2.8 3.2.8z" />
          <path d="m153.6 292c4 0 24 .8 24-20.8 0-20-19.2-16-19.2-24 0-4 3.2-5.6 8.8-5.6 2.4 0 11.2.8 11.2.8l2.4-14.4s-5.6-1.6-15.2-1.6c-12 0-24 4.8-24 20.8 0 18.4 20 16.8 20 24 0 4.8-5.6 5.6-9.6 5.6-7.2 0-14.4-2.4-14.4-2.4l-2.4 14.4c.8 1.6 4.8 3.2 18.4 3.2z" />
          <path d="m472.8 214.4-3.2 21.6s-6.4-8-15.2-8c-14.4 0-27.2 17.6-27.2 38.4 0 12.8 6.4 26.4 20 26.4 9.6 0 15.2-6.4 15.2-6.4l-.8 5.6h16l12-76.8zm-7.2 42.4c0 8.8-4 20-12.8 20-5.6 0-8.8-4.8-8.8-12.8 0-12.8 5.6-20.8 12.8-20.8 5.6 0 8.8 4 8.8 13.6z" />
          <path d="m29.6 291.2 9.6-57.6 1.6 57.6h11.2l20.8-57.6-8.8 57.6h16.8l12.8-76.8h-26.4l-16 47.2-.8-47.2h-23.2l-12.8 76.8z" />
          <path d="m277.6 291.2c4.8-26.4 5.6-48 16.8-44 1.6-10.4 4-14.4 5.6-18.4 0 0-.8 0-3.2 0-7.2 0-12.8 9.6-12.8 9.6l1.6-8.8h-15.2l-10.4 62.4h17.6z" />
          <path d="m376.8 227.2c-11.2 0-19.2 3.2-19.2 3.2l-2.4 13.6s7.2-3.2 17.6-3.2c5.6 0 10.4.8 10.4 5.6 0 3.2-.8 4-.8 4s-4.8 0-7.2 0c-13.6 0-28.8 5.6-28.8 24 0 14.4 9.6 17.6 15.2 17.6 11.2 0 16-7.2 16.8-7.2l-.8 6.4h14.4l6.4-44c.8-19.2-16-20-21.6-20zm4 36c0 2.4-1.6 15.2-11.2 15.2-4.8 0-6.4-4-6.4-6.4 0-4 2.4-9.6 14.4-9.6 2.4.8 2.4.8 3.2.8z" />
          <path d="m412 291.2c4.8-26.4 5.6-48 16.8-44 1.6-10.4 4-14.4 5.6-18.4 0 0-.8 0-3.2 0-7.2 0-12.8 9.6-12.8 9.6l1.6-8.8h-15.2l-10.4 62.4h17.6z" />
        </g>
        <path d="m180 279.2c0 9.6 5.6 13.6 12.8 13.6 5.6 0 10.4-1.6 12-2.4l2.4-13.6c-.8 0-2.4.8-4 .8-5.6 0-6.4-3.2-5.6-4.8l4.8-28h8.8l2.4-15.2h-8l1.6-9.6" fill="#dce5e5" />
        <path d="m218.4 264.8c0 22.4 7.2 28 20 28 12 0 16.8-2.4 16.8-2.4l3.2-15.2s-8.8 4-16.8 4c-17.6 0-14.4-12.8-14.4-12.8h32.8s2.4-10.4 2.4-14.4c0-10.4-5.6-23.2-23.2-23.2-16.8-1.6-20.8 16-20.8 36zm20-23.2c8.8 0 10.4 10.4 10.4 11.2h-20.8c0-.8 1.6-11.2 10.4-11.2z" fill="#dce5e5" />
        <path d="m340 290.4 3.2-17.6s-8 4-13.6 4c-11.2 0-16-8.8-16-18.4 0-19.2 9.6-29.6 20.8-29.6 8 0 14.4 4.8 14.4 4.8l2.4-16.8s-9.6-4-18.4-4c-18.4 0-28.8 16-28.8 46.4 0 20 1.6 33.6 20.8 33.6 6.4 0 15.2-2.4 15.2-2.4z" fill="#dce5e5" />
        <path d="m95.2 244.8s7.2-3.2 17.6-3.2c5.6 0 10.4.8 10.4 5.6 0 3.2-.8 4-.8 4s-4.8 0-7.2 0c-13.6 0-28.8 5.6-28.8 24 0 14.4 9.6 17.6 15.2 17.6 11.2 0 16-7.2 16.8-7.2l-.8 6.4h14.4l6.4-44c0-18.4-16-19.2-22.4-19.2m12 34.4c0 2.4-9.6 15.2-19.2 15.2-4.8 0-6.4-4-6.4-6.4 0-4 2.4-9.6 14.4-9.6 2.4.8 11.2.8 11.2.8z" fill="#dce5e5" />
        <path d="m136 290.4s4.8 1.6 18.4 1.6c4 0 24 .8 24-20.8 0-20-19.2-16-19.2-24 0-4 3.2-5.6 8.8-5.6 2.4 0 11.2.8 11.2.8l2.4-14.4s-5.6-1.6-15.2-1.6c-12 0-16 4.8-16 20.8 0 18.4 12 16.8 12 24 0 4.8-5.6 5.6-9.6 5.6" fill="#dce5e5" />
        <path d="m469.6 236s-6.4-8-15.2-8c-14.4 0-19.2 17.6-19.2 38.4 0 12.8-1.6 26.4 12 26.4 9.6 0 15.2-6.4 15.2-6.4l-.8 5.6h16l12-76.8m-20.8 41.6c0 8.8-7.2 20-16 20-5.6 0-8.8-4.8-8.8-12.8 0-12.8 5.6-20.8 12.8-20.8 5.6 0 12 4 12 13.6z" fill="#dce5e5" />
        <path d="m29.6 291.2 9.6-57.6 1.6 57.6h11.2l20.8-57.6-8.8 57.6h16.8l12.8-76.8h-20l-22.4 47.2-.8-47.2h-8.8l-27.2 76.8z" fill="#dce5e5" />
        <path d="m260.8 291.2h16.8c4.8-26.4 5.6-48 16.8-44 1.6-10.4 4-14.4 5.6-18.4 0 0-.8 0-3.2 0-7.2 0-12.8 9.6-12.8 9.6l1.6-8.8" fill="#dce5e5" />
        <path d="m355.2 244.8s7.2-3.2 17.6-3.2c5.6 0 10.4.8 10.4 5.6 0 3.2-.8 4-.8 4s-4.8 0-7.2 0c-13.6 0-28.8 5.6-28.8 24 0 14.4 9.6 17.6 15.2 17.6 11.2 0 16-7.2 16.8-7.2l-.8 6.4h14.4l6.4-44c0-18.4-16-19.2-22.4-19.2m12 34.4c0 2.4-9.6 15.2-19.2 15.2-4.8 0-6.4-4-6.4-6.4 0-4 2.4-9.6 14.4-9.6 3.2.8 11.2.8 11.2.8z" fill="#dce5e5" />
        <path d="m395.2 291.2h16.8c4.8-26.4 5.6-48 16.8-44 1.6-10.4 4-14.4 5.6-18.4 0 0-.8 0-3.2 0-7.2 0-12.8 9.6-12.8 9.6l1.6-8.8" fill="#dce5e5" />
      </symbol>
    
      <symbol id="icon-paypal" viewBox="0 0 491.2 491.2">
        <path d="m392.049 36.8c-22.4-25.6-64-36.8-116-36.8h-152.8c-10.4 0-20 8-21.6 18.4l-64 403.2c-1.6 8 4.8 15.2 12.8 15.2h94.4l24-150.4-.8 4.8c1.6-10.4 10.4-18.4 21.6-18.4h44.8c88 0 156.8-36 176.8-139.2.8-3.2.8-6.4 1.6-8.8-2.4-1.6-2.4-1.6 0 0 5.6-38.4 0-64-20.8-88" fill="#263b80" />
        <path d="m412.849 124.8c-.8 3.2-.8 5.6-1.6 8.8-20 103.2-88.8 139.2-176.8 139.2h-44.8c-10.4 0-20 8-21.6 18.4l-29.6 186.4c-.8 7.2 4 13.6 11.2 13.6h79.2c9.6 0 17.6-7.2 19.2-16l.8-4 15.2-94.4.8-5.6c1.6-9.6 9.6-16 19.2-16h12c76.8 0 136.8-31.2 154.4-121.6 7.2-37.6 3.2-69.6-16-91.2-6.4-7.2-13.6-12.8-21.6-17.6" fill="#139ad6" />
        <path d="m391.249 116.8c-3.2-.8-6.4-1.6-9.6-2.4s-6.4-1.6-10.4-1.6c-12-2.4-25.6-3.2-39.2-3.2h-119.2c-3.2 0-5.6.8-8 1.6-5.6 2.4-9.6 8-10.4 14.4l-25.6 160.8-.8 4.8c1.6-10.4 10.4-18.4 21.6-18.4h44.8c88 0 156.8-36 176.8-139.2.8-3.2.8-6.4 1.6-8.8-4.8-2.4-10.4-4.8-16.8-7.2-1.6 0-3.2-.8-4.8-.8" fill="#232c65" />
        <path d="m275.249 0h-152c-10.4 0-20 8-21.6 18.4l-36.8 230.4 246.4-246.4c-11.2-1.6-23.2-2.4-36-2.4z" fill="#2a4dad" />
        <path d="m441.649 153.6c-2.4-4-4-8-7.2-12-5.6-6.4-13.6-12-21.6-16.8-.8 3.2-.8 5.6-1.6 8.8-20 103.2-88.8 139.2-176.8 139.2h-44.8c-10.4 0-20 8-21.6 18.4l-25.6 161.6z" fill="#0d7dbc" />
        <path d="m50.449 436.8h94.4l23.2-145.6c0-2.4.8-4 1.6-5.6l-131.2 131.2-.8 4.8c-.8 8 4.8 15.2 12.8 15.2z" fill="#232c65" />
        <path d="m246.449 0h-123.2c-3.2 0-5.6.8-8 1.6l-12 12c-.8 1.6-1.6 3.2-1.6 4.8l-24 150.4z" fill="#436bc4" />
        <path d="m450.449 232.8c2.4-12 3.2-23.2 3.2-34.4l-156 156c76-.8 135.2-32 152.8-121.6z" fill="#0cb2ed" />
        <path d="m248.849 471.2 12.8-80-100 100h68c9.6 0 17.6-7.2 19.2-16z" fill="#0cb2ed" />
        <g fill="#33e2ff" opacity=".6">
          <path d="m408.049 146.4 45.6 45.6c0-5.6-1.6-11.2-2.4-16.8l-40-40c-1.6 4-2.4 7.2-3.2 11.2z" />
          <path d="m396.849 180c-1.6 3.2-3.2 6.4-4.8 9.6l55.2 55.2c.8-4 1.6-8 2.4-12z" />
          <path d="m431.249 287.2c1.6-3.2 3.2-6.4 4.8-9.6l-60.8-60.8c-2.4 2.4-4 5.6-6.4 8z" />
          <path d="m335.249 250.4 69.6 69.6 7.2-7.2-68-68c-3.2 1.6-5.6 3.2-8.8 5.6z" />
          <path d="m292.849 266.4 76 76c3.2-1.6 6.4-3.2 9.6-4.8l-74.4-74.4c-4 .8-7.2 2.4-11.2 3.2z" />
          <path d="m320.849 353.6c4-.8 8.8-.8 12.8-1.6l-80-80c-4.8 0-8.8.8-13.6.8z" />
          <path d="m196.049 272.8h-6.4c-2.4 0-4.8.8-6.4.8l86.4 87.2c2.4-2.4 5.6-4.8 8.8-5.6z" />
          <path d="m164.049 314.4 94.4 94.4 2.4-12.8-94.4-94.4z" />
          <path d="m156.049 364.8 94.4 94.4 2.4-12-94.4-94.4z" />
          <path d="m150.449 403.2-1.6 12.8 75.2 75.2h5.6c2.4 0 4.8-.8 7.2-1.6z" />
          <path d="m140.049 466.4 24.8 24.8h14.4l-36.8-36.8z" />
        </g>
      </symbol>
    
      <symbol id="icon-visa" viewBox="0 0 504 504">
        <path d="m184.8 324.4 25.6-144h40l-24.8 144z" fill="#3c58bf" />
        <path d="m184.8 324.4 32.8-144h32.8l-24.8 144z" fill="#293688" />
        <path d="m370.4 182c-8-3.2-20.8-6.4-36.8-6.4-40 0-68.8 20-68.8 48.8 0 21.6 20 32.8 36 40s20.8 12 20.8 18.4c0 9.6-12.8 14.4-24 14.4-16 0-24.8-2.4-38.4-8l-5.6-2.4-5.6 32.8c9.6 4 27.2 8 45.6 8 42.4 0 70.4-20 70.4-50.4 0-16.8-10.4-29.6-34.4-40-14.4-7.2-23.2-11.2-23.2-18.4 0-6.4 7.2-12.8 23.2-12.8 13.6 0 23.2 2.4 30.4 5.6l4 1.6z" fill="#3c58bf" />
        <path d="m370.4 182c-8-3.2-20.8-6.4-36.8-6.4-40 0-61.6 20-61.6 48.8 0 21.6 12.8 32.8 28.8 40s20.8 12 20.8 18.4c0 9.6-12.8 14.4-24 14.4-16 0-24.8-2.4-38.4-8l-5.6-2.4-5.6 32.8c9.6 4 27.2 8 45.6 8 42.4 0 70.4-20 70.4-50.4 0-16.8-10.4-29.6-34.4-40-14.4-7.2-23.2-11.2-23.2-18.4 0-6.4 7.2-12.8 23.2-12.8 13.6 0 23.2 2.4 30.4 5.6l4 1.6z" fill="#293688" />
        <path d="m439.2 180.4c-9.6 0-16.8.8-20.8 10.4l-60 133.6h43.2l8-24h51.2l4.8 24h38.4l-33.6-144zm-18.4 96c2.4-7.2 16-42.4 16-42.4s3.2-8.8 5.6-14.4l2.4 13.6s8 36 9.6 44h-33.6z" fill="#3c58bf" />
        <path d="m448.8 180.4c-9.6 0-16.8.8-20.8 10.4l-69.6 133.6h43.2l8-24h51.2l4.8 24h38.4l-33.6-144zm-28 96c3.2-8 16-42.4 16-42.4s3.2-8.8 5.6-14.4l2.4 13.6s8 36 9.6 44h-33.6z" fill="#293688" />
        <path d="m111.2 281.2-4-20.8c-7.2-24-30.4-50.4-56-63.2l36 128h43.2l64.8-144h-43.2z" fill="#3c58bf" />
        <path d="m111.2 281.2-4-20.8c-7.2-24-30.4-50.4-56-63.2l36 128h43.2l64.8-144h-35.2z" fill="#293688" />
        <path d="m0 180.4 7.2 1.6c51.2 12 86.4 42.4 100 78.4l-14.4-68c-2.4-9.6-9.6-12-18.4-12z" fill="#ffbc00" />
        <path d="m0 180.4c51.2 12 93.6 43.2 107.2 79.2l-13.6-56.8c-2.4-9.6-10.4-15.2-19.2-15.2z" fill="#f7981d" />
        <path d="m0 180.4c51.2 12 93.6 43.2 107.2 79.2l-9.6-31.2c-2.4-9.6-5.6-19.2-16.8-23.2z" fill="#ed7c00" />
        <g fill="#051244">
          <path d="m151.2 276.4-27.2-27.2-12.8 30.4-3.2-20c-7.2-24-30.4-50.4-56-63.2l36 128h43.2z" />
          <path d="m225.6 324.4-34.4-35.2-6.4 35.2z" />
          <path d="m317.6 274.8c3.2 3.2 4.8 5.6 4 8.8 0 9.6-12.8 14.4-24 14.4-16 0-24.8-2.4-38.4-8l-5.6-2.4-5.6 32.8c9.6 4 27.2 8 45.6 8 25.6 0 46.4-7.2 58.4-20z" />
          <path d="m364 324.4h37.6l8-24h51.2l4.8 24h38.4l-13.6-58.4-48-46.4 2.4 12.8s8 36 9.6 44h-33.6c3.2-8 16-42.4 16-42.4s3.2-8.8 5.6-14.4" />
        </g>
      </symbol>
    </svg>

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


