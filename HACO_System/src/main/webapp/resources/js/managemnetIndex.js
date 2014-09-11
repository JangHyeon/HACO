$(document).ready(function () {
    	
    	
        $("#date-popover").popover({html: true, trigger: "manual"});
        $("#date-popover").hide();
        $("#date-popover").click(function (e) {
            $(this).hide();
        });
    
        $("#my-calendar").zabuto_calendar({
            action: function () {
                return myDateFunction(this.id, false);
            },
            action_nav: function () {
                return myNavFunction(this.id);
            },
            ajax: {
                url: "",
                modal: true
            },
            legend: [
                {type: "text", label: "Special event", badge: "00"},
                {type: "block", label: "Regular event", }
            ]
        });

	var today = new Date();
	
	$('[data-name="now"]').text(today.toDateString());
    
    function myNavFunction(id) {
        $("#date-popover").hide();
        var nav = $("#" + id).data("navigation");
        var to = $("#" + id).data("to");
        console.log('nav ' + nav + ' to: ' + to.month + '/' + to.year);
    }
    
    var maxStorage = $('#maxStorage').val()/1024;
	var totalFileSize = $('#totalFileSize').val()/1024;
	var totalImageSize = $('#totalImageSize').val()/1024;
	
	var totalFileSizePercent = (totalFileSize/(maxStorage/100)).toFixed(1) * 1;
	var totalImageSizePercent = (totalImageSize/(maxStorage/100)).toFixed(1) * 1;

	var doughnutData = [
		{
			value: (totalFileSize).toFixed(1) * 1,
			color:"#FF865C",
			highlight: "#dF764C",
	        label: "File"
		},{
			value: (totalImageSize).toFixed(1) * 1,
			color:"#68dff0",
			highlight: "#2daebf",
	        label: "Image"
		},{
			value : (maxStorage-(totalFileSize+totalImageSize)).toFixed(1) * 1,
			color : "#444c57",
			highlight: "#485360",
			label: "여유 공간",
			labelFontSize: 9
			
		}
	];
	var myDoughnut = new Chart(document.getElementById("serverstatus02").getContext("2d")).Doughnut(
			doughnutData,
			{
				tooltipTemplate: "<%if (label){%><%=label%>: <%}%><%= value %>MB"
			}
		);
	
	$('#usePercent').text(totalFileSizePercent+totalImageSizePercent+'% 사용');
	
	var past7mouthsBar = new Chart(document.getElementById("bar-chart").getContext("2d")).Bar({
		labels: eval($('#barChartLabel').val()),
		datasets:[{
			label: "My First dataset",
            fillColor: "rgba(255, 134, 92, 1)",
            strokeColor: "rgba(255, 134, 92,0.95)",
            highlightFill: "rgba(255, 163, 132,0.75)",
            highlightStroke: "rgba(255, 163, 132,1)",
            data: eval($('#barChartData').val())
		}]
	},{
		/*
		// 단위 수동 설정
		// Boolean - If we want to override with a hard coded scale
	    scaleOverride: true,
		
		// ** Required if scaleOverride is true **
	    // Number - The number of steps in a hard coded scale
	    scaleSteps: 10,
	    // Number - The value jump in the hard coded scale
	    scaleStepWidth: 5,
	    // Number - The scale starting value
	    scaleStartValue: 0,
		*/
		
		//Boolean - Whether the scale should start at zero, or an order of magnitude down from the lowest value
	    scaleBeginAtZero : true,

	    //Boolean - Whether grid lines are shown across the chart
	    scaleShowGridLines : true,

	    //String - Colour of the grid lines
	    scaleGridLineColor : "rgba(0,0,0,.05)",

	    //Number - Width of the grid lines
	    scaleGridLineWidth : 1,

	    //Boolean - If there is a stroke on each bar
	    barShowStroke : true,

	    //Number - Pixel width of the bar stroke
	    barStrokeWidth : 1,

	    //Number - Spacing between each of the X value sets
	    barValueSpacing : 20,

	    //Number - Spacing between data sets within X values
	    barDatasetSpacing : 5,
	    
	    // Number - Tooltip title font size in pixels
	    tooltipFontSize: 12,
	    
	    // String - Tooltip background colour
	    tooltipFillColor: "rgba(66, 74, 93,.8)",
	    
	    // Number - pixel width of padding around tooltip text
	    tooltipYPadding: 8,

	    // Number - pixel width of padding around tooltip text
	    tooltipXPadding: 8,

	    // Number - Size of the caret on the tooltip
	    tooltipCaretSize: 5,

	    // Number - Pixel radius of the tooltip border
	    tooltipCornerRadius: 5,
	    
	    responsive: true,
	    maintainAspectRatio: false,

	    // String - Template string for single tooltips
	    tooltipTemplate: "<%if (label){%><%=label%> : <%}%><%= value %>명"
	});
});
