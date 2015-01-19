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
      questionId = $this.attr('data-question-id')
      localStorage.setItem('current-question-id', questionId)
      localStorage.setItem('current-question-title', $this.attr('data-question-title'))
      location.href = '/formation' + '?qid=' + questionId

  $('.formation.index').ready ->
    $pointBtn = $('.goodBtn')
    $tweetBtn = $('.twBtn')
    width = Math.min($('.container').width(), 400)
    height = 4 / 3 * width
    $('.user-post-image').css({ width: width, height: height });
    $('.user-post-image-question').css({ width: width });
    $('.sns_btn').css({ width: width });
    $('.user-image-opinion').css({ width: width });
    $('.user-image-opinion-btn').css({ width: width });
    $('.arrow_box').css({ width: width });
    $('.other-user-comment').css({ width: width });

    $pointBtn.each ->
      $this = $(this)
      if localStorage.getItem('good-' + $this.attr('data-image-id'))
        $this.addClass('disabled');
      else
        $this.css({opacity:"1.0"})

    $tweetBtn.on click: ->
      $this = $(this)
      id = $this.attr('data-image-id')
      host = location.host + '/user_post_images/' + id
      url = 'http://twitter.com/share?url=http://' + host + '&text=' + encodeURIComponent('#俺ブン')
      location.href = url

    $pointBtn.on click: ->
      $this = $(this)
      if $this.hasClass('disabled')
        return false
      $this.addClass('disabled');
      $this.css({opacity:"0.6"})
      id = $this.attr('data-image-id')
      $point = $this.children('span')
      nextPoint = parseInt($point.text()) + 1
      $point.text(nextPoint)
      localStorage.setItem('good-' + id, true)
      $.ajax '/user_post_images/good',
        type: 'POST'
        dataType: 'json'
        data: { id: id }
        error: (jqXHR, textStatus, errorThrown) ->
        success: (data, textStatus, jqXHR) ->

    $('.formation-each-btn').on click: ->
      $this = $(this)
      formationId = $this.attr('data-formation-id')
      localStorage.setItem('current-formation-type', 'formation-' + $this.attr('data-formation-type'))
      localStorage.setItem('current-formation-id', formationId)
      location.href = '/selection?foId=' + formationId

  $('.selection.index').ready ->
    $createBtn = $('#create-btn')
    $formationChangeBtn = $('#formation-change-btn')
    $comment = $('#post-image-comment')
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

    width = Math.min($('.container').width(), 400)
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
        $position.css("background-image", "url('/images/players/" + pidCache + ".png')")
        $position.attr('data-pid', pidCache);
      playerNameCache = localStorage.getItem('f' + i + '-player-name')
      if playerNameCache
        $('.position-' + i + ' > .selection-inner-player-name').text(playerNameCache)

      $('.position-' + i).on click: ->
        bid = $(this).attr('data-pid')
        fid = $(this).attr('data-fid')
        qid = localStorage.getItem('current-question-id')
        if $comment.val().length > 0
          localStorage.setItem('current-internal-comment', $comment.val())
        location.href = '/selection/select?bid=' + bid + '&fid=' + fid + '&qid=' + qid

    internalComment = localStorage.getItem('current-internal-comment')
    if internalComment
      $comment.text(internalComment)

    queryParams = getQueryString()
    if queryParams
      if queryParams['fid'] > 0
        fid = queryParams['fid']
        pid = queryParams['aid']
        $position = $('.position-' + fid)
        $position.css("background-image", "url('/images/players/" + pid + ".png')")
        $position.attr('data-pid', pid);
        localStorage.setItem('fid' + fid, pid)

    if isValidSelection()
      $createBtn.removeAttr("disabled")
    else
      $createBtn.attr("disabled", "disabled")

    $createBtn.on click: ->
      if $comment.val().length > 0
        localStorage.setItem('current-internal-comment', $comment.val())
      else
        localStorage.removeItem('current-internal-comment')
      location.href = '/selection/show'

    $formationChangeBtn.on click: ->
      location.href = '/formation?qid=' + localStorage.getItem('current-question-id')

  $('.selection.select').ready ->
    for index in [1..11]
      cache = localStorage.getItem('fid' + index)
      if cache
        selector = 'select.select-target option[value=' + cache + ']'
        $(selector).remove()
    fieldId = $('#select-player-after').attr('data-fid')
    localStorage.removeItem('tmp-f' + fieldId + '-player-name')
    $('.select-target').on change: ->
      $selected = $('option:selected', this)
      $after = $('#select-player-after')
      $afterPlayerName = $('#select-player-after > .selection-select-inner-player-name')
      playerId = $(this).val()
      tmpKeyName = 'tmp-f' + fieldId + '-player-name'
      $after.css("background-image", "url('" + $selected.attr('data-image-path') + "')")
      $after.attr('data-pid', playerId);
      if playerId > 0
        $afterPlayerName.text($selected.text())
        localStorage.setItem(tmpKeyName, $selected.text())
      else
        $afterPlayerName.text('')
        localStorage.removeItem(tmpKeyName)

    $('#select-done-btn').on click: ->
      $after = $('#select-player-after')
      playerId = $after.attr('data-pid')
      keyName = 'f' + fieldId + '-player-name'
      tmpKeyName = 'tmp-f' + fieldId + '-player-name'
      if playerId > 0
        localStorage.setItem(keyName, localStorage.getItem(tmpKeyName))
      else
        localStorage.removeItem(keyName)
        localStorage.removeItem(tmpKeyName)
      location.href = '/selection?aid=' + playerId + '&fid=' + fieldId


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

    internalComment = localStorage.getItem('current-internal-comment')
    url = 'http://' + location.host + '/'
    if internalComment
      $imageComment.text(internalComment + ' #' + questionTitle + 'ベストイレブン #俺ブン ' + url)
    else
      $imageComment.text(' #' + questionTitle + 'ベストイレブン #俺ブン ' + url)

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
      data: { players: players, foId: formationId, qid: qid, comment: internalComment }
      error: (jqXHR, textStatus, errorThrown) ->
        $('#spinner-container').hide()
        $('#result-error-comment').show()
      success: (data, textStatus, jqXHR) ->
        $('#spinner-container').hide()
        width = Math.min($('.container').width(), 400)
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
    $pointBtn = $('.goodBtn')
    $tweetBtn = $('.twBtn')

    width = Math.min($('.container').width(), 400)
    height = 4 / 3 * width
    $('.user-post-image').css({ width: width, height: height });
    $('.user-post-image-question').css({ width: width });
    $('.sns_btn').css({ width: width });
    $('.user-image-opinion').css({ width: width });
    $('.user-image-opinion-btn').css({ width: width });
    $('.arrow_box').css({ width: width });
    $('.other-user-comment').css({ width: width });

    $pointBtn.each ->
      $this = $(this)
      if localStorage.getItem('good-' + $this.attr('data-image-id'))
        $this.addClass('disabled');
      else
        $this.css({opacity:"1.0"})

    $tweetBtn.on click: ->
      $this = $(this)
      id = $this.attr('data-image-id')
      host = location.host + '/user_post_images/' + id
      url = 'http://twitter.com/share?url=http://' + host + '&text=' + encodeURIComponent('#俺ブン')
      location.href = url

    $pointBtn.on click: ->
      $this = $(this)
      if $this.hasClass('disabled')
        return false
      $this.addClass('disabled');
      $this.css({opacity:"0.6"})
      id = $this.attr('data-image-id')
      $point = $this.children('span')
      nextPoint = parseInt($point.text()) + 1
      $point.text(nextPoint)
      localStorage.setItem('good-' + id, true)
      $.ajax '/user_post_images/good',
        type: 'POST'
        dataType: 'json'
        data: { id: id }
        error: (jqXHR, textStatus, errorThrown) ->
        success: (data, textStatus, jqXHR) ->
 
  $('.user_post_images.index_order_by_point').ready ->
    $pointBtn = $('.goodBtn')
    $tweetBtn = $('.twBtn')

    width = Math.min($('.container').width(), 400)
    height = 4 / 3 * width
    $('.user-post-image').css({ width: width, height: height });
    $('.user-post-image-question').css({ width: width });
    $('.sns_btn').css({ width: width });
    $('.user-image-opinion').css({ width: width });
    $('.user-image-opinion-btn').css({ width: width });
    $('.arrow_box').css({ width: width });
    $('.other-user-comment').css({ width: width });

    $pointBtn.each ->
      $this = $(this)
      if localStorage.getItem('good-' + $this.attr('data-image-id'))
        $this.addClass('disabled');
      else
        $this.css({opacity:"1.0"})

    $tweetBtn.on click: ->
      $this = $(this)
      id = $this.attr('data-image-id')
      host = location.host + '/user_post_images/' + id
      url = 'http://twitter.com/share?url=http://' + host + '&text=' + encodeURIComponent('#俺ブン')
      location.href = url

    $pointBtn.on click: ->
      $this = $(this)
      if $this.hasClass('disabled')
        return false
      $this.addClass('disabled');
      $this.css({opacity:"0.6"})
      id = $this.attr('data-image-id')
      $point = $this.children('span')
      nextPoint = parseInt($point.text()) + 1
      $point.text(nextPoint)
      localStorage.setItem('good-' + id, true)
      $.ajax '/user_post_images/good',
        type: 'POST'
        dataType: 'json'
        data: { id: id }
        error: (jqXHR, textStatus, errorThrown) ->
        success: (data, textStatus, jqXHR) ->

  $('.user_post_images.index_order_by_comment').ready ->
    $pointBtn = $('.goodBtn')
    $tweetBtn = $('.twBtn')

    width = Math.min($('.container').width(), 400)
    height = 4 / 3 * width
    $('.user-post-image').css({ width: width, height: height });
    $('.user-post-image-question').css({ width: width });
    $('.sns_btn').css({ width: width });
    $('.user-image-opinion').css({ width: width });
    $('.user-image-opinion-btn').css({ width: width });
    $('.arrow_box').css({ width: width });
    $('.other-user-comment').css({ width: width });

    $pointBtn.each ->
      $this = $(this)
      if localStorage.getItem('good-' + $this.attr('data-image-id'))
        $this.addClass('disabled');
      else
        $this.css({opacity:"1.0"})

    $tweetBtn.on click: ->
      $this = $(this)
      id = $this.attr('data-image-id')
      host = location.host + '/user_post_images/' + id
      url = 'http://twitter.com/share?url=http://' + host + '&text=' + encodeURIComponent('#俺ブン')
      location.href = url

    $pointBtn.on click: ->
      $this = $(this)
      if $this.hasClass('disabled')
        return false
      $this.addClass('disabled');
      $this.css({opacity:"0.6"})
      id = $this.attr('data-image-id')
      $point = $this.children('span')
      nextPoint = parseInt($point.text()) + 1
      $point.text(nextPoint)
      localStorage.setItem('good-' + id, true)
      $.ajax '/user_post_images/good',
        type: 'POST'
        dataType: 'json'
        data: { id: id }
        error: (jqXHR, textStatus, errorThrown) ->
        success: (data, textStatus, jqXHR) ->

  $('.user_post_images.show').ready ->
    $pointBtn = $('.goodBtn')
    $tweetBtn = $('.twBtn')

    width = Math.min($('.container').width(), 400)
    height = 4 / 3 * width
    $('.user-post-image').css({ width: width, height: height });
    $('.user-post-image-question').css({ width: width });
    $('.sns_btn').css({ width: width });
    $('.user-image-opinion').css({ width: width });
    $('.user-image-opinion-btn').css({ width: width });
    $('.arrow_box').css({ width: width });
    $('.other-user-comment').css({ width: width });

    $pointBtn.each ->
      $this = $(this)
      if localStorage.getItem('good-' + $this.attr('data-image-id'))
        $this.addClass('disabled');
      else
        $this.css({opacity:"1.0"})

    $tweetBtn.on click: ->
      $this = $(this)
      id = $this.attr('data-image-id')
      host = location.host + '/user_post_images/' + id
      url = 'http://twitter.com/share?url=http://' + host + '&text=' + encodeURIComponent('#俺ブン')
      location.href = url

    $pointBtn.on click: ->
      $this = $(this)
      if $this.hasClass('disabled')
        return false
      $this.addClass('disabled');
      $this.css({opacity:"0.6"})
      id = $this.attr('data-image-id')
      $point = $this.children('span')
      nextPoint = parseInt($point.text()) + 1
      $point.text(nextPoint)
      localStorage.setItem('good-' + id, true)
      $.ajax '/user_post_images/good',
        type: 'POST'
        dataType: 'json'
        data: { id: id }
        error: (jqXHR, textStatus, errorThrown) ->
        success: (data, textStatus, jqXHR) ->

#    _.each {one : 1, two : 2, three : 3}, (num, key) -> console.log num
#  $('#selection-done').on click: ->
#    $(':checkbox').each (index, element) =>
#      if $(element).is(':checked')
#        console.log $(element).val()
