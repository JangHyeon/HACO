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
						<i class="fa fa-angle-right"></i> 과목수정
					</h4>
					<form class="form-horizontal style-form" action="UpdateOk" id="updatesubject"
						method="POST">
						
						<c:forEach var="role" items="${roleList}">
						<input type="hidden" value="${role.center_id}" id="Cid" >
						<input type="hidden" value="${role.subject_id}" name="subject_id">
						<div class="form-group">
							<label class="col-md-2 col-sm-2 control-label">등록센터</label>
							<div class="col-md-4 col-sm-4">
								 <input type="hidden" value="${role.center_id}"  id="center_id" name="center_id">
								 <input type="text" class="form-control" name="location"	id="location" value="${role.location}" disabled="disabled">
							</div>
						</div>
					
						<div class="form-group">
							<label class="col-md-2 col-sm-2		 control-label">과목명</label>
							<div class="col-sm-10 col-md-10">
								<input type="text" class="form-control" name="subject_name"
									value="${role.subject_name}" id="subject_name">
							</div>
						</div>
						<div class="form-group">
							<label class="col-md-2 col-sm-2 control-label">정원</label>
							<div class="col-md-4 col-sm-4">
								<div class="input-group">
									<input type="text" class="form-control" name="capacity_String"
										value="${role.capacity}" id="capacity_String" style="ime-mode: disabled">
										<span class="input-group-addon">명</span>
								</div>
							</div>
							
						</div>
						<div class="form-group">
							<label class="col-md-2 col-sm-2 control-label">총강의일수</label>
							<div class="col-md-4 col-sm-4">
								<div class="input-group">
									<input type="text" class="form-control" name="lecture_totalday_String"
										value="${role.lecture_totalday}" id="lecture_totalday_String" style="ime-mode: disabled">
									<span class="input-group-addon">일</span>
								</div>
							</div>
						</div>
						<div class="form-group">
							<label class="col-md-2 col-sm-2 control-label">강의시간</label>
							<div class="col-md-10 col-sm-10">
								<div class="input-group col-sm-5 time">
									<span class="input-group-addon">시작</span>
									<input type="time" name="start" id="start" 
									value="${role.lecture_time_start}" class="form-control time">
								</div>
								<div class="input-group col-sm-5 time">
									<span class="input-group-addon">종료</span>
									<input type="time" class="form-control time" 
										value="${role.lecture_time_end}" name="end" id="end">
								</div>
							</div>
						</div>
						<div class="form-group">
							<label class="col-md-2 col-sm-2 control-label">수강료</label>
							<div class="col-md-4 col-sm-4">
								<div class="input-group">
									<span class="input-group-addon">￦</span>
									<input type="text" class="form-control" name="tuition_fee_String"
										value="${role.tuition_fee}" id="tuition_fee_String" style="ime-mode: disabled">
								</div>
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
						
						<div class="btn-group submitBtn">
								<button id="updateBtn"  
									class="btn btn-large btn-block btn-primary joinbtn" 
									type="button">수정</button>
							</div>
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

<script src="${resourceUrl}/ckeditor/ckeditor.js"></script>
<script type="text/javascript" src="${resourceUrl}/jquery-number-master/jquery.number.min.js"></script>
<script type="text/javascript" src="${resourceUrl}/js/jquery.alphanum.js"></script>


<script type="text/javascript">

$("#center_id").val($("#Cid").val()).attr("selected", "selected");

$(document).ready(function(){

    /* $('#capacity_String').numeric();
    $('#lecture_totalday_String').numeric();
	$("#tuition_fee_String").numeric(); */
	
	$('#capacity_String').number(true);
    $('#lecture_totalday_String').number(true);
	$("#tuition_fee_String").number(true);
	
	var ckeditor1;
	var ckeditor2;
	var ckeditor3;
	var ckeditor4;
	
	CKEDITOR.replace( 'lecture_content', {
		skin : 'bootstrapck',
		enterMode: '2',
		shiftEnterMode:'3',
		//filebrowserBrowseUrl : "${resourceUrl}",
		filebrowserUploadUrl : '${pageContext.request.contextPath}/ckUpload/board/subject/command/QuickUpload/type/File',
        filebrowserImageUploadUrl : '${pageContext.request.contextPath}/ckUpload/board/subject/command/QuickUpload/type/Images'
	});
	ckeditor1 = CKEDITOR.instances['lecture_content'];

	CKEDITOR.replace( 'subject_explanation', {
		skin : 'bootstrapck',
		enterMode: '2',
		shiftEnterMode:'3',
		//filebrowserBrowseUrl : "${resourceUrl}",
		filebrowserUploadUrl : '${pageContext.request.contextPath}/ckUpload/board/subject/command/QuickUpload/type/File',
        filebrowserImageUploadUrl : '${pageContext.request.contextPath}/ckUpload/board/subject/command/QuickUpload/type/Images'
	});
	ckeditor2 = CKEDITOR.instances['subject_explanation'];
	
	CKEDITOR.replace( 'instructional_objectives', {
		skin : 'bootstrapck',
		enterMode: '2',
		shiftEnterMode:'3',
		//filebrowserBrowseUrl : "${resourceUrl}",
		filebrowserUploadUrl : '${pageContext.request.contextPath}/ckUpload/board/subject/command/QuickUpload/type/File',
        filebrowserImageUploadUrl : '${pageContext.request.contextPath}/ckUpload/board/subject/command/QuickUpload/type/Images' 
	});
	ckeditor3 = CKEDITOR.instances['instructional_objectives'];
	
	CKEDITOR.replace( 'subject_point', {
		skin : 'bootstrapck',
		enterMode: '2',
		shiftEnterMode:'3',
		//filebrowserBrowseUrl : "${resourceUrl}",
		filebrowserUploadUrl : '${pageContext.request.contextPath}/ckUpload/board/subject/command/QuickUpload/type/File',
        filebrowserImageUploadUrl : '${pageContext.request.contextPath}/ckUpload/board/subject/command/QuickUpload/type/Images' 
	});
	ckeditor4 = CKEDITOR.instances['subject_point'];
	
	
	// 페이지 이탈시 작동
 	var beforeUnload = 1;
	$(window).on('beforeunload',function() {
		if (beforeUnload) return "저장하지 않고 페이지를 벗어나려 합니다.\n작성중인 내용은 저장되지 않습니다.";
	});
 
	// BackSpace 키 방지 이벤트
	$(document).keydown(function(e) {
		if (e.target.nodeName != "INPUT"
				&& e.target.nodeName != "TEXTAREA") {
			if (e.keyCode === 8) {
				e.preventDefault();
				return false;
			}
		}
	});

	
	$('#updateBtn').on('click', function() {
		$('#updatesubject').submit();
	});

	$('#updatesubject').submit(function() {
		
		/*과목명 예외처리 */
		if ($('#subject_name').val() == "") {
			alert("과목명을 입력하세요.");
			$('#subject_name').focus();
			return false;
		}
		else if($('#subject_name').val().length>20){
			alert("과목명은 20자 이하로 입력하세요.");
			$('#subject_name').focus();
			return false;
		}

		/*정원 예외처리 */
		if ($('#capacity_String').val() == "") {
			alert("정원을 입력하세요.");
			$('#capacity_String').focus();
			return false;
		}
		else if($('#capacity_String').val().replace(',','')>100){
			alert("정원은 최대 100명입니다.");
			$('#capacity_String').focus();
			return false;
		}

		
		/*센터명 예외처리 */
		if ($('#center_id').val() == "name") {
			alert("센터명을 선택하세요.");
			$('#center_id').focus();
			return false;
		}
		
		/*총강의일수 예외처리 */
		if ($('#lecture_totalday_String').val() == "") {
			alert("강의일수를 입력하세요.");
			$('#lecture_totalday_String').focus();
			return false;
		}else if($('#lecture_totalday_String').val().replace(',','')>500){
			alert("최대 강의일수는 500일입니다.");
			$('#capacity_String').focus();
			return false;
		}
		
		/*강의시간 예외처리 */
		if ($('#start').val() == "") {
			alert("강의시작시간을 입력하세요.");
			$('#start').focus();
			return false;
		}
		if ($('#end').val() == "") {
			alert("강의종료시간을 입력하세요.");
			$('#end').focus();
			return false;
		}
		else if ($('#end').val() <= $('#start').val() ) {
			alert("강의종료시간이 강의시작시간보다 이릅니다.");
			$('#end').focus();
			return false;
		}
		
		/*수강료 예외처리 */
		if ($('#tuition_fee_String').val() == "") {
			alert("수강료를 입력하세요.");
			$('#tuition_fee_String').focus();
			return false;
		}else if($('#tuition_fee_String').val().replace(',','')>10000000){
			alert("최대 수강료는 10,000,000원 입니다.");
			$('#tuition_fee_String').focus();
			return false;
		}
		
		/*강의내용 예외처리  */
		if (ckeditor1.getData()=="") {
			alert("강의 내용을 입력하세요.");
			ckeditor1.focus();
			return false;
		}else if(ckeditor1.getData().length>=1000){
			alert("1000자 이하로 입력해주세요.");
			ckeditor1.focus();
			return false;
		} 
		/*과목설명 예외처리  */
		if (ckeditor2.getData()=="") {
			alert("과목 설명을 입력하세요.");
			ckeditor2.focus();
			return false;
		}else if(ckeditor2.getData().length>=2000){
			alert("2000자 이하로 입력해주세요.");
			ckeditor2.focus();
			return false;
		} 
		/*학습목표 예외처리  */
		if (ckeditor3.getData()=="") {
			alert("학습 목표을 입력하세요.");
			ckeditor3.focus();
			return false;
		}else if(ckeditor3.getData().length>=2000){
			alert("2000자 이하로 입력해주세요.");
			ckeditor3.focus();
			return false;
		} 
		/*강의내용 예외처리  */
		if (ckeditor4.getData()=="") {
			alert("과목 특장점을 입력하세요.");
			ckeditor4.focus();
			return false;
		}else if(ckeditor4.getData().length>=2000){
			alert("2000자 이하로 입력해주세요.");
			ckeditor4.focus();
			return false;
		} 
		
		//수강 대상
		if ($('#lecture_target').val() == "") {
			alert("수강대상을 입력하세요.");
			$('#lecture_target').focus();
			return false;
		}
		$(window).off('beforeunload');
	});
});
</script>