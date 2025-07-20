// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"
import "color-modes"
import "bootstrap"

document.addEventListener("turbo:load", () => {
  document.querySelectorAll(".toast").forEach((toastEl) => {
    const toast = new bootstrap.Toast(toastEl, {
      autohide: true,
      delay: 3500
    });
    toast.show();
  });
});
