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
      $position.css({'margin-left': - halfSize,  width: size, height: size})
      $position.addClass('formation-player-base-image')
      pidCache = localStorage.getItem('fid' + i)
      if pidCache
        $playerMaster = $('#player-master-' + pidCache)
        $position = $('.position-' + i)
        $position.css("background-image", "url('" + $playerMaster.attr('data-image-path') + "')")
        $position.attr('data-pid', pidCache);
      $('.position-' + i).on click: ->
        bid = $(this).attr('data-pid')
        fid = $(this).attr('data-fid')
        location.href = '/selection/select?bid=' + bid + '&fid=' + fid

    queryParams = getQueryString()
    if queryParams
      fid = queryParams['fid']
      pid = queryParams['aid']
      $playerMaster = $('#player-master-' + pid)
      $position = $('.position-' + fid)
      $position.css("background-image", "url('" + $playerMaster.attr('data-image-path') + "')")
      $position.attr('data-pid', pid);
      localStorage.setItem('fid' + fid, pid)

    $('#create-btn').on click: ->
      form = $('#create-form')
      for i in [1..11]
        $position = $('.position-' + i)
        bid = $position.attr('data-pid')
        $elm = $('<input>');
        $elm.attr('name', 'players[]')
        $elm.attr('type', 'hidden')
        $elm.attr('value', bid)
        form.append($elm)
      form.submit()

  $('.selection.select').ready ->
    $('#select-target').on change: ->
      $('#select-player-after').css("background-image", "url('" + $('#select-target option:selected').attr('data-image-path') + "')")
      $('#select-player-after').attr('data-pid', $(this).val());
 
    $('#select-done-btn').on click: ->
      $after = $('#select-player-after')
      location.href = '/selection?aid=' + $after.attr('data-pid') + '&fid=' + $after.attr('data-fid')


  $('.selection.show').ready ->
    players = []
    for fieldId in [1..11]
      cache = localStorage.getItem('fid' + fieldId)
      if cache
        players.push(cache)
      else
        players.push(0)
    $.ajax '/image/create',
      type: 'POST'
      dataType: 'json'
      data: { players: players }
      error: (jqXHR, textStatus, errorThrown) ->
        console.log 'error'
      success: (data, textStatus, jqXHR) ->
        $('#spinner-container').hide()
        width = screen.width * 0.9;
        height = 4 / 3 * width;
        img = $('<img>').attr({ src: data.path, width: width, height: height})
        $('#result-image').append(img)
        $('#twitter-tweet-btn').css({opacity:"1.0"})

#    _.each {one : 1, two : 2, three : 3}, (num, key) -> console.log num
#  $('#selection-done').on click: ->
#    $(':checkbox').each (index, element) =>
#      if $(element).is(':checked')
#        console.log $(element).val()
