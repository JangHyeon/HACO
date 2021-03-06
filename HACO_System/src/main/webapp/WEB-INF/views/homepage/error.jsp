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

<link rel="stylesheet" type="text/css" href="${resourceUrl}/css/normalize.css" />
<link rel="stylesheet" type="text/css" href="${resourceUrl}/css/demo.css" />
<link rel="stylesheet" type="text/css" href="${resourceUrl}/css/component.css" />



<!-- Begin Body -->
<div class="demo-7 error">
		<!-- content column-->
		<div id="container" class="contain intro-effect-jam3 modify">
		
		<header class="header">
				<div class="bg-img">
					<div id="backst"></div>
				</div>
				<div class="title">
					<h1>ERROR</h1>
					<p class="subline">
						<img src="${resourceUrl}/images/76b2b7e90210a0fe77e083ec89c56769.GIF">
						<br>
						${errorMsg}
					</p>
					<p>Please check <strong> URL </strong></p>
				</div>
			</header>
			<button class="trigger" data-info="Click or ScollDown"><span>Trigger</span></button>
			<article class="content">
				<div id="errorMsg" class="error">
					<c:if test="${errorMsg=='PageNotFound'}">
						<p>존재하지 않는 페이지 입니다.</p>
						<p>경로를 확인해주세요!</p>
					</c:if>
					<c:if test="${errorMsg=='NotSupported'}">
						<p>지원하지 않는 방식입니다.</p>
						<p>올바른 방식으로 시도하세요!</p>
					</c:if>
					<c:if test="${errorMsg=='FileNotFound'}">
						<p>파일을 찾을 수 없습니다.</p>
						<p>올바른 파일명을 입력하세요!</p>
					</c:if>
					
					<c:if test="${errorMsg=='Error'}">
						<p>이럴리가 없는데...</p>
						<p>다시 로그인 후 시도해주시거나 관리자에게 연락해주세요!</p>
					</c:if>
					
					<c:if test="${errorMsg=='NoAuthority'}">
						<p>권한이 없습니다.</p>
						<p>올바른 경로로 접속해주세요!</p>
					</c:if>
				</div>
			</article>
		
		</div>	
</div>

<!-- script references -->
<script src="${resourceUrl}/gazONojfL3/js/jquery.1.9.1.min.js"></script>
<script	src="${resourceUrl}/gazONojfL3/js/bootstrap.3.2.0.min.js"></script>
<script	src="${resourceUrl}/gazONojfL3/js/scripts.js"></script>

<!--BACKSTRETCH-->
<!-- You can use an image of whatever size. This script will stretch to fit in any screen size.-->
<script src="${resourceUrl}/assets/js/jquery.backstretch.min.js"></script>

<!-- JavaScript jQuery code from Bootply.com editor  -->
<script src="${resourceUrl}/js/classie.js"></script>
		<script>
		$(document).ready(function(){
			$("#container").append($("footer"));
			
		});
			(function() {
				
				$("#backst").backstretch("${pageContext.request.contextPath}/images/wallpaper-1845631.jpg");
				
				/* // detect if IE : from http://stackoverflow.com/a/16657946		
				var ie = (function(){
					var undef,rv = -1; // Return value assumes failure.
					var ua = window.navigator.userAgent;
					var msie = ua.indexOf('MSIE ');
					var trident = ua.indexOf('Trident/');

					if (msie > 0) {
						// IE 10 or older => return version number
						rv = parseInt(ua.substring(msie + 5, ua.indexOf('.', msie)), 10);
					} else if (trident > 0) {
						// IE 11 (or newer) => return version number
						var rvNum = ua.indexOf('rv:');
						rv = parseInt(ua.substring(rvNum + 3, ua.indexOf('.', rvNum)), 10);
					}

					return ((rv > -1) ? rv : undef);
				}());


				// disable/enable scroll (mousewheel and keys) from http://stackoverflow.com/a/4770179					
				// left: 37, up: 38, right: 39, down: 40,
				// spacebar: 32, pageup: 33, pagedown: 34, end: 35, home: 36
				var keys = [32, 37, 38, 39, 40], wheelIter = 0;

				function preventDefault(e) {
					e = e || window.event;
					if (e.preventDefault)
					e.preventDefault();
					e.returnValue = false;  
				}
				

				function keydown(e) {
					for (var i = keys.length; i--;) {
						if (e.keyCode === keys[i]) {
							preventDefault(e);
							return;
						}
					}
				}

				function touchmove(e) {
					preventDefault(e);
				}

				function wheel(e) {
					// for IE 
					//if( ie ) {
						//preventDefault(e);
					//}
				}

				function disable_scroll() {
					window.onmousewheel = document.onmousewheel = wheel;
					document.onkeydown = keydown;
					document.body.ontouchmove = touchmove;
				}

				function enable_scroll() {
					window.onmousewheel = document.onmousewheel = document.onkeydown = document.body.ontouchmove = null;  
				}

				var docElem = window.document.documentElement,
					scrollVal,
					isRevealed, 
					noscroll, 
					isAnimating,
					container = document.getElementById( 'container' ),
					trigger = container.querySelector( 'button.trigger' );

				function scrollY() {
					return window.pageYOffset || docElem.scrollTop;
				}
				
				function scrollPage() {
					scrollVal = scrollY();
					
					if( noscroll && !ie ) {
						if( scrollVal < 0 ) return false;
						// keep it that way
						window.scrollTo( 0, 0 );
					}

					if( classie.has( container, 'notrans' ) ) {
						classie.remove( container, 'notrans' );
						return false;
					}

					if( isAnimating ) {
						return false;
					}
					
					if( scrollVal <= 0 && isRevealed ) {
						toggle(0);
					}
					else if( scrollVal > 0 && !isRevealed ){
						toggle(1);
					}
				}

				function toggle( reveal ) {
					isAnimating = true;
					
					if( reveal ) {
						classie.add( container, 'modify' );
					}
					else {
						noscroll = true;
						disable_scroll();
						classie.remove( container, 'modify' );
					}

					// simulating the end of the transition:
					var simultimer = setInterval(function(){ $("#backst").trigger('resize'); },0);
					setTimeout( function() {
						isRevealed = !isRevealed;
						isAnimating = false;
						if( reveal ) {
							noscroll = false;
							enable_scroll();
						}else{
							
						}
						clearsetInterval(simultimer);
					}, 600 );
				}

				// refreshing the page...
				var pageScroll = scrollY();
				noscroll = pageScroll === 0;
				
				disable_scroll();
				
				if( pageScroll ) {
					isRevealed = true;
					classie.add( container, 'notrans' );
					classie.add( container, 'modify' );
				}
				
				window.addEventListener( 'scroll', scrollPage );
				trigger.addEventListener( 'click', function() { toggle( 'reveal' ); } );
				

				$('button.trigger').trigger('click'); */
			})();
		</script>