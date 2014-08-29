MemberofLeaveList<%@page import="kr.co.haco.VO.EmployeeList"%>
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
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


<input id="current-accordion" type="hidden" value="member,memberOfAcademyList" />

<!-- **********************************************************************************************************************************************************
      MAIN CONTENT
      *********************************************************************************************************************************************************** -->
<!--main content start-->
<section id="main-content">
	<section class="wrapper">
		<h3>
			<i class="fa fa-angle-right"></i> 회원 조회			 
		</h3>		
		<div class="row">

			<div class="col-md-12">
				<div class="content-panel">
					<h4>
						<i class="fa fa-angle-right"></i> 원생 		
												
						<!-- 강좌목록 -->
						<div class="btn-group pull-right">
						  <button type="button" class="btn btn-info dropdown-toggle" data-toggle="dropdown">
						    강좌 목록 <span class="caret"></span>
						  </button>
						  <ul class="dropdown-menu" role="menu">
						  		<li><a href="memberOfAcademyList?center_id=0&open_course_id=0">전체 강좌</a></li>
						  	<c:forEach var="course" items="${courseList}">
						   		<li><a href="memberOfAcademyList?center_id=${course.center_id}&open_course_id=${course.open_course_id}">${course.course_name}</a></li>
						    </c:forEach>					    
						  </ul>
						</div>	
						
						<!-- 센터목록 -->
						<div class="btn-group pull-right">
						  <button type="button" class="btn btn-info dropdown-toggle" data-toggle="dropdown">
						    센터목록 <span class="caret"></span>
						  </button>
						  <ul class="dropdown-menu" role="menu">
						  		<li><a href="memberOfAcademyList?center_id=0">전체 센터</a></li>
						  	<c:forEach var="edu" items="${eduCenterList}">
						   		<li><a href="memberOfAcademyList?c_id=${edu.center_id}">${edu.location}</a></li>
						    </c:forEach>					    
						  </ul>
						</div>	
								
					</h4>
					<hr>			
					<table class="table">
						<thead>
							<tr>
								<th>번호</th>
								<th>센터명</th>	
								<th>과정명</th>
								<th>이름</th>	
								<th>직무</th>			
								<th>전화번호</th>								
								<th>주소</th>
								<th>이메일</th>
								<th>등록일자</th>	
								<th>등록코드</th>		
								<th>설문여부</th>														
							</tr>
						</thead>
						<tbody>
							<c:forEach var="member" items="${memberList}" varStatus="seq">
								<tr>
									<td>${seq.index+1}</td>
									<td>${member.center_id}</a></td>
									<td>${member.course_name}</a></td>
									<td>${member.name}</td>									
									<td>${member.job_duty}</a></td>
									<td>${member.phone}</td>
									<td>${member.address}</td>
									<td>${member.email}</td>
									<td>${member.lecture_register_date}</td>
									<td>${member.lecture_register_code}</td>
									<td>${member.is_survey}</td>												
								</tr>
							</c:forEach>
						</tbody>
					</table>
				</div>
				<!-- /content-panel -->
			</div>
			<!-- /col-md-12 -->

		</div>
		<!-- row -->
		
		
		
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
			
        }
    
</script>


