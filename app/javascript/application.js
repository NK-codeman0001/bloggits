// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"
import "trix"
import "@rails/actiontext"

$(document).ready(function(){
  var counter = 0;
  $('.blog-select-check').on('click',function(){
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

  $('#archive-blogs').on('click', function(){
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
  });
});