$(function() {
  $("a.click-able").on("mouseover", function() {
    return $(this).addClass("click-able-effect");
  });
  return $("a.click-able").on("mouseout", function() {
    return $(this).removeClass("click-able-effect");
  });
});
