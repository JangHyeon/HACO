<%@page import="kr.co.haco.VO.EmployeeList"%>
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
		<div class="row">

			<div class="col-md-12">
				<div class="content-panel">						
					<!-- 단버튼 -->
					<div class="btn-group pull-right topToggle">
					  <button type="button" class="btn btn-default dropdown-toggle" data-toggle="dropdown">
					    센터목록 <span class="caret"></span>
					  </button>
					  <ul class="dropdown-menu" role="menu">
					  		<li><a href="${uri}?now_center_id=0">전체 센터</a></li>
					  	<c:forEach var="edu" items="${eduCenterList}">
					   		<li><a href="${uri}?now_center_id=${edu.center_id}">${edu.location}</a></li>
					    </c:forEach>					    
					  </ul>
					</div>
					<h4>
						<i class="fa fa-angle-right"></i> 
						<c:choose>
							<c:when test="${job_code==1}">강사</c:when>
							<c:when test="${job_code==2}">관리 직원</c:when>
							<c:when test="${job_code==3}">센터장</c:when>							
						</c:choose>					
					</h4>
					<hr>			
					<table class="table">
						<thead>
							<tr>
								<th>번호</th>
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
							<c:forEach var="emp" items="${emplist}" varStatus="seq">
								<tr>
									<td>${seq.index+1}</td>
									<td>${emp.now_center_name}</td>
									<td>${emp.account_id}</td>
									<td><a href="employeeDetail/${emp.account_id}">${emp.name_kor}</a></td>
									<td>${emp.phone_cell}</td>
									<td>${emp.email}</td>
									<td>${emp.join_date}</td>
									<td>${emp.join_center_name}</td>						
								</tr>
							</c:forEach>
						</tbody>
					</table>
                  <c:if test="${empty emplist || empty emplist[0]}">
					<h3 style="margin: 80px auto; text-align: center;">등록 직원이 없습니다...</h3>
				  </c:if>
				  <div class="table-footer">
		<!-- 페이징 -->
	      <div class="col-xs-12">         
	         <ul class="pagination pagination-centered">
	            <!-- 이전 링크 -->
	            <li<c:if test="${beginpage<10}"> class="disabled"</c:if>>
	               <a<c:if test="${beginpage>10}"> href="${pageContext.request.contextPath}/management/${uri}?pageSize=${pageSize}&pageNum=${beginpage-1}"</c:if>>«</a>
	            </li>
	            
	              <!-- 페이지 리스트   -->
	              <c:if test="${beginpage!=0}">
	            <c:forEach var="i" begin="${beginpage}" end="${endpage}" step="1">
	            
	               <c:if test="${i==pageNum}">
	                  <li class="active"><a>${i} <span class="sr-only">(current)</span></a></li>
	               </c:if>
	               <c:if test="${i!=pageNum}">
	                  <li><a href="${pageContext.request.contextPath}/management/${uri}?pageSize=${pageSize}&pageNum=${i}">${i}</a></li>
	               </c:if>
	            </c:forEach>
	            </c:if>
	              <!-- 다음링크 -->
	            <li<c:if test="${endpage>=pagecount}"> class="disabled"</c:if>>
	               <a<c:if test="${endpage<pagecount}"> href="${pageContext.request.contextPath}/management/${uri}?pageSize=${pageSize}&pageNum=${endpage+1}"</c:if>>»</a>
	            </li>
	         </ul>
	      </div>   
		</div>
				  
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

</script>


