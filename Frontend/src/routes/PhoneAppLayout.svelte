<script>
    export let title = '';
  </script>
  
  <style>
    .phone-app-design {
      background-color: white;
      padding: 20px;
      border-radius: 10px;
      box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
    }
  
    .phone-app-header {
      background-color: #ffffff;
      padding: 20px;
      border-radius: 10px;
      margin-bottom: 20px;
      text-align: center;
    }
  
    .fixed-width-height {
      width: 600px; /* Adjust the width as needed */
      height: 850px; /* Adjust the height as needed */
      margin: 0 auto; /* Center the container horizontally */
    }
  </style>
  
  <div class="container py-5">
    <div class="d-flex flex-column align-items-center mt-5">
      <div class="phone-app-design fixed-width-height">
        <div class="phone-app-header">
          <h1 class="text-center mt-3">{title}</h1>
        </div>
        <slot></slot>
      </div>
    </div>
  </div>
  