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

<link rel="stylesheet"
	href="${resourceUrl}/Remodal/jquery.remodal.css">

<!-- myPage header column -->
<%@ include file="inc/noticeHeader.jsp"%>


<!-- Begin Body -->
<div class="container">
	<div class="no-gutter row">
		<div class="col-xs-12 col-sm-12 col-md-10 col-md-offset-1">
			<div class="panel panel-default">
				<!-- <div class="panel-heading">공지사항</div> -->
				<div class="panel-body">
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
					<hr style="display: block; clear: both;">

				</div>
			</div>
			<!--/panel-->
		</div>
	</div>
</div>

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



<!-- script references -->
<script
	src="${resourceUrl}/gazONojfL3/js/jquery.1.9.1.min.js"></script>
<script
	src="${resourceUrl}/gazONojfL3/js/bootstrap.3.2.0.min.js"></script>
<script
	src="${resourceUrl}/gazONojfL3/js/scripts.js"></script>
<script src="http://dmaps.daum.net/map_js_init/postcode.js"></script>
<script
	src="${resourceUrl}/Remodal/jquery.remodal.min.js"></script>
	
<script src="${resourceUrl}/ckeditor/ckeditor.js"></script>


<!-- JavaScript jQuery code from Bootply.com editor  -->
<script type="text/javascript">
	
	
	$('#listBtn').on('click', function() {
		location.href='${pageContext.request.contextPath}/notice/pageSize/${notice.pageSize}/pageNum/${notice.pageNum}/searchType/${notice.searchType}/searchKey/${notice.searchKey}';
	});
	
	$('#modifyBtn').on('click', function() {
		location.href='${pageContext.request.contextPath}/noticeModify/pageSize/${notice.pageSize}/pageNum/${notice.pageNum}/searchType/${notice.searchType}/searchKey/${notice.searchKey}/noticeId/${notice.notice_id}';
	});

	$('#deleteBtn').on('click', function() {
		$('#deleteModal').modal('show');
	});
	
	$('#deleteModalDeleteBtn').on('click',function(){
		location.href='${pageContext.request.contextPath}/noticeDelete/${notice.notice_id}';
	});

});
</script>



