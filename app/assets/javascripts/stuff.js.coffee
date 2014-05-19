# Tooltip
$(document).ready ->
  $('.cerb-tip').tooltip()

# Player Index Search
$(document).ready ->
  $('form').on 'click', '.remove_fields', (event) ->
    $(this).closest('.field').remove()
    event.preventDefault()

  $('form').on 'click', '.add_fields', (event) ->
    time = new Date().getTime()
    regexp = new RegExp($(this).data('id'), 'g')
    $(this).before($(this).data('fields').replace(regexp, time))
    event.preventDefault()


# Select2 on Player Index
$(document).ready ->
  $("#pi-attribute").select2({
    placeholder: 'Select an Attribute'
    width: '150px'
  });
  $("#pi-predicate").select2({
    width: '150px'
  });

