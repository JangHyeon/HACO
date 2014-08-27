<%@page import="kr.co.haco.VO.Subject"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="s" uri="http://www.springframework.org/security/tags"%>
<!-- Begin Body -->
<h1>과정설명</h1>
<section id="main-content">
 	<section class="wrapper site-min-height">
 	<body>
 		<div class="row mt">
			<div class="col-md-12">
				<div class="content-panel">
					<table class="table table-striped table-advance table-hover">
								<h1>죄송합니다 정원이 초과되어 수강신청을 하실 수 없습니다.</h1>
					</table>
				</div>
			</div>
		</div>
	</body>
	</section>
</section>
<!-- script references -->
<script	src="${pageContext.request.contextPath}/resources/gazONojfL3/js/jquery.1.9.1.min.js"></script>
<script	src="${pageContext.request.contextPath}/resources/gazONojfL3/js/bootstrap.3.2.0.min.js"></script>

<script>
$(document).ready(function(){
	$('#selectType>li').on('click',function(){
		$('#searchType>span:first-child').text($('a',this).text());
		$('input[name=searchType]').val($(this).attr('value'));
	});
});

</script>