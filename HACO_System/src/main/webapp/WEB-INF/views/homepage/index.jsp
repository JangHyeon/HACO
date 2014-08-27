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

<!-- Begin Body -->
<div class="container">
	<div class="no-gutter row">
		<div id="slideshow" class="slideshow panel">
			<ol class="slides">
				<li class="current">
					<div class="description">
						<h2>컨텐츠 슬라이드쇼</h2>
						<p>This slider, 에에헤헿헤핳하하하하 <a href="http://www.thefwa.com/">FWA</a>, plays with 3D perspective and performs some interesting animations on the right-hand side images.</p>
					</div>
					<div class="tiltview col">
						<a href="http://grovemade.com/"><img src="${resourceUrl}/TiltedContentSlideshow/img/1_screen.jpg"/></a>
						<a href="https://tsovet.com/"><img src="${resourceUrl}/TiltedContentSlideshow/img/2_screen.jpg"/></a>
					</div>
				</li>
				<li>
					<div class="description">
						<h2>CSS Animations</h2>
						<p>We are using 12 different animations for showing and hiding the items of a slide. The animations are defined by randomly adding data-attributes called <code>data-effect-in</code> and <code>data-effect-out</code> for every slide. </p>
					</div>
					<div class="tiltview row">
						<a href="http://pexcil.com/"><img src="${resourceUrl}/TiltedContentSlideshow/img/3_mobile.jpg"/></a>
						<a href="http://foodsense.is/"><img src="${resourceUrl}/TiltedContentSlideshow/img/4_mobile.jpg"/></a>
					</div>
				</li>
				<li>
					<div class="description">
						<h2>Tilted Items</h2>
						<p>The perspective view is achieved by adding a perspective value to the slide list item and tilting a division that contains the two screenshots.</p>
					</div>
					<div class="tiltview col">
						<a href="http://minimalmonkey.com/"><img src="${resourceUrl}/TiltedContentSlideshow/img/5_screen.jpg"/></a>
						<a href="http://www.herschelsupply.com/"><img src="${resourceUrl}/TiltedContentSlideshow/img/6_screen.jpg"/></a>
					</div>
				</li>
				<li>
					<div class="description">
						<h2>Column or Row</h2>
						<p>The items in the tilted container are either laid out in a column or in a row. For some directions we need to adjust the animation delays for the items, since we don't want the items to overlap each other when they move in or out.</p>
					</div>
					<div class="tiltview row">
						<a href="http://grovemade.com/"><img src="${resourceUrl}/TiltedContentSlideshow/img/1_mobile.jpg"/></a>
						<a href="https://tsovet.com/"><img src="${resourceUrl}/TiltedContentSlideshow/img/2_mobile.jpg"/></a>
					</div>
				</li>
				<li>
					<div class="description">
						<h2>Responsiveness</h2>
						<p>For smaller screens, the items on the right hand side will become less opaque and serve as decoration only. The focus will be on the description which will occupy all the width.</p>
					</div>
					<div class="tiltview col">
						<a href="http://pexcil.com/"><img src="${resourceUrl}/TiltedContentSlideshow/img/3_screen.jpg"/></a>
						<a href="http://foodsense.is/"><img src="${resourceUrl}/TiltedContentSlideshow/img/4_screen.jpg"/></a>
					</div>
				</li>
				<li>
					<div class="description">
						<h2>Navigation</h2>
						<p>For the "line" navigation we use a little trick to make the clickable area a bit bigger: we add a thick white border to the top and bottom of the span. Since the border is part of the element, it will be part of the clickable zone.</p>
					</div>
					<div class="tiltview row">
						<a href="http://minimalmonkey.com/"><img src="${resourceUrl}/TiltedContentSlideshow/img/5_mobile.jpg"/></a>
						<a href="http://www.herschelsupply.com/"><img src="${resourceUrl}/TiltedContentSlideshow/img/6_mobile.jpg"/></a>
					</div>
				</li>
			</ol>
		</div><!-- /slideshow -->
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
	setInterval(function(){
		if(el==7){
		$('#slideshow nav span:nth-child(1)').click();
		el=2;
		}
		else{
		$('#slideshow nav span:nth-child('+el+')').click();
		el=el+1;
		}
	},6000);
});
</script>

