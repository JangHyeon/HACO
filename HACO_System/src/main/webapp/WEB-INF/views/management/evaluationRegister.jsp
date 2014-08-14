<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="s" uri="http://www.springframework.org/security/tags"%>



    <!--external css-->
    <link href="${pageContext.request.contextPath}/resources/assets/font-awesome/css/font-awesome.css" rel="stylesheet" />
        
    <!-- Custom styles for this template -->
    <link href="${pageContext.request.contextPath}/resources/assets/css/style.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/resources/assets/css/style-responsive.css" rel="stylesheet">
    
	<input id="current-accordion" type="hidden" value="lectureEvaluation"/>

      <!-- **********************************************************************************************************************************************************
      MAIN CONTENT
      *********************************************************************************************************************************************************** -->
      <!--main content start-->
      <section id="main-content">
          <section class="wrapper">
          <h3><i class="fa fa-angle-right"></i> 강의평가 등록</h3>
              <!-- page start-->
              <div class="tab-pane" id="chartjs">
                      <div class="col-sm-6">
                          <div class="table-responsive">
							  <table class="table table-striped">
							<tr><td>순번</td><td>센터명</td><td>과정명</td><td>수강일자</td></tr>
							<c:forEach var="erl" items="${er}">
								<tr><td>1</td><td>${erl.location}</td><td><a href="${pageContext.request.contextPath}/management/evaluationRegisterform?course_name=${erl.course_name}">${erl.course_name}</a></td><td>${erl.course_start_date} ~ ${erl.course_end_date}</td></tr>
							</c:forEach>
							  </table>
							</div>
                      </div>
              </div>
              <!-- page end-->
          </section>          
      </section><!-- /MAIN CONTENT -->

      <!--main content end-->
     <script src="//netdna.bootstrapcdn.com/bootstrap/3.0.0-wip/js/bootstrap.min.js"></script>
     
    <!-- inclue common script -->
    <%@ include file="commonScript.jsp" %>

    <!--script for this page-->
    
  <script>
      //custom select box

      $(function(){
          $('select.styled').customSelect();
      });
  </script>
  

