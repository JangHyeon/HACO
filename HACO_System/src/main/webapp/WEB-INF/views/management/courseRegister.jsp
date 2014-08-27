<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="s" uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<!-- spEL을 활용한 리소스 버전 관리 -->
<spring:eval expression="@baseConfig['app.version']" var="applicationVersion" />
<spring:url value="/static-{applicationVersion}" var="resourceUrl">
	<spring:param name="applicationVersion" value="${applicationVersion}" />
</spring:url>


<input id="current-accordion" type="hidden"
	value="course,subjectRegister" />

<!--external css-->
<link
	href="${resourceUrl}/assets/font-awesome/css/font-awesome.css"
	rel="stylesheet" />
<link rel="stylesheet" type="text/css"
	href="${resourceUrl}/assets/js/gritter/css/jquery.gritter.css" />

<!-- Custom styles for this template -->
<link
	href="${resourceUrl}/assets/css/style.css"
	rel="stylesheet">
<link
	href="${resourceUrl}/assets/css/style-responsive.css"
	rel="stylesheet">


<input id="current-accordion" type="hidden"
	value="course,subjectRegister" />

<!-- **********************************************************************************************************************************************************
      MAIN CONTENT
      *********************************************************************************************************************************************************** -->
<!--main content start-->

<section id="main-content">
	<section class="wrapper">
		<h3>
			<i class="fa fa-angle-right"></i> 서브페이지 샘플
		</h3>
		<h5>
			<a href="http://fontawesome.io/icons/" target="_blank">- aside
				아이콘 정보</a>
		</h5>
		<div class="row">

			<div class="col-md-12">
				<div class="content-panel">
					<h4>
						<i class="fa fa-angle-right"></i> 과목등록
					</h4>
					<hr>
					<table class="table">
						<thead>
							<tr>
								<th>seq</th>
								<th>강사명</th>
								<th>과목명</th>
								<th>과정명</th>
								<th>강의실</th>
								<th>과정시작일자/과정종료일자</th>
								<th>교육센터</th>
								<th>수정</th>
								<th>삭제</th>
							</tr>
						</thead>
						<tbody>
							<c:forEach var="role" items="${CourseList}">
								<tr>
									<td>${role.open_course_id}</td>
									<td>${role.name_kor}</td>
									<td>${role.subject_name}</td>
									<td>${role.course_name}</td>
									<td>${role.classroom}</td> 
									<td><fmt:formatDate value="${role.course_start_date}"
											pattern="yyyy-MM-dd" />~
									<fmt:formatDate value="${role.course_end_date}"
											pattern="yyyy-MM-dd" /></td>
									<td>${role.location}</td>
									<td><a
										href="${pageContext.request.contextPath}/management/courseUpdate?id=${role.open_course_id}">
											<p>수정</p>
									</a></td>
									<td><a
										href="${pageContext.request.contextPath}/management/courseDeleteOk?id=${role.open_course_id}">
											<p>삭제</p>
									</a></td> 	
								</tr>
							</c:forEach>

						</tbody>

					</table>

					<%--test:${pageContext.request.contextPath}  --%>
					<a
						href="${pageContext.request.contextPath}/management/courseInsert">
						<p>등록</p>
					</a>
				</div>
				<!-- 페이징 -->
										<ul class="pagination pagination-centered">
											<!-- 이전 링크 -->
											<li<c:if test="${beginpage<10}"> class="disabled"</c:if>>
												<a<c:if test="${beginpage>10}"> href="${pageContext.request.contextPath}/management/subjectRegister/pageSize/${pageSize}/pageNum/${beginpage-1}/searchType/${searchType}/searchKey/${searchKey}"</c:if>>«</a>
											</li>
											
										  	<!-- 페이지 리스트   -->
										  	<c:if test="${beginpage!=0}">
											<c:forEach var="i" begin="${beginpage}" end="${endpage}" step="1">
											
												<c:if test="${i==pageNum}">
													<li class="active"><a>${i} <span class="sr-only">(current)</span></a></li>
												</c:if>
												
												<c:if test="${i!=pageNum}">
													<li><a href="${pageContext.request.contextPath}/management/courseRegister/pageSize/${pageSize}/pageNum/${i}/searchType/${searchType}/searchKey/${searchKey}">${i}</a></li>
												</c:if>
											</c:forEach>
											</c:if>
										  	<!-- 다음링크 -->
											<li<c:if test="${endpage>=pagecount}"> class="disabled"</c:if>>
												<a<c:if test="${endpage<pagecount}"> href="${pageContext.request.contextPath}/management/courseRegister/pageSize/${pageSize}/pageNum/${endpage+1}/searchType/${searchType}/searchKey/${searchKey}"</c:if>>»</a>
											</li>
										</ul>
									</div>						
										
									<!-- 검색 -->
									<div class="col-sm-6 col-sm-offset-3" style="clear:both">
							          <div class="input-group">
							            <div class="input-group-btn">
							              <button id="searchType" type="button" class="btn btn-default dropdown-toggle" data-toggle="dropdown">
							              	<c:choose>
							              		<c:when test="${searchType=='teacherAndcourse'}">
							              			<span>강사+과정 </span>
							              		</c:when>
							              		<c:when test="${searchType=='course'}">
							              			<span>과정명 </span>
							              		</c:when>
							              		<c:otherwise>
							              			<span>강사명</span>
							              		</c:otherwise>
							              	</c:choose> 
							              	<span class="caret"></span>
							              </button>
							              <ul id="selectType" class="dropdown-menu" role="menu">
							                <li id=teacher value="teacher"><a>강사명</a></li>
							                <li id="teacherAndcourse" value="teacherAndcourse"><a>강사+과정</a></li>
							                <li id="course" value="course"><a>과정명</a></li>
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
				<!-- /content-panel -->
			</div>
			
		</div>
	</section>
</section>
<!--main content end-->



<!-- inclue common script -->

<script	src="${resourceUrl}/gazONojfL3/js/bootstrap.3.2.0.min.js"></script>
<%@ include file="commonScript.jsp"%>

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
			location.href="${pageContext.request.contextPath}/management/courseRegister/pageSize/"+$('input[name=pageSize]').val()+"/pageNum/1/searchType/"+$('input[name=searchType]').val()+"/searchKey/"+$('input[name=searchKey]').val();
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
	/* $('#writeBtn').on('click', function() {
		location.href='${pageContext.request.contextPath}/noticeWrite';
	}); */
});

</script>





