<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="s" uri="http://www.springframework.org/security/tags"%>
<%@ page import="kr.co.haco.VO.OpenCourse" %>
<%@ page import="kr.co.haco.VO.Subject" %>
<!-- Begin Body -->
<h1>과정목록</h1>
<script type="text/javascript">
	function course_sel(opid){
		document.lecture.opid.value =opid;
		document.lecture.submit();
	}
</script>
<section id="main-content">
 	<section class="wrapper site-min-height">
			<div class="row mt">
                  <div class="col-md-12">
                      <div class="content-panel">
                          <table class="table table-striped table-advance table-hover">
	                  	  	  <h4><i class="fa fa-angle-right"></i>과정목록</h4>
	                  	  	  <hr>
                              <thead>
                     			<tr>
									<th width="50">center</th>
									<th width="270">제목</th>
									<th width="60">강사명</th>
									<th width="240">기간</th>
									<th width="80">현재인원 / 정원</th>
								</tr>
                              </thead>
                              <tbody>
               		
				
						<c:forEach var="b" items="${getopencourselist}">
							<tr>
								<td>${b.location}</td>
								<td onclick="course_sel('${b.open_course_id}')">${b.course_name} ${b.subject_name}</td>
								<td>${b.name_kor}</td>
								<td>${b.course_start_date} ~ ${b.course_end_date}</td>
								<td>${b.CNT} /	${b.capacity }</td>
							</tr>
						</c:forEach>
                              </tbody>
                          </table>
                      </div><!-- /content-panel -->
                  </div><!-- /col-md-12 -->
              </div><!-- /row -->
              	<form id="lecture" name="lecture" action="lecture" method="get">
					<input type="hidden" id="opid" name="opid" value="${open_course_id}">
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