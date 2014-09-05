$ ->
  getQueryString = ->
    if window.location.search.length > 1
      query = window.location.search.substring(1)
      params = query.split('&');
      res = {}
      for param in params
        element = param.split('=')
        key = decodeURIComponent(element[0])
        value = decodeURIComponent(element[1])
        res[key] = value
      return res
    else
      return 0

  $('.selection.index').ready ->
    width = screen.width * 0.9;
    height = 4 / 3 * width;
    $('#formation-base').css({ width: width, height: height });
    $('#formation-base').addClass('formation-base-image');
    $('#formation-base').addClass('formation-4-4-2');
    for i in [1..11]
      size = width * 0.2;
      halfSize = size / 2;
      $position = $('.position-' + i)
      $position.css({'margin-left': - halfSize,  width: size, height: size});
      $position.addClass('formation-player-base-image');
      cache = localStorage.getItem('fid' + i);
#      if cache
#        $position.css("background-image", "url('" + players
#      playerImage.css("background-image", "url('/images/" + item.group + '/' + item.id + ".png')");
      $('.position-' + i).on click: ->
        bid = $(this).attr('data-pid')
        fid = $(this).attr('data-fid')
        location.href = '/selection/select?bid=' + bid + '&fid=' + fid
    console.log getQueryString()

  $('.selection.select').ready ->
    $('#select-target').on change: ->
      $('#select-player-after').css("background-image", "url('" + $('#select-target option:selected').attr('data-image-path') + "')")
      $('#select-player-after').attr('data-pid', $(this).val());
 
    $('#select-done-btn').on click: ->
      $after = $('#select-player-after')
      location.href = '/selection?aid=' + $after.attr('data-pid') + '&fid=' + $after.attr('data-fid')

#  $('#selection-done').on click: ->
#    $(':checkbox').each (index, element) =>
#      if $(element).is(':checked')
#        console.log $(element).val()
