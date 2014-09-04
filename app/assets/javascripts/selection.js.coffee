$ ->
  $('.selection.index').ready ->
    width = screen.width * 0.9;
    height = 4 / 3 * width;
    $('#formation-base').css({ width: width, height: height });
    $('#formation-base').addClass('formation-base-image');
    $('#formation-base').addClass('formation-4-4-2');
    for i in [1..11]
      size = width * 0.2;
      halfSize = size / 2;
      $('.position-' + i).css({'margin-left': - halfSize,  width: size, height: size});
      $('.position-' + i).addClass('formation-player-base-image');

#  $('#selection-done').on click: ->
#    $(':checkbox').each (index, element) =>
#      if $(element).is(':checked')
#        console.log $(element).val()
