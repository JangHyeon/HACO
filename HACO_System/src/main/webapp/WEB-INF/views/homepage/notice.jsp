<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="s" uri="http://www.springframework.org/security/tags"%>



<!-- myPage header column -->
<%@ include file="inc/noticeHeader.jsp"%>


<!-- Begin Body -->
<div class="container">
	<div class="no-gutter row">
		<div class="col-xs-12 col-sm-12 col-md-10 col-md-offset-1">
			<div class="panel panel-default">
				<!-- <div class="panel-heading">공지사항 작성</div> -->
				<div class="panel-body">
					<div class="form-panel">
						<div class="row">
							<div class="col-md-12 mt">
								<div class="content-panel">
									<!-- <h4>
										<i class="fa fa-angle-right"></i> Hover Table
									</h4>
									<hr> -->
									<table class="table table-hover">
										<thead>
											<tr>
												<th>#</th>
												<th>제목</th>
												<th>작성자</th>
												<th>작성일</th>
												<th>조회</th>
											</tr>
										</thead>
										<tbody>
											<c:forEach var="notice" items="${noticeList}">
												<tr>
													<td>${notice.notice_id}</td>
													<td>${notice.title}</td>
													<td>${notice.name_kor}</td>
													<td>${notice.register_date}</td>
													<td>${notice.hit}</td>
												</tr>
											</c:forEach>
										</tbody>
									</table>
									
									
									<!-- 페이징 -->
									<ul class="pagination">
									  <li class="disabled"><a href="#">«</a></li>
									  <li class="active"><a href="#">1 <span class="sr-only">(current)</span></a></li>
									  <li><a href="#">»</a></li>
									</ul>
									
									
									<!-- 검색 -->
									<form id="noticeSearch">
										<div class="col-lg-6">
								          <div class="input-group">
								            <div class="input-group-btn">
								              <button id="searchType" type="button" class="btn btn-default dropdown-toggle" data-toggle="dropdown">
								              	<c:choose>
								              		<c:when test="${param.searchType=='titleAndContent'}">
								              			<span>제목+내용 </span>
								              		</c:when>
								              		<c:when test="${param.searchType=='writer'}">
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
								            <input type="text" class="form-control" name="searchKey" value="${param.searchKey}">
								            <span class="input-group-btn">
								              <button class="btn btn-default" type="submit">검색</button>
								            </span>
								          </div>
								        </div>
								        
								        <input type="hidden" name="pageNum" value="${param.pageNum}">
								        <input type="hidden" name="pageSize" value="${param.pageSize}">
								        <input type="hidden" name="searchType" value="${param.searchType}">
							        </form>
								</div>
								<!-- --/content-panel ---->
							</div>
							<!-- /col-md-12 -->
						</div>
					</div>
					<hr style="display: block; clear: both;">
				</div>
			</div>
			<!--/panel-->
		</div>
	</div>
</div>

<!-- script references -->
<script	src="${pageContext.request.contextPath}/resources/gazONojfL3/js/jquery.1.9.1.min.js"></script>
<script	src="${pageContext.request.contextPath}/resources/gazONojfL3/js/bootstrap.3.2.0.min.js"></script>

<script>
$(document).ready(function(){
	$('#selectType>li').on('click',function(){
		$('#searchType>span:first-child').text($('a',this).text());
		$('input[name=searchType]').val($(this).attr('value'));
	});
});

</script>