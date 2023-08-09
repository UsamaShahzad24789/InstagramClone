import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="search"
export default class extends Controller {
  connect() {
  }
  close(e)
  {
    e.preventDefault();
    const modal=document.getElementById("search")
    modal.innerHTML=""

  }
}
