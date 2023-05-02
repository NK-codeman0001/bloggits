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

function toggleMenu(){
  const menuButton = document.getElementById('menu-button');
  const navbar = document.getElementById('navbar-sticky');
  menuButton.addEventListener('click', function() {
  navbar.classList.toggle('hidden');
  });
}

function hideNotice(){
  $('#notice').fadeOut(5000); // 5 seconds x 1000 milisec = 5000 milisec

}

function hideAlert(){
  $('#alert').fadeOut(8000); // 5 seconds x 1000 milisec = 5000 milisec
}
var ready;
ready = function () {
  // hideAlert();
  hideNotice();
  toggleMenu();
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
    // // toggle navigation on small screens
    // $("#menu-button").on("click", function () {
    //   $("nav ul").toggleClass("hidden");
    // });
  
    // // hide navigation when clicking outside of it
    // $(document).on("click", function (event) {
    //   if (!$(event.target).closest("nav").length) {
    //     $("nav ul").addClass("hidden");
    //   }
    // });
  
    // // hide navigation on resize if it's visible on small screens
    // $(window).on("resize", function () {
    //   if ($(window).width() > 768) {
    //     $("nav ul").removeClass("hidden");
    //   } else {
    //     $("nav ul").addClass("hidden");
    //   }
    // });
  
};

// $(document).ready(ready);
$(document).on("turbo:load", ready);

