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



<!-- **********************************************************************************************************************************************************
      MAIN CONTENT
      *********************************************************************************************************************************************************** -->
<!--main content start-->
<section id="main-content">
	<section class="wrapper">
		<h3>
			<i class="fa fa-angle-right"></i> 직원 상세 정보
		</h3>

		<form id="employeeUpdate" action="employeeUpdate" method="post">
			<!-- BASIC FORM ELELEMNTS -->
			<input type="hidden" name="account_id"
				value="<s:authentication property="name"/>">
			<div class="row mt">
				<div class="col-lg-12">
					<div class="content-panel panel-body">
						<div class="pull-right employeeDetail">
							HACO SYSTEM
						</div>
						<br>
						<br>
						<div class="form-group">
							<!-- <label class="col-sm-2 col-sm-2 control-label">사진</label> -->
							<div class="col-md-12">
								<div class="cover">
									<!-- 업로드된 파일 -->
									<div id="img-preview"><i id="loadingIcon" class="fa fa-spinner fa-spin fa-5x"></i><img
									class="photo"
									src="${pageContext.request.contextPath}/employeePhoto/${emp.photo}"
									onerror="this.src='${pageContext.request.contextPath}/images/User-Role-Guest-icon.png'"></div>
									<!-- 부트 스트랩 적용 input버튼 -->
									<!-- The fileinput-button span is used to style the file input field as button -->
									<span class="btn btn-success fileinput-button"> 
										<i class="glyphicon glyphicon-plus"></i> <span>사진 선택</span> <!-- The file input field used as target for the file upload widget -->
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
							</div>
							<br>

							<div class="col-md-12">
								<h4>기본 정보</h4>
								<table class="table">
									<tr>
										<td><b>이름</b></td>
										<td>${emp.name_kor}</td>
										<td><b>영문 이름</b></td>
										<td>${emp.name_eng}</td>
									</tr>
									<tr>
										<td><b>성별</b></td>
										<td>${emp.gender}</td>
										<td><b>주민 번호</b></td>
										<td>${emp.resident_registration_num1}-${emp.resident_registration_num2}</td>
									</tr>
									<tr>
										<td><b>실 거주지</b></td>
										<td><input type="text" style="border: 0px"
											name="address_real" value="${emp.address_real}"
											maxlength="50"></td>
										<td><b>주민등록 상 주소</b></td>
										<td><input type="text" style="border: 0px"
											name="address_registered" value="${emp.address_registered}"
											maxlength="50"></td>
									</tr>
									<tr>
										<td><b>핸드폰 번호</b></td>
										<td><input type="text" style="border: 0px"
											name="phone_cell" value="${emp.phone_cell}"></td>
										<td><b>집전화 번호</b></td>
										<td><input type="text" style="border: 0px"
											name="phone_home" value="${emp.phone_home}"></td>

									</tr>
									<tr>
										<td><b>이메일</b></td>
										<td><input type="text" style="border: 0px" name="email"
											value="${emp.email}"></td>
										<td><b>입사일</b></td>
										<td>${emp.join_date}</td>
									</tr>

								</table>
							</div>

							<div class="col-md-12">
								<h4>급여 정보</h4>
								<table class="table">
									<tr>
										<td><b>은행</b></td>
										<td><input type="text" style="border: 0px" name="bank"
											value="${emp.bank}"></td>
										<td><b>계좌 번호</b></td>
										<td><input type="text" style="border: 0px"
											name="bank_account" value="${emp.bank_account}"></td>
									</tr>
									<tr>
										<td><b>급여</b></td>
										<td>${emp.salary}원</td>
										<td><b>예금주</b></td>
										<td><input type="text" style="border: 0px"
											name="account_owner" value="${emp.account_owner}"></td>
									</tr>
								</table>
							</div>
						</div>
						<button id="registerBtn" type="button" class="btn btn-theme writeBtn">수정</button>
					</div>
					
				</div>
				<!-- col-lg-12-->
			</div>
			<!-- /row -->
		</form>

	</section>
</section>

<!--main content end-->


<!-- inclue common script -->
<%@ include file="commonScript.jsp"%>

<!--script for this page-->
<script type="text/javascript"
	src="http://code.jquery.com/ui/1.10.3/jquery-ui.js"></script>
<script type="text/javascript"
	src="${resourceUrl}/js/jquery.fileupload.js"></script>
<script type="text/javascript" src="${resourceUrl}/js/upload.js"></script>
<script type="application/javascript">
		
$(document).ready(function(){
	/* //유효성 검사 
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
	 */
	//submit, 유효성 검사
	$('#registerBtn').on('click',function(){
	   $('#employeeUpdate').submit();
   	});
	$('#employeeUpdate').submit(function(){    
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


