<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="s" uri="http://www.springframework.org/security/tags"%>



    <!--external css-->
    <link href="${pageContext.request.contextPath}/resources/assets/font-awesome/css/font-awesome.css" rel="stylesheet" />
        
    <!-- Custom styles for this template -->
    <link href="${pageContext.request.contextPath}/resources/assets/css/style.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/resources/assets/css/style-responsive.css" rel="stylesheet">
    
	<input id="current-accordion" type="hidden" value="lectureEvaluation,evaluationResult"/>

      <!-- **********************************************************************************************************************************************************
      MAIN CONTENT
      *********************************************************************************************************************************************************** -->
      <!--main content start-->
      <section id="main-content">
          <section class="wrapper">
          <h3><i class="fa fa-angle-right"></i> Chartjs Charts</h3>
              <!-- page start-->
              <div class="tab-pane" id="chartjs">
                      <div class="col-sm-6">
                          <div class="content-panel">
							  <h4><i class="fa fa-angle-right"></i> Doughnut</h4>
                              <div class="panel-body text-center">
                                  <canvas id="doughnut" height="300" width="400"></canvas>
                              </div>
                          </div>
                      </div>
                      <!-- 주관식 -->
                      <div class="col-sm-6">
                      <div class="content-panel">
                      	hi- hello
                      </div>
                      </div>
              </div>
              <!-- page end-->
          </section>          
      </section><!-- /MAIN CONTENT -->

      <!--main content end-->
     
     
    <!-- inclue common script -->
    <%@ include file="commonScript.jsp" %>

    <!--script for this page-->
    <script src="${pageContext.request.contextPath}/resources/assets/js/chart-master/Chart.js"></script>
    <script src="${pageContext.request.contextPath}/resources/assets/js/chartjs-conf.js"></script>
    
  <script>
      //custom select box

      $(function(){
          $('select.styled').customSelect();
      });
      
     


  </script>
  <style>
			body{
				padding: 0;
				margin: 0;
			}
			#canvas-holder{
				width:30%;
			}
		</style>

