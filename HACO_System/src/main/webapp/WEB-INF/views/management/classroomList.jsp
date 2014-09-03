<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="s" uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<!-- spEL을 활용한 리소스 버전 관리 -->
<spring:eval expression="@baseConfig['app.version']"
	var="applicationVersion" />
<spring:url value="/static-{applicationVersion}" var="resourceUrl">
	<spring:param name="applicationVersion" value="${applicationVersion}" />
</spring:url>
<!--external css-->
<link href="${resourceUrl}/assets/font-awesome/css/font-awesome.css"
	rel="stylesheet" />
<link rel="stylesheet" type="text/css"
	href="${resourceUrl}/assets/js/gritter/css/jquery.gritter.css" />

<!-- Custom styles for this template -->
<link href="${resourceUrl}/assets/css/style.css" rel="stylesheet">
<link href="${resourceUrl}/assets/css/style-responsive.css"
	rel="stylesheet">


<input id="current-accordion" type="hidden"
	value="course,centerRegister" />

<!-- **********************************************************************************************************************************************************
      MAIN CONTENT
      *********************************************************************************************************************************************************** -->
<!--main content start-->

<section id="main-content">
	<section class="wrapper">
		<h3>
			<i class="fa fa-angle-right"></i> 과정
		</h3>

		<div class="row">

			<div class="col-md-12">
				<div class="content-panel pull">
					<div class="col-md-6">						
					<div class="pull-right topToggle">
						<a class="btn btn-success"
							href="${pageContext.request.contextPath}/management/subjectInsert">
							과목 등록</a>
					</div>
					
						<h4>
							<i class="fa fa-angle-right"></i> 강의실등록
						</h4>
						<div>
							<table class="table">
								<thead>
									<tr>

										<th>center_classroom_id</th>
										<th>classroom</th>
										<th>삭제</th>
									</tr>
								</thead>
								<tbody>
									<c:forEach var="Classroom" items="${Classroom}">
										<tr>
											<td>${Classroom.center_classroom_id}</td>
											<td>${Classroom.classroom}</td>
											<td>
												<button class="btn btn-danger btn-xs" id="deletebtn">
													<i class="fa fa-trash-o "></i>
												</button>
											</td>
										</tr>
									</c:forEach>
								</tbody>
							</table>
						</div>
					</div>

					<div class="col-md-6">비어놈</div>
				</div>
			</div>
		</div>
	</section>
</section>



<!-- inclue common script -->

<script src="${resourceUrl}/gazONojfL3/js/bootstrap.3.2.0.min.js"></script>
<%@ include file="commonScript.jsp"%>

<script>
	$(document).ready(function() {

	});
</script>
