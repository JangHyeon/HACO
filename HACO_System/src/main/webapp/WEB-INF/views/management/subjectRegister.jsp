<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="s" uri="http://www.springframework.org/security/tags"%>
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


<input id="current-accordion" type="hidden"
	value="course,subjectRegister" />

<!-- **********************************************************************************************************************************************************
      MAIN CONTENT
      *********************************************************************************************************************************************************** -->
<!--main content start-->

<section id="main-content">
	<section class="wrapper">
		<h3>
			<i class="fa fa-angle-right"></i> 서브페이지 샘플
		</h3>
		<h5>
			<a href="http://fontawesome.io/icons/" target="_blank">- aside
				아이콘 정보</a>
		</h5>
		<div class="row">

			<div class="col-md-12">
				<div class="content-panel">
					<h4>
						<i class="fa fa-angle-right"></i> 과목등록
					</h4>
					<hr>
					<table class="table">
						<thead>
							<tr>	
								<th>하악</th>
								<th>과목명</th>
								<th>총강의일수</th>
								<th>총강의시간</th>
								<th>강의시간</th>
								<th>수강대상</th>
								<th>모집인원</th>
								<th>수강료</th>
								<th>수정</th>
								<th>삭제</th>
							</tr>
						</thead>
						<tbody>
							<c:forEach var="role" items="${roleList}">
								<tr>
									<td>${role.subject_id}</td>
									<td>${role.subject_name}</td>
									<td>${role.lecture_totalday}</td>
									<td>${role.lecture_totaltime}</td>
									<td>${role.lecture_time}</td>
									<td>${role.lecture_target}</td>
									<td>${role.capacity}</td>
									<td>${role.tuition_fee}</td>
									<td><a
										href="${pageContext.request.contextPath}/management/Register4?id=${role.subject_id}">
											<p>수정</p>
									</a></td>
									<td><a
										href="${pageContext.request.contextPath}/management/Register2">
											<p>삭제</p>
									</a></td>
								</tr>
							</c:forEach>

						</tbody>

					</table>
					<%--test:${pageContext.request.contextPath}  --%>
					<a href="${pageContext.request.contextPath}/management/Register2">
						<p>등록</p>
					</a>
				</div>
				<!-- /content-panel -->
			</div>
			<%-- <!-- /col-md-12 -->

			<div class="col-md-12 mt">
				<div class="content-panel">
					<table class="table table-hover">
						<h4>
							<i class="fa fa-angle-right"></i> Hover Table
						</h4>
						<hr>
						<thead>
							<tr>
								<th>#</th>
								<th>권한</th>
								<th>설명</th>
								<th>생성일시</th>
							</tr>
						</thead>
						<tbody>
							<c:forEach var="role" items="${roleList}">
								<tr>
									<td>${role}</td>
									<td>${role.role_name}</td>
									<td>${role.role_desc}</td>
									<td>${role.create_date}</td>
								</tr>
							</c:forEach>
						</tbody>
					</table>
				</div>
				<!--/content-panel -->
			</div>
			<!-- /col-md-12 -->
		</div>
		<!-- row -->

		<div class="row mt">
			<div class="col-md-12">
				<div class="content-panel">
					<table class="table table-striped table-advance table-hover">
						<h4>
							<i class="fa fa-angle-right"></i> Advanced Table
						</h4>
						<hr>
						<thead>
							<tr>
								<th><i class="fa fa-bullhorn"></i> Company</th>
								<th class="hidden-phone"><i class="fa fa-question-circle"></i>
									Descrition</th>
								<th><i class="fa fa-bookmark"></i> Profit</th>
								<th><i class=" fa fa-edit"></i> Status</th>
								<th></th>
							</tr>
						</thead>
						<tbody>
							<tr>
								<td><a href="basic_table.html#">Company Ltd</a></td>
								<td class="hidden-phone">Lorem Ipsum dolor</td>
								<td>12000.00$</td>
								<td><span class="label label-info label-mini">Due</span></td>
								<td>
									<button class="btn btn-success btn-xs">
										<i class="fa fa-check"></i>
									</button>
									<button class="btn btn-primary btn-xs">
										<i class="fa fa-pencil"></i>
									</button>
									<button class="btn btn-danger btn-xs">
										<i class="fa fa-trash-o "></i>
									</button>
								</td>
							</tr>
							<tr>
								<td><a href="basic_table.html#"> Dashgum co </a></td>
								<td class="hidden-phone">Lorem Ipsum dolor</td>
								<td>17900.00$</td>
								<td><span class="label label-warning label-mini">Due</span></td>
								<td>
									 
									<button class="btn btn-primary btn-xs">
										<i class="fa fa-pencil"></i>
									</button>
									<button class="btn btn-danger btn-xs">
										<i class="fa fa-trash-o "></i>
									</button>
								</td>
							</tr>
							<tr>
								<td><a href="basic_table.html#"> Another Co </a></td>
								<td class="hidden-phone">Lorem Ipsum dolor</td>
								<td>14400.00$</td>
								<td><span class="label label-success label-mini">Paid</span></td>
								<td>
									<button class="btn btn-success btn-xs">
										<i class="fa fa-check"></i>
									</button>
									<button class="btn btn-primary btn-xs">
										<i class="fa fa-pencil"></i>
									</button>
									<button class="btn btn-danger btn-xs">
										<i class="fa fa-trash-o "></i>
									</button>
								</td>
							</tr>
							<tr>
								<td><a href="basic_table.html#"> Dashgum ext </a></td>
								<td class="hidden-phone">Lorem Ipsum dolor</td>
								<td>22000.50$</td>
								<td><span class="label label-success label-mini">Paid</span></td>
								<td>
									<button class="btn btn-success btn-xs">
										<i class="fa fa-check"></i>
									</button>
									<button class="btn btn-primary btn-xs">
										<i class="fa fa-pencil"></i>
									</button>
									<button class="btn btn-danger btn-xs">
										<i class="fa fa-trash-o "></i>
									</button>
								</td>
							</tr>
							<tr>
								<td><a href="basic_table.html#">Total Ltd</a></td>
								<td class="hidden-phone">Lorem Ipsum dolor</td>
								<td>12120.00$</td>
								<td><span class="label label-warning label-mini">Due</span></td>
								<td>
									<button class="btn btn-success btn-xs">
										<i class="fa fa-check"></i>
									</button>
									<button class="btn btn-primary btn-xs">
										<i class="fa fa-pencil"></i>
									</button>
									<button class="btn btn-danger btn-xs">
										<i class="fa fa-trash-o "></i>
									</button>
								</td>
							</tr>
						</tbody>
					</table>
				</div>
				<!-- /content-panel -->
			</div>
			<!-- /col-md-12 -->
		</div>
		<!-- /row --> --%>
	</section>
</section>





<!--main content end-->



<!-- inclue common script -->
<%@ include file="commonScript.jsp"%>

<!--script for this page-->

<script>
	//custom select box

	$(function() {

	});
</script>

