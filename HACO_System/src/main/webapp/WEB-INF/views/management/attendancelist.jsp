<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="s" uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<!-- spEL을 활용한 리소스 버전 관리 -->
<spring:eval expression="@baseConfig['app.version']" var="applicationVersion" />
<spring:url value="/static-{applicationVersion}" var="resourceUrl">
	<spring:param name="applicationVersion" value="${applicationVersion}" />
</spring:url>


<!--external css-->
<link
	href="${resourceUrl}/assets/font-awesome/css/font-awesome.css"
	rel="stylesheet" />
<link rel="stylesheet" type="text/css"
	href="${resourceUrl}/assets/css/zabuto_calendar.css">
<link rel="stylesheet" type="text/css"
	href="${resourceUrl}/assets/js/gritter/css/jquery.gritter.css" />
<link rel="stylesheet" type="text/css"
	href="${resourceUrl}/assets/lineicons/style.css">

<!-- Custom styles for this template -->
<link
	href="${resourceUrl}/assets/css/style.css"
	rel="stylesheet">
<link
	href="${resourceUrl}/assets/css/style-responsive.css"
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
                                  <th>센터명</th>
                                  <th>과정명</th>
                                  <th>강의실</th>
                                  <th>교육기간</th>
                                  <th>강사명</th>
                              </tr>
                              </thead>
                              <tbody>
                              <c:forEach var="b" items="${getattenlist}">
								<tr onclick="course_write('${b.open_course_id}','${b.center_id}')" style="cursor: pointer;">
									<td>${b.location}</td>
									<td>${b.course_name}</td>
									<td>${b.classroom }</td>
									<td>${b.course_start_date} ~ ${b.course_end_date}</td>
									<td>${b.name_kor }</td>
								</tr>
							  </c:forEach>
                              </tbody>
                          </table>
                          <c:if test="${empty getattenlist || empty getattenlist[0]}">
							<h3 style="margin: 80px auto; text-align: center;">진행중인 과정이 없습니다...</h3>
						  </c:if>
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
	src="${resourceUrl}/assets/js/sparkline-chart.js"></script>
<script
	src="${resourceUrl}/assets/js/zabuto_calendar.js"></script>



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


