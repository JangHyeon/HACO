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

<%@ include file="inc/curriculum.jsp" %>

<!-- Begin Body -->
<div class="container">
	<div class="no-gutter row">
		<!-- right content column-->
		<div class="col-md-12" id="content">
			<div class="panel">
				<ol class="breadcrumb">
				  <li class="active">과정설명</li>
				</ol>
				
				<!-- Main Content -->
				<div class="panel-body">
					<div class="form-panel">
						<div class="form-group">
                              <label class="col-sm-2 col-md-2 control-label">과정명</label>
                              <div class="col-sm-10 col-md-10">${sbj.course_name}</div>
                        </div>
						<div class="form-group">
							  <label class="col-sm-2 col-md-2 control-label">강사명</label>
                              <div class="col-sm-10 col-md-10">${sbj.name_kor}</div>
                        </div>
                        <div class="form-group">
                       		  <label class="col-sm-2">교육기간</label>
                              <div class="col-sm-10">${sbj.course_start_date} ~ ${sbj.course_end_date}</div>
                        </div>
                        <div class="form-group">
                       		  <label class="col-sm-2">교육시간</label>
                              <div class="col-sm-10">${sbj.lecture_time_start} ~ ${sbj.lecture_time_end}</div>
                        </div>
                        <div class="form-group">
                       		  <label class="col-sm-2">교육비용</label>
                              <div class="col-sm-10">${sbj.tuition_fee}</div>
                        </div>
                        <div class="form-group">
                       		  <label class="col-sm-2">교육장</label>
                              <div class="col-sm-10">${sbj.location}</div>
                        </div>
                        <div class="form-group">
                       		  <label class="col-sm-2">현재인원 / 정원</label>
                              <div class="col-sm-10">${sbj.CNT} / ${sbj.capacity}</div>
                        </div>
                        <div class="form-group">
                       		  <label class="col-sm-2">과정개요</label>
                              <div class="col-sm-10">${sbj.lecture_content}</div>
                        </div>
                         <div class="form-group">
                         	<label class="col-sm-12">${member.name}님의 수강신청이 완료 되었습니다.</label>
                         </div>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>
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