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

      this.animateCart();
    });
  }

  animateCart() {
    const productCard = this.element;
    const animationElement = this.element.cloneNode(true);

    const cartBar = document.getElementById('cartbar');
    const cartCounter = cartBar.querySelector('.counter');

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

    animationElement.classList.add('addToCart');
    this.element.appendChild(animationElement);

    animationElement.animate(addToCartAnimation, addToCartTiming);

    setTimeout(() => {
      animationElement.remove();

      cartBar.classList.add('addToCart');

      setTimeout(() => {
        cartBar.classList.remove('addToCart');
      }, 400);

      cartCounter.innerText = parseInt(cartCounter.innerText) + 1;
    }, animationDiration);

    //   const cartButton = document.querySelector('.A_CartButton');
    //   const cartButtonCounter = cartButton.querySelector('.W_CartItemsCounter');
    //   const bookContentContainer = document.querySelector('.S_BookContent');
    //   const bookImagesElement = document.querySelector('.O_BookImages');
    //   const animationElement = bookImagesElement.cloneNode(true);
    //   animationElement.querySelector('.C_BookGalleryControls').remove();
    //   animationElement.querySelector('.C_BookImagesMeatballs').remove();

    //   animationElement.classList.add('addToCart');
    //   bookContentContainer.appendChild(animationElement);

    //   const buttonImagesDelta = {
    //     x:
    //       cartButton.getBoundingClientRect().left -
    //       animationElement.getBoundingClientRect().left -
    //       animationElement.getBoundingClientRect().width / 2 +
    //       18,
    //     y:
    //       cartButton.getBoundingClientRect().top -
    //       animationElement.getBoundingClientRect().top -
    //       animationElement.getBoundingClientRect().height / 2 +
    //       18,
    //   };

    //   const addToCartAnimation = [
    //     {
    //       transform: `translateX(${buttonImagesDelta.x}px) translateY(${buttonImagesDelta.y}px) scale(0.03)`,
    //       opacity: 0,
    //     },
    //   ];

    //   const addToCartTiming = {
    //     duration: 1000,
    //     iterations: 1,
    //     fill: 'forwards',
    //   };

    //   animationElement.animate(addToCartAnimation, addToCartTiming);

    //   setTimeout(() => {
    //     animationElement.remove();
    //     cartButton.classList.add('addToCart');
    //     cartButton.classList.remove('empty');
    //     cartButtonCounter.innerText = parseInt(cartButtonCounter.innerText) + 1;
    //   }, 1000);
  }
}
