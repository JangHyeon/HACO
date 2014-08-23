<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="s" uri="http://www.springframework.org/security/tags"%>

<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/Remodal/jquery.remodal.css">

<!-- myPage header column -->
<%@ include file="inc/mypageHeader.jsp" %>

<!-- Begin Body -->
<div class="container">
	<div class="no-gutter row">
		
		<!-- left side column -->
		<%@ include file="inc/mypageAside.jsp" %>
		<!-- END/left side column -->


		<!-- right content column-->
		<div class="col-md-10" id="content">
			<div class="panel">
				<ol class="breadcrumb">
				  <li class="active">수강 내역</li>
				</ol>
				
				<!-- Main Content -->
				<div class="panel-body">
					<div class="form-panel">
                		<table class="table table-hover">
							<thead>
								<tr>
									<th class="idx">번호</th>
									<th>과정명</th>		
									<th>센터명</th>	
									<th>시작일시</th>	
									<th>종료일시</th>	
									<th>수강중</th>								
									<th>설문완료</th>									
								</tr>
							</thead>
							<tbody>								
								<c:forEach var="myLecture" items="${myLectureList}">								
								<tr>
									<td>0</td>
									<td>${myLecture.course_name}</td>					
									<td>${myLecture.location}</td>									
									<td>${myLecture.course_start_date}</td>	
									<td>${myLecture.course_end_date}</td>	
									<td><a href="#"><b>${myLecture.now_study}</b></a></td>			
									<td>							
										<c:choose>
											<c:when test="${myLecture.is_survey=='N'}"><a href="myLectureEvaluation?open_course_id=${myLecture.open_course_id}"><b>강의평가 하기</b></a></c:when>
											<c:when test="${myLecture.is_survey=='Y'}"><a href="#"><b>수료증 발급</b></a></c:when>
										</c:choose>
									</td>				
								</tr>
								</c:forEach>
							</tbody>							
						</table>	      
                  	</div>
					
					<hr style="display:block;clear:both;">

				</div>
				<!--/panel-body-->
				
			</div>
			<!--/panel-->
			<!--/end right column-->
		</div>
	</div>
</div>

<div id="zipcodeModal" class="remodal" data-remodal-id="modal"></div>

<!-- lodingmodel -->
<div aria-hidden="true" aria-labelledby="myModalLabel" role="dialog" tabindex="-1" id="lodingModal" class="modal fade">
	<div class="modal-dialog">
		<div id="loaderImage"></div>
	</div>
</div>
<!-- modal -->



<!-- script references -->
<script src="${pageContext.request.contextPath}/resources/gazONojfL3/js/jquery.1.9.1.min.js"></script>
<script	src="${pageContext.request.contextPath}/resources/gazONojfL3/js/bootstrap.3.2.0.min.js"></script>
<script	src="${pageContext.request.contextPath}/resources/gazONojfL3/js/scripts.js"></script>
<script src="http://dmaps.daum.net/map_js_init/postcode.js"></script>
<script src="${pageContext.request.contextPath}/resources/Remodal/jquery.remodal.min.js"></script>

<!-- JavaScript jQuery code from Bootply.com editor  -->

<script type="text/javascript">
	$(document).ready(function() {
		
		$('#sidebar').affix({
			offset : {
				top : 230,
				bottom : 100
			}
		});
	});
</script>


<!-- JavaScript jQuery code from Bootply.com editor  -->
<script type="text/javascript">

	
</script>



