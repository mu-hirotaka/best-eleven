$ ->
  $('#selection-done').on click: ->
    $(':checkbox').each (index, element) =>
      if $(element).is(':checked')
        console.log $(element).val()
