import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="post-modals"
export default class extends Controller {
  connect() {
  }
  close(e)
  {
    e.preventDefault();
    const modal=document.getElementById("PostModal")
    modal.innerHTML=""

  }
}
