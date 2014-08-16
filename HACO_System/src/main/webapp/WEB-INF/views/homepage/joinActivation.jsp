<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="s" uri="http://www.springframework.org/security/tags"%>






<!-- Begin Body -->
<div class="container">
	<div class="no-gutter row">

		<!-- content column-->
		<div class="col-xs-12 col-sm-12 col-md-10 col-md-offset-1 panel" id="joinform">
			<div class="page-header">
				<h1 class="title">
					계정 만들기 <small>이메일 인증</small>
				</h1>
			</div>
			
			<!-- 진행바 -->
			<div class="progress progress-striped active">
			  <div class="progress-bar progress-bar-success" style="width: 20%"></div>
			  <div class="progress-bar progress-bar-warning" style="width: 50%"></div>
			  <div id="joinProgress" class="progress-bar progress-bar-primary" style="width: 0%"></div>
			</div>	
			
			<hr class="top_hr">
			
			<div class="content" id="step1">
				<div class="col-sm-12 col-md-4 col-md-offset-1 email_img">
					<img src="${pageContext.request.contextPath}/images/Email_256x256-32.png"/>
				</div>
				<div class="col-sm-8 col-sm-offset-2 col-md-6 col-md-offset-1 email_text">
					<div class="textbox">
						<h2 class="title">
							인증메일을 확인해주세요.
						</h2>
						<h5><a>${email}</a>으로 인증 메일을 발송했습니다.</h5>
						<p>메일을 확인하시고 인증을 해주시면 회원가입이 완료됩니다.</p>
						<div class="btn-group">
							<button id="nextBtn" class="btn btn-large btn-block btn-primary joinbtn" type="button">메인으로</button>
						</div>
					</div>						
				</div>
			</div>
			
			<hr class="bottom_hr">
			
		</div>
	</div>
</div>

<!-- script references -->
<script src="${pageContext.request.contextPath}/resources/gazONojfL3/js/jquery.1.9.1.min.js"></script>
<script	src="${pageContext.request.contextPath}/resources/gazONojfL3/js/bootstrap.3.2.0.min.js"></script>
<script	src="${pageContext.request.contextPath}/resources/gazONojfL3/js/scripts.js"></script>

<!-- JavaScript jQuery code from Bootply.com editor  -->
<script type="text/javascript">
	$(document).ready(function() {
		$('#joinProgress').css('width','20%');
		
		// BackSpace 키 방지 이벤트
	    $(document).keydown(function(e){    
	        if(e.target.nodeName != "INPUT" && e.target.nodeName != "TEXTAREA"){        
	            if(e.keyCode === 8){    
	            return false;
	            }
	        }
	    });

		$('#nextBtn').on('click',function(e){
			location.href="${pageContext.request.contextPath}";
		});
	});
</script>





