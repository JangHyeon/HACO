<%@page import="kr.co.haco.VO.EmployeeList"%>
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


<input id="current-accordion" type="hidden" value="employee,${uri}" />

<!-- **********************************************************************************************************************************************************
      MAIN CONTENT
      *********************************************************************************************************************************************************** -->
<!--main content start-->
<section id="main-content">
	<section class="wrapper">
		<h3>
			<i class="fa fa-angle-right"></i> 직원 조회			 
		</h3>
		<h5><a href="http://fontawesome.io/icons/" target="_blank">- aside 아이콘 정보</a></h5>
		<div class="row">

			<div class="col-md-12">
				<div class="content-panel">
					<h4>
						<i class="fa fa-angle-right"></i> 
						<c:choose>
							<c:when test="${job_code==1}">강사</c:when>
							<c:when test="${job_code==2}">관리 직원</c:when>
							<c:when test="${job_code==3}">센터장</c:when>							
						</c:choose>					
					
						<!-- 단버튼 -->
						<div class="btn-group pull-right">
						  <button type="button" class="btn btn-info dropdown-toggle" data-toggle="dropdown">
						    센터목록 <span class="caret"></span>
						  </button>
						  <ul class="dropdown-menu" role="menu">
						  		<li><a href="manager?now_center_id=0">전체 센터</a></li>
						  	<c:forEach var="edu" items="${eduCenterList}">
						   		<li><a href="${uri}?now_center_id=${edu.center_id}">${edu.location}</a></li>
						    </c:forEach>					    
						  </ul>
						</div>
									
					</h4>
					<hr>			
					<table class="table">
						<thead>
							<tr>
								<th>현 센터</th>
								<th>계정 번호</th>
								<th>이름</th>
								<th>전화번호</th>
								<th>이메일</th>
								<th>입사일자</th>
								<th>체용센터</th>								
							</tr>
						</thead>
						<tbody>
							<c:forEach var="emp" items="${emplist}">
								<tr>
									<td>${emp.now_center_name}</td>
									<td>${emp.account_id}</td>
									<td><a href="#">${emp.name_kor}</a></td>
									<td>${emp.phone_cell}</td>
									<td>${emp.email}</td>
									<td>${emp.join_date}</td>
									<td>${emp.join_center_name}</td>						
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


