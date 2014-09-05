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
<%@ include file="inc/qnaHeader.jsp"%>


<!-- Begin Body -->
<div class="container body">
	<div class="no-gutter row">
		<div class="col-xs-12 col-sm-12 col-md-12">
			<div class="panel panel-default">
				<!-- <div class="panel-heading">공지사항</div> -->
				<div class="panel-body">
					<!-- 뷰 -->
					<div class="view_head">
						<div class="subject">
							<c:if test="${qna.divide_code_toString == 'Q'}">
								<i class='fa fa-question-circle'></i>
							</c:if>
							<c:if test="${qna.divide_code_toString == 'A'}">
								<i class='fa fa-tag'></i>
							</c:if>
							${qna.title}
						</div>
						<!-- <div class="idx">${dto.idx}</div> -->
						<div class="readcount_text">조회수</div>
						<div class="readcount">${qna.hit}</div>
						<span class="txt_bar"> | </span>
						<c:if test="${qna.divide_code_toString == 'Q'}">
							<div class="writer">${qna.name}</div>
						</c:if>
						<c:if test="${qna.divide_code_toString == 'A'}">
							<div class="writer">${qna.name_kor}</div>
						</c:if>
						<span class="txt_bar"> | </span>
						<div class="reg_date">
							<fmt:formatDate value="${qna.register_date}" pattern="yy.MM.dd hh:mm:ss" />
						</div>
						<div class="state">
							<c:if test="${qna.state_code==0}">
								<span class='label label-default'><i class='fa fa-lock'></i> 비공개 </span>
							</c:if>
						</div>
					</div>
					<div class="view_body">
						<div class="content">${qna.content}</div>
					</div>				
					<div class="btn-group">
						<button id="listBtn" class="btn btn-default" type="button">목록</button>
						<c:if test="${sessionScope.member.account_id == qna.account_id || sessionScope.employee.account_id == qna.account_id}">
							<button id="modifyBtn" class="btn btn-default" type="button">수정</button>
							<button id="deleteBtn" class="btn btn-default" type="button">삭제</button>
						</c:if>
						<s:authorize ifAnyGranted="TEACHER,MANAGER,CENTER,MASTER">
							<c:if test="${qna.divide_code_toString=='Q'}">
								<button id="answerBtn" class="btn btn-primary" type="button">답변하기</button>
							</c:if>
						</s:authorize>
					</div>
					<hr style="margin-top:0px;display: block; clear: both; visibility: hidden;">
					
					<c:if test="${!empty qnaList}">
						<table class="table table-hover">
							<tbody>
								<c:forEach var="qna" items="${qnaList}">
									<tr>
										<td>
											<c:if test="${qna.divide_code_toString == 'Q'}">
												<span class='label label-default'><i class='fa fa-question-circle'></i> 질문 </span>
											</c:if>
											<c:if test="${qna.divide_code_toString == 'A'}">
												<span class='label label-primary'><i class='fa fa-tag'></i> 답변 </span>
											</c:if>
										</td>
										<td>
											<a href="${pageContext.request.contextPath}/qnaView/pageSize/${pageSize}/pageNum/${pageNum}/searchType/${searchType}/searchKey/${searchKey}/qnaId/${qna.qna_id}">${qna.title}</a>
										</td>
										<td>${qna.name_kor}${qna.name}</td>
										<td>${qna.register_date_string}</td>
										<td>${qna.hit}</td>
									</tr>
								</c:forEach>
							</tbody>
						</table>
					</c:if>
					<c:if test="${qna.divide_code_toString == 'Q'}">
						<c:if test="${empty qnaList || empty qnaList[0]}">
							<div class="alert alert-warning">
								<i class="fa fa-spinner fa-spin"></i> 아직 답변이 없습니다...
							</div>
						</c:if>			
					</c:if>
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
        	<s:authorize ifAnyGranted="TEACHER,MANAGER,CENTER,MASTER">
	        	<div class="modal-header">
	                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
	                <h4 class="modal-title">답변 삭제</h4>
	            </div>
	            <div class="modal-body">
	                <p>지켜보고있다요?</p>
	                <h3><Strong id="resultID">이 답변을 삭제하시겠습니까?</Strong></h3>
	
	            </div>
        	</s:authorize>
        	<s:authorize ifAnyGranted="GUEST,STUDENT">
	            <div class="modal-header">
	                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
	                <h4 class="modal-title">질문 삭제</h4>
	            </div>
	            <div class="modal-body">
	                <p>궁금증은 해결하셨나요?</p>
	                <h3><Strong id="resultID">이 질문을 삭제하시겠습니까?</Strong></h3>
	
	            </div>
        	</s:authorize>
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
$(document).ready(function(){		
	
	$('#listBtn').on('click', function() {
		location.href='${pageContext.request.contextPath}/qna/pageSize/${qna.pageSize}/pageNum/${qna.pageNum}/searchType/${qna.searchType}/searchKey/${qna.searchKey}';
	});
	
	$('#modifyBtn').on('click', function() {
		location.href='${pageContext.request.contextPath}/qnaModify/pageSize/${qna.pageSize}/pageNum/${qna.pageNum}/searchType/${qna.searchType}/searchKey/${qna.searchKey}/qnaId/${qna.qna_id}';
	});

	$('#deleteBtn').on('click', function() {
		$('#deleteModal').modal('show');
	});
	
	$('#answerBtn').on('click', function() {
		location.href='${pageContext.request.contextPath}/answerWrite/pageSize/${qna.pageSize}/pageNum/${qna.pageNum}/searchType/${qna.searchType}/searchKey/${qna.searchKey}/qnaId/${qna.qna_id}';
	});
	
	
	$('#deleteModalDeleteBtn').on('click',function(){
		location.href='${pageContext.request.contextPath}/qnaDelete/${qna.qna_id}';
	});

});
</script>



