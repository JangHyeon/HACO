<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="s" uri="http://www.springframework.org/security/tags"%>


<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/normalize.css" />
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/demo.css" />
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/component.css" />



<!-- Begin Body -->
<div class="demo-7">
		<!-- content column-->
		<div id="container" class="contain intro-effect-fadeout">
		
		<header class="header">
				<div class="bg-img">
					<div id="backst"></div>
				</div>
				<div class="title">
					<nav class="codrops-demos">
						<a href="${pageContext.request.contextPath}/introduction">학원 소개</a>
						<a class="current-demo" href="${pageContext.request.contextPath}/introductionGreeting">학원장 인사말</a>
						<a href="${pageContext.request.contextPath}/contectUs">찾아오는 길</a>
					</nav>
					<h1>HACO <br>Academy</h1>
					<p class="subline">New learning and experience</p>
					<p>by <strong>Kglim</strong> &#8212; on 2014. 9. 1</p>
				</div>
			</header>
			<button class="trigger" data-info="Click or ScollDown"><span>Trigger</span></button>
			<article class="content">
				<div>
					<p>HACO는 창의와 혁신으로 행복한 세상을 함께 만들어갑니다.</p>
					<p>HACO는 창의적인 생각과 기술력으로 기존 시장의 패러다임을 혁신하여 고객에게 최적화된 차별적 서비스와 언제 어디서나 즐길 수 있는 다양한 플랫폼을 제공하고 있습니다.</p>
					<p>또한 온∙온프라인과 모바일을 아울러 소비자의 스마트한 쇼핑 생활과 판매자의 통합 마케팅 솔루션을 지원하는 Next Commerce를 중심으로 더 큰 Eco System을 구축하며 혁신과 도전정신으로 국내를 넘어 해외로 우리의 지평을 넓혀 나가고 있습니다.</p>
					<p>“inspiring everyone on the planet”, 우리는 언제나 고객의 즐거움과 가치제고를 최우선으로 하며, 상생의 가치를 바탕으로 비즈니스 파트너들은 물론 사회와 함께 성장하고 구성원들의 행복한 몰입을 통해 Global Leader로 자리매김하고자 합니다.</p>
					<p>HACO는 오늘도 꿈꾸는 모두와 함께 더 행복한 내일을 키워나갑니다.</p>
					<p>HACO의 새로운 가능성과 도전에 여러분의 많은 관심과 따뜻한 성원 부탁 드립니다.</p>
					<p><strong>HACO President & CEO <a>Kglim</a></strong></p>
				</div>
			</article>
		</div>
</div>

<!-- script references -->
<script src="${pageContext.request.contextPath}/resources/gazONojfL3/js/jquery.1.9.1.min.js"></script>
<script	src="${pageContext.request.contextPath}/resources/gazONojfL3/js/bootstrap.3.2.0.min.js"></script>
<script	src="${pageContext.request.contextPath}/resources/gazONojfL3/js/scripts.js"></script>

<!--BACKSTRETCH-->
<!-- You can use an image of whatever size. This script will stretch to fit in any screen size.-->
<script src="${pageContext.request.contextPath}/resources/assets/js/jquery.backstretch.min.js"></script>

<!-- JavaScript jQuery code from Bootply.com editor  -->
<script src="${pageContext.request.contextPath}/resources/js/classie.js"></script>
		<script>
			$(document).ready(function(){
				$("#container").append($("footer"));
				
			});
			(function() {
				
				$("#backst").backstretch("${pageContext.request.contextPath}/resources/images/Bill-Gates-1.jpg");
				
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