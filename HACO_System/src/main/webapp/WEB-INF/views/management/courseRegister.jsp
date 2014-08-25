<%@page import="java.text.DateFormat"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="s" uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
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
								<th>seq</th>
								<th>강사명</th>
								<th>과정명</th>
								<th>강의실</th>
								<th>과정시작일자</th>
								<th>과정종료일자</th>
								<th>교육센터</th>
								<th>수정</th>
								<th>삭제</th>
							</tr>
						</thead>
						<tbody>
							<c:forEach var="role" items="${roleList}">
								<tr>
									<td>${role.open_course_id}</td>
									<td>${role.name_kor}</td>
									<td>${role.subject_name}</td>
									<td>${role.classroom}</td>
									<td><fmt:formatDate value="${role.course_start_date}"
											pattern="yyyy-MM-dd" /></td>
									<td><fmt:formatDate value="${role.course_end_date}"
											pattern="yyyy-MM-dd" /></td>
									<td>${role.location}</td>
									<td><a
										href="${pageContext.request.contextPath}/management/courseUpdate?id=${role.open_course_id}">
											<p>수정</p>
									</a></td>
									<td><a
										href="${pageContext.request.contextPath}/management/courseDeleteOk?id=${role.open_course_id}">
											<p>삭제</p>
									</a></td> 	
								</tr>
							</c:forEach>

						</tbody>

					</table>

					<%--test:${pageContext.request.contextPath}  --%>
					<a
						href="${pageContext.request.contextPath}/management/courseInsert">
						<p>등록</p>
					</a>
				</div>
				<!-- /content-panel -->
			</div>
			
		</div>
	</section>
</section>
<!--main content end-->



<!-- inclue common script -->
<%@ include file="commonScript.jsp"%>

<!--script for this page-->

</script>