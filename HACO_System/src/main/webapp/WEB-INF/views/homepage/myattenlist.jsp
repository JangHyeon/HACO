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
<link rel="stylesheet" href="${resourceUrl}/Remodal/jquery.remodal.css">


<!-- myPage header column -->
<%@ include file="inc/myLectureHistoryHeader.jsp" %>
<!-- Begin Body -->
<div class="container">
	<div class="no-gutter row">

		<!-- right content column-->
		<div class="col-md-12" id="content">
			<div class="panel">
				<ol class="breadcrumb">
				  <li class="active">출석 정보</li>
				</ol>
				
				<!-- Main Content -->
				<div class="panel-body">
					<div class="form-panel">
                		<table class="table table-hover">
							<thead>
								<tr>
									<th>이름</th>		
									<th>교육날짜</th>	
									<th>출석정보</th>	
								</tr>
							</thead>
							<tbody>								
								<c:forEach var="b" items="${getattenlist}">								
								<tr>
									<td>${b.name}</td>					
									<td>${b.attendance_date}</td>									
									<td>${b.attendance_state_name}</td>	
								</tr>
								</c:forEach>
							</tbody>							
						</table>
						<c:if test="${empty getattenlist || empty getattenlist[0]}">
							<h3 style="margin: 80px auto; text-align: center;">출석 정보가 없습니다...</h3>
						</c:if>
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
<form id="attenlist" name="attenlist" action="attenlist">
	<input type="hidden" id="memberid" name="memberid" value="">
</form>
<div id="zipcodeModal" class="remodal" data-remodal-id="modal"></div>

<!-- lodingmodel -->
<div aria-hidden="true" aria-labelledby="myModalLabel" role="dialog" tabindex="-1" id="lodingModal" class="modal fade">
	<div class="modal-dialog">
		<div id="loaderImage"></div>
	</div>
</div>
<!-- modal -->



<!-- script references -->
<script src="${resourceUrl}/gazONojfL3/js/jquery.1.9.1.min.js"></script>
<script	src="${resourceUrl}/gazONojfL3/js/bootstrap.3.2.0.min.js"></script>
<script	src="${resourceUrl}/gazONojfL3/js/scripts.js"></script>

<!-- JavaScript jQuery code from Bootply.com editor  -->

<script type="text/javascript">
	$(document).ready(function() {
		
		$('#sidebar').affix({
			offset : {
				top : 230,
				bottom : 100
			}
		});
		
		$('#nextBtn').on('click',function(e){
			location.href="${pageContext.request.contextPath}/memberModify";
		});
	});
</script>
