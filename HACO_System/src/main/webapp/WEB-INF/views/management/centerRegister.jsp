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


<input id="current-accordion" type="hidden"
	value="course,centerRegister" />

<!-- **********************************************************************************************************************************************************
      MAIN CONTENT
      *********************************************************************************************************************************************************** -->
<!--main content start-->

<section id="main-content">
	<section class="wrapper">
		<h3>
			<i class="fa fa-angle-right"></i> 과정
		</h3>

		<div class="row">
			<div class="col-md-12">
				<div class="content-panel pull">
 
					<div class="col-md-6">
						<div class="pull-right topToggle">
						<input type="text" id="newcenter">
							<a class="btn btn-success" id="test">
								센터 등록</a>
						</div>
						<h4>
							<i class="fa fa-angle-right"></i> 교육센터등록
						</h4>
						<div>
							<table class="table">
								<thead>
									<tr>

										<th>center_id</th>
										<th>location</th>
										<th>삭제</th>
									</tr>
								</thead>
								<tbody>
									<c:forEach var="Center" items="${Center}">


										<tr>

											<td><input type="hidden" value="${Center.center_id}"
												id="centerId">${Center.center_id}</td>
											<td><a
												href="${pageContext.request.contextPath}/management/classroomList?id=${Center.center_id}">
													${Center.location} </a></td>
											<td>
												<button class="btntn btn btn-danger btn-xs" id="deletebtn"
													value="${Center.center_id}">
													<i class="fa fa-trash-o "></i>
												</button>
											</td>

										</tr>
									</c:forEach>
								</tbody>
							</table>
						</div>
					</div>

					<div class="col-md-6">비어놈</div>
				</div>
			</div>
		</div>
	</section>
</section>



<!-- Modal -->
<div aria-hidden="true" aria-labelledby="myModalLabel" role="dialog"
	tabindex="-1" id="deleteModal" class="modal fade">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal"
					aria-hidden="true">&times;</button>
				<h4 class="modal-title">교육센터 삭제</h4>
			</div>
			<div class="modal-body">
				<p>응슷응</p>
				<h3>
					<Strong id="resultID">이 과목을 삭제하시겠습니까?</Strong>
				</h3>

			</div>
			<div class="modal-footer">
				<button id="deleteModalCloseBtn" data-dismiss="modal"
					class="btn btn-default" type="button">닫기</button>
				<button id="ModalDeletebtn" class="btn btn-danger" type="button">삭제</button>

			</div>
		</div>
	</div>
</div>
<!-- modal -->

<script src="${resourceUrl}/gazONojfL3/js/bootstrap.3.2.0.min.js"></script>
<%@ include file="commonScript.jsp"%>

<script>
	$(document)
			.ready(
					function() {
						
						$('#test').on('click', function() {
							location.href = "${pageContext.request.contextPath}/management/centerinsertOk?location="+$("#newcenter").val();
					});
						
						var centerId;
						$('.btntn').on('click', function() {
							centerId = $(this).val();

							var json_data = $(this).val();
							$.ajax({
								type : 'POST',
								url : 'centerdeleteOk',
								data : 'json_data=' + json_data,
								dataType : "json",
								success : function(date) {
									alert('검색어를 입력해주세요.' + date);

								},
								error : function() {
									$('#deleteModal').modal('show');
								}
							});

						});

						$('#ModalDeletebtn')
								.on(
										'click',
										function() {
											location.href = "${pageContext.request.contextPath}/management/centerdeleteOk?id="
													+ centerId;
										});
					});
</script>
