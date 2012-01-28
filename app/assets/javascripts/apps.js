$(function() {
	$('.new_app, .edit_app').sisyphus({
		customKeyPrefix: 'app',
		timeout: 30,
		onSave: function() {
			$('#form-status').text("Draft saved");
			$('#form-status').fadeIn(250).delay(5000).fadeOut(250);
		},
		onRestore: function() {
			$('#form-status').text("Draft restored");
			$('#form-status').fadeIn(250).delay(5000).fadeOut(250);
		},
		onRelease: function() {
			$('#form-status').text("Draft removed");
			$('#form-status').fadeIn(250).delay(5000).fadeOut(250);
		}
	});
});