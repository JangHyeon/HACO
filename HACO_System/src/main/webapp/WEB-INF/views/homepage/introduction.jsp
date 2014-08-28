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
<div class="demo-7">
		<!-- content column-->
		<div id="container" class="contain intro-effect-jam3">
		
		<header class="header">
				<div class="bg-img">
					<div id="backst"></div>
				</div>
				<div class="title">
					<nav class="codrops-demos">
						<a class="current-demo" href="${pageContext.request.contextPath}/introduction">학원 소개</a>
						<a href="${pageContext.request.contextPath}/introductionGreeting">학원장 인사말</a>
						<a href="${pageContext.request.contextPath}/contectUs">찾아오는 길</a>
					</nav>
					<h1>HACO Academy</h1>
					<p class="subline">New learning and experience</p>
					<p>by <strong>Kglim</strong> &#8212; on &nbsp;&nbsp;<font face="Nanum Gothic">2014. 9. 1</font></p>
				</div>
			</header>
			<button class="trigger" data-info="Click or ScollDown"><span>Trigger</span></button>
			<article class="content">
				<div>
					<p>검색, 포털, 게임, SNS, 클라우드 서비스 등, </p>
					<p>이제 소프트웨어는 종래의 기업 업무 영역을 벗어나 일반사용자들의 일상생활에서 가치를 창출하고 있습니다. 우리는 이런 류의 소프트웨어를 일반 사용자용 소프트웨어라 부르고자 합니다. 스마트폰 등 개인용 컴퓨팅 환경이 일반화되면서 일반 사용자용 소프트웨어는 세상을 변화시키는 데 가장 큰 역할을 수행하고 있고, 산업의 가치도 빠르게 성장하고 있습니다. 우리는 이 분야에 소프트웨어 산업의 새로운 미래가 있다고 믿습니다.</p>
					<p>기존 소프트웨어 커리큘럼은 개발에만 집중되어 있습니다. 기업 업무용 소프트웨어는 정해진 업무의 생산성, 효율성에 초점을 두기 때문입니다. 하지만, 일반 사용자용 소프트웨어는 수천만, 수억 명의 사람들이 생활 속에서 사용하는 일반도구이기 때문에, 이 소프트웨어가 창출하는 새로운 가치와 경험이 매우 중요합니다. 이러한 가치와 경험을 담아내기 위해서는 소프트웨어 커리큘럼에 개발뿐만 아니라 디자인, UX, 인문사회학이 융합되어야 합니다.</p>
					<p>교육에 있어서 가장 핵심은 “배움”이 일어나는 것입니다. 마치, 병원의 핵심이 단순한 의료절차가 아니라 건강을 되찾는 것과 같습니다. 우리는 실무현장이 가장 좋은 배움의 장이라고 믿습니다. 따라서 교육환경은 최대한 실제 현장과 동일하게 유지되어야 합니다. 이를 위해 커리큘럼, 교수진, 수업, 과제가 모두 현장을 옮겨놓은 효과를 갖도록 운영되어야 합니다.</p>
					<p>HACO는 일반 사용자용 소프트웨어 산업에서 주도적인 역할을 해왔고, 이 분야의 미래 인재를 양성하고자 HACO Academy 교육기관을 직접 설립하였습니다. HACO Academy는 미래 소프트웨어가 필요로 하는 최적의 융합형 커리큘럼을 완성하고, 실제현장을 그대로 반영한 교육체계를 갖추어 최고의 교육기관으로서 사회에 공헌할 것입니다.</p>
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
				
				$("#backst").backstretch("${resourceUrl}/images/wallpaper-1200407.jpg", {speed: 800});
				
				// detect if IE : from http://stackoverflow.com/a/16657946		
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
					setTimeout( function() {
						isRevealed = !isRevealed;
						isAnimating = false;
						if( reveal ) {
							noscroll = false;
							enable_scroll();
						}else{
							$(window).trigger('resize');
						}
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
			})();
		</script>