import { Controller } from '@hotwired/stimulus';

export default class extends Controller {
  static targets = [
    'galleryImagesRail',
    'galleryImage',
    'prevButton',
    'nextButton',
    'newImageButton',
    'createImageButton',
    'galleryMeatball',
  ];

  static values = { index: Number };

  static classes = ['navButtonVisibility', 'meatballActive'];

  // Callbacks

  indexValueChanged() {
    if (this.galleryImageTargets.length) {
      this.renderSlides();
      this.renderNavigation();
      // this.renderMeatballs();
    }
  }

  galleryImagesRailTargetConnected() {
    console.log('galleryImagesRailTargetConnected');
    this.renderSlides();
  }

  galleryImageTargetConnected() {
    this.renderNavigation();
    // this.renderMeatballs();
  }

  // galleryImageTargetDisconnected() {
  //   console.log('galleryImageTargetDisconnected');
  //   let nextIndex;

  //   if (this.indexValue > 0) {
  //     nextIndex = this.indexValue - 1;
  //   } else {
  //     nextIndex = 0;
  //   }

  //   this.moveToSlide({
  //     params: { position: nextIndex },
  //   });
  // }

  galleryMeatballsTargetConnected() {
    if (this.indexValue > this.galleryImageTargets.length - 1) {
      console.log(this.indexValue, this.galleryImageTargets.length);

      this.indexValue = this.galleryImageTargets.length - 1;
    }

    if (this.galleryImageTargets.length) {
      this.renderMeatballs();
    }
  }

  newImageFormTargetDisconnected() {
    if (this.galleryImageTargets.length) {
      this.moveToSlide({
        params: { position: this.galleryImageTargets.length - 1 },
      });
    }

    this.renderMeatballs();
  }

  // Actions

  nextImage() {
    this.moveSlide('next');
    this.renderMeatballs();
  }

  prevImage() {
    this.moveSlide('prev');
    this.renderMeatballs();
  }

  newImage() {
    this.newImageButtonTarget.click();
  }

  createImage() {
    this.createImageButtonTarget.click();
  }

  moveToSlide({ params: { position } }) {
    this.indexValue = position;
    this.renderMeatballs();
  }

  // Other methods

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
    console.log(this.indexValue);

    this.galleryMeatballTargets.forEach((meatball) => {
      meatball.classList.remove(this.meatballActiveClass);
    });

    const meatball = this.galleryMeatballTargets[this.indexValue];
    meatball.classList.add(this.meatballActiveClass);
  }
}
