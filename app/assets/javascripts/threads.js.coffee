$("#thread").ready ->
  minimize = (element) ->
    quoted = $(element.prev())
    id = Math.random().toString(36).substring(7)
    element.attr("id", id)
    if quoted.text().indexOf(" wrote:") > 0
      element.addClass("hidden")
      quoted.data("for", id)
      quoted.addClass("quoted")
      $("<i class='glyphicon glyphicon-chevron-up arrow'></i>").appendTo(quoted)
  $(".message").waypoint
    handler: (direction) ->
      history.pushState(null, null, $(this).children(".number").first().attr("href") || "#" + $(this).attr("id"))
  $("body").keyup (evt) ->
    number = parseInt(location.hash.split("reply-")[1])
    @id = "root" if number == NaN

    # Pressed "j", let's go up
    if evt.keyCode == 74

      # If we're already at the topmost reply
      if number < 2
        @id = "root"
      else
        @id = "reply-#{number - 1}"
      location.hash = @id

    # Pressed "k", let's go down
    else if evt.keyCode == 75
      element = $("#reply-#{number - 1}")
      if element = element.length
        location.hash = element.attr("id")

  $("blockquote").each (index, element) ->
    minimize($(element))
  $(".quoted").on "click", ->
    id = $(this).data("for")
    blockquote = $("##{id}")
    isCollapsing = blockquote.hasClass('hidden')
    blockquote.toggleClass("hidden")
    $(this).toggleClass("active")

    $(this).children(".arrow").remove()
    if isCollapsing
      $("<i class='glyphicon glyphicon-chevron-down arrow'></i>").appendTo($(this))
    else
      $("<i class='glyphicon glyphicon-chevron-up arrow'></i>").appendTo($(this))
