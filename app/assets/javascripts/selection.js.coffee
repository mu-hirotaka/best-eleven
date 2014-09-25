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

  $('.question.index').ready ->
    localStorage.clear()
    $('.question-each-btn').on click: ->
      $this = $(this)
      localStorage.setItem('current-question-id', $this.attr('data-question-id'))
      localStorage.setItem('current-question-title', $this.attr('data-question-title'))
      location.href = '/formation'

  $('.formation.index').ready ->
    $('.formation-each-btn').on click: ->
      $this = $(this)
      formationId = $this.attr('data-formation-id')
      localStorage.setItem('current-formation-type', 'formation-' + $this.attr('data-formation-type'))
      localStorage.setItem('current-formation-id', formationId)
      location.href = '/selection?foId=' + formationId

  $('.selection.index').ready ->
    $createBtn = $('#create-btn')
    isValidSelection = ->
      count = 0
      for i in [1..11]
        pid = $('.position-' + i).attr('data-pid')
        if pid > 0
          count++
      if count == 11
        return true
      else
        return false

#    width = screen.width * 0.9
#    width = document.documentElement.clientWidth * 0.9
#    width = $('html').prop('clientWidth') * 0.9
    width = $('.container').width()
    height = 4 / 3 * width

    $('#formation-base').css({ width: width, height: height });
    $('#formation-base').addClass('formation-base-image');
    $('#formation-base').addClass(localStorage.getItem('current-formation-type'));
    for i in [1..11]
      size = width * 0.2;
      halfSize = size / 2;
      $position = $('.position-' + i)
      $position.css({'margin-left': - halfSize,  width: size, height: size})
      $position.addClass('formation-player-base-image')
      pidCache = localStorage.getItem('fid' + i)
      if pidCache
        $position = $('.position-' + i)
        $position.css("background-image", "url('/images/players/" + pidCache + ".jpg')")
        $position.attr('data-pid', pidCache);
      $('.position-' + i).on click: ->
        bid = $(this).attr('data-pid')
        fid = $(this).attr('data-fid')
        qid = localStorage.getItem('current-question-id')
        location.href = '/selection/select?bid=' + bid + '&fid=' + fid + '&qid=' + qid

    queryParams = getQueryString()
    if queryParams
      if queryParams['fid'] > 0
        fid = queryParams['fid']
        pid = queryParams['aid']
        $position = $('.position-' + fid)
        $position.css("background-image", "url('/images/players/" + pid + ".jpg')")
        $position.attr('data-pid', pid);
        localStorage.setItem('fid' + fid, pid)

    if isValidSelection()
      $createBtn.removeAttr("disabled")
    else
      $createBtn.attr("disabled", "disabled")

    $createBtn.on click: ->
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
    $('.select-target').on change: ->
      $('#select-player-after').css("background-image", "url('" + $('option:selected', this).attr('data-image-path') + "')")
      $('#select-player-after').attr('data-pid', $(this).val());
 
    $('#select-done-btn').on click: ->
      $after = $('#select-player-after')
      location.href = '/selection?aid=' + $after.attr('data-pid') + '&fid=' + $after.attr('data-fid')


  $('.selection.show').ready ->
    $tweetBtn = $('#twitter-tweet-btn')
    $imageComment = $('#user-image-comment')
    $commentLength = $('#user-image-comment-length')
    setCommentLength = (init) ->
      length = $imageComment.val().length
      if length > 140
        $commentLength.text(length + '文字(文字数を減らしてください)')
        $commentLength.css({"color":"red"})
        $tweetBtn.css({opacity:"0.3"})
        $tweetBtn.attr("disabled", "disabled")
      else
        $commentLength.text(length + '文字')
        $commentLength.css({"color":"black"})
        if !init
          $tweetBtn.css({opacity:"1.0"})
          $tweetBtn.removeAttr("disabled")

    qid = localStorage.getItem('current-question-id')
    questionTitle = localStorage.getItem('current-question-title')
    if questionTitle
      $title = $('.common-title > p')
      $title.text(questionTitle + 'ベストイレブン')
    $imageComment.text('お題「' + questionTitle + 'ベストイレブン」 #なんでもベストイレブン')

    setCommentLength('init')
    players = []
    for fieldId in [1..11]
      cache = localStorage.getItem('fid' + fieldId)
      if cache
        players.push(cache)
      else
        players.push(0)
    formationId = localStorage.getItem('current-formation-id')
    if !formationId
      formationId = 1
    $imageComment.keyup (e) ->
      setCommentLength()

    $tweetBtn.on click: ->
      localStorage.setItem('current-comment', $imageComment.val())
      location.href = '/twitter'

    $.ajax '/image/create',
      type: 'POST'
      dataType: 'json'
      data: { players: players, foId: formationId, qid: qid }
      error: (jqXHR, textStatus, errorThrown) ->
        $('#spinner-container').hide()
        $('#result-error-comment').show()
      success: (data, textStatus, jqXHR) ->
        $('#spinner-container').hide()
        width = $('.container').width()
        height = 4 / 3 * width;
        img = $('<img>').attr({ src: data.path, width: width, height: height})
        $('#result-image').append(img)
        localStorage.setItem('current-image-url', data.path)
        if $imageComment.val().length <= 140
          $tweetBtn.css({opacity:"1.0"})
          $tweetBtn.removeAttr("disabled")

  $('.twitter.index').ready ->
    url = localStorage.getItem('current-image-url')
    comment = localStorage.getItem('current-comment')
    $.ajax '/twitter/tweet',
      type: 'POST'
      dataType: 'json'
      data: { url: url, comment: comment }
      error: (jqXHR, textStatus, errorThrown) ->
        $('.common-title > p').text('投稿エラー')
        $('#spinner-container').hide()
        $('#result-error-comment').show()
      success: (data, textStatus, jqXHR) ->
        $('.common-title > p').text('投稿完了')
        $('#spinner-container').hide()
        $('#result-comment').show()

  $('.user_post_images.index').ready ->
    width = $('.container').width()
    height = 4 / 3 * width
    $('.user-post-image').css({ width: width, height: height });

#    _.each {one : 1, two : 2, three : 3}, (num, key) -> console.log num
#  $('#selection-done').on click: ->
#    $(':checkbox').each (index, element) =>
#      if $(element).is(':checked')
#        console.log $(element).val()
