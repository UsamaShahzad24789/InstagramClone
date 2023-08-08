import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="comment-modals"
export default class extends Controller {
  connect() {
  }
  close(e)
  {
    e.preventDefault();
    const modal=document.getElementById("comment")
    modal.innerHTML=""

  }
}
