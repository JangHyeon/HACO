<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="s" uri="http://www.springframework.org/security/tags"%>


<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/Remodal/jquery.remodal.css">

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
					</div>
					<div class="view_body">
						<div class="content">${notice.content}</div>
					</div>				
					<div class="btn-group">
						<button id="listBtn" class="btn btn-default" type="button" onclick="history.go(-1)">목록</button>
						<button id="modifyBtn" class="btn btn-default" type="button">수정</button>
						<button id="deleteBtn" class="btn btn-default" type="button">삭제</button>
					</div>
					<hr style="display: block; clear: both;">

				</div>
			</div>
			<!--/panel-->
		</div>
	</div>
</div>


<!-- lodingmodel -->
<div aria-hidden="true" aria-labelledby="myModalLabel" role="dialog"
	tabindex="-1" id="lodingModal" class="modal fade">
	<div class="modal-dialog">
		<div id="loaderImage"></div>
	</div>
</div>
<!-- modal -->



<!-- script references -->
<script
	src="${pageContext.request.contextPath}/resources/gazONojfL3/js/jquery.1.9.1.min.js"></script>
<script
	src="${pageContext.request.contextPath}/resources/gazONojfL3/js/bootstrap.3.2.0.min.js"></script>
<script
	src="${pageContext.request.contextPath}/resources/gazONojfL3/js/scripts.js"></script>
<script src="http://dmaps.daum.net/map_js_init/postcode.js"></script>
<script
	src="${pageContext.request.contextPath}/resources/Remodal/jquery.remodal.min.js"></script>
	
<script src="${pageContext.request.contextPath}/resources/ckeditor/ckeditor.js"></script>


<!-- JavaScript jQuery code from Bootply.com editor  -->
<script type="text/javascript">
$(document).ready(function(){		
	
	$('#modifyBtn').on('click', function() {
		location.href='${pageContext.request.contextPath}/noticeModify/${notice.notice_id}';
	});

	$('#deleteBtn').on('click', function() {
		location.href='${pageContext.request.contextPath}/noticeDelete/${notice.notice_id}';
	});

});
</script>



