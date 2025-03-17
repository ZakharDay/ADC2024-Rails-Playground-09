import { Controller } from '@hotwired/stimulus';

export default class extends Controller {
  static targets = ['slide'];
  static values = { index: Number };

  initialize() {
    console.log(this.indexValue);
    console.log(typeof this.indexValue);
    this.showCurrentSlide();
  }

  next() {
    this.indexValue++;
  }

  previous() {
    this.indexValue--;
  }

  indexValueChanged() {
    this.showCurrentSlide();
  }

  showCurrentSlide() {
    this.slideTargets.forEach((element, index) => {
      element.hidden = index !== this.indexValue;
    });
  }
}
