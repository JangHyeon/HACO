MemberofLeaveList<%@page import="kr.co.haco.VO.EmployeeList"%>
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="s" uri="http://www.springframework.org/security/tags"%>


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
						
						<!-- 단버튼 -->					
						<div class="btn-group pull-right">
						  <button type="button" class="btn btn-info dropdown-toggle" data-toggle="dropdown">
						    강좌 목록 <span class="caret"></span>
						  </button>
						  <ul class="dropdown-menu" role="menu">
						  		<li><a href="memberOfAcademyList?center_id=0">전체 강좌</a></li>
						  	<c:forEach var="edu" items="${eduCenterList}">
						   		<li><a href="memberOfAcademyList?center_id=${edu.center_id}">${edu.location}</a></li>
						    </c:forEach>					    
						  </ul>
						</div>	
						<div class="btn-group pull-right">
						  <button type="button" class="btn btn-info dropdown-toggle" data-toggle="dropdown">
						    센터목록 <span class="caret"></span>
						  </button>
						  <ul class="dropdown-menu" role="menu">
						  		<li><a href="memberOfAcademyList?center_id=0">전체 센터</a></li>
						  	<c:forEach var="edu" items="${eduCenterList}">
						   		<li><a href="memberOfAcademyList?center_id=${edu.center_id}">${edu.location}</a></li>
						    </c:forEach>					    
						  </ul>
						</div>	
								
					</h4>
					<hr>			
					<table class="table">
						<thead>
							<tr>
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
							<c:forEach var="member" items="${memberList}">
								<tr>
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
	src="${pageContext.request.contextPath}/resources/assets/js/sparkline-chart.js"></script>
<script
	src="${pageContext.request.contextPath}/resources/assets/js/zabuto_calendar.js"></script>



<script type="application/javascript">
	
        $(document).ready(function () {
			
        }
    
</script>


