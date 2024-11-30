import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["customCompany", "collectionCompany"];

  connect() {
    console.log("form stimulus: connected.");
  }

  customCompany(event) {
    const selectedValue = event.target.value;
    console.log(selectedValue);

    if (selectedValue === "Add a new company") {
      this.customCompanyTarget.classList.remove("hidden");
      this.collectionCompanyTarget.classList.add("hidden");
      this.customCompanyTarget.required = true; // Make it required
    } else {
      this.customCompanyTarget.classList.add("hidden");
      this.collectionCompanyTarget.classList.remove("hidden");
      this.customCompanyTarget.required = false;
    }
  }
}
