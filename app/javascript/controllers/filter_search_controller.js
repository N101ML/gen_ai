import { Controller } from "@hotwired/stimulus";

function debounce(func, wait) {
  let timeout;
  return function (...args) {
    clearTimeout(timeout);
    timeout = setTimeout(() => func.apply(this, args), wait);
  };
}

export default class extends Controller {
  initialize() {
    this.submit = debounce(this.submit.bind(this), 300);
  }

  connect() {
    console.log("filter_search controller connected. Ready to filter.");
  }

  submit() {
    console.log("Submitting filter form...");
    this.element.requestSubmit();
  }
}
