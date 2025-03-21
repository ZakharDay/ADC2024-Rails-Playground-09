import { Controller } from '@hotwired/stimulus';

export default class extends Controller {
  static values = {
    url: String,
  };

  initialize() {
    console.log('Product Controller Initialized');
  }

  connect() {
    console.log('Product Controller Connected');
  }

  addToCart() {
    console.log('ADD TO CART CLICKED');

    fetch(this.urlValue + '.json').then((response) => {
      console.log(response);

      response.json().then((data) => {
        console.log(data);

        this.animateCart(data);
      });
    });
  }

  animateCart(data) {
    const { items, total } = data;

    const productCard = this.element;
    const animationElement = this.element.cloneNode(true);

    const cartBar = document.getElementById('cartbar');
    const cartItems = cartBar.querySelector('.items');
    const cartTotal = cartBar.querySelector('.total');

    const animationDelta = {
      x:
        cartBar.getBoundingClientRect().left -
        productCard.getBoundingClientRect().left -
        productCard.getBoundingClientRect().width / 2,
      y:
        cartBar.getBoundingClientRect().top -
        productCard.getBoundingClientRect().top -
        productCard.getBoundingClientRect().height / 2,
    };

    const addToCartAnimation = [
      {
        transform: `translateX(${animationDelta.x}px) translateY(${animationDelta.y}px) scale(0.03)`,
        opacity: 0,
      },
    ];

    const animationDiration = 1000;

    const addToCartTiming = {
      duration: animationDiration,
      iterations: 1,
      fill: 'forwards',
    };

    animationElement.querySelectorAll('.product').forEach((card) => {
      card.remove();
    });

    animationElement.classList.add('addToCart');
    this.element.appendChild(animationElement);

    animationElement.animate(addToCartAnimation, addToCartTiming);

    setTimeout(() => {
      animationElement.remove();

      cartBar.classList.add('addToCart');

      setTimeout(() => {
        cartBar.classList.remove('addToCart');
      }, 400);

      cartItems.innerText = items;
      cartTotal.innerText = total;
    }, animationDiration);
  }
}
