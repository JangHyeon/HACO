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
<link rel="stylesheet" href="${resourceUrl}/Remodal/jquery.remodal.css">

<!-- myPage header column -->
<%@ include file="inc/curriculum.jsp" %>

<!-- Begin Body -->
<script type="text/javascript">
	function course_sel(opid){
		document.lecture.opid.value =opid;
		document.lecture.submit();
	}
	function teacher_sel(proid){
		var date2 = [];
		var json_data = $(this).val();
		$.ajax({
			type : 'POST',
			url : 'test',
			data : 'json_data=' + json_data,
			dataType : "json",
			success : function(date) {
			for (var i = 0; i < date.t.length; i++) {
				date2.push(date.t[i].name_kor);
			} 
			  $("#teacher").autocomplete({
					source : date2
				});
			},
			error : function() {
			}
		});
		document.pro.proid.value=proid;
		document.pro.submit();
		$(document).ready(function(){		
			$('#teacher').modal('show');
		});
	}
	$('#findId').on('click',function(){
		$('#idMsg').hide();
		$.post(
	    	"/haco/forgetId", 	  //url
	    	{
	    		name:$('#idName').val(),
	    		email:$('#idEmail').val()
	    	},
			function(data){
	    		if(data =='notFindID'){
	    			$('#idMsg').show();
	    		}else{
	    			$('#idMsg').hide();
	    			$('#resultID').text(data);
	    			$('#idModal2').modal('show');
	    		}
		   	}
	   	)
	});
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
									<th style="min-width:80px">center</th>
									<th width="270">제목</th>
									<th width="60">강사명</th>	
									<th width="240">기간</th>
									<th width="80">모집인원</th>
								</tr>
                              </thead>
                              <tbody>
               		
				
						<c:forEach var="b" items="${getopencourselist}">
							<tr onclick="course_sel('${b.open_course_id}')" style="cursor:pointer">
								<td>${b.location}</td>
								<td>${b.course_name} ${b.subject_name}</td>
								<td>${b.name_kor}</td>
								<td>${b.course_start_date} ~ ${b.course_end_date}</td>
								<td>${b.CNT} /	${b.capacity }</td>
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
<form id="lecture" name="lecture" action="lecture" method="get">
					<input type="hidden" id="opid" name="opid" value="">
</form>
<form id="pro" name="pro" action="pro" method="get">
					<input type="hidden" id="proid" name="proid" value="">
</form>

<!-- idModal2 -->
<div aria-hidden="true" aria-labelledby="myModalLabel" role="dialog" tabindex="-1" id="teacher" class="modal fade">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                <h4 class="modal-title">프로필</h4>
            </div>
            <div class="modal-body">
            	<c:forEach var="b" items="${getteacherlist}">
					${b.name_kor },${b.career_desc}${c.certificate}${d.profile_photo} 
					${d.profile_content },${d.introduction}
				</c:forEach>
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

<script>
$(document).ready(function(){
	$('#selectType>li').on('click',function(){
		$('#searchType>span:first-child').text($('a',this).text());
		$('input[name=searchType]').val($(this).attr('value'));
	});
});
</script>