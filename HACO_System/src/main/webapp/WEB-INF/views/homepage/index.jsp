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

<link rel="stylesheet" type="text/css" href="${resourceUrl}/TiltedContentSlideshow/css/component.css" />

<div id="slideshow" class="slideshow panel">
			<ol class="slides">
				<li class="current">
					<div class="description">
						<h2><span>Java Framework<br><strong>자바 개발자 취업반</strong><span></h2>
						<p><span>현재 IT에서 가장 각광받는 java Technology의 기초부터 고급기술까지 학습합니다.</span></p>
						<p><span><strong>전자정부 프레임워크(java opensource framework)</strong>를 이용한 Enterprise Solution 설계 및 구현과 안드로이드 및 하이브리드앱을 이용한 모바일 애플리케이션 구현을 <br>학습하고 <strong>실무 프로젝트</strong>를 통해 현업에서 필요로 하는 자바 엔지니어 양성을 목표로 합니다.</span></p>
					</div>
					<div class="tiltview col">
						<a href="#"><img src="${resourceUrl}/TiltedContentSlideshow/img/20140828_112100.png"/></a>
						<a href="#"><img src="${resourceUrl}/TiltedContentSlideshow/img/java-oracle.png"/></a>
					</div>
				</li>
				<li>
					<div class="description">
						<h2><span>jQuery기반<br><strong>Ajax & Template</strong><span></h2>
						<p><span><strong>jQuery</strong>를 이용한 다이나믹한 웹 프로그래밍을 위한 기초 과정으로, jQuery, JSON, Ajax에 초점을 맞춰 수업이 진행되며, <br>서버에서 JSON을 처리하는 <strong>JSON-LIB</strong>를 사용합니다.</span></p>
<p><span>또한 Handlers Template 엔진을 이용하여, <strong>Template 프레임워크</strong>에 대한 개념도 익힐 수 있습니다.</span></p>
					</div>
					<div class="tiltview col">
						<a href="#"><img src="${resourceUrl}/TiltedContentSlideshow/img/jQuery-And-Ajax_01.png"/></a>
						<a href="#"><img src="${resourceUrl}/TiltedContentSlideshow/img/jQuery-And-Ajax_02.png"/></a>
					</div>
				</li>
				<li>
					<div class="description">
						<h2><span>BootStrap 기반<br><strong>반응형 웹</strong><span></h2>
						<p><span><strong>Twitter Bootstrap</strong>을 이용한 반응형 웹 프로그래밍을 위한 기초 과정부터 고급과정까지 수업이 진행되며, <br>강력한 프론트엔드 프레임워크 <strong>Bootstrap 3</strong>을 사용합니다.</span></p>
<p><span>부트스트랩의 개요, 다운받아 사용하는법, 기본 템플릿과 예제 등을 익힐 수 있습니다.</span></p>
					</div>
					<div class="tiltview col">
						<a href="#"><img src="${resourceUrl}/TiltedContentSlideshow/img/Bootstrap_Banner.png"/></a>
						<a href="#"><img src="${resourceUrl}/TiltedContentSlideshow/img/featured10@wdd2x.jpg"/></a>
					</div>
				</li>
			</ol>
		</div><!-- /slideshow -->

<!-- Begin Body -->
<div class="container">
	

	<div class="no-gutter row">
		
	</div>	
	<div class="row">
		<div class="col-md-4">
			<div class="panel panel-default">
				<div class="panel-heading">공지사항<span class="pull-right"><a href="${pageContext.request.contextPath}/notice"><small><i class="fa fa-plus-square"></i>&nbsp; 더보기</small></a></span></div>
				<div class="notice-content">
					<!-- <h4>
						<i class="fa fa-angle-right"></i> Hover Table
					</h4>
					<hr> -->
					<table class="table table-hover index-notice">
						<tbody>
							<c:forEach var="notice" items="${noticeList}">
								<tr>
									<td><span>－<a href="${pageContext.request.contextPath}/noticeView/pageSize/${pageSize}/pageNum/${pageNum}/searchType/${searchType}/searchKey/${searchKey}/noticeId/${notice.notice_id}">${notice.title}</a></span></td>
								</tr>
							</c:forEach>
						</tbody>
					</table>
					<c:if test="${empty noticeList || empty noticeList[0]}">
						<h4 style="margin: 50px auto 60px; text-align: center;">등록된 글이 없습니다...</h4>
					</c:if>
				</div>
			</div>
		</div>
		<div class="col-md-5">
			<div class="panel panel-default edu">
				<div class="panel-heading">교육과정<span class="pull-right"><a href="${pageContext.request.contextPath}/lectureregister"><small><i class="fa fa-plus-square"></i>&nbsp; 더보기</small></a></span></div>
				<div class="notice-content">
					<!-- <h4>
						<i class="fa fa-angle-right"></i> Hover Table
					</h4>
					<hr> -->
					<table class="table table-hover index-notice">
						<tbody>
							<c:forEach var="lectureRegister" items="${lectureRegisterList}">
								<tr>
									<td><span>－<a href="${pageContext.request.contextPath}/noticeView/pageSize/${pageSize}/pageNum/${pageNum}/searchType/${searchType}/searchKey/${searchKey}/noticeId/${notice.notice_id}">${lectureRegister.course_name}</a></span></td>
								</tr>
							</c:forEach>
						</tbody>
					</table>
					<c:if test="${empty lectureRegisterList || empty lectureRegisterList[0]}">
						<h4 style="margin: 50px auto 60px; text-align: center;">등록된 글이 없습니다...</h4>
					</c:if>
				</div>
			</div>
		</div>
		<div class="col-xs-6 col-sm-6 col-md-3">
			<div class="panel panel-default">
				<div id="carousel-example-generic" class="carousel slide bs-docs-carousel-example">
			        <ol class="carousel-indicators">
			          <li data-target="#carousel-example-generic" data-slide-to="0" class="active"></li>
			          <li data-target="#carousel-example-generic" data-slide-to="1" class=""></li>
			          <li data-target="#carousel-example-generic" data-slide-to="2" class=""></li>
			          <li data-target="#carousel-example-generic" data-slide-to="3" class=""></li>
			          <li data-target="#carousel-example-generic" data-slide-to="4" class=""></li>
			        </ol>
			        <div class="carousel-inner">
			          <div class="item active">
			          	<a href="http://getbootstrap.com" target="_blank">
			            <img src="${resourceUrl}/images/index/bootstrap.png" data-src="holder.js/900x500/auto/#777:#555/text:First slide" alt="First slide">
			            </a>
			          </div>
			          <div class="item">
			          	<a href="https://evernote.com" target="_blank">
			            <img src="${resourceUrl}/images/index/evernote.png" data-src="holder.js/900x500/auto/#666:#444/text:Second slide" alt="Second slide">
			            </a>
			          </div>
			          <div class="item">
			          	<a href="https://mail.google.com" target="_blank">
			            <img src="${resourceUrl}/images/index/gmail.png" data-src="holder.js/900x500/auto/#666:#444/text:Second slide" alt="Second slide">
			            </a>
			          </div>
			          <div class="item">
			          	<a href="http://jquery.com" target="_blank">
			            <img src="${resourceUrl}/images/index/jquery.png" data-src="holder.js/900x500/auto/#666:#444/text:Second slide" alt="Second slide">
			            </a>
			          </div>
			          <div class="item">
			          	<a href="http://spring.io" target="_blank">
			            <img src="${resourceUrl}/images/index/spring.png" data-src="holder.js/900x500/auto/#666:#444/text:Second slide" alt="Second slide">
			            </a>
			          </div>
			        </div>
			        <a class="left carousel-control" href="#carousel-example-generic" data-slide="prev">
			          <span class="icon-prev"></span>
			        </a>
			        <a class="right carousel-control" href="#carousel-example-generic" data-slide="next">
			          <span class="icon-next"></span>
			        </a>
			      </div>
			</div>
		</div>
	</div>
</div>

<!-- script references -->
<script src="${resourceUrl}/gazONojfL3/js/jquery.1.9.1.min.js"></script>
<script	src="${resourceUrl}/gazONojfL3/js/bootstrap.3.2.0.min.js"></script>
<script	src="${resourceUrl}/gazONojfL3/js/scripts.js"></script>


<script src="${resourceUrl}/TiltedContentSlideshow/js/modernizr.custom.js"></script>
<script src="${resourceUrl}/TiltedContentSlideshow/js/classie.js"></script>
<script src="${resourceUrl}/TiltedContentSlideshow/js/tiltSlider.js"></script>
<script>
$(document).ready(function(){
	new TiltSlider( document.getElementById( 'slideshow' ) );

	var el=2;
	var maxSilde=$('.slides>li').length;
	setInterval(function(){
		if(el==maxSilde){
		$('#slideshow nav span:nth-child(1)').click();
		el=2;
		}
		else{
		$('#slideshow nav span:nth-child('+el+')').click();
		el=el+1;
		}
	},8000);
	
	$('.carousel').carousel({
		  interval: 5000
	});
});
</script>

