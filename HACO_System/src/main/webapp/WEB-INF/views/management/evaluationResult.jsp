<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="s" uri="http://www.springframework.org/security/tags"%>



    <!--external css-->
    <link href="${pageContext.request.contextPath}/resources/assets/font-awesome/css/font-awesome.css" rel="stylesheet" />
        
    <!-- Custom styles for this template -->
    <link href="${pageContext.request.contextPath}/resources/assets/css/style.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/resources/assets/css/style-responsive.css" rel="stylesheet">
    
	<input id="current-accordion" type="hidden" value="lectureEvaluation,evaluationResultList"/>

     <!-- **********************************************************************************************************************************************************
      MAIN CONTENT
      *********************************************************************************************************************************************************** -->
      <!--main content start-->
      <section id="main-content">
          <section class="wrapper site-min-height">
          	<h3><i class="fa fa-angle-right"></i> 강의평가 결과 - Java 제 123123기수 과정 </h3>
          	<div class="row mt">
          		<div class="col-lg-12">
     
                      <!-- CHART PANELS -->
                      <div class="row">                     
                      
                      	<div class="col-md-4 col-sm-4 mb">
                      		<div class="grey-panel pn donut-chart">
                      			<div class="grey-header">
						  			<h5>질문1</h5>
                      			</div>
                      			<div id="je">
                      			
                      			</div>								
	                      	</div><! --/grey-panel -->
                      	</div><!-- /col-md-4-->
                      	

                      
                    </div><!-- /END CHART - 4TH ROW OF PANELS -->      
           
          		</div>
          	</div>
			
		</section><! --/wrapper -->
      </section><!-- /MAIN CONTENT -->

      <!--main content end-->
     
     
 <!-- include common script -->
<%@ include file="commonScript.jsp" %>
<!--script for this page-->
<script src="http://code.highcharts.com/highcharts.js"></script>
<script src="http://code.highcharts.com/modules/exporting.js"></script>
<script type="text/javascript">
	$(document).ready(function() {
	    $.getJSON('getEvalChart?open_course_id=${param.open_course_id}', function(data) {
	    	//alert("data.lenght:"+data.length);		
	    			
			var resultData = new Array();
			
			for(var i=0; i<data.length; i++){			
				//var o = new Object();
				//o['name']=data[i].example_content;
				//o['y']=data[i].counts*1;
				
				/* var o = {
					    name : data[i].example_content,
					    y : data[i].counts*1
					}; */
				
				//o.name=data[i].example_content;
				//o.y=data[i].counts*1;
				//alert("example_content:"+o.example_content);
				//alert("counts:"+o.counts);
				resultData.push([data[i].example_content,data[i].counts]);
			}
			
			//highcharts함수
			 $('#je').highcharts({
			        chart: {
			            plotBackgroundColor: null,
			            plotBorderWidth: 1,//null,
			            plotShadow: false
			        },
			        title: {
			            text: ''
			        },
			        tooltip: {
			            pointFormat: '{series.name}: <b>{point.percentage:.1f}%</b>'
			        },
			        plotOptions: {
			            pie: {
			                allowPointSelect: true,
			                cursor: 'pointer',
			                dataLabels: {
			                    enabled: true,
			                    format: '<b>{point.name}</b>: {point.percentage:.1f} %',
			                    style: {
			                        color: (Highcharts.theme && Highcharts.theme.contrastTextColor) || 'black'
			                    }
			                }
			            }
			        },
			        series: [{
			            type: 'pie',
			            name: 'Browser share',
			            data: resultData
			        }]
			    });
	       
	        
	    });

	});
</script>


