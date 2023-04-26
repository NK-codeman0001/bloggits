// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"
import "trix"
import "@rails/actiontext"
//= require jquery
//= require jquery.turbolinks
//= require_tree .



 var ready;
 ready = function() {
      var counter = 0;
      $('.blog-select-check').on('click',function(){
        if($(this).prop('checked')){
          counter +=1;
        }
        else {
          counter -=1;
        }
      });
    
      $('#select-all-blog').on('click', function(){
        $('.blog-select-check').prop('checked', $(this). prop('checked'));
      });
    
      $('#archive-blogs').on('click', function(){
        if(counter <=0){
            alert("Please select atleast one blog");
            }
            else {
        var blogIds = [];
        $('.blog-select-check').each(function(){
          if($(this).prop('checked')){
            blogIds.push($(this).data('blog-id'))
          }
        
        });
    
        $.ajax({
          url: 'blogs/bulk_archive_blogs',
          type: 'PATCH',
          data: {blog_ids: blogIds}
        });
      }
      });
      $("#search_field" ).on( "keyup", function() {
        var searchKey = $("#search_field").val();
        
    
        $.ajax({
          url: 'blogs/search',
          type: 'GET',
          data: {search: searchKey}
        });
      });
    };

  $(document).ready(ready);
  $(document).on('turbolinks:load', ready);    

// // $(document).ready(function(){
// $(document).on('turbolinks:load', function() {
// // document.addEventListener("turbolinks:load", function() {

//   var counter = 0;
//   $('.blog-select-check').on('click',function(){
//     if($(this).prop('checked')){
//       counter +=1;
//     }
//     else {
//       counter -=1;
//     }
//   });

//   $('#select-all-blog').on('click', function(){
//     $('.blog-select-check').prop('checked', $(this). prop('checked'));
//   });

//   $('#archive-blogs').on('click', function(){
//     if(counter <=0){
//         alert("Please select atleast one blog");
//         }
//         else {
//     var blogIds = [];
//     $('.blog-select-check').each(function(){
//       if($(this).prop('checked')){
//         blogIds.push($(this).data('blog-id'))
//       }
    
//     });

//     $.ajax({
//       url: 'blogs/bulk_archive_blogs',
//       type: 'PATCH',
//       data: {blog_ids: blogIds}
//     });
//   }
//   });
//   $("#search_field" ).on( "keyup", function() {
//     var searchKey = $("#search_field").val();
    

//     $.ajax({
//       url: 'blogs/search',
//       type: 'GET',
//       data: {search: searchKey}
//     });
//   });
// });