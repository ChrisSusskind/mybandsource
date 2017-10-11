###
App.notification_center = App.cable.subscriptions.create "NotificationCenterChannel",
  connected: ->
    # Called when the subscription is ready for use on the server

  disconnected: ->
    # Called when the subscription has been terminated by the server

  received: (data) ->
    # Called when there's incoming data on the websocket for this channel
    picture_url = "http://res.cloudinary.com/mybandsource/image/upload/" + data["picture_url"]
    if(picture_url == "http://res.cloudinary.com/mybandsource/image/upload/")
      picture_url = "http://res.cloudinary.com/mybandsource/image/upload/v1490846366/static/blank_user.png"

    user_url = "/users/#{data['sender_id']}"

    $unviewed = $('#unviewed_notification_number')
    unviewed_number = parseInt($unviewed.html(), 10)
    unviewed_number += 1
    $unviewed.html(unviewed_number)

    switch
      when data["type"] == "follow" then @appendFollowNotification(data, picture_url, user_url)
      when data["type"] == "review" then @appendReviewNotification(data, picture_url, user_url)
      when data["type"] == "response" then @appendResponseNotification(data, picture_url, user_url)
      else null

  appendFollowNotification: (data, picture_url, user_url) ->
    html = @generateFollowNotificationHTML(data, picture_url, user_url)
    $('#notification-dropdown-menu').prepend(html)

  appendReviewNotification: (data, picture_url, user_url) ->
    html = @generateReviewNotificationHTML(data, picture_url, user_url)
    $('#notification-dropdown-menu').prepend(html)

  appendResponseNotification: (data, picture_url, user_url) ->
    html = @generateResponseNotificationHTML(data, picture_url, user_url)
    $('#notification-dropdown-menu').prepend(html)

  generateFollowNotificationHTML: (data, picture_url, user_url) ->
    html =
      '<li>' +
        '<div class="media notification-container">' +
          '<div class="media-left">' +
            '<div class="media-object">' +
              '<img src=' + picture_url + ' alt="Avatar" height="30" width="30" class="notification-pic rounded-circle img-circle" />' +
            '</div>' +
          '</div>' +
          '<div class="media-body notification-text-container">' +
            '<p class="notification-text">' +
              '<a href=' + user_url + '>' + data["sender_name"] + '</a> followed your profile' +
            '</p>' +
            '<abbr class="timeago">' +
              data["timestamp"] +
            '</abbr>' +
          '</div>' +
        '</div>' +
      '</li>'

  generateReviewNotificationHTML: (data, picture_url, user_url) ->
    html =
      '<li>' +
        '<div class="media notification-container">' +
          '<div class="media-left">' +
            '<div class="media-object">' +
              '<img src=' + picture_url + ' alt="Avatar" height="30" width="30" class="notification-pic rounded-circle img-circle" />' +
            '</div>' +
          '</div>' +
          '<div class="media-body notification-text-container">' +
            '<p class="notification-text">' +
              '<a href=' + user_url + '>' + data["sender_name"] + '</a> reviewed your profile' +
            '</p>' +
            '<abbr class="timeago">' +
              data["timestamp"] +
            '</abbr>' +
          '</div>' +
        '</div>' +
      '</li>'

  generateResponseNotificationHTML: (data, picture_url, user_url) ->
    html =
      '<li>' +
        '<div class="media notification-container">' +
          '<div class="media-left">' +
            '<div class="media-object">' +
              '<img src=' + picture_url + ' alt="Avatar" height="30" width="30" class="notification-pic rounded-circle img-circle" />' +
            '</div>' +
          '</div>' +
          '<div class="media-body notification-text-container">' +
            '<p class="notification-text">' +
              '<a href=' + user_url + '>' + data["sender_name"] + '</a> responded to your comment' +
            '</p>' +
            '<abbr class="timeago">' +
              data["timestamp"] +
            '</abbr>' +
          '</div>' +
        '</div>' +
      '</li>'
  
Use a single # sign

###       