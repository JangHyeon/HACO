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
<%@ include file="inc/noticeHeader.jsp"%>


<!-- Begin Body -->
<div class="container body">
	<div class="no-gutter row">
		<div class="col-xs-12 col-sm-12 col-md-12">
			<div class="panel panel-default">
				<!-- <div class="panel-heading">공지사항 작성</div> -->
				<div class="panel-body">
					<div class="form-panel">
						<div class="mt">
							<div class="content-panel">
								<!-- <h4>
									<i class="fa fa-angle-right"></i> Hover Table
								</h4>
								<hr> -->
								
								<s:authorize ifAnyGranted="TEACHER,MANAGER,CENTER,MASTER">
									<div class="pull-right" style="margin-left: 10px;">
										<button id="writeBtn" class="btn btn-primary" type="button">공지사항 작성하기</button>
									</div>
								</s:authorize>
								
								<div class="pull-right topToggle">
									<div class="btn-group">
									  <button type="button" class="btn btn-default" id="noticeToggle" data-toggle="button" data-noti-text="공지 보이기">공지 숨기기</button>										 
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
											<th class="idx">#</th>
											<th>제목</th>
											<s:authorize ifAnyGranted="TEACHER,MANAGER,CENTER,MASTER">
												<th class="writer">작성자</th>
											</s:authorize>
											<th class="writeDate">작성일</th>
											<th class="hit">조회</th>
										</tr>
									</thead>
									<tbody id="topNotice">
										<c:forEach var="top" items="${topNoticeList}">
											<tr class="topNotice">
												<td><i class='fa fa-bullhorn'></i></td>
												<td><a href="${pageContext.request.contextPath}/noticeView/pageSize/${pageSize}/pageNum/${pageNum}/searchType/${searchType}/searchKey/<c:if test="${searchKey==''}">[emptySearchKey]</c:if><c:if test="${searchKey!=''}">${searchKey}</c:if>/noticeId/${top.notice_id}">${top.title}</a></td>
													<s:authorize ifAnyGranted="TEACHER,MANAGER,CENTER,MASTER">
												<td>${top.name_kor}</td>
												</s:authorize>
												<td>${top.register_date_string}</td>
												<td>${top.hit}</td>
											</tr>
										</c:forEach>
									</tbody>
									<tbody>
										<c:forEach var="notice" items="${noticeList}">
											<tr>
												<td>${notice.notice_id}</td>
												<td><a href="${pageContext.request.contextPath}/noticeView/pageSize/${pageSize}/pageNum/${pageNum}/searchType/${searchType}/searchKey/${searchKey}/noticeId/${notice.notice_id}">${notice.title}</a></td>
												<s:authorize ifAnyGranted="TEACHER,MANAGER,CENTER,MASTER">
													<td>${notice.name_kor}</td>
												</s:authorize>
												<td>${notice.register_date_string}</td>
												<td>${notice.hit}</td>
											</tr>
										</c:forEach>
									</tbody>
								</table>
								
								<c:if test="${empty noticeList || empty noticeList[0]}">
									<h3 style="margin: 80px auto; text-align: center;">결과가 없습니다...</h3>
								</c:if>

								<div class="col-xs-12">
									<!-- 페이징 -->
									<ul class="pagination pagination-centered">
										<!-- 이전 링크 -->
										<li<c:if test="${beginpage<10}"> class="disabled"</c:if>>
											<a<c:if test="${beginpage>10}"> href="${pageContext.request.contextPath}/notice/pageSize/${pageSize}/pageNum/${beginpage-1}/searchType/${searchType}/searchKey/${searchKey}"</c:if>>«</a>
										</li>
										
									  	<!-- 페이지 리스트   -->
									  	<c:if test="${beginpage!=0}">
										<c:forEach var="i" begin="${beginpage}" end="${endpage}" step="1">
										
											<c:if test="${i==pageNum}">
												<li class="active"><a>${i} <span class="sr-only">(current)</span></a></li>
											</c:if>
											<c:if test="${i!=pageNum}">
												<li><a href="${pageContext.request.contextPath}/notice/pageSize/${pageSize}/pageNum/${i}/searchType/${searchType}/searchKey/${searchKey}">${i}</a></li>
											</c:if>
										</c:forEach>
										</c:if>
									  	<!-- 다음링크 -->
										<li<c:if test="${endpage>=pagecount}"> class="disabled"</c:if>>
											<a<c:if test="${endpage<pagecount}"> href="${pageContext.request.contextPath}/notice/pageSize/${pageSize}/pageNum/${endpage+1}/searchType/${searchType}/searchKey/${searchKey}"</c:if>>»</a>
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
						              			<s:authorize ifAnyGranted="TEACHER,MANAGER,CENTER,MASTER">
						              			<span>작성자 </span>
						              			</s:authorize>
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
						                <s:authorize ifAnyGranted="TEACHER,MANAGER,CENTER,MASTER">
						                	<li id="writer" value="writer"><a>작성자</a></li>
						                </s:authorize>
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
		
		if($.trim($('input[name=searchKey]').val()).length==0){
			alert('검색어를 입력해주세요.');
			$('#inputSearchKey').focus();
		}else{
			location.href="${pageContext.request.contextPath}/notice/pageSize/"+$('input[name=pageSize]').val()+"/pageNum/1/searchType/"+$('input[name=searchType]').val()+"/searchKey/"+$.trim($('input[name=searchKey]').val());
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
	$('#noticeToggle').on('click',function(){
		if(!toggle){
			$(this).button('noti');
			toggle=true;
			$('#topNotice').hide();
		}else{
			$(this).blur();
			$(this).button('reset');
			toggle=false;
			$('#topNotice').show();
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
		location.href='${pageContext.request.contextPath}/noticeWrite';
	});
});

</script>