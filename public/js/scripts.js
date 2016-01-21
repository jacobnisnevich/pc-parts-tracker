$(document).ready(function() {
	var loadingButton = "<button id='list-parts-button' class='btn btn-default btn-warning' type='submit'><span class='glyphicon glyphicon-refresh glyphicon-refresh-animate'></span> Loading...</button>"
	var submitButton = "<button id='list-parts-button' class='btn btn-default' type='submit'>Submit</button>"

	$("#partlist-select").submit(function() {
		$("#list-parts-button").replaceWith(loadingButton);

		$.post("/listParts", {
			"partsId": $("#partsId").val()
		}, function(data) {
			$("#list-parts-button").replaceWith(submitButton);
			createPartList(JSON.parse(data));
		});

		return false;
	});

	$("#partlist-grid tbody").on("click", ".part", function() {
		$($(this).next().find(".part-deals-grid")[0]).slideToggle();
	});
});

var createPartList = function(listData) {
	$("#partlist-grid tbody").empty();

	var dark = false;

	Object.keys(listData).forEach(function(key) {
		var color = dark ? "dark" : "light";

		$("#partlist-grid tbody").append(generateRow(color, key, listData[key][0].name, listData[key][0].price, listData[key][0].merchant, listData[key][0].deals));

		if (listData[key].length > 1) {
			for (var i = 1; i < listData[key].length; i++) {
				$("#partlist-grid tbody").append(generateRow(color, "", listData[key][i].name, listData[key][i].price, listData[key][i].merchant, listData[key][0].deals));
			}
		}

		dark = !dark;
	});

	$("#partlist-grid").show();
}

var generateRow = function(color, type, name, price, merchant, deals) {
	var row = "<tr class='part " + color + "'>\
		<td>" + type + "</td>\
		<td>" + name + "</td>\
		<td>" + price + "</td>\
		<td>" + merchant + "</td>\
		<td><span class='badge'>" + Math.min(deals.length, 5) + "</span></td>\
	</tr>";

	if (deals.length > 0) {	
		row = row.concat("<tr class='part-deals'><td colspan='5'>");

		var dealsGrid = "<div class='part-deals-grid'>";

		deals.slice(0, 5).forEach(function(deal) {
			var imageSrc = deal["image"];
			if (imageSrc == "nsfw" || imageSrc == "self" || imageSrc == "default") {
				imageSrc = "images/" + imageSrc + ".png";
			}

			var date = new Date(deal["date"]);
			var dateString = date.toDateString() + ", " + date.toLocaleTimeString();

			dealsGrid = dealsGrid.concat("<div class='row clearfix'>\
				<div class='thumbnail'><img src='" + imageSrc + "'/></div>\
				<div class='title'><a href='" + deal["link"] + "'>" + deal["title"] + "</a></div>\
				<div class='date'>" + dateString + "</div>\
			</div>");
		});

		dealsGrid = dealsGrid.concat("</div>");

		row = row.concat(dealsGrid);
		row = row.concat("</td></tr>");
	}

	return row;
}