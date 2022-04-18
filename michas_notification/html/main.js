window.addEventListener('message', (event) => {
	if (event.data.type == 'HELP') {
		if (event.data.action == 'SHOW') {
			$('#text').html(event.data.msg)
			$('#help').fadeIn(300)
		} else if (event.data.action == 'HIDE') {
			$('#help').fadeOut(300)
			setTimeout(function() {
				$('#text').html("")
			}, 300)
		}
	}
})

window.addEventListener('load', (event) => {
	$('#help').fadeOut(0)
});0