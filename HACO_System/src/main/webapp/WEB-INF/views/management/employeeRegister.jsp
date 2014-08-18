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
			<i class="fa fa-angle-right"></i> 직원 등록
		</h3>

		<!-- BASIC FORM ELELEMNTS -->
		<div class="row mt">
			<div class="col-lg-12">
				<div class="form-panel">
					<h4 class="mb">
						<i class="fa fa-angle-right"></i> 계정 등록
					</h4>
					<form class="form-horizontal style-form" action="employeeRegister" method="post">
						<div class="form-group">
							<label class="col-sm-2 col-sm-2 control-label">사진</label>
							<div cemployeeRegister.jsplass="col-sm-10">
								<div class="cover">
									<!-- 업로드된 파일 -->
									<div id="img-preview"><i id="loadingIcon" class="fa fa-spinner fa-spin fa-5x"></i><img class="photo" src=""></div>
									<!-- 부트 스트랩 적용 input버튼 -->
									<!-- The fileinput-button span is used to style the file input field as button -->
									<span class="btn btn-success fileinput-button"> <i
										class="glyphicon glyphicon-plus"></i> <span>사진 선택</span> <!-- The file input field used as target for the file upload widget -->
										<input id="photoUpFile" type="file" name="file"
										multiple />
									</span>
									<!-- 업로드 프로그래스바 -->
									<div id="progress_thumbnail" class="progress">
										<div class="progress-bar progress-bar-success"></div>
									</div>

									<p class="dsc">
										사진 크기는 <em>177X236</em> 사이즈에 최적화 되어있습니다.
									</p>

								</div>
								<input type="hidden" id="photo" name="photo">
							</div>
						</div>


						<div class="form-group">
							<label class="col-sm-2 col-sm-2 control-label">한글 이름</label>
							<div class="col-sm-10">
								<input type="text" class="form-control" name="name_kor">
							</div>
						</div>
						<div class="form-group">
							<label class="col-sm-2 col-sm-2 control-label">영문 이름</label>
							<div class="col-sm-10">
								<input type="text" class="form-control" name="name_eng">
							</div>
						</div>					
						<div class="form-group">
							<label class="col-sm-2 col-sm-2 control-label">성별</label>
							<div class="col-lg-6">
						    <div class="input-group">	
						    	&nbsp;&nbsp;&nbsp;							     
								<label> <input type="radio" name="gender"
									id="optionsRadios1" value="M"> 남자
								</label>
						     	&nbsp;&nbsp;&nbsp;						     	
							 
								<label> <input type="radio" name="gender"
									id="optionsRadios2" value="F"> 여자
								</label>							  
						    </div>
  						  </div>
						</div>	
						<div class="form-group">
							<label class="col-sm-2 col-sm-2 control-label">직무</label>
							<div class="col-lg-6">
						    <div class="input-group">
						    	&nbsp;&nbsp;&nbsp;								     
								<label> <input type="radio" name="job_code"
									id="optionsRadios1" value="1"> 1강사
								</label>
						     	&nbsp;&nbsp;&nbsp;					 
								<label> <input type="radio" name="job_code"
									id="optionsRadios2" value="2"> 2관리직원
								</label>	
								&nbsp;&nbsp;&nbsp;		
								<label> <input type="radio" name="job_code"
									id="optionsRadios2" value="3"> 3센터장
								</label>					  
						    </div>
  						  </div>
						</div>
						
			<%-- 			<div class="form-group">
							<label class="col-sm-2 col-sm-2 control-label">직무</label>
							<div class="col-lg-6">
						    <div class="input-group">
						      <span class="input-group-addon">
						        <input type="radio" name="job_code" value="1">
						      </span>
						      <input type="text" class="form-control" value="1강사" readonly>						     
						      <span class="input-group-addon">
						        <input type="radio" name="job_code" value="2">
						      </span>
						      <input type="text" class="form-control" value="2관리직원" readonly>
						      <span class="input-group-addon">
						        <input type="radio" name="job_code" value="3">
						      </span>
						      <input type="text" class="form-control" value="3센터장" readonly>
						    </div><!-- /input-group -->
  						  </div><!-- /.col-lg-6 -->
						</div>		
						 --%>					
						<div class="form-group">
							<label class="col-sm-2 col-sm-2 control-label">주민등록번호</label>
							<div class="col-sm-10">
								<input type="text" class="form-control-je" 
								name="resident_registration_num1" maxlength="6"> -
								<input type="text" class="form-control-je" 
								name="resident_registration_num2" maxlength="7">
							</div>
						</div>	
						<div class="form-group">
							<label class="col-sm-2 col-sm-2 control-label">주민등록지주소</label>
							<div class="col-sm-10">
								<input type="text" class="form-control" name="address_registered">
							</div>
						</div>	
						<div class="form-group">
							<label class="col-sm-2 col-sm-2 control-label">거주지주소</label>
							<div class="col-sm-10">
								<input type="text" class="form-control" name="address_real">
							</div>
						</div>	
						<div class="form-group">
							<label class="col-sm-2 col-sm-2 control-label">휴대폰번호</label>
							<div class="col-sm-10">
								<input type="text" class="form-control" name="phone_cell">
							</div>
						</div>	
					<!-- 	<div class="form-group">
							<label class="col-sm-2 col-sm-2 control-label">휴대폰번호</label>
							<div class="col-sm-10">
								<input type="text" class="form-control-je" 
								name="phone_cell1" maxlength="3"> -
								<input type="text" class="form-control-je" 
								name="phone_cell2" maxlength="4"> -
								<input type="text" class="form-control-je" 
								name="phone_cell3" maxlength="4">
							</div>
						</div>	 -->
						<div class="form-group">
							<label class="col-sm-2 col-sm-2 control-label">이메일</label>
							<div class="col-sm-10">
								<input type="text" class="form-control" name="email">
							</div>
						</div>	
						<div class="form-group">
							<label class="col-sm-2 col-sm-2 control-label">채용센터</label>
							<div class="col-sm-10">
								<input type="text" class="form-control" name="join_center_id">
							</div>
						</div>			
						<div class="form-group">
							<label class="col-sm-2 col-sm-2 control-label">현재 센터</label>
							<div class="col-sm-10">
								<input type="text" class="form-control" name="now_center_id">
							</div>
						</div>		
						<div class="form-group">
							<label class="col-sm-2 col-sm-2 control-label">입사 일자</label>
							<div class="col-sm-10">
								<input type="text" class="form-control" name="join_date">
							</div>
						</div>												
									
						<button type="submit" class="btn btn-theme">등록</button>						
					</form>
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


