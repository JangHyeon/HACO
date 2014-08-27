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

<!-- Begin Body -->
<h1>과정설명</h1>
<section id="main-content">
 	<section class="wrapper site-min-height">
 		<div class="row mt">
			<div class="col-md-12">
				<div class="content-panel">
					<table class="table table-striped table-advance table-hover">
						<tr>
							<th>과정명</th>
									<td>${sbj.course_name }</td>
						</tr>
						<tr>
							<th>강사명</th>
									<td>${sbj.name_kor }</td>
						</tr>
						<tr>
							<th>교육기간</th>
									<td>${sbj.course_start_date} ~ ${sbj.course_end_date}</td>
						</tr>
						<tr>
							<th>교육시간</th>
									<td>${sbj.lecture_time_start} ~ ${sbj.lecture_time_end}</td>
						</tr>
						<tr>
							<th>교육비용</th>
									<td>${sbj.tuition_fee}</td>
						</tr>
						<tr>
							<th>교육장</th>
									<td>${sbj.location}</td>
						</tr>
						<tr>
							<th>현재인원 / 정원</th>
									<td>${sbj.CNT} /
										${sbj.capacity } </td>
						</tr>
						<tr>
							<th>과정개요</th>
									<td>${sbj.lecture_content}</td>
						</tr>
						<tr colspan="2" align="center">
							<td>${member.name}님의 수강신청이 완료 되었습니다.</td>
						</tr>
					</table>
				</div>
			</div>
		</div>
	</section>
</section>
<!-- script references -->
<script	src="${resourceUrl}/gazONojfL3/js/jquery.1.9.1.min.js"></script>
<script	src="${resourceUrl}/gazONojfL3/js/bootstrap.3.2.0.min.js"></script>

<script>
$(document).ready(function(){
	$('#selectType>li').on('click',function(){
		$('#searchType>span:first-child').text($('a',this).text());
		$('input[name=searchType]').val($(this).attr('value'));
	});
});

</script>