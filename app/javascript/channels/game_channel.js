// import consumer from "channels/consumer"

// consumer.subscriptions.create("GameChannel", {
//   connected() {
//     // Called when the subscription is ready for use on the server
//   },

//   disconnected() {
//     // Called when the subscription has been terminated by the server
//   },

//   received(data) {
//     // Called when there's incoming data on the websocket for this channel
//   }
// });

// app/assets/javascripts/channels/game_channel.js
var App = App || {};

document.addEventListener('DOMContentLoaded', () => {
  App.gameChannel = App.cable.subscriptions.create('GameChannel', {
    received: function(data) {
      // Handle received data and update the UI
      $('#test').innerText = 123
      console.log(data);
      // Implement logic to update the game UI based on the received data
    }
  });
});
