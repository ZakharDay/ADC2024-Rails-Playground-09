import { Controller } from '@hotwired/stimulus';

export default class extends Controller {
  static targets = [
    'galleryImagesRail',
    'galleryImage',
    'prevButton',
    'nextButton',
    'newImageForm',
    'newImageButton',
    'createImageButton',
    'galleryMeatball',
    'galleryMeatballs',
  ];

  static values = {
    index: Number,
    createImageUrl: String,
    lowerImageUrl: String,
    higherImageUrl: String,
    destroyImageUrl: String,
  };

  static classes = ['navButtonVisibility', 'meatballActive'];

  // Callbacks

  indexValueChanged() {
    if (this.galleryImageTargets.length) {
      this.renderSlides();
      this.renderNavigation();
      this.renderMeatballs();
    }
  }

  galleryImagesRailTargetConnected() {
    console.log('galleryImagesRailTargetConnected');

    if (this.indexValue > this.galleryImageTargets.length - 1) {
      this.indexValue = this.galleryImageTargets.length - 1;
    }

    this.renderSlides();
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

  newImageFormTargetDisconnected() {
    console.log(
      'newImageFormTargetDisconnected',
      this.galleryImageTargets.length
    );

    if (this.galleryImageTargets.length) {
      this.moveToSlide({
        params: { position: this.galleryImageTargets.length - 1 },
      });
    }
  }

  // Actions

  nextImage() {
    this.moveSlide('next');
  }

  prevImage() {
    this.moveSlide('prev');
  }

  nthImage({ params: { position } }) {
    this.moveToSlide({
      params: { position: position },
    });
  }

  newImage() {
    this.newImageButtonTarget.click();
  }

  createImage() {
    const form = this.newImageFormTarget;
    const formContent = new FormData(form);

    fetch(this.createImageUrlValue + '.html', {
      method: 'POST',
      body: formContent,
    }).then((response) => {
      response.text().then((data) => {
        const html = new DOMParser().parseFromString(data, 'text/html');

        this.galleryImagesRailTarget.appendChild(
          html.querySelector('.galleryImage').cloneNode(true)
        );

        this.galleryMeatballsTarget.appendChild(
          html.querySelector('.galleryMeatball').cloneNode(true)
        );

        this.newImageFormTarget.reset();

        this.moveToSlide({
          params: { position: this.galleryImageTargets.length - 1 },
        });
      });
    });
  }

  lowerImage({ params: { imageId } }) {
    console.log(imageId);
  }

  higherImage({ params: { imageId } }) {
    console.log(imageId);
  }

  destroyImage({ params: { imageId } }) {
    console.log(imageId);

    fetch(this.destroyImageUrlValue + '.json', {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json',
      },
      body: JSON.stringify({ id: imageId }),
    }).then((response) => {
      console.log(response.status);

      if (response.status == 200) {
        this.galleryImageTargets.forEach((galleryImage) => {
          if (galleryImage.dataset.galleryImageIdParam == imageId) {
            galleryImage.remove();
          }
        });
      }

      // response.json().then((data) => {
      // console.log(data);

      // const html = new DOMParser().parseFromString(data, 'text/html');

      // this.galleryImagesRailTarget.appendChild(
      //   html.querySelector('.galleryImage').cloneNode(true)
      // );

      // this.galleryMeatballsTarget.appendChild(
      //   html.querySelector('.galleryMeatball').cloneNode(true)
      // );

      // this.newImageFormTarget.reset();

      // this.moveToSlide({
      //   params: { position: this.galleryImageTargets.length - 1 },
      // });
      // });
    });
  }

  // Other methods

  moveToSlide({ params: { position } }) {
    this.indexValue = position;
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
    if (this.galleryMeatballTargets.length > 0) {
      this.galleryMeatballTargets.forEach((meatball) => {
        meatball.classList.remove(this.meatballActiveClass);
      });

      console.log(
        this.indexValue,
        this.galleryMeatballTargets,
        this.galleryMeatballTargets[this.indexValue]
      );

      const meatball = this.galleryMeatballTargets[this.indexValue];
      meatball.classList.add(this.meatballActiveClass);
    }
  }
}
