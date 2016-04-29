viewer = {
  upvote: function(button, count, number){
    $(button).css("color", "red");
    $(count).text(number);
    },
  delete: function(number){
    var target = "article#" + number;
    $(target).hide();
    },
  append: function(post){
    $('.post-container').append(post);
    $('form#posts').get(0).reset();
    },
  showSorted: function(data){
    $('.post-container').empty();
    $.each(data, function(index){
    $('.post-container').append(data[index].title + " " + data[index].timestamp + " hours ago<br>");
      });
    },
};

server = {
  hit:  function(verb, route, data, next){
  $.ajax({
    method  : verb,
    url     : route,
    data    : data,
    success : next,
  });
  }
}


$(document).ready(function() {
  // This is called after the document has loaded in its entirety
  // This guarantees that any elements we bind to will exist on the page
  // when we try to bind to them
$('button.song_search').on("click", function(event){
  event.preventDefault();



});




  // See: http://docs.jquery.com/Tutorials:Introducing_$(document).ready()
});



