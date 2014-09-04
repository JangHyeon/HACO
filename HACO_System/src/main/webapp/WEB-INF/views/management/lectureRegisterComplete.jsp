<%@page import="kr.co.haco.VO.Employee"%>
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
	href="${resourceUrl}/assets/js/bootstrap-datepicker/css/datepicker.css" />
<link rel="stylesheet" type="text/css"
	href="${resourceUrl}/assets/js/bootstrap-daterangepicker/daterangepicker.css" />

<!-- Custom styles for this template -->
<link
	href="${resourceUrl}/assets/css/style.css"
	rel="stylesheet">
<link
	href="${resourceUrl}/assets/css/style-responsive.css"
	rel="stylesheet">

<input id="current-accordion" type="hidden" value="lectureRegister,lectureRegisterComplete" />

<!-- **********************************************************************************************************************************************************
      MAIN CONTENT
      *********************************************************************************************************************************************************** -->
<!--main content start-->
<section id="main-content">
	<section class="wrapper site-min-height">
		<div class="row mt">
			<div class="col-md-12">
				<div class="content-panel">
					<table class="table table-striped table-advance table-hover">
						<h4>
							<i class="fa fa-angle-right"></i>수강신청완료목록
						</h4>
						<hr>
						<thead>
							<tr>
								<th class="responsive">센터명</th>
								<th>과정명</th>
								<th>강의실</th>
								<th>강사명</th>
								<th class="responsive">기간</th>
								<th>현재인원/정원</th>
								<th>성명</th>
								<th>수강신청상태</th>
							</tr>
						</thead>
							<c:forEach var="b" items="${getlecturecomplete}">
								<tr>
									<td class="responsive">${b.location}</td>
									<td>${b.course_name}</td>
									<td>${b.classroom }</td>
									<td>${b.name_kor }</td>
									<td class="responsive">${b.course_start_date}~ ${b.course_end_date}</td>
									<td>${b.CNT}/${b.capacity }</td>
									<td>${b.name }</td>
									<td>${b.lecture_register_name}</td>
								</tr>
							</c:forEach>
					</table>
					<c:if test="${empty getlecturecomplete || empty getlecturecomplete[0]}">
						<h3 style="margin: 80px auto; text-align: center;">목록이 없습니다...</h3>
					</c:if>
				</div>
				<!-- /content-panel -->
			</div>
			<!-- /col-md-12 -->
		</div>
		<!-- /row -->
	</section>
</section>

<!--main content end-->




<!-- inclue common script -->
<%@ include file="commonScript.jsp"%>

<!--script for this page-->
<script
	src="${resourceUrl}/assets/js/jquery-ui-1.9.2.custom.min.js"></script>

<!--custom switch-->
<script
	src="${resourceUrl}/assets/js/bootstrap-switch.js"></script>

<!--custom tagsinput-->
<script
	src="${resourceUrl}/assets/js/jquery.tagsinput.js"></script>

<!--custom checkbox & radio-->

<script type="text/javascript"
	src="${resourceUrl}/assets/js/bootstrap-datepicker/js/bootstrap-datepicker.js"></script>
<script type="text/javascript"
	src="${resourceUrl}/assets/js/bootstrap-daterangepicker/date.js"></script>
<script type="text/javascript"
	src="${resourceUrl}/assets/js/bootstrap-daterangepicker/daterangepicker.js"></script>

<script type="text/javascript"
	src="${resourceUrl}/assets/js/bootstrap-inputmask/bootstrap-inputmask.min.js"></script>


<script
	src="${resourceUrl}/assets/js/form-component.js"></script>


<script>
      //custom select box

      $(function(){
          
      });

  </script>
