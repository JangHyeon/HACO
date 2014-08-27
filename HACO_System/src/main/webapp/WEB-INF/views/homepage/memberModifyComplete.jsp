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
<%@ include file="inc/mypageHeader.jsp" %>

<!-- Begin Body -->
<div class="container">
	<div class="no-gutter row">
		
		<!-- left side column -->
		<%@ include file="inc/mypageAside.jsp" %>
		<!-- END/left side column -->


		<!-- right content column-->
		<div class="col-md-10" id="content">
			<div class="panel">
				<ol class="breadcrumb">
				  <li class="active">회원정보수정 완료</li>
				</ol>
				<div class="panel-body">
					<div class="row content" id="step1">
						<div class="col-sm-12 col-md-4 col-md-offset-1 mypage_img">
							<img src="${pageContext.request.contextPath}/images/Administrative_Tools_256x256-32.png"/>
						</div>
						<div class="col-sm-8 col-sm-offset-2 col-md-5 col-md-offset-1 email_text">
							<div class="textbox">
								<h2 class="title">
									회원정보수정 완료
								</h2>
								<h5><a>${sessionScope.member.name}</a>님의 회원정보수정이 완료되었습니다.
								</h5>
								<small>
								■ Email : ${sessionScope.member.email}<br>
								■ Phone : ${sessionScope.member.phone}
								</small>
								<div class="btn-group mypageBtn">
									<button id="nextBtn" class="btn btn-large btn-block btn-primary joinbtn" type="button">마이 페이지 메인</button>
								</div>
							</div>						
						</div>
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

<!-- script references -->
<script src="${resourceUrl}/gazONojfL3/js/jquery.1.9.1.min.js"></script>
<script	src="${resourceUrl}/gazONojfL3/js/bootstrap.3.2.0.min.js"></script>
<script	src="${resourceUrl}/gazONojfL3/js/scripts.js"></script>

<!-- JavaScript jQuery code from Bootply.com editor  -->

<script type="text/javascript">
	$(document).ready(function() {
		
		$('#sidebar').affix({
			offset : {
				top : 230,
				bottom : 100
			}
		});
		$('#nextBtn').on('click',function(e){
			location.replace("${pageContext.request.contextPath}/myPage");
		});
	});
</script>

