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


<!-- myPage header column -->
<%@ include file="inc/qnaHeader.jsp"%>


<!-- Begin Body -->
<div class="container">
	<div class="no-gutter row">
		<div class="col-xs-12 col-sm-12 col-md-12">
			<div class="panel panel-default">
				<!-- <div class="panel-heading">공지사항 작성</div> -->
				<div class="panel-body">
					<div class="form-panel">
						<div class="row mt">
							<div class="content-panel">
								<!-- <h4>
									<i class="fa fa-angle-right"></i> Hover Table
								</h4>
								<hr> -->
								<div class="pull-right topToggle">
									<div class="">
									  <!-- <button type="button" class="btn btn-default" id="qnaToggle" data-toggle="button" data-noti-text="자주묻는질문 보이기">자주묻는질문 숨기기</button> -->										 
									  <div class="btn-group">
									    <button id="pageBtn" type="button" class="btn btn-default dropdown-toggle" data-toggle="dropdown">
									      <c:choose>
							              		<c:when test="${pageSize==15}">
							              			<span>15개씩 보기 </span>
							              		</c:when>
							              		<c:when test="${pageSize==20}">
							              			<span>20개씩 보기 </span>
							              		</c:when>
							              		<c:when test="${pageSize==50}">
							              			<span>50개씩 보기 </span>
							              		</c:when>
							              		<c:otherwise>
							              			<span>10개씩 보기 </span>
							              		</c:otherwise>
							              	</c:choose> 
									      <span class="caret"></span>
									    </button>
									    <ul id="pageNum" class="dropdown-menu pull-right pageSize">
									      <li value="10"><a>10개씩</a></li>
									      <li value="15"><a>15개씩</a></li>
									      <li value="20"><a>20개씩</a></li>
									      <li value="50"><a>50개씩</a></li>
									    </ul>
									  </div>
									</div>
								</div>
								<table class="table table-hover">
									<thead>
										<tr>
											<th class="divide_code">구분</th>
											<th>제목</th>
											<th>작성자</th>
											<th class="writeDate">작성일</th>
											<th class="hit">조회</th>
										</tr>
									</thead>
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
													<s:authorize ifAnyGranted="TEACHER,MANAGER,CENTER,MASTER">
														<a href="${pageContext.request.contextPath}/qnaView/pageSize/${pageSize}/pageNum/${pageNum}/searchType/${searchType}/searchKey/${searchKey}/qnaId/${qna.qna_id}">${qna.title}</a>
													</s:authorize>
													<s:authorize ifNotGranted="TEACHER,MANAGER,CENTER,MASTER">
														<c:choose>
															<c:when test="${sessionScope.member.account_id==qna.account_id}">
																<c:set var="group_id" value="${qna.group_no}" scope="page" />
																<a href="${pageContext.request.contextPath}/qnaView/pageSize/${pageSize}/pageNum/${pageNum}/searchType/${searchType}/searchKey/${searchKey}/qnaId/${qna.qna_id}">${qna.title}</a>
															</c:when>
															<c:when test="${qna.state_code!=0}">
																<a href="${pageContext.request.contextPath}/qnaView/pageSize/${pageSize}/pageNum/${pageNum}/searchType/${searchType}/searchKey/${searchKey}/qnaId/${qna.qna_id}">${qna.title}</a>
															</c:when>
															<c:when test="${group_id==qna.group_no}">
																<a href="${pageContext.request.contextPath}/qnaView/pageSize/${pageSize}/pageNum/${pageNum}/searchType/${searchType}/searchKey/${searchKey}/qnaId/${qna.qna_id}">${qna.title}</a>
															</c:when>
															<c:otherwise>
																<a class="lock">${qna.title}</a>
															</c:otherwise>
														</c:choose>
													</s:authorize>
												</td>
												<td>${qna.name_kor}${qna.name}</td>
												<td>${qna.register_date_string}</td>
												<td>${qna.hit}</td>
											</tr>
										</c:forEach>
									</tbody>
								</table>
								
								<c:if test="${empty qnaList || empty qnaList[0]}">
									<h3 style="margin: 80px auto; text-align: center;">결과가 없습니다...</h3>
								</c:if>
								
								<s:authorize ifAnyGranted="GUEST,STUDENT">
					            <div class="pull-right">
									<button id="writeBtn" class="btn btn-default" type="button">질문 올리기</button>
								</div>
								</s:authorize>

								<div class="col-xs-12">
									<!-- 페이징 -->
									<ul class="pagination pagination-centered">
										<!-- 이전 링크 -->
										<li<c:if test="${beginpage<10}"> class="disabled"</c:if>>
											<a<c:if test="${beginpage>10}"> href="${pageContext.request.contextPath}/qna/pageSize/${pageSize}/pageNum/${beginpage-1}/searchType/${searchType}/searchKey/${searchKey}"</c:if>>«</a>
										</li>
										
									  	<!-- 페이지 리스트   -->
									  	<c:if test="${beginpage!=0}">
										<c:forEach var="i" begin="${beginpage}" end="${endpage}" step="1">
										
											<c:if test="${i==pageNum}">
												<li class="active"><a>${i} <span class="sr-only">(current)</span></a></li>
											</c:if>
											<c:if test="${i!=pageNum}">
												<li><a href="${pageContext.request.contextPath}/qna/pageSize/${pageSize}/pageNum/${i}/searchType/${searchType}/searchKey/${searchKey}">${i}</a></li>
											</c:if>
										</c:forEach>
										</c:if>
									  	<!-- 다음링크 -->
										<li<c:if test="${endpage>=pagecount}"> class="disabled"</c:if>>
											<a<c:if test="${endpage<pagecount}"> href="${pageContext.request.contextPath}/qna/pageSize/${pageSize}/pageNum/${endpage+1}/searchType/${searchType}/searchKey/${searchKey}"</c:if>>»</a>
										</li>
									</ul>
								</div>					
									
								<!-- 검색 -->
								<div class="col-sm-6 col-sm-offset-3" style="clear:both">
						          <div class="input-group">
						            <div class="input-group-btn">
						              <button id="searchType" type="button" class="btn btn-default dropdown-toggle" data-toggle="dropdown">
						              	<c:choose>
						              		<c:when test="${searchType=='titleAndContent'}">
						              			<span>제목+내용 </span>
						              		</c:when>
						              		<c:when test="${searchType=='writer'}">
						              			<span>작성자 </span>
						              		</c:when>
						              		<c:otherwise>
						              			<span>제목 </span>
						              		</c:otherwise>
						              	</c:choose> 
						              	<span class="caret"></span>
						              </button>
						              <ul id="selectType" class="dropdown-menu" role="menu">
						                <li id="typeTitle" value="title"><a>제목</a></li>
						                <li id="typeTitleAndContent" value="titleAndContent"><a>제목+내용</a></li>
						                <li id="writer" value="writer"><a>작성자</a></li>
						              </ul>
						            </div><!-- /btn-group -->
						            <input type="text" class="form-control" id="inputSearchKey" value='<c:if test="${searchKey!='[noKeyword]'}">${searchKey}</c:if>'>
						            <span class="input-group-btn">
						              <button class="btn btn-default" id="submitBtn" type="button">검색</button>
						            </span>
						          </div>
							        <input type="hidden" name="searchKey" value="${searchKey}">
							        <input type="hidden" name="pageNum" value="${pageNum}">
							        <input type="hidden" name="pageSize" value="${pageSize}">
							        <input type="hidden" name="searchType" value="${searchType}">
						        </div>
							</div>
							<!-- --/content-panel ---->
						</div>
						<!-- /col-md-12 -->
					</div>
					<hr style="display: block; clear: both;">
				</div>
			</div>
			<!--/panel-->
		</div>
	</div>
</div>

<!-- script references -->
<script	src="${resourceUrl}/gazONojfL3/js/jquery.1.9.1.min.js"></script>
<script	src="${resourceUrl}/gazONojfL3/js/bootstrap.3.2.0.min.js"></script>

<script>
$(document).ready(function(){
	//검색 조건
	$('#selectType>li').on('click',function(){
		$('#searchType>span:first-child').text($('a',this).text());
		$('input[name=searchType]').val($(this).attr('value'));
	});
	
	var submit = function(){
		if($('input[name=searchKey]').val().length==0){
			alert('검색어를 입력해주세요.');
			$('#inputSearchKey').focus();
		}else{
			location.href="${pageContext.request.contextPath}/qna/pageSize/"+$('input[name=pageSize]').val()+"/pageNum/1/searchType/"+$('input[name=searchType]').val()+"/searchKey/"+$('input[name=searchKey]').val();
		}
	}
	
	$('#submitBtn').on('click',function(){
		$('input[name=searchKey]').val($('#inputSearchKey').val());
		submit();
	});
	
	$('#inputSearchKey').on('keypress',function(e){
		if(e.keyCode==13){
			$('input[name=searchKey]').val($('#inputSearchKey').val());
			submit();
		}
	});
	

	//공지 토글
	var toggle = false;
	$('#qnaToggle').on('click',function(){
		if(!toggle){
			$(this).button('noti');
			toggle=true;
			$('#topqna').hide();
		}else{
			$(this).blur();
			$(this).button('reset');
			toggle=false;
			$('#topqna').show();
		}
	});
	
	//페이지 사이즈
	$('#pageNum>li').on('click',function(){
		$('#pageBtn>span:first-child').text($('a',this).text()+" 보기");
		$('input[name=pageSize]').val($(this).attr('value'));
		if($('input[name=searchKey]').val()!='[noKeyword]'){
			$('input[name=searchKey]').val($('#inputSearchKey').val());
		}
		submit();
	});
	
	
	// 글쓰기 페이지
	$('#writeBtn').on('click', function() {
		location.href='${pageContext.request.contextPath}/questionWrite';
	});
});

</script>