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
		<div id="container" class="contain intro-effect-fadeout contectUs">
		
		<header class="header">
				<div class="bg-img">
					<div id="backst"></div>
				</div>
				<div class="title">
					<nav class="codrops-demos">
						<a href="${pageContext.request.contextPath}/introduction">학원 소개</a>
						<a href="${pageContext.request.contextPath}/introductionGreeting">학원장 인사말</a>
						<a class="current-demo" href="${pageContext.request.contextPath}/contectUs">찾아오는 길</a>
					</nav>
					<h1>HACO <br>Academy</h1>
					<p class="subline">New learning and experience</p>
					<p>by <strong>Kglim</strong> &#8212; on 2014. 9. 1</p>
				</div>
			</header>
			<button class="trigger" data-info="Click or ScollDown"><span>Trigger</span></button>
			<article class="content">
				<div>
					<p>HACO는 오늘도 꿈꾸는 모두와 함께 더 행복한 내일을 키워나갑니다.</p>
					<ul class="contact">
						<li><span class="fcB">판교 주소</span> : 경기도 성남시 분당구 판교로 264(삼평동) HACO Academy</li>
						<li><span class="fcB">고객문의전화</span> : 1588-5588(유료), 1588-8292(무료)</li>
						<li><span class="indent"><span class="fcB">교통편 : </span>지하철 : 신분당선 판교역 4번 출구 방면<br>마을버스 :  602-1번, 602-2번, 71번, 73번, 75번<br>일반버스 :  330, 350, 380<br>직행버스 : 4000, 9005, 9007</span></li>
					</ul>
					<p><strong>HACO President & CEO <a>Kglim</a></strong></p>
				</div>
			</article>
			<div id="map-canvas"></div> 
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
				
				$("#backst").backstretch("${resourceUrl}/images/20140819_005048.png", {speed: 800});
				
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
		
		
		
<!-- http://blog.naver.com/young02177/50191642196 -->
<!-- http://dakccom.tistory.com/56 -->
		
<script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyDvPEfA_0PETEqI_l2R9nDp4S_LBcgN9eY&sensor=SET_TO_TRUE_OR_FALSE" type="text/javascript"></script>
 
<script type="text/javascript">
	$(document).ready(function(){
	    function initialize() {
	    	
	    	var mapOptions = {
   			   scaleControl: true,
   			   center: new google.maps.LatLng(37.402112, 127.107050),
   			   zoom: 15
   			    };
				var map = new google.maps.Map(document.getElementById('map-canvas'),
	 			   mapOptions
	 			);
	   			
				/* var marker = new google.maps.Marker({
	   			   map: map,
	   			   position: map.getCenter()
	   			}); */

	   			var size_x = 30;
	   			var size_y = 30;
	   			var image = new google.maps.MarkerImage( '${resourceUrl}/favicon.png',  
	   					 		    new google.maps.Size(size_x, size_y),
	   					 		    '',
	   					 		    '',
	   					 		    new google.maps.Size(size_x, size_y));
	   			
	   			var latlng = new google.maps.LatLng(37.402112, 127.107050);
	   			var newmarker = new google.maps.Marker({ 
	   			   position: latlng, 
	   			   map: map,
	   			   title: 'HACO Academy 유스페이스 B2 8F'
	   			});
	   			
	   			
  			    var infowindow = new google.maps.InfoWindow();
  			    infowindow.setContent('HACO Academy 유스페이스 B2 8F');
  			    
  			  	//infowindow.open(map, marker);
  			  	infowindow.open(map, newmarker);
	  			/* google.maps.event.addListener(newmarker, 'click', function() {
	  			     infowindow.open(map, newmarker);
	  			}); */

	    }
 
    	google.maps.event.addDomListener(window, 'load', initialize);
	});
</script>
		