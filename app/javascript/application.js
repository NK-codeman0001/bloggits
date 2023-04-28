// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails";
import "controllers";
import "trix";
import "@rails/actiontext";
function setupCheckboxes() {
  var counter = 0;
  $(".blog-select-check").on("click", function () {
    if ($(this).prop("checked")) {
      counter += 1;
    } else {
      counter -= 1;
      $("#select-all-blogs").prop("checked", false);
    }
  });

  $("#select-all-blogs").on("click", function () {
    if ($(this).prop("checked")) {
      $(".blog-select-check").each(function () {
        $(this).prop("checked", true);
        counter += 1;
      });
    } else {
      $(".blog-select-check").each(function () {
        $(this).prop("checked", false);
        counter -= 1;
      });
    }
  });

  $("#archive-blogs").on("click", function () {
    if (counter <= 0) {
      alert("Please select atleast one blog");
    } else {
      var blogIds = [];
      $(".blog-select-check").each(function () {
        if ($(this).prop("checked")) {
          blogIds.push($(this).data("blog-id"));
        }
      });
      counter = 0;

      $.ajax({
        url: "blogs/bulk_archive_blogs",
        type: "PATCH",
        data: { blog_ids: blogIds },
      });
    }
  });
}


var ready;
ready = function () {
  setupCheckboxes();

  $("#search_field").on("keyup", function () {
    var searchKey = $("#search_field").val();

    $.ajax({
      url: "blogs/search",
      type: "GET",
      data: { search: searchKey },
      success: function() {
        setupCheckboxes();
      }
    });
  });
};

// $(document).ready(ready);
$(document).on("turbo:load", ready);

