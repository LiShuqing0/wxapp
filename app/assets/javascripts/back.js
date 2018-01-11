//= require jquery
//= require jquery_ujs
//= require jquery-ui.min
//= require bootstrap.min
//= require jquery.dcjqaccordion.2.7
//= require jquery.scrollTo.min
//= require jquery.nicescroll
//= require common-scripts
//= require ckeditor/init
// require_tree 

function showTip(type, str) {
    PNotify.removeAll();
    type = {
        "success": "",
        "warning": 'error'
    }[type];
    var delay = type == 'error' ? 5000 : 2000;
    new PNotify({
        title: '通知',
        text: str,
        type: type,
        remove: true,
        delay: delay
    });
    return false;
}