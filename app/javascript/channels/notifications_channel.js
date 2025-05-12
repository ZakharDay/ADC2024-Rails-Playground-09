import consumer from 'channels/consumer';

consumer.subscriptions.create('NotificationsChannel', {
  connected() {
    // Called when the subscription is ready for use on the server
    console.log('NotificationsChannel connected');
  },

  disconnected() {
    // Called when the subscription has been terminated by the server
    console.log('NotificationsChannel disconnected');
  },

  received(data) {
    // Called when there's incoming data on the websocket for this channel
    console.log('NotificationsChannel received', data);

    // Add notification
    const container = document.getElementById('notifications');
    const notification = document.createElement('div');
    const link = document.createElement('a');

    notification.classList.add('notification');
    link.innerText = data.body;
    link.href = 'http://localhost:3000' + data.url;

    notification.appendChild(link);
    container.appendChild(notification);

    // Update counter
    const counter = document.querySelector('.notificationsCounter span');
    const text = parseInt(counter.innerText);
    counter.innerText = text + 1;
  },
});
