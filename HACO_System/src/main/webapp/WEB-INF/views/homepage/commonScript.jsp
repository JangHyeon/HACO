<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>

<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<!-- spEL을 활용한 리소스 버전 관리 -->
<spring:eval expression="@baseConfig['app.version']" var="applicationVersion" />
<spring:url value="/static-{applicationVersion}" var="resourceUrl">
	<spring:param name="applicationVersion" value="${applicationVersion}" />
</spring:url>


    <!-- DOM객체보다 나중에 로딩 되어야하는 스크립트 -->
    <script src="${resourceUrl}/assets/js/jquery.js"></script>
    <script src="${resourceUrl}/assets/js/jquery-1.8.3.min.js"></script>
    <script src="${resourceUrl}/assets/js/bootstrap.min.js"></script>
    <script src="${resourceUrl}/assets/js/jquery.dcjqaccordion.2.7.js"></script>
    <script src="${resourceUrl}/assets/js/jquery.scrollTo.min.js"></script>
    <script src="${resourceUrl}/assets/js/jquery.nicescroll.js" type="text/javascript"></script>

    <!-- 모든 페이지에서 사용되는 스크립트 -->
    <script src="${resourceUrl}/assets/js/common-scripts.js"></script>
