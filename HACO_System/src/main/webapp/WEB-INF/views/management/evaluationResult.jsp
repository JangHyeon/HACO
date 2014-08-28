<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="s" uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<!-- spEL을 활용한 리소스 버전 관리 -->
<spring:eval expression="@baseConfig['app.version']" var="applicationVersion" />
<spring:url value="/static-{applicationVersion}" var="resourceUrl">
	<spring:param name="applicationVersion" value="${applicationVersion}" />
</spring:url>


    <!--external css-->
    <link href="${resourceUrl}/assets/font-awesome/css/font-awesome.css" rel="stylesheet" />
        
    <!-- Custom styles for this template -->
    <link href="${resourceUrl}/assets/css/style.css" rel="stylesheet">
    <link href="${resourceUrl}/assets/css/style-responsive.css" rel="stylesheet">
    
	<input id="current-accordion" type="hidden" value="lectureEvaluation,evaluationResultList"/>

      <!-- **********************************************************************************************************************************************************
      MAIN CONTENT
      *********************************************************************************************************************************************************** -->
      <!--main content start-->
      <section id="main-content">
          <section class="wrapper site-min-height">
          	<h3><i class="fa fa-angle-right"></i> 강의평가 결과</h3>
          	<div class="row mt">
          		<div class="col-lg-12">
          		
          			<!-- START CHART - 4TH ROW OF PANELS -->                      
                      <div class="row" id="examResultPlace">
                      	
                      	<div class="col-md-4 col-sm-4 mb" id="examQuest" style="display:none">
                      		<div class="grey-panel pn donut-chart">
                      			<div class="grey-header">
						  			<h5>질문1</h5>
                      			</div>
								<div id="evalChart">		                      			
		                      	</div>
	                      	</div><! --/grey-panel -->
                      	</div><!-- /col-md-4-->                      	
                      
                    </div><!-- /END CHART - 4TH ROW OF PANELS -->                  
                    
          		</div>
          	</div>
          	
          	<!-- 주관식 -->          	
          	<div class="bs-example">
			    <div class="panel-group" id="accordion">
			    	<%-- <c:forEach var="essay" items="${essayResult}"> --%>
			        <div class="panel panel-default">
			            <div class="panel-heading">
			                <h4 class="panel-title">
			                    <a data-toggle="collapse" data-parent="#accordion" href="#collapseOne">ㅎㅎㅎ</a>
			                </h4>
			            </div>
			            <div id="collapseOne" class="panel-collapse collapse in">
			                <div class="panel-body">
			                    <p>하하하</p>
			                </div>
			            </div>
			        </div>
			       <%--  </c:forEach> --%>
			        <div class="panel panel-default">
			            <div class="panel-heading">
			                <h4 class="panel-title">
			                    <a data-toggle="collapse" data-parent="#accordion" href="#collapseTwo">2. 샘플?</a>
			                </h4>
			            </div>
			            <div id="collapseTwo" class="panel-collapse collapse in">
			                <div class="panel-body">
			                    <p>Twitter Bootstrap is a powerful front-end framework for faster and easier web development. It is a collection of CSS and 
			                    HTML conventions. <a href="http://www.tutorialrepublic.com/twitter-bootstrap-tutorial/" target="_blank">Learn more.</a></p>
			                </div>
			            </div>
			        </div>
			      
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
			    $.getJSON('getEvalChart?open_course_id=${param.open_course_id}', function(dataList) {
	    	//alert("dataList.lenght:"+dataList.length);	    	
	    		
	    	
	    	for(var i=0; i<dataList.length; i++){	
	    		//alert("i:"+i);
	    		var newDiv = $("#examQuest").clone(true).css("display","block");
	    		$(newDiv).attr("id", "examQuest"+i);
	    		$(newDiv).find("#evalChart").attr("id", "evalChart"+i); 
	    		$("#examResultPlace").append(newDiv);   
	    		
	    	}    	
	    	
			for(var x=0; x<dataList.length; x++){				
				var data = dataList[x];
				var resultData = new Array();
				for(var i=0; i<data.length; i++){			
					//alert("data[i].example_content:"+data[i].example_content);
					//alert("data[i].counts:"+data[i].counts);
					resultData.push([data[i].example_content,data[i].counts]);
				}
				//highcharts함수						 		
				$("#examQuest"+x).find("#evalChart"+x).highcharts({
			        chart: {
			            plotBackgroundColor: null, //'#dfdfe1',
			            plotBorderWidth: null,
			            plotShadow: false
			        },
			        title: {
			            text: ''
			        },
			        tooltip: {
			            pointFormat: '{series.name}: <b>{point.percentage:.1f}</b>'
			            /* pointFormat: '{series.name}: <b>{point.percentage:.1f}%</b>' */
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
	       
	    	} //for문
	    });

	   
	});
	
</script>


