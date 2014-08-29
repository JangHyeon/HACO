<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="s" uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<!-- spEL을 활용한 리소스 버전 관리 -->
<spring:eval expression="@baseConfig['app.version']" var="applicationVersion" />
<spring:url value="/static-{applicationVersion}" var="resourceUrl">
	<spring:param name="applicationVersion" value="${applicationVersion}" />
</spring:url>
<%@ include file="inc/curriculum explanation.jsp" %>

<!-- Begin Body -->
<form id="lecturesuccess" name="lecturesuccess" action="lecturesuccess" method="get">
<script type="text/javascript">
	function course_write(opid){
		var capacity = document.lecturesuccess.capacity.value;
		var CNT = document.lecturesuccess.CNT.value;
		var account_id = document.lecturesuccess.account_id.value;
		alert("account_id : " + account_id);
		
		if(account_id==""){
			$(document).ready(function(){
				$('#empty').modal('show');
				});
		}
		else if(account_id!=null){
			var id = document.lecturesuccess.id.value;
			alert("id : " + id);
			if(account_id == id){
				$(document).ready(function(){
					$('#fail').modal('show');
					});
			}else if(CNT>=capacity){
				$(document).ready(function(){
					$('#over').modal('show');
					});
			}else if(capacity>CNT){
				document.lecturesuccess.opid.value =opid;
				document.lecturesuccess.submit();
				}
			
		}
		
		
		
}
</script>
<div class="container">
	<div class="no-gutter row">
		<!-- right content column-->
		<div class="col-md-12" id="content">
			<div class="panel">
				<ol class="breadcrumb">
				  <li class="active">교육과정</li>
				</ol>
				
				<!-- Main Content -->
				<div class="panel-body">
					<div class="form-panel">
                		<table class="table table-hover">
							<thead>
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
								<td align="center" colspan="2"><input type="button" name="failed" value="수강신청" onclick="course_write('${getCNT.open_course_id}')"></td>
							</tr>
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
			<input type="hidden" name="opid" id="opid" value=""/>
			<input type="hidden" name="name" id="name" value="${getCNT.name}"/>
			<input type="hidden" name="account_id" id="account_id" value="${member.account_id}"/>
			<input type="hidden" name="id" id="id" value="${lecturemember.account_id}"/>
</form>
<!-- idModal2 -->
<div aria-hidden="true" aria-labelledby="myModalLabel" role="dialog" tabindex="-1" id="over" class="modal fade">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                <h4 class="modal-title">수강신청실패</h4>
            </div>
            <div class="modal-body">
                <h3><Strong id="resultID">정원 초과로 인하여 수강신청을 하지 못했습니다.</Strong></h3>
            </div>
            <div class="modal-footer">
            	<button id="deleteModalCloseBtn" data-dismiss="modal" class="btn btn-default" type="button">확인</button>
            </div>
        </div>
    </div>
</div>
<!-- modal -->	
<!-- idModal2 -->
<div aria-hidden="true" aria-labelledby="myModalLabel" role="dialog" tabindex="-1" id="fail" class="modal fade">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                <h4 class="modal-title">수강신청실패</h4>
            </div>
            <div class="modal-body">
                <h3><Strong id="resultID">이미 신청하신 과목입니다.</Strong></h3>
            </div>
            <div class="modal-footer">
            	<button id="deleteModalCloseBtn" data-dismiss="modal" class="btn btn-default" type="button">확인</button>
            </div>
        </div>
    </div>
</div>
<div aria-hidden="true" aria-labelledby="myModalLabel" role="dialog" tabindex="-1" id="empty" class="modal fade">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                <h4 class="modal-title">수강신청실패</h4>
            </div>
            <div class="modal-body">
                <h3><Strong id="resultID">수강신청은 로그인이 필요합니다.</Strong></h3>
            </div>
            <div class="modal-footer">
            	<button id="deleteModalCloseBtn" data-dismiss="modal" class="btn btn-default" type="button">확인</button>
            </div>
        </div>
    </div>
</div>
<!-- modal -->	
<!-- script references -->
<script	src="${resourceUrl}/gazONojfL3/js/jquery.1.9.1.min.js"></script>
<script	src="${resourceUrl}/gazONojfL3/js/bootstrap.3.2.0.min.js"></script>