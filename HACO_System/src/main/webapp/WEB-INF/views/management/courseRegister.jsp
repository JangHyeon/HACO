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
	value="course,courseRegister" />

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
				<div class="content-panel">

					<div class="pull-right topToggle">
						<a class="btn btn-success"
							href="${pageContext.request.contextPath}/management/courseInsert">
							과정 등록</a>
					</div>


					<h4>
						<i class="fa fa-angle-right"></i> 과정등록
					</h4>
					<hr>
					<table class="table">
						<thead>
							<tr>

								<th>강사명</th>
								<th>과목명</th>
								<th>과정명</th>
								<th>강의실</th>
								<th>과정시작일자/과정종료일자</th>
								<th>교육센터</th>
								<th>수정</th>
								<th>삭제</th>
							</tr>
						</thead>
						<tbody>
							<c:forEach var="role" items="${CourseList}">
								<tr>
									<td>${role.name_kor}</td>
									<td>${role.subject_name}</td>
									<td>${role.course_name}</td>
									<td>${role.classroom}</td>
									<td><fmt:formatDate value="${role.course_start_date}"
											pattern="yyyy-MM-dd" />~ <fmt:formatDate
											value="${role.course_end_date}" pattern="yyyy-MM-dd" /></td>
									<td>${role.location}</td>
									<td><a
										href="${pageContext.request.contextPath}/management/courseUpdate?id=${role.open_course_id}">
											<button class="btn btn-default btn-xs">
												<i class="fa fa-pencil"></i>
											</button>

									</a></td>
									<td>
										<button class="btntn btn btn-danger btn-xs" id="deletebtn"
											value="${role.open_course_id}">
											<i class="fa fa-trash-o "></i>
										</button>
									</td>

								</tr>
							</c:forEach>
						</tbody>

					</table>

					<div class="table-footer">

						<div class="col-xs-12">
							<!-- 페이징 -->
							<ul class="pagination pagination-centered">
								<!-- 이전 링크 -->
								<li <c:if test="${beginpage<10}"> class="disabled"</c:if>>
									<a
									<c:if test="${beginpage>10}"> href="${pageContext.request.contextPath}/management/courseRegister/pageSize/${pageSize}/pageNum/${beginpage-1}/searchType/${searchType}/searchKey/${searchKey}"</c:if>>«</a>
								</li>

								<!-- 페이지 리스트   -->
								<c:if test="${beginpage!=0}">
									<c:forEach var="i" begin="${beginpage}" end="${endpage}"
										step="1">

										<c:if test="${i==pageNum}">
											<li class="active"><a>${i} <span class="sr-only">(current)</span></a></li>
										</c:if>
										<c:if test="${i!=pageNum}">
											<li><a
												href="${pageContext.request.contextPath}/management/courseRegister/pageSize/${pageSize}/pageNum/${i}/searchType/${searchType}/searchKey/${searchKey}">${i}</a></li>
										</c:if>
									</c:forEach>
								</c:if>
								<!-- 다음링크 -->
								<li <c:if test="${endpage>=pagecount}"> class="disabled"</c:if>>
									<a
									<c:if test="${endpage<pagecount}"> href="${pageContext.request.contextPath}/management/courseRegister/pageSize/${pageSize}/pageNum/${endpage+1}/searchType/${searchType}/searchKey/${searchKey}"</c:if>>»</a>
								</li>
							</ul>
						</div>

						<!-- 검색 -->
						<div class="col-sm-6 col-sm-offset-3" style="clear: both">
							<div class="input-group">
								<div class="input-group-btn">
									<button id="searchType" type="button"
										class="btn btn-default dropdown-toggle" data-toggle="dropdown">
										<c:choose>
											<c:when test="${searchType=='name'}">
												<span>강사명 </span>
											</c:when>
											<c:when test="${searchType=='subject'}">
												<span>과목명 </span>
											</c:when>
											<c:when test="${searchType=='course'}">
												<span>과정명 </span>
											</c:when>
											<c:otherwise>
												<span>교육센터 </span>
											</c:otherwise>



										</c:choose>
										<span class="caret"></span>
									</button>
									<ul id="selectType" class="dropdown-menu" role="menu">
										<li id="name" value="name"><a>강사명</a></li>
										<li id="subject" value="subject"><a>과목명</a></li>
										<li id="course" value="course"><a>과정명</a></li>
										<li id="center" value="center"><a>교육센터</a></li>
									</ul>
								</div>
								<!-- /btn-group -->
								<input type="text" class="form-control" id="inputSearchKey"
									value='<c:if test="${searchKey!='[noKeyword]'}">${searchKey}</c:if>'>
								<span class="input-group-btn">
									<button class="btn btn-default" id="submitBtn" type="button">검색</button>
								</span>
							</div>
							<input type="hidden" name="searchKey" value="${searchKey}">
							<input type="hidden" name="pageNum" value="${pageNum}"> <input
								type="hidden" name="pageSize" value="${pageSize}"> <input
								type="hidden" name="searchType" value="${searchType}">
						</div>
					</div>
				</div>
			</div>
			<!-- /content-panel -->
		</div>
	</section>
</section>
<!--main content end-->



<!-- Modal -->
<div aria-hidden="true" aria-labelledby="myModalLabel" role="dialog"
	tabindex="-1" id="deleteModal" class="modal fade">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal"
					aria-hidden="true">&times;</button>
				<h4 class="modal-title">과목 삭제</h4>
			</div>
			<div class="modal-body">
		
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

<!-- inclue common script -->

<script src="${resourceUrl}/gazONojfL3/js/bootstrap.3.2.0.min.js"></script>
<%@ include file="commonScript.jsp"%>

<script>
	$(document)
			.ready(
					function() {
						var open_course_id;
						$('.btntn').on('click', function() {
							open_course_id = $(this).val();

							var json_data = $(this).val();
							$.ajax({
								type : 'POST',
								url : 'courseDeleteOk',
								data : 'json_data=' + json_data,
								dataType : "json",
								success : function(date) {
									alert('사용중인 과정명 입니다.');
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
											location.href = "${pageContext.request.contextPath}/management/courseDeleteOk?id="+open_course_id;
										});
						//검색 조건
						$('#selectType>li').on(
								'click',
								function() {
									$('#searchType>span:first-child').text(
											$('a', this).text());
									$('input[name=searchType]').val(
											$(this).attr('value'));
								});

						var submit = function() {
							if ($('input[name=searchKey]').val().length == 0) {
								alert('검색어를 입력해주세요.');
								$('#inputSearchKey').focus();
							} else {
								location.href = "${pageContext.request.contextPath}/management/courseRegister/pageSize/"
										+ $('input[name=pageSize]').val()
										+ "/pageNum/1/searchType/"
										+ $('input[name=searchType]').val()
										+ "/searchKey/"
										+ $('input[name=searchKey]').val();
							}
						}

						$('#submitBtn').on(
								'click',
								function() {
									$('input[name=searchKey]').val(
											$('#inputSearchKey').val());
									submit();
								});

						$('#inputSearchKey').on(
								'keypress',
								function(e) {
									if (e.keyCode == 13) {
										$('input[name=searchKey]').val(
												$('#inputSearchKey').val());
										submit();
									}
								});

						//페이지 사이즈
						$('#pageNum>li')
								.on(
										'click',
										function() {
											$('#pageBtn>span:first-child')
													.text(
															$('a', this).text()
																	+ " 보기");
											$('input[name=pageSize]').val(
													$(this).attr('value'));
											if ($('input[name=searchKey]')
													.val() != '[noKeyword]') {
												$('input[name=searchKey]').val(
														$('#inputSearchKey')
																.val());
											}
											submit();
										});

						// 글쓰기 페이지
						$('#writeBtn')
								.on(
										'click',
										function() {
											location.href = '${pageContext.request.contextPath}/management/courseInsert';
										});
					});
</script>





