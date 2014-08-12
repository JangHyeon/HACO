var Script = function () {


	 var doughnutData = [
	          				{
	          					value: 300,
	          					color:"#F7464A",
	          					highlight: "#FF5A5E",
	          					label: "Red"
	          				},
	          				{
	          					value: 120,
	          					color: "#4D5360",
	          					highlight: "#616774",
	          					label: "Dark Grey"
	          				}

	          			];

	          			window.onload = function(){
	          				var ctx = document.getElementById("doughnut").getContext("2d");
	          				window.myDoughnut = new Chart(ctx).Doughnut(doughnutData, {responsive : true});
	          			};


}();