<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="s" uri="http://www.springframework.org/security/tags"%>
<%@ page import="kr.co.haco.VO.OpenCourse" %>


<!--external css-->
<link
	href="${pageContext.request.contextPath}/resources/assets/font-awesome/css/font-awesome.css"
	rel="stylesheet" />
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/resources/assets/css/zabuto_calendar.css">
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/resources/assets/js/gritter/css/jquery.gritter.css" />
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/resources/assets/lineicons/style.css">

<!-- Custom styles for this template -->
<link
	href="${pageContext.request.contextPath}/resources/assets/css/style.css"
	rel="stylesheet">
<link
	href="${pageContext.request.contextPath}/resources/assets/css/style-responsive.css"
	rel="stylesheet">


<input id="current-accordion" type="hidden" value="mansgement" />

<!-- **********************************************************************************************************************************************************
      MAIN CONTENT
      *********************************************************************************************************************************************************** -->
<!--main content start-->
<script type="text/javascript">
	function course_write(open_course_id,center_id){
		document.studentlist.open_course_id.value = open_course_id;
		document.studentlist.center_id.value = center_id;
		document.studentlist.attendance_date.value;
		document.studentlist.submit();
	}
</script>
 <section id="main-content">
 	<section class="wrapper site-min-height">
 	<form id="studentlist" name="studentlist" action="studentlist" method="get">
			<div class="row mt">
                  <div class="col-md-12">
                      <div class="content-panel">
                          <table class="table table-striped table-advance table-hover">
	                  	  	  <h4><i class="fa fa-angle-right"></i>과정목록</h4>
	                  	  	  <hr>
                              <thead>
                              <tr>
                                  <th><i class="fa fa-bullhorn"></i>센터명</th>
                                  <th><i class="fa fa-bullhorn"></i>과정명</th>
                                  <th><i class="fa fa-bullhorn"></i>강의실</th>
                                  <th><i class="fa fa-bullhorn"></i>교육기간</th>
                                  <th><i class="fa fa-bullhorn"></i>강사명</th>
                                  <th></th>
                              </tr>
                              </thead>
                              <tbody>
                              <c:forEach var="b" items="${getattenlist}">
								<tr>
									<td>${b.location}</td>
									<td onclick="course_write('${b.open_course_id}','${b.center_id}')">${b.course_name}</td>
									<td>${b.classroom }</td>
									<td>${b.course_start_date} ~ ${b.course_end_date}</td>
									<td>${b.name_kor }</td>
								</tr>
							  </c:forEach>
                              </tbody>
                          </table>
                      </div><!-- /content-panel -->
                  </div><!-- /col-md-12 -->
              </div><!-- /row -->
		<input type="hidden" name="open_course_id" value=""/>
		<input type="hidden" name="center_id" value=""/>
		<input type="hidden" name="attendance_date" value="${attendance_date.seldate}"/>
	</form>
	</section>
</section>

<!--main content end-->


<!-- inclue common script -->
<%@ include file="commonScript.jsp"%>

<!--script for this page-->
<script
	src="${pageContext.request.contextPath}/resources/assets/js/sparkline-chart.js"></script>
<script
	src="${pageContext.request.contextPath}/resources/assets/js/zabuto_calendar.js"></script>



<script type="application/javascript">
	
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
                    url: "show_data.php?action=1",
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
    
</script>


