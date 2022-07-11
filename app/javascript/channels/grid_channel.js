import consumer from "channels/consumer"

consumer.subscriptions.create("GridChannel", {
  connected() {
    // Called when the subscription is ready for use on the server
    console.log("Channel Connected");
  },

  disconnected() {
    // Called when the subscription has been terminated by the server

    console.log("DISCONNECTED");
  },

  received(data) {
    // Called when there's incoming data on the websocket for this channel

    document.getElementById("generation").innerHTML = data.generation;
    document.getElementById("grid").innerHTML = data.grid;
  }
  
});
