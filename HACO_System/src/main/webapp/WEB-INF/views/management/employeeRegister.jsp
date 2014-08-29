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

<!--external css-->
<link href="${resourceUrl}/assets/font-awesome/css/font-awesome.css"
	rel="stylesheet" />
<link rel="stylesheet" type="text/css"
	href="${resourceUrl}/assets/lineicons/style.css">

<!-- Custom styles for this template -->
<link href="${resourceUrl}/assets/css/style.css" rel="stylesheet">
<link href="${resourceUrl}/assets/css/style-responsive.css"
	rel="stylesheet">

<link rel="stylesheet" href="${resourceUrl}/css/jquery.fileupload.css">
<link rel="stylesheet" href="${resourceUrl}/css/upload.css">


<link rel="stylesheet" type="text/css"
	href="${resourceUrl}/css/datepicker3.css">




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
				<div class="content-panel panel-body">
					<div class="col-md-12">
						<!-- <h4 class="mb">
							<i class="fa fa-angle-right"></i> 계정 등록
						</h4> -->
						<div class="pull-right employeeDetail">
							HACO SYSTEM
						</div>
						<br>
						<br>
						<form id="registerFrm" class="form-horizontal style-form"
							method="post">
							<div class="form-group">
								<label class="col-sm-2 col-sm-2 control-label">사진</label>
								<div class="col-sm-10">
									<div class="cover">
										<!-- 업로드된 파일 -->
										<div id="img-preview">
											<i id="loadingIcon" class="fa fa-spinner fa-spin fa-5x"></i><img
									class="photo"
									src="${pageContext.request.contextPath}/employeePhoto/${emp.photo}"
									onerror="this.src='${pageContext.request.contextPath}/images/User-Role-Guest-icon.png'">
										</div>
										<!-- 부트 스트랩 적용 input버튼 -->
										<!-- The fileinput-button span is used to style the file input field as button -->
										<span class="btn btn-success fileinput-button"> <i
											class="glyphicon glyphicon-plus"></i> <span>사진 선택</span> <!-- The file input field used as target for the file upload widget -->
											<input id="photoUpFile" type="file" name="file" multiple />
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
									<input type="text" class="form-control onlyAlphanum"
										name="name_kor" id="name_kor">
								</div>
							</div>
							<div class="form-group">
								<label class="col-sm-2 col-sm-2 control-label">영문 이름</label>
								<div class="col-sm-10">
									<input type="text" class="form-control onlyAlphanum"
										name="name_eng" id="name_eng">
								</div>
							</div>
							<div class="form-group">
								<label class="col-sm-2 col-sm-2 control-label">성별</label>
								<div class="col-lg-6">
									<div class="input-group">
										&nbsp;&nbsp;&nbsp; <label> <input type="radio"
											name="gender" id="optionsRadios1" value="M"> 남자
										</label> &nbsp;&nbsp;&nbsp; <label> <input type="radio"
											name="gender" id="optionsRadios2" value="F"> 여자
										</label>
									</div>
								</div>
							</div>
							<div class="form-group">
								<label class="col-sm-2 col-sm-2 control-label">직무</label>
								<div class="col-lg-6">
									<div class="input-group">
										&nbsp;&nbsp;&nbsp; <label> <input type="radio"
											name="job_code" id="optionsRadios1" value="1"> 1강사
										</label> &nbsp;&nbsp;&nbsp; <label> <input type="radio"
											name="job_code" id="optionsRadios2" value="2"> 2관리직원
										</label> &nbsp;&nbsp;&nbsp; <label> <input type="radio"
											name="job_code" id="optionsRadios2" value="3"> 3센터장
										</label>
									</div>
								</div>
							</div>
							<div class="form-group">
								<label class="col-sm-2 col-sm-2 control-label">주민등록번호</label>
								<div class="col-sm-10">
									<input type="text" class="form-control-je onlyNumber"
										id="resident_registration_num1"
										name="resident_registration_num1" maxlength="6"> - <input
										type="text" class="form-control-je onlyNumber"
										id="resident_registration_num2"
										name="resident_registration_num2" maxlength="7">
								</div>
							</div>
							<div class="form-group">
								<label class="col-sm-2 col-sm-2 control-label">주민등록지주소</label>
								<div class="col-sm-10">
									<input type="text" class="form-control"
										name="address_registered">
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
									<input type="text" class="form-control-je onlyNumber"
										name="phone_cell1" maxlength="3"> - <input type="text"
										class="form-control-je onlyNumber" name="phone_cell2"
										maxlength="4"> - <input type="text"
										class="form-control-je onlyNumber" name="phone_cell3"
										maxlength="4">
								</div>
							</div>
							<div class="form-group">
								<label class="col-sm-2 col-sm-2 control-label">이메일</label>
								<div class="col-sm-10">
									<input type="text" class="form-control" name="email">
								</div>
							</div>
							<div class="form-group">
								<label class="col-sm-2 col-sm-2 control-label">채용센터</label>
								<div class="col-sm-10">
									<div class="btn-group">
										<button id="joinCenterBtn" type="button"
											class="btn btn-default dropdown-toggle"
											data-toggle="dropdown">
											<span>채용센터 선택</span> <span class="caret"></span>
										</button>
										<ul id="joinCenter" class="dropdown-menu pull-right pageSize">
											<c:forEach var="edu" items="${eduCenterList}">
												<li value="${edu.center_id}"><a>${edu.center_id}:${edu.location}</a></li>
											</c:forEach>
										</ul>
									</div>
								</div>

							</div>
							<div class="form-group">
								<label class="col-sm-2 col-sm-2 control-label">현재 센터</label>
								<div class="col-sm-10">
									<div class="btn-group">
										<button id="nowCenterBtn" type="button"
											class="btn btn-default dropdown-toggle"
											data-toggle="dropdown">
											<span>현재센터 선택</span> <span class="caret"></span>
										</button>
										<ul id="nowCenter" class="dropdown-menu pull-right pageSize">
											<c:forEach var="edu" items="${eduCenterList}">
												<li value="${edu.center_id}"><a>${edu.center_id}:${edu.location}</a></li>
											</c:forEach>
										</ul>
									</div>
								</div>
							</div>
							<div class="form-group">
								<label class="col-sm-2 col-sm-2 control-label">입사 일자</label>
								<div class="col-sm-2">
									<div id="datapickerBox">
										<input class="form-control" type="text" id="wrtDtReg"
											name="join_date" placeholder="">
									</div>
								</div>
							</div>
							<input type="hidden" name="join_center_id" id="join_center_id"
								value="0"> <input type="hidden" name="now_center_id"
								id="now_center_id" value="0">

							<button id="registerBtn" type="button" class="btn btn-theme writeBtn">등록</button>
						</form>
					</div>
				</div>
			</div>
			<!-- col-lg-12-->
		</div>
		<!-- /row -->

	</section>
</section>

<!--main content end-->

<!-- lodingmodel -->
<div aria-hidden="true" aria-labelledby="myModalLabel" role="dialog"
	tabindex="-1" id="lodingModal" class="modal fade">
	<div class="modal-dialog">
		<div id="loaderImage"></div>
	</div>
</div>
<!-- modal -->

<!-- inclue common script -->
<%@ include file="commonScript.jsp"%>

<!--script for this page-->
<script type="text/javascript"
	src="http://code.jquery.com/ui/1.10.3/jquery-ui.js"></script>
<script type="text/javascript"
	src="${resourceUrl}/js/jquery.fileupload.js"></script>
<script type="text/javascript" src="${resourceUrl}/js/upload.js"></script>

<script type="text/javascript"
	src="${resourceUrl}/js/bootstrap-datepicker.js"></script>
<script type="text/javascript"
	src="${resourceUrl}/js/bootstrap-datepicker.kr.js"></script>
<script type="text/javascript"
	src="${resourceUrl}/js/jquery.alphanum.js"></script>

<script type="application/javascript">
	
	$(document).ready(function(){
		//유효성 검사 
		//숫자만 입력 가능하도록 처리 하는 부분
        $(".onlyNumber").numeric();       
        //문자,숫자만 입력- 특수문자입력 불가
        $(".onlyAlphanum").alphanum();       
        
		//채용센터 선택
		$('#joinCenter>li').on('click',function(){
			$('#joinCenterBtn>span:first-child').text($('a',this).text());		
			$('input[name=join_center_id]').val($(this).attr('value'));			
		});
		//현재 센터 선택
		$('#nowCenter>li').on('click',function(){
			$('#nowCenterBtn>span:first-child').text($('a',this).text());		
			$('input[name=now_center_id]').val($(this).attr('value'));			
		});
		
		$('#datapickerBox input').datepicker({
			  format: "yyyy-mm-dd",
			  startView: 3,
			  todayBtn:"linked",
			  language: "kr",
			  orientation: "top auto",
			  keyboardNavigation: false,
			  forceParse: false,
			  autoclose: true,
			  todayHighlight: true
			 });
		
		//submit, 유효성 검사
		$('#registerBtn').on('click',function(){
    	   $('#registerFrm').submit();
       	});
		$('#registerFrm').submit(function(){    
		   //alert($('#joinCenterBtn>span:first-child').text);
           if($('#name_kor').val() == ""){
                alert("한글 이름을 입력하세요");
                //$('#name_kor').addClass('alertFocus');
                $('#name_kor').focus();
                return false;           
           }
           if($('#name_eng').val() == ""){
               alert("영어 이름을 입력하세요");
               $('#name_eng').focus();
               return false;
           }       
           if(!$("input:radio[name='gender']").is(":checked")){
               alert("성별을 선택해주세요");              
               return false;
           }
           if(!$("input:radio[name='job_code']").is(":checked")){
               alert("직무를 선택해주세요.");
               $('#job_code').focus();
               return false;
           }
           if($('#resident_registration_num1').val() == ""){
               alert("주민번호를 입력하세요");
               $('#resident_registration_num1').focus();
               return false;
           }
           if($('#resident_registration_num2').val() == ""){
               alert("주민번호를 입력하세요");
               $('#resident_registration_num2').focus();
               return false;
           }    
           if($('#join_center_id').val() =='0'){
               alert("채용센터를 선택하세요");              
               return false;
           }
           if($('#now_center_id').val() =='0'){
               alert("현재센터를 선택하세요");              
               return false;
           }
           if($('#wrtDtReg').val() == ""){
               alert("입사 날짜를 입력하세요");
           
               return false;
           }
           
           $(window).off('beforeunload');
           $('#registerBtn').off('click');
           $("#registerBtn").attr("disabled", true);
           $('#registerBtn').text('처리중');
           $('#lodingModal').modal({
   			backdrop:false,
   			keyboard:false
   			
   		   });
		});
	
	});	

</script>

