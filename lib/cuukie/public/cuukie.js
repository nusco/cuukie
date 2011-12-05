FEATURE_ELEMENTS = "h3[id^='fe_']";

$(document).ready(function() {
  $(FEATURE_ELEMENTS).css('cursor', 'pointer');
  $(FEATURE_ELEMENTS).click(function() {
    $(this).siblings().toggle(250);
  });

  $("#collapser").css('cursor', 'pointer');
  $("#collapser").click(function() {
    $(FEATURE_ELEMENTS).siblings().hide();
  });

  $("#expander").css('cursor', 'pointer');
  $("#expander").click(function() {
    $(FEATURE_ELEMENTS).siblings().show();
  });
})

function moveProgressBar(percentDone) {
  $("cucumber-header").css('width', percentDone +"%");
}
function failedColors(element_id) {
  $('#'+element_id).css('background', '#C40D0D');
  $('#'+element_id).css('color', '#FFFFFF');
}
function pendingColors(element_id) {
  $('#'+element_id).css('background', '#FAF834');
  $('#'+element_id).css('color', '#000000');
}
function passedColors(element_id) {
  $('#'+element_id).css('background', '#65c400');
  $('#'+element_id).css('color', '#000000');
}
