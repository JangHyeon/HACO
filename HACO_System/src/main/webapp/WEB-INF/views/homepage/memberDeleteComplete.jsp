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
		<div class="col-xs-12 col-sm-12 col-md-10 col-md-offset-1" id="joinform">
			<div class="page-header">
				<h1 class="title">
					회원 탈퇴 <small>탈퇴 완료</small>
				</h1>
			</div>
						
			<div class="row content" id="step1">
				<div class="col-sm-12 col-md-4 col-md-offset-1 delete_img">
					<img src="${pageContext.request.contextPath}/images/1408204318_close.svg"/>
				</div>
				<div class="col-sm-8 col-sm-offset-2 col-md-5 col-md-offset-1 email_text">
					<div class="textbox">
						<h2 class="title">
							탈퇴완료
						</h2>
							<h5><a>${member.name}</a>님의 탈퇴처리가 완료되었습니다.</h5>
							<p>그 동안 이용해 주셔서 감사합니다.<br>
							10초뒤 자동으로 메인페이지로 이동합니다.</p>
						<div class="btn-group mypageBtn">
							<button id="nextBtn" class="btn btn-large btn-block btn-success joinbtn" type="button">메인페이지</button>
						</div>
					</div>						
				</div>
			</div>
			<hr style="display:block;clear:both;">
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
		
		timer = setTimeout(function(){
			location.replace("${pageContext.request.contextPath}");
		},10000);
		
		$('#nextBtn').on('click',function(e){
			location.replace("${pageContext.request.contextPath}");
		});
	});
</script>

