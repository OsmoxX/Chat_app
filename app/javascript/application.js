import "@hotwired/turbo-rails"
import "controllers"
import "channels"


window.scroll_bottom = function () {
    if ($('#messages').length > 0) {
        $('#messages').scrollTop($('#messages')[0].scrollHeight)
    }
}
$(document).on('turbo:load', function () {
    $('.ui.dropdown').dropdown();
    $('.message .close').on('click', function () {
        $(this).closest('.message').transition('fade');
    });
    scroll_bottom();
});
