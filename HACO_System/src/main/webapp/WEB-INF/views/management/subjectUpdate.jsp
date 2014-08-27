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

<!DOCTYPE html>

<input id="current-accordion" type="hidden"
	value="course,subjectRegister" />

<!--external css-->
<link
	href="${resourceUrl}/assets/font-awesome/css/font-awesome.css"
	rel="stylesheet" />
<link rel="stylesheet" type="text/css"
	href="${resourceUrl}/assets/js/gritter/css/jquery.gritter.css" />

<!-- Custom styles for this template -->
<link
	href="${resourceUrl}/assets/css/style.css"
	rel="stylesheet">
<link
	href="${resourceUrl}/assets/css/style-responsive.css"
	rel="stylesheet">



<input id="current-accordion" type="hidden"
	value="course,subjectRegister" />

<!-- **********************************************************************************************************************************************************
      MAIN CONTENT
      *********************************************************************************************************************************************************** -->
<!--main content start-->
<section id="main-content">
	<section class="wrapper">
		<h3>
			<i class="fa fa-angle-right"></i>과정
		</h3>

		<!-- BASIC FORM ELELEMNTS -->
		<div class="row mt">
			<div class="col-lg-12">
				<div class="form-panel">
					<h4 class="mb">
						<i class="fa fa-angle-right"></i> 과목등록
					</h4>
					<form class="form-horizontal style-form" action="UpdateOk" id=""
						method="get">

						
						<c:forEach var="role" items="${roleList}">
						<input type="hidden" value="${role.subject_id}" name="subject_id">
							<div class="form-group">
								<label class="col-md-2 col-sm-2 control-label">과목명</label>
								<div class="col-sm-10 col-md-10">
									<input type="text" class="form-control" name="subject_name"
										value="${role.subject_name}">
								</div>
							</div>
							<div class="form-group">
								<label class="col-md-2 col-sm-2 control-label">정원</label>
								<div class="col-md-4 col-sm-4">
									<input type="text" class="form-control" name="capacity"
										value="${role.capacity}">
								</div>
								<label class="col-md-2 col-sm-2 control-label">교육센터</label>
								<div class="col-md-4 col-sm-4">
									<select id="center_id" name="center_id">
										<option value="">교육센터명</option>
										<c:forEach var="Center" items="${Center}">
											<option value="${Center.center_id}">${Center.location}</option>
										</c:forEach>
									</select>
								</div>
							</div>

							<div class="form-group">
								<label class="col-md-2 col-sm-2 control-label">총강의일수</label>
								<div class="col-md-1 col-sm-1">
									<input type="text" class="form-control" name="lecture_totalday"
										value="${role.lecture_totalday}">
								</div>

								<label class="col-md-1 col-sm-1 control-label">강의시간</label>
								<div class="col-md-4 col-sm-4">
									<input type="time" name="start"
										value="${role.lecture_time_start}">
									&nbsp&nbsp&nbsp~&nbsp&nbsp&nbsp <input type="time" name="end"
										value="${role.lecture_time_end}">
								</div>

								<label class="col-md-1 col-sm-1 control-label">수강료</label>
								<div class="col-md-3 col-sm-3">
									<input type="text" class="form-control" name="Tuition_fee"
										value="${role.tuition_fee}">
								</div>
							</div>
							<div class="form-group">
								<label class="col-sm-2 col-sm-2 control-label">강의내용</label>
								<div class="col-md-10 col-sm-10">
									<textarea class="form-control" name="lecture_content">${role.lecture_content}</textarea>
								</div>
							</div>

							<div class="form-group">
								<label class="col-sm-2 col-sm-2 control-label">과목설명</label>
								<div class="col-md-10 col-sm-10">
									<textarea class="form-control" name="subject_explanation">${role.subject_explanation}</textarea>
								</div>
							</div>


							<div class="form-group">
								<label class="col-lg-2 col-sm-2 control-label">학습목표</label>
								<div class="col-md-10 col-sm-10">
									<textarea class="form-control" name="instructional_objectives">${role.instructional_objectives}</textarea>
								</div>
							</div>

							<div class="form-group">
								<label class="col-lg-2 col-sm-2 control-label">과목특장점</label>
								<div class="col-md-10 col-sm-10">
									<textarea class="form-control" name="subject_point">${role.subject_point}</textarea>
								</div>
							</div>

							<div class="form-group">
								<label class="col-lg-2 col-sm-2 control-label">수강대상</label>
								<div class="col-md-10 col-sm-10">
									<input type="text" class="form-control" name="lecture_target"
										value="${role.lecture_target}">
								</div>
							</div>
						</c:forEach>
						<button class="btn1" type="submit">수정</button>
						<!-- <button class="btn2">취소</button>   -->
					</form>
				</div>
			</div>
			<!-- col-lg-12-->
		</div>
		<!-- /row -->



	</section>
	<!--/wrapper -->
</section>
<!-- /MAIN CONTENT -->


<!--main content end-->



<!-- inclue common script -->
<%@ include file="commonScript.jsp"%>

<!--script for this page-->


