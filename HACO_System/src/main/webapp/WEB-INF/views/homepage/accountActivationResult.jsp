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




<!-- Begin Body -->
<div class="container">
	<div class="no-gutter row">

		<!-- content column-->
		<div class="col-xs-12 col-sm-12 col-md-10 col-md-offset-1 panel" id="joinform">
			<div class="page-header">
				<h1 class="title">
					계정 만들기 <small>가입 완료</small>
				</h1>
			</div>
			
			<!-- 진행바 -->
			<div class="progress progress-striped active">
			  <div class="progress-bar progress-bar-success" style="width: 20%"></div>
			  <div class="progress-bar progress-bar-warning" style="width: 50%"></div>
			  <div class="progress-bar progress-bar-primary" style="width: 20%"></div>
			  <div id="joinProgress" class="progress-bar progress-bar-info" style="width: 0%"></div>
			</div>	
			
			<hr class="top_hr">
			
			<div class="content" id="step1">
				<div class="col-sm-12 col-md-4 col-md-offset-1 email_img">
					<img src="${pageContext.request.contextPath}/images/Email_256x256-32.png"/>
				</div>
				<div class="col-sm-8 col-sm-offset-2 col-md-6 col-md-offset-1 email_text2">
					<c:choose>
						<c:when test="${data.result=='noChange'}">
							<div class="textbox">
								<h2 class="title"><i class="fa fa-check-square-o fa-2x"></i> </h2>
								<h5><a>${data.member.name}</a>님 이미 인증된 이메일 입니다.</h5>
								<p>가입 절차가 모두 완료되어 다시 인증 하실필요가 없습니다.</p>
								<div class="btn-group">
									<button id="nextBtn" class="btn btn-large btn-block btn-primary joinbtn" type="button">메인으로</button>
								</div>
							</div>
						</c:when>
						<c:when test="${data.result=='success'}">
							<div class="textbox">
								<h2 class="title"><i class="fa fa-child fa-2x"></i> 환영합니다.</h2>
								<h5><a>${data.member.name}</a>님 계정 만들기의 모든 과정이 처리 되었습니다.</h5>
								HACO의 회원이 되신것을 진심으로 환영합니다.
								<div class="btn-group">
									<button id="nextBtn" class="btn btn-large btn-block btn-primary joinbtn" type="button">메인으로</button>
								</div>
							</div>
						</c:when>
						<c:otherwise>
							<div class="textbox">
								<h2 class="title"><i class="fa fa-ban fa-2x"></i> 인증 실패</h2>
								<h5>존재하지 않는 <a>활성키</a>이거나 문제가 발생했습니다.</h5>
								계속해서 정상적으로 처리가 되지 않는경우 <a>관리자</a>에게 연락해주시기 바랍니다. 
								<div class="btn-group joinBtn">
									<button id="nextBtn" class="btn btn-large btn-block btn-primary joinbtn" type="button">메인으로</button>
								</div>
							</div>
						</c:otherwise>
					</c:choose>
				</div>
			</div>
			
			<hr class="bottom_hr">
			
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
		$('#joinProgress').css('width','10%');

		$('#nextBtn').on('click',function(e){
			location.href="${pageContext.request.contextPath}";
		});
	});
</script>





