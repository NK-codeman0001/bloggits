// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"
import "trix"
import "@rails/actiontext"

$(document).ready(function(){
  var counter = 0;
  $('.book-select-check').on('click',function(){
    if($(this).prop('checked')){
      counter +=1;
      //$('#archive-blogs').css('display','block');
      $('#archive-blogs').show();
    }
    else {
      counter -=1;
      if(counter <=0){
    //$('#archive-blogs').css('display','none');
      $('#archive-blogs').hide();
      }
    }
  });
});