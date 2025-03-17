import { Controller } from '@hotwired/stimulus';

export default class extends Controller {
  static targets = ['name'];

  initialize() {
    console.log('Hello Controller Initialized');
  }

  connect() {
    console.log('Hello Controller Connected');
  }

  nameTargetConnected() {
    console.log('Hello Controller Name Target Connected');
  }

  greet() {
    console.log(`Hello, ${this.name}!`);
  }

  get name() {
    return this.nameTarget.value;
  }
}
