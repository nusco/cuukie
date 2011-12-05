SCENARIOS = "h3[id^='fe_']";

$(document).ready(function() {
  $(SCENARIOS).css('cursor', 'pointer');
  $(SCENARIOS).click(function() {
    $(this).siblings().toggle(250);
  });

  $("#collapser").css('cursor', 'pointer');
  $("#collapser").click(function() {
    $(SCENARIOS).siblings().hide();
  });

  $("#expander").css('cursor', 'pointer');
  $("#expander").click(function() {
    $(SCENARIOS).siblings().show();
  });
})

function moveProgressBar(percentDone) {
  $("cucumber-header").css('width', percentDone +"%");
}

function passedColors(element_id) {
  $('#'+element_id).css('background', '#65c400');
  $('#'+element_id).css('color', '#000000');
}
function failedColors(element_id) {
  $('#'+element_id).css('background', '#C40D0D');
  $('#'+element_id).css('color', '#FFFFFF');
}
function pendingColors(element_id) {
  $('#'+element_id).css('background', '#FAF834');
  $('#'+element_id).css('color', '#000000');
}
function skippedColors(element_id) {
  $('#'+element_id).css('background', '#E0FFFF');
  $('#'+element_id).css('color', '#000000');
}
