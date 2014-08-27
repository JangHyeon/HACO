<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="s" uri="http://www.springframework.org/security/tags"%>


<!DOCTYPE html>

<input id="current-accordion" type="hidden"
	value="course,subjectRegister" />

<!--external css-->

<link
	href="${pageContext.request.contextPath}/resources/assets/font-awesome/css/font-awesome.css"
	rel="stylesheet" />
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/resources/assets/js/gritter/css/jquery.gritter.css" />

<!-- Custom styles for this template -->
<link
	href="${pageContext.request.contextPath}/resources/assets/css/style.css"
	rel="stylesheet">
<link
	href="${pageContext.request.contextPath}/resources/assets/css/style-responsive.css"
	rel="stylesheet">

<link rel="stylesheet" type="text/css" media="screen"
	href="${pageContext.request.contextPath}/resources/assets/css/bootstrap-datetimepicker.min.css 	">

<link rel="stylesheet"
	href="//code.jquery.com/ui/1.11.1/themes/smoothness/jquery-ui.css">
<link rel="stylesheet" href="/resources/demos/style.css">

<input id="current-accordion" type="hidden"
	value="course,subjectRegister" />

<!-- **************************	********************************************************************************************************************************
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
						<i class="fa fa-angle-right"></i> 과정등록
					</h4>
						<form class="form-horizontal style-form" action="courseInsertOk" id="insertsubject" method="get">
				 	강사명:<input type="text" name="name" id="tags">
					
						 	<select id ="selectCenter" name="center_id">
								<option value="">교육센터명</option>
								<c:forEach var="Center" items="${Center}">
									<option value="${Center.center_id}">${Center.location}</option>
								</c:forEach>
							</select>
									
							<select id ="selectClassroom" name="center_classroom_id">
								<option value="">강의실</option>
							</select>
						
						<select name="subject_id">
								<option value="">과목명</option>
								<c:forEach var="Subject" items="${Subject}">
									<option value="${Subject.subject_id}">${Subject.subject_name}</option>
								</c:forEach>
							</select>
						 과정명 <input type="text" name="course_name">
						
			 시작일:<input type="date" name="course_start_date"/>
			종료일:<input type="date" name="course_end_date"/> 
			<button class="btn btn-warning"   type="submit">등록</button> 
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
  <script src="//code.jquery.com/ui/1.11.1/jquery-ui.js"></script>
 
<!--script for this page-->

<script type="text/javascript">
	$(function() {

		$("#tags").on('keyup', function() {
			var date2 = [];
			var json_data = $(this).val();
			// alert("test2");
			$.ajax({
				type : 'POST',
				url : 'test',
				data : 'json_data=' + json_data,
				dataType : "json",
				success : function(date) {
				for (var i = 0; i < date.t.length; i++) {
					date2.push(date.t[i].name_kor);
				} 
				  $("#tags").autocomplete({
						source : date2
					});
				},
				error : function() {
				}
			});
		});

		$("#selectCenter").change(
				function() {
					//alert($(this).val());
					var json_data = $(this).val();
					$.ajax({	
						type : 'POST',
						url : 'courseInsert',
						data : 'json_data=' + json_data,
						dataType : "json",
						success : function(date) {
							//alert("testing:start");//mt
							var selectClassroom = document
									.getElementById("selectClassroom");

							$("#selectClassroom option").remove();

							var option1 = document.createElement("option");
							option1.innerText = "강의실";
							selectClassroom.appendChild(option1);

							for (i = 0; i < date.t.length; i++) {
								var option = document.createElement("option");
								option.innerText = date.t[i].classroom;
							//	option.attr("value",date.t[i].center_classroom_id);	
								selectClassroom.appendChild(option);
						      $("#selectClassroom option").eq(i+1).attr("value",date.t[i].center_classroom_id);	
							}
							//alert("testing:end");
						},
						error : function() {

							$("#selectClassroom option").remove();
						}

					});
				});

		$("#selectClassroom").change(function() {
			//alert($("#selectClassroom option:selected").val());
		});

	});
</script>
