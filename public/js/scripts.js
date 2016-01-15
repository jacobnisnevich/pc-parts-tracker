$(document).ready(function() {
	$("#list-parts-button").click(function() {
		$.post("/listParts", {
			"partsId": $("#partsId").val()
		}, function(data) {
			console.log(data);
		})
	})
});
