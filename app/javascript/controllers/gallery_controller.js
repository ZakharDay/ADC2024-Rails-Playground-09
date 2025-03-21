import { Controller } from '@hotwired/stimulus';

export default class extends Controller {
  static targets = [
    'galleryImagesRail',
    'galleryImage',
    'prevButton',
    'nextButton',
    'galleryMeatball',
  ];

  static values = { index: Number };

  static classes = ['navButtonVisibility', 'meatballActive'];

  initialize() {
    console.log('Gallery Controller Initialized');
  }

  connect() {
    console.log('Gallery Controller Connected');
  }

  nextImage() {
    this.moveSlide('next');
  }

  prevImage() {
    this.moveSlide('prev');
  }

  moveSlide(direction) {
    if (direction === 'next') {
      if (this.indexValue + 1 < this.galleryImageTargets.length) {
        this.indexValue++;
      }
    }

    if (direction === 'prev') {
      if (this.indexValue >= 1) {
        this.indexValue--;
      }
    }
  }

  indexValueChanged() {
    this.renderSlides();
    this.renderNavigation();
    this.renderMeatballs();
  }

  renderSlides() {
    this.galleryImagesRailTarget.style.transform = `translateX(-${
      100 * this.indexValue
    }%)`;
  }

  renderNavigation() {
    if (this.indexValue === 0) {
      this.prevButtonTarget.classList.remove(this.navButtonVisibilityClass);
    }

    if (this.indexValue > 0) {
      this.prevButtonTarget.classList.add(this.navButtonVisibilityClass);
    }

    if (this.indexValue + 1 < this.galleryImageTargets.length) {
      this.nextButtonTarget.classList.add(this.navButtonVisibilityClass);
    }

    if (this.indexValue + 1 >= this.galleryImageTargets.length) {
      this.nextButtonTarget.classList.remove(this.navButtonVisibilityClass);
    }
  }

  renderMeatballs() {
    this.galleryMeatballTargets.forEach((meatball) => {
      meatball.classList.remove(this.meatballActiveClass);
    });

    const meatball = this.galleryMeatballTargets[this.indexValue];
    meatball.classList.add(this.meatballActiveClass);
  }
}
