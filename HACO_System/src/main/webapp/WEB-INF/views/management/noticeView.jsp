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

<!--external css-->
<link href="${resourceUrl}/assets/font-awesome/css/font-awesome.css" rel="stylesheet" />
<link rel="stylesheet" type="text/css" href="${resourceUrl}/assets/css/zabuto_calendar.css">
<link rel="stylesheet" type="text/css" href="${resourceUrl}/assets/js/gritter/css/jquery.gritter.css" />
<link rel="stylesheet" type="text/css" href="${resourceUrl}/assets/lineicons/style.css">

<!-- Custom styles for this template -->
<link href="${resourceUrl}/assets/css/style.css" rel="stylesheet">
<link href="${resourceUrl}/assets/css/style-responsive.css" rel="stylesheet">

<input id="current-accordion" type="hidden" value="board,notice" />

<!-- **********************************************************************************************************************************************************
      MAIN CONTENT
      *********************************************************************************************************************************************************** -->
<!--main content start-->
<section id="main-content">
	<section class="wrapper">
		<h3>
			<i class="fa fa-angle-right"></i> 공지사항
		</h3>
		<div class="row">
			<div class="col-md-12 mt">
				<!-- <div class="panel-heading">공지사항</div> -->
				<div class="content-panel panel-body">
					<!-- 뷰 -->
					<div class="view_head">
						<div class="subject">${notice.title}</div>
						<!-- <div class="idx">${dto.idx}</div> -->
						<div class="readcount_text">조회수</div>
						<div class="readcount">${notice.hit}</div>
						<span class="txt_bar"> | </span>
						<div class="writer">${notice.name_kor}</div>
						<span class="txt_bar"> | </span>
						<div class="reg_date">
							<fmt:formatDate value="${notice.register_date}" pattern="yy.MM.dd hh:mm:ss" />
						</div>
						<div class="state">
							<c:if test="${notice.state_code==0}">
								<span class='label label-info'><i class='fa fa-exclamation-circle'></i> 직원 공지 </span>
							</c:if>
							<c:if test="${notice.state_code==1}">
								<span class='label label-default'><i class='fa fa-exclamation-circle'></i> 공지 사항 </span>
							</c:if>
							<c:if test="${notice.state_code==2}">
								<span class='label label-primary'><i class='fa fa-exclamation-circle'></i> 상단 고정 공지 </span>
							</c:if>
						</div>
					</div>
					<div class="view_body">
						<div class="content">${notice.content}</div>
					</div>				
					<div class="btn-group">
						<button id="listBtn" class="btn btn-default" type="button">목록</button>
						<s:authorize ifAnyGranted="TEACHER,MANAGER,CENTER,MASTER">
						<button id="modifyBtn" class="btn btn-default" type="button">수정</button>
						<button id="deleteBtn" class="btn btn-default" type="button">삭제</button>
						</s:authorize>
					</div>
				</div>
			</div>
		</div>
		<!-- row -->
	</section>
</section>
<!--main content end-->


<!-- idModal2 -->
<div aria-hidden="true" aria-labelledby="myModalLabel" role="dialog" tabindex="-1" id="deleteModal" class="modal fade">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                <h4 class="modal-title">공지사항 삭제</h4>
            </div>
            <div class="modal-body">
                <p>센터장님에게 허락은 받으셨나요?</p>
                <h3><Strong id="resultID">이 공지사항을 삭제하시겠습니까?</Strong></h3>

            </div>
            <div class="modal-footer">
            	<button id="deleteModalCloseBtn" data-dismiss="modal" class="btn btn-default" type="button">닫기</button>
                <button id="deleteModalDeleteBtn" class="btn btn-danger" type="button">삭제</button>
            </div>
        </div>
    </div>
</div>
<!-- modal -->	




<!-- inclue common script -->
<%@ include file="commonScript.jsp"%>

<!--script for this page-->
<script src="${resourceUrl}/ckeditor/ckeditor.js"></script>


<!-- JavaScript jQuery code from Bootply.com editor  -->
<script type="text/javascript">
$(document).ready(function(){		
	
	$('#listBtn').on('click', function() {
		location.href='${pageContext.request.contextPath}/management/notice/pageSize/${notice.pageSize}/pageNum/${notice.pageNum}/searchType/${notice.searchType}/searchKey/${notice.searchKey}';
	});
	
	$('#modifyBtn').on('click', function() {
		location.href='${pageContext.request.contextPath}/management/noticeModify/pageSize/${notice.pageSize}/pageNum/${notice.pageNum}/searchType/${notice.searchType}/searchKey/${notice.searchKey}/noticeId/${notice.notice_id}';
	});

	$('#deleteBtn').on('click', function() {
		$('#deleteModal').modal('show');
	});
	
	$('#deleteModalDeleteBtn').on('click',function(){
		location.href='${pageContext.request.contextPath}/management/noticeDelete/${notice.notice_id}';
	});

});
</script>