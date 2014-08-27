<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="s" uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>


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
						<form class="form-horizontal style-form" action="courseUpdateOk" id="insertsubject" method="get">
							<c:forEach var="role" items="${roleList}">
							<input type="hidden" name="open_course_id" value="${role.open_course_id}">
							<input type="hidden" name="account_id" value="${role.account_id}">
							<input type="hidden" name="subject_id" value="${role.subject_id}">
					
							강사명:<input type="text" name="name_kor" value="${role.name_kor}" disabled="disabled">

							<input type="hidden" id="subject_name" value="${role.subject_name}">

						 	<select id ="selectCenter" name="center_id">
								<option value="">교육센터	명</option>
								<c:forEach var="Center" items="${Center}">
									<option value="${Center.center_id}">${Center.location}</option>
								</c:forEach>
							</select>
							<select id ="selectClassroom" name="center_classroom_id">
								<option value="">강의실</option>
							</select>
						
						<select name="course_name">
									<option value="${role.subject_name}" selected >${role.subject_name}</option>
								
							</select>
								
						 과정명 <input type="text" name="course_name" value="${role.course_name}">
			 시작일:<input type="date" name="start" value="${role.course_start_date}" disabled="disabled"/>
			종료일:<input type="date" name="end" value="${role.course_end_date}" disabled="disabled"/> 
			<button class="btn btn-warning"   type="submit">등록</button>
			</c:forEach> 
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

<script type="text/javascript">
	$(function() {

	

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
