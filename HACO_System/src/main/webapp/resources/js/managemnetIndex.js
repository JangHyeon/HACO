$(function(){
	$(document).ready(function () {
    	
		var today = new Date();
    	
    	$('[data-name="now"]').text(today.toDateString());
    	
    	
    	
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
    });
    
    
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
});