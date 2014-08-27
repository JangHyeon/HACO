<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="s" uri="http://www.springframework.org/security/tags"%>
<%@ page import="kr.co.haco.VO.StudentVO" %>
<!-- Begin Body -->
<h1>과정설명</h1>
<script type="text/javascript">
	function course_write(opid){
		document.lecturesuccess.opid.value =opid;
		document.lecturesuccess.submit();
	}
</script>
<section id="main-content">
 	<section class="wrapper site-min-height">
		<form id="lecturesuccess" name="lecturesuccess" action="lecturesuccess" method="get">
	 		<div class="row mt">
				<div class="col-md-12">
					<div class="content-panel">
						<table class="table table-striped table-advance table-hover">
							<tr>
								<th>과정명</th>
										<td>${getCNT.course_name}<input type="hidden" name="course_name" value="${getCNT.course_name }"/></td>
							</tr>
							<tr>
								<th>강사명</th>
										<td>${getCNT.name_kor}<input type="hidden" name="name_kor" value="${getCNT.name_kor }"/></td>
							</tr>
							<tr>
								<th>교육기간</th>
										<td>${getCNT.course_start_date}<input type="hidden" name="course_start_date" value="${getCNT.course_start_date }"/>
										 ~ ${getCNT.course_end_date}<input type="hidden" name="course_end_date" value="${getCNT.course_end_date }"/></td>
							</tr>
							<tr>
								<th>교육시간</th>
										<td>${getCNT.lecture_time_start}<input type="hidden" name="lecture_time_start" value="${getCNT.lecture_time_start }"/>
										 ~ ${getCNT.lecture_time_end}<input type="hidden" name="lecture_time_end" value="${getCNT.lecture_time_end }"/></td>
							</tr>
							<tr>
								<th>교육비용</th>
										<td>${getCNT.tuition_fee}<input type="hidden" name="tuition_fee" value="${getCNT.tuition_fee }"/></td>
							</tr>
							<tr>
								<th>교육장</th>
										<td>${getCNT.location}<input type="hidden" name="location" value="${getCNT.location }"/></td>
							</tr>
							<tr>
								<th>현재인원 / 정원</th>
										<td>${getCNT.CNT}<input type="hidden" name="CNT" value="${getCNT.CNT }"/>
										 / ${getCNT.capacity}<input type="hidden" name="capacity" value="${getCNT.capacity}"/> </td>
							</tr>
							<tr>
								<th>과정개요</th>
										<td>${getCNT.lecture_content}<input type="hidden" name="lecture_content" value="${getCNT.lecture_content }"/></td>
							</tr>
							
							<tr>
								<td align="center" colspan="2"><input type="button" value="수강신청" onclick="course_write('${getCNT.open_course_id}')"></td>
							</tr>
						</table>
					</div>
				</div>
			</div>
			<input type="hidden" name="opid" id="opid" value=""/>
			<input type="hidden" name="name" value="${getCNT.name}"/>
			<input type="hidden" name="account_id" value="${getCNT.account_id}"/>
		</form>
	</section>
</section>
<!-- script references -->
<script	src="${pageContext.request.contextPath}/resources/gazONojfL3/js/jquery.1.9.1.min.js"></script>
<script	src="${pageContext.request.contextPath}/resources/gazONojfL3/js/bootstrap.3.2.0.min.js"></script>

<script>
$(document).ready(function(){
	$('#selectType>li').on('click',function(){
		$('#searchType>span:first-child').text($('a',this).text());
		$('input[name=searchType]').val($(this).attr('value'));
	});
});

</script>