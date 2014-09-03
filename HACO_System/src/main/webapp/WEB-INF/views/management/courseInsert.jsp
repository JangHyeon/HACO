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

<input id="current-accordion" type="hidden"
	value="course,subjectRegister" />

<!--external css-->

<link href="${resourceUrl}/assets/font-awesome/css/font-awesome.css"
	rel="stylesheet" />
<link rel="stylesheet" type="text/css"
	href="${resourceUrl}/assets/js/gritter/css/jquery.gritter.css" />

<!-- Custom styles for this template -->
<link href="${resourceUrl}/assets/css/style.css" rel="stylesheet">
<link href="${resourceUrl}/assets/css/style-responsive.css"
	rel="stylesheet">

<link rel="stylesheet" type="text/css" media="screen"
	href="${resourceUrl}/assets/css/bootstrap-datetimepicker.min.css    ">

<link rel="stylesheet"
	href="//code.jquery.com/ui/1.11.1/themes/smoothness/jquery-ui.css">
<link rel="stylesheet" href="/resources/demos/style.css">

<input id="current-accordion" type="hidden"
	value="course,subjectRegister" />

<!-- **********************************************************************************************************************************************************
      MAIN CONTENT
      *********************************************************************************************************************************************************** -->
<!--main content start-->
<section id="main-content">
	<section class="wrapper">
		<h3>
			<i class="fa fa-angle-right"></i>과정등록
		</h3>

		<!-- BASIC FORM ELELEMNTS -->
		<div class="row mt">
			<div class="col-lg-12">
				<div class="form-panel">
					<h4 class="mb">
						<i class="fa fa-angle-right"></i> 과정등록-등록
					</h4>
					<form class="form-horizontal style-form" action="courseInsertOk"
						id="courseInsertOk" method="get">
						<input type="hidden" name="name2" id="name2">
						<div class="form-group">
							<label class="col-md-2 col-sm-2 control-label">강사명</label>
							<div class="col-md-4 col-sm-4">
								<input class="form-control" type="text" name="name" id="tags">
							</div>
							<label class="col-md-2 col-sm-2 control-label">시작시간/종료시간</label>
							<div class="col-md-2 col-sm-2">
								<input type="date" name="course_start_date"
									id="course_start_date" class="form-control" />
							</div>
							<div class="col-md-2 col-sm-2">
								<input type="date" name="course_end_date" id="course_end_date"
									class="form-control" />
							</div>
						</div>
						<div class="form-group">
							<label class="col-md-2 col-sm-2 control-label">센터명/강의실</label>
							<div class="col-md-2 col-sm-2">
								<select class="form-control" id="selectCenter" name="center_id">
									<option value="novalue">교육센터명</option>
									<c:forEach var="Center" items="${Center}">
										<option value="${Center.center_id}">${Center.location}</option>
									</c:forEach>
								</select>
							</div>
							<div class="col-md-2 col-sm-2">
								<select class="form-control" id="selectClassroom"
									name="center_classroom_id">
									<option value="novalue">강의실</option>
								</select>
							</div>
							<label class="col-md-2 col-sm-2 control-label">과목명</label>
							<div class="col-md-4 col-sm-4">
								<select name="subject_id" class="form-control" id="subject_id">
									<option value="novalue">과목명</option>
									<c:forEach var="Subject" items="${Subject}">
										<option value="${Subject.subject_id}">${Subject.subject_name}</option>
									</c:forEach>
								</select>
							</div>
						</div>
						<div class="form-group">
							<label class="col-md-2 col-sm-2 control-label">과정명</label>
							<div class="col-md-10 col-sm-10">
								<input type="text" name="course_name" id="course_name"
									class="form-control">
							</div>
						</div>
						<button class="btn btn-warning" id="submitBtn" type="button">등록</button>
					</form>
				</div>
			</div>
		</div>
	</section>
</section>


<!--main content end-->



<!-- inclue common script -->
<%@ include file="commonScript.jsp"%>





<!--script for this page-->
<script src="//code.jquery.com/ui/1.11.1/jquery-ui.js"></script>

<!--script for this page-->

<script type="text/javascript">
	$(function() {

		$('#Btn').on('click', function() {
			$('#insertModal').modal('show');
		});

		$("#tags").on(
				'keyup',
				function() {
					var date2 = [];
					var json_data = $(this).val();
					// alert("test2");
					$.ajax({
						type : 'POST',
						url : 'test',
						data : 'json_data=' + json_data,
						dataType : "json",
						success : function(date) {
							for (var i = 0; i < date.auto.length; i++) {
								date2.push(date.auto[i].account_id + "/"
										+ date.auto[i].name_kor);	
							}
							$("#tags").autocomplete({
								source : date2
							});
						},
						error : function() {
							
						}
					});
				});

		$("#tags").on('blur', function() {
			$("#name2").val($("#tags").val().split("/",1));
		});


		$("#selectCenter")
				.change(
						function() {
							//alert($(this).val());
							var json_data = $(this).val();
							$
									.ajax({
										type : 'POST',
										url : 'courseInsert',
										data : 'json_data=' + json_data,
										dataType : "json",
										success : function(date) {
											//alert("testing:start");//mt
											var selectClassroom = document
													.getElementById("selectClassroom");

											$("#selectClassroom option")
													.remove();

											var option1 = document
													.createElement("option");
											option1.innerText = "강의실";
											selectClassroom
													.appendChild(option1);

											for (var i = 0; i < date.t.length; i++) {
												var option = document
														.createElement("option");
												option.innerText = date.t[i].classroom;
												selectClassroom.appendChild(option);
												$("#selectClassroom option").eq(0).attr("value",'novalue');
												$("#selectClassroom option").eq(i + 1).attr("value",date.t[i].center_classroom_id);
											}
										},
										error : function() {

											$("#selectClassroom option")
													.remove();
										}

									});
						});

		$("#selectClassroom").change(function() {
			alert($("#selectClassroom option:selected").val());
		});

		$('#submitBtn').on('click', function() {
			$('#courseInsertOk').submit();
		});

		$('#courseInsertOk').submit(
				function() {

					/*강사명 예외처리 */
					if ($('#tags').val() == "") {
						alert("강사명을 입력하세요.");
						$('#tags').focus();
						return false;
					} else if ($('#tags').val().length > 10) {
						alert("강사명은 10자 이하로 입력하세요.");
						$('#tags').focus();
						return false;
					}

					/*시작종료일시 예외처리 */
					if ($('#course_start_date').val() == "") {
						alert("시작일을 입력하세요.");
						$('#course_start_date').focus();
						return false;
					}
					if ($('#course_end_date').val() == "") {
						alert("종료일을 입력하세요.");
						$('#course_end_date').focus();
						return false;
					} else if ($('#course_start_date').val() >= $(
							'#course_end_date').val()) {
						alert("종료일이 시작일보다 빠릅니다.");
						$('#course_end_date').focus();
						return false;
					}

					/*센터명 예외처리 */
					if ($('#selectCenter').val() == "novalue") {
						alert("센터명을 선택하세요.");
						$('#selectCenter').focus();
						return false;
					} /*강의실 예외처리 */
					if ($('#selectClassroom').val() == "novalue") {
						alert("강의실을 선택하세요.");
						$('#selectClassroom').focus();
						return false;
					}

					/*과목명 예외처리 */
					if ($('#subject_id').val() == "novalue") {
						alert("과목명을 선택하세요.");
						$('#subject_id').focus();
						return false;
					}
					/*과정명 예외처리 */
					if ($('#course_name').val() == "") {
						alert("과정명을 입력하세요.");
						$('#course_name').focus();
						return false;
					} else if ($('#course_name').val().length >= 20) {
						alert("50자이내로 입력하세요.");
						$('#course_name').focus();
						return false;
					}
				});

	});

	
</script>