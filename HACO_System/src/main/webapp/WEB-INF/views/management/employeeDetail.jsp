<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="s" uri="http://www.springframework.org/security/tags"%>


<!--external css-->
<link
	href="${pageContext.request.contextPath}/resources/assets/font-awesome/css/font-awesome.css"
	rel="stylesheet" />
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/resources/assets/lineicons/style.css">

<!-- Custom styles for this template -->
<link
	href="${pageContext.request.contextPath}/resources/assets/css/style.css"
	rel="stylesheet">
<link
	href="${pageContext.request.contextPath}/resources/assets/css/style-responsive.css"
	rel="stylesheet">

<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/jquery.fileupload.css">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/upload.css">

<input id="current-accordion" type="hidden"
	value="employeeManagement,employeeRegister" />

<!-- **********************************************************************************************************************************************************
      MAIN CONTENT
      *********************************************************************************************************************************************************** -->
<!--main content start-->
<section id="main-content">
	<section class="wrapper">
		<h3>
			<i class="fa fa-angle-right"></i> 직원 상세 정보
		</h3>
		
		<!-- BASIC FORM ELELEMNTS -->
		<div class="row mt">
			<div class="col-lg-12">
				<div class="form-panel">
					<h4 class="mb">
						<i class="fa fa-angle-right"></i> ${emp.name_kor} 
					</h4>						
				</div>
						<br>
						<div class="form-group">
							<!-- <label class="col-sm-2 col-sm-2 control-label">사진</label> -->
							
							<div class="col-sm-10">
								<div class="cover">
									<!-- 업로드된 파일 -->
									<div id="img-preview">
										<i id="loadingIcon" class="fa fa-spinner fa-spin fa-5x"></i>
										<img class="photo" src="${emp.photo}">
									</div>									
								</div>														
							</div>	
							<br>
							
							<div class="col-md-12">		
								<h4>기본 정보</h4>					
								<table class="table">
										<tr>
											<td><b>이름</b></td><td>${emp.name_kor}</td>
											<td><b>영문 이름</b></td><td>${emp.name_eng}</td>
										</tr>
										<tr>
											<td><b>성별</b></td><td>${emp.gender}</td>
											<td><b>주민 번호</b></td><td>${emp.resident_registration_num1}-${emp.resident_registration_num2}</td>
										</tr>
										<tr>
											<td><b>실 거주지</b></td><td>${emp.address_real}</td>
											<td><b>주민등록 상 주소</b></td><td>${emp.address_registered}</td>
										</tr>
										<tr>
											<td><b>핸드폰 번호</b></td><td>${emp.phone_cell}</td>
											<td><b>집전화 번호</b></td><td>${emp.phone_home}</td>
											
										</tr>
										<tr>
											<td><b>이메일</b></td><td>${emp.email}</td>
											<td><b>입사일</b></td><td>${emp.join_date}</td>											
										</tr>
									
								</table>
							</div>
							
							<div class="col-md-12">		
								<h4>급여 정보</h4>					
								<table class="table">
									<tr>
										<td><b>은행</b></td><td>${emp.bank}</td>
										<td><b>계좌 번호</b></td><td>${emp.bank_account}</td>
									</tr>
									<tr>
										<td><b>급여</b></td><td>${emp.salary}원</td>
										<td><b>예금주</b></td><td>${emp.account_owner}</td>
									</tr>								
								</table>
							</div>
							
							
						</div>
										
			</div>
			<!-- col-lg-12-->
		</div>
		<!-- /row -->
		
	</section>
</section>

<!--main content end-->


<!-- inclue common script -->
<%@ include file="commonScript.jsp"%>

<!--script for this page-->
<script type="text/javascript"
	src="http://code.jquery.com/ui/1.10.3/jquery-ui.js"></script>
<script type="text/javascript"
	src="${pageContext.request.contextPath}/resources/js/jquery.fileupload.js"></script>
<script type="text/javascript"
	src="${pageContext.request.contextPath}/resources/js/upload.js"></script>
<script type="application/javascript">

</script>


