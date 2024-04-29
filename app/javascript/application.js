// Entry point for the build script in your package.json
import "@hotwired/turbo-rails";
import "./controllers";

document.querySelectorAll(".stop-propagation").forEach((button) => {
  button.addEventListener("click", function (event) {
    event.stopPropagation();
  });
});
