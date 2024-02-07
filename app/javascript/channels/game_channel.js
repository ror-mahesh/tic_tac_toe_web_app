import consumer from "channels/consumer"

consumer.subscriptions.create("GameChannel", {
  connected() {
   console.log("Connected to Game channel.")

    // Called when the subscription is ready for use on the server
  },

  disconnected() {
    // Called when the subscription has been terminated by the server
  },

  received(data) {
   var test = document.getElementById(`${data['game']['id']}_${data['col']}_${data['row']}`)
   if(test){
    location.reload()
   }
  },
});
