<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="s" uri="http://www.springframework.org/security/tags"%>



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
				  <li class="active">마이페이지</li>
				</ol>
				
				<!-- MainContent -->
				<div class="panel-body">
					<div class="row content" id="step1">
						<div class="col-sm-12 col-md-4 col-md-offset-1 mypage_img">
							<img src="${pageContext.request.contextPath}/images/Folder_-Documents_256x256-32.png"/>
						</div>
						<div class="col-sm-8 col-sm-offset-2 col-md-5 col-md-offset-1 email_text">
							<div class="textbox">
								<h2 class="title">
									${sessionScope.member.name}님 환영합니다.
								</h2>
								<h5>해당 계정의 등급은 <a>
										<s:authorize ifAllGranted="GUEST">손님</s:authorize>
										<s:authorize ifAllGranted="STUDENT">학생</s:authorize>
									</a>회원 입니다.
								</h5>
								<small>
								■ Email : ${sessionScope.member.email}<br>
								■ Phone : ${sessionScope.member.phone}
								</small>
								<div class="btn-group mypageBtn">
									<button id="nextBtn" class="btn btn-large btn-block btn-success joinbtn" type="button">정보수정하기</button>
								</div>
							</div>						
						</div>
					</div>
					
					
					
					<hr>

					Bootstrap 3 is the latest "Mobile-first" release of the Bootstrap
					framework that offers a starter foundation for Web designers and
					developers. Bootstrap consists of a CSS and JavaScript library. To
					use Bootstrap, you simply include (reference) in the HTML of your
					Web page. There is also a CDN for Bootstrap that serves pages
					faster.

					<hr>

					This theme was made at Bootply. Bootply is a HTML, JavaScript and
					CSS editor app built just for Bootstrap. Bootply enables developers
					to easily apply the Bootstrap Framework to their projects using a
					beautiful hand-coding interface. The browser-based Bootply editor
					lets developers select and paste Bootstrap friendly code snippets.
					Bootply can be used to test, manage and share any Bootstrap code,
					from small snippets to entire Bootstrap-ready themes. Find it at
					http://bootply.com

					<hr>

					<div class="row">
						<div class="col-md-3 col-sm-6 col-6">
							<a href="#"><img src="//placehold.it/600X200/EDEDED"
								class="img-responsive"></a>
						</div>
						<div class="col-md-3 col-sm-6 col-6">
							<a href="#"><img src="//placehold.it/600X200/DDDDDD"
								class="img-responsive"></a>
						</div>
						<div class="col-md-3 col-sm-6 col-6">
							<a href="#"><img src="//placehold.it/600X200/555555/EEE"
								class="img-responsive"></a>
						</div>
						<div class="col-md-3 col-sm-6 col-6">
							<a href="#"><img src="//placehold.it/600X200/F3F3F3"
								class="img-responsive"></a>
						</div>
					</div>
					<br>
					<div class="row">
						<div class="col-md-3 col-sm-6 col-6">
							<a href="#"><img src="//placehold.it/600X200/999999/DDD"
								class="img-responsive"></a>
						</div>
						<div class="col-md-3 col-sm-6 col-6">
							<a href="#"><img src="//placehold.it/600X200/CCCCCC"
								class="img-responsive"></a>
						</div>
						<div class="col-md-3 col-sm-6 col-6">
							<a href="#"><img src="//placehold.it/600X200/EDEDED"
								class="img-responsive"></a>
						</div>
						<div class="col-md-3 col-sm-6 col-6">
							<a href="#"><img src="//placehold.it/600X200/E0E0E0"
								class="img-responsive"></a>
						</div>
					</div>
					
					
					<hr>
					<h4>
						<a href="http://bootply.com/69913">Edit on Bootply</a>
					</h4>
					<hr>
				</div>
				<!--/panel-body-->
			</div>
			<!--/panel-->
			<!--/end right column-->
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
		
		$('#sidebar').affix({
			offset : {
				top : 230,
				bottom : 100
			}
		});
		
		$('#nextBtn').on('click',function(e){
			location.href="${pageContext.request.contextPath}/memberModify";
		});
	});
</script>





