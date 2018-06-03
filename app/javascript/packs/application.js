/* eslint no-console: 0 */
import "jquery"
import "jquery-ujs"
import "bootstrap"
import jQueryBridget from 'jquery-bridget'

import setupLayout from 'src/layout'

// STYLES
import '../stylesheets/application'

import Routes from 'javascripts/utils/routes'
window.RailsRouter = new Routes()

document.addEventListener('DOMContentLoaded', () => {

  setupLayout()

  // Configure tooltips for collapsed side navigation
  $('.navbar-sidenav [data-toggle="tooltip"]').tooltip({
    template: '<div class="tooltip navbar-sidenav-tooltip" role="tooltip" style="pointer-events: none"><div class="arrow"></div><div class="tooltip-inner"></div></div>'
  })

  // Prevent the content wrapper from scrolling when the fixed side navigation hovered over
  $('body.fixed-nav .navbar-sidenav, body.fixed-nav .sidenav-toggler, body.fixed-nav .navbar-collapse').on('mousewheel DOMMouseScroll', function(e) {
    var e0 = e.originalEvent,
      delta = e0.wheelDelta || -e0.detail
    this.scrollTop += (delta < 0 ? 1 : -1) * 30
    e.preventDefault()
  })

  // Configure tooltips globally
  $('[data-toggle="tooltip"]').tooltip()

  $('.alert').each(function(_i, elem) {
    window.setTimeout(function() {
      $(elem).fadeOut("slow")
    }, 3000)
  })

  $('.toggle-link-form-button').click(function(e) {
    e.preventDefault()
    $(e.target).parents('.link-container').find('.link-form').toggleClass('toggled')
  })


  // Refresh trigger
  $('.refresh-user-monitor-button').click(function(e) {
    e.preventDefault()

    const monitorId = $(e.currentTarget).data('monitor-id')
    const refreshEndpoint = window.RailsRouter.get('api_refresh_app_monitor_index')

    $.ajax({
      url: refreshEndpoint,
      beforeSend: function( xhr ) {
        xhr.overrideMimeType( "text/plain; charset=x-user-defined" );
      },
      type: 'POST',
      data: {
        monitor_id: monitorId,
      }
    })
      .done(function( data ) {
        $('.alert.alert-success').html('Success!')
        $('.alert.alert-success').fadeIn("slow")
        window.setTimeout(function() {
          $('.alert.alert-success').fadeOut("slow")
        }, 2000)
      });
  })

  // Clear all notifications
  $('.clear-notifications-button').click(function(e) {
    e.preventDefault()
    const userId = $(e.currentTarget).data('monitor-id')
    const clearNotificationEndpoint = window.RailsRouter.get('api_clear_notifications')

    $.ajax({
      url: clearNotificationEndpoint,
      beforeSend: function( xhr ) {
        xhr.overrideMimeType( "text/plain; charset=x-user-defined" );
      },
      type: 'POST',
      data: {
        user_id: userId,
      }
    })
      .done(function( data ) {
        location.reload()
      })
  })
})

