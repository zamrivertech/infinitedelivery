import "@hotwired/turbo-rails";
import "controllers";
import "color-modes";
import "bootstrap";

// Show Bootstrap toasts
document.addEventListener("turbo:load", () => {
  document.querySelectorAll(".toast").forEach((toastEl) => {
    const toast = new bootstrap.Toast(toastEl, {
      autohide: true,
      delay: 3500
    });
    toast.show();
  });

  // Initialize nested fields for contacts
  setupNestedFields({
    addButtonId: "add-contact",
    containerId: "contacts-container",
    templateSelector: "[data-template='true']",
    removeClassPrefix: "remove-" // will match remove-contact, remove-address, etc.
  });

  initEntitySelect2();
  initNationalitySelect();
});

// Setup dynamic nested fields
function setupNestedFields({ addButtonId, containerId, templateSelector, recordPrefix = "NEW_RECORD", removeClassPrefix }) {
  const addButton = document.getElementById(addButtonId);
  const container = document.getElementById(containerId);
  const template = document.querySelector(templateSelector);

  if (!addButton || !container || !template) {
    //console.warn("Nested field setup skipped: missing elements");
    return;
  }

  // Add new nested form
  addButton.addEventListener("click", () => {
    const time = new Date().getTime();
    const clone = template.cloneNode(true);
    clone.style.display = "block";
    clone.innerHTML = clone.innerHTML.replace(new RegExp(recordPrefix, "g"), time);
    container.appendChild(clone);
    console.log("Nested form added");
  });

  // Remove nested form via delegation
  container.addEventListener("click", (e) => {
    const removeClassMatch = Array.from(e.target.classList).find(cls => cls.startsWith(removeClassPrefix));
    if (removeClassMatch) {
      e.preventDefault();
      const association = removeClassMatch.replace(removeClassPrefix, ""); // e.g. "contact"
      const fieldset = e.target.closest(`[data-nested='${association}']`);
      if (!fieldset) {
        //console.warn(`Remove failed: no fieldset found for ${association}`);
        return;
      }

      const destroyField = fieldset.querySelector("input[name*='_destroy']");
      if (destroyField) {
        destroyField.value = "1";
        fieldset.style.display = "none";
        //console.log(`Nested ${association} marked for removal`);
      } else {
        //console.warn(`Remove failed: _destroy field not found for ${association}`);
      }
    }
  });
}

// Select2 for entity dropdowns
function initEntitySelect2() {
  setTimeout(() => {
    $('.entity-select').each(function () {
      const $select = $(this);

      if ($select.data('select2')) {
        $select.select2('destroy');
      }

      $select.select2({
        theme: 'bootstrap4',
        placeholder: $select.find('option[selected]').text() || 'Buscar...',
        templateResult: formatEntity,
        templateSelection: formatEntity
      }).on('select2:open', function () {
        $('.select2-dropdown').addClass('bg-dark text-white');
        $('.select2-search__field').addClass('bg-dark text-white border-secondary');
      });

      const $container = $select.next('.select2-container');
      $container.find('.select2-selection').addClass('bg-dark text-white');

      if ($select.hasClass('is-invalid')) {
        $container.addClass('is-invalid');
      }
    });
  }, 0);
}

// Format Select2 entity dropdown
function formatEntity(entity) {
  if (!entity.id) return entity.text;
  return $(`<div><strong>${entity.text}</strong></div>`);
}

// Nationality dropdown
function initNationalitySelect() {
  $('.select2').select2({
    theme: 'bootstrap4',
    placeholder: "Selecione a nacionalidade..."
  });
}
