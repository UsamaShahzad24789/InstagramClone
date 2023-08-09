// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"
import "popper"

import "bootstrap"

// for searching by pressing enter
$(document).ready(function() {
  $('#searchForm').keydown(function(event) {
    if (event.keyCode == 13) {
      event.preventDefault();
      $('#searchForm').submit();
    }
  });
});
