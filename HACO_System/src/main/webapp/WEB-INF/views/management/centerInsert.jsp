<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="s" uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<!-- spEL을 활용한 리소스 버전 관리 -->
<spring:eval expression="@baseConfig['app.version']"
	var="applicationVersion" />
<spring:url value="/static-{applicationVersion}" var="resourceUrl">
	<spring:param name="applicationVersion" value="${applicationVersion}" />
</spring:url>

<!DOCTYPE html>


<!--external css-->
<link href="${resourceUrl}/assets/font-awesome/css/font-awesome.css"
	rel="stylesheet" />
<link rel="stylesheet" type="text/css"
	href="${resourceUrl}/assets/js/gritter/css/jquery.gritter.css" />

<!-- Custom styles for this template -->
<link href="${resourceUrl}/assets/css/style.css" rel="stylesheet">
<link href="${resourceUrl}/assets/css/style-responsive.css"
	rel="stylesheet">


<link rel="stylesheet"
	href="//code.jquery.com/ui/1.11.1/themes/smoothness/jquery-ui.css">
<link rel="stylesheet" href="/resources/demos/style.css">

<input id="current-accordion" type="hidden"
	value="course,centerRegister"/>

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
						<i class="fa fa-angle-right"></i> 센터명등록
					</h4>
					<form class="form-horizontal style-form" action="centerinsertOk"
						id="centerinsert" method="get">
						<div class="form-group">
							<label class="col-md-2 col-sm-2		 control-label">센터명</label>
							<div class="col-sm-10 col-md-10">
								<input type="text" class="form-control" name="location"
									id="location">
							</div>
						</div>
						<button class="btn btn-warning" id="submitBtn" type="button">등록</button>
					</form>
				</div>
			</div>
		</div>
	</section>
</section>





<%@ include file="commonScript.jsp"%>

<script src="${resourceUrl}/ckeditor/ckeditor.js"></script>

<script type="text/javascript">
$('#submitBtn').on('click', function() {
	$('#centerinsert').submit();
});
</script>




