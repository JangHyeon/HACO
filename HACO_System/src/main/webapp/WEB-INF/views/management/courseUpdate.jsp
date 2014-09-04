<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="s" uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
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
	href="${resourceUrl}/assets/js/gritter/css/jquery.gritter.css" />

<!-- Custom styles for this template -->
<link href="${resourceUrl}/assets/css/style.css" rel="stylesheet">
<link href="${resourceUrl}/assets/css/style-responsive.css"
	rel="stylesheet">
<link rel="stylesheet" type="text/css" media="screen"
	href="${resourceUrl}/assets/css/bootstrap-datetimepicker.min.css 	">
	
	
<input id="current-accordion" type="hidden"
	value="course,courseRegister" />

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
						<i class="fa fa-angle-right"></i> 과정등록-수정
					</h4>
					<form class="form-horizontal style-form" action="courseUpdateOk"
						id="courseUpdateOk" method="get">
						<c:forEach var="role" items="${roleList}">
							<input type="hidden" name="open_course_id" value="${role.open_course_id}">
							<input type="hidden" name="account_id" value="${role.account_id}">
							<input type="hidden" name="subject_id" value="${role.subject_id}">
							<input type="hidden" id="subject_name" value="${role.subject_name}">
							<input type="hidden" id=center_classroom_id1 value="${role.center_classroom_id}">
							<input type="hidden" id="center_id1" value="${role.center_id}">

								<fmt:formatDate value="${role.course_start_date}" var="start2" pattern="yyyy-MM-dd"/>
							
								<fmt:formatDate value="${role.course_end_date}" var="end2" pattern="yyyy-MM-dd"/>
							
							<div class="form-group">
								<label class="col-md-2 col-sm-2 control-label">강사명</label>
								<div class="col-md-4 col-sm-4">
									<input type="text" name="name_kor" class="form-control"
										value="${role.name_kor}" disabled="disabled">
								</div>
								<label class="col-md-2 col-sm-2 control-label">시작시간/종료시간</label>
								<div class="col-md-2 col-sm-2">
									<input type="date" name="start"
									value=${start2}	id="course_start_date" class="form-control"/>
								</div>
								<div class="col-md-2 col-sm-2">
									<input type="date" name="end" id="course_end_date"
									value=${end2}	class="form-control"/>
								</div>
							</div>

							<div class="form-group">
								<label class="col-md-2 col-sm-2 control-label">센터명/강의실</label>
								<div class="col-md-2 col-sm-2">
									<select class="form-control" id="selectCenter" name="center_id">
										<!-- <option>교육센터 명</option> -->
										<c:forEach var="centerchild" items="${Center}">
											<c:if test="${centerchild.center_id==role.center_id}">
												<option value="${centerchild.center_id}" selected="selected">${centerchild.location}</option>
											</c:if>
											<c:if test="${centerchild.center_id!=role.center_id}">
												<option value="${centerchild.center_id}">${centerchild.location}</option>
											</c:if>
										</c:forEach>
									</select>
								</div>
								<div class="col-md-2 col-sm-2">
									<select class="form-control" id="selectClassroom"
										name="center_classroom_id">
										<option value="">강의실</option>
									</select>
								</div>
								<label class="col-md-2 col-sm-2 control-label">과목명</label>
								<div class="col-md-4 col-sm-4">
									<input class="form-control" type="text" name="subject_id"
										value="${role.subject_name}" disabled="disabled">
									
								</div>
							</div>
							<div class="form-group">
								<label class="col-md-2 col-sm-2 control-label">과정명</label>
								<div class="col-md-10 col-sm-10">
									<input type="text" name="course_name" id="course_name"
										class="form-control" value="${role.course_name}">
								</div>
							</div>
							<button class="btn btn-warning" id="submitBtn" type="button">수정</button>
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
	         var json_data = $('#selectCenter').val();
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
		                     $("#selectClassroom option").eq(0).attr("value","");
		                     for (var i = 0; i < date.t.length; i++) {
		                        var option = document.createElement("option");
		                        option.innerText = date.t[i].classroom;
		                        selectClassroom.appendChild(option);
		                        $("#selectClassroom option").eq(i+1).attr("value",date.t[i].center_classroom_id);   
		                     }
		                    $("#selectClassroom").val($("#center_classroom_id1").val()).attr("selected", "selected");

		                  },
		                  error : function() {

		                     $("#selectClassroom option").remove();
		                  }

		               });
		            
		///////////////////////////////////////////////////// 
		 $("#selectCenter").change(
            function() {
                
               var json_data = $('#selectCenter').val();
          
               $.ajax({   
                  type : 'POST',
                  url : 'courseInsert',
                  data : 'json_data=' + json_data,
                  dataType : "json",
                  success : function(date) {
                      var selectClassroom = document
                           .getElementById("selectClassroom");

                     $("#selectClassroom option").remove();

                     var option1 = document.createElement("option");
                     option1.innerText = "강의실";
                     selectClassroom.appendChild(option1);
                     $("#selectClassroom option").eq(0).attr("value","");
                     for (var i = 0; i < date.t.length; i++) {
                        var option = document.createElement("option");
                        option.innerText = date.t[i].classroom; 
                        selectClassroom.appendChild(option);
                        $("#selectClassroom option").eq(i+1).attr("value",date.t[i].center_classroom_id);   
                     }
                  },
                  error : function() {

                     $("#selectClassroom option").remove();
                  }

               });
           }); 

		 $('#submitBtn').on('click', function() {
				$('#courseUpdateOk').submit();
			});

			$('#courseUpdateOk').submit(
					function() {
						if ($('#selectClassroom').val() == ""){
							alert("강의실을 입력하세요.");
							$('#selectClassroom').focus();
							return false;
						} 
		
		
  
						   
					   }); 
   });
</script>