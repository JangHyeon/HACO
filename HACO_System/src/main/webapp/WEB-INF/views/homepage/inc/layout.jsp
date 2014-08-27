<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles" %>

<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<!-- spEL을 활용한 리소스 버전 관리 -->
<spring:eval expression="@baseConfig['app.version']" var="applicationVersion" />
<spring:url value="/static-{applicationVersion}" var="resourceUrl">
	<spring:param name="applicationVersion" value="${applicationVersion}" />
</spring:url>


<!DOCTYPE html>
<html>
	<head>
		<meta http-equiv="content-type" content="text/html; charset=UTF-8">
		<meta charset="utf-8">
		
		<meta name="generator" content="Bootply" />
		<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
		
		<!-- favicon -->
		<link rel="icon" href="${resourceUrl}/favicon.ico" type="image/x-icon" />
		
		<!-- title 영역 -->
		<title><tiles:getAsString name="title"/> : HACO Academy</title>
		
		<link rel="stylesheet" href="//maxcdn.bootstrapcdn.com/bootstrap/3.2.0/css/bootstrap.min.css">
		<link href="//maxcdn.bootstrapcdn.com/font-awesome/4.1.0/css/font-awesome.min.css" rel="stylesheet">
		
		
		<!--[if lt IE 9]>
			<script src="//html5shim.googlecode.com/svn/trunk/html5.js"></script>
		<![endif]-->
		<link href="${resourceUrl}/gazONojfL3/css/styles.css" rel="stylesheet">
	</head>
<body>	
	<!-- header 영역 -->
	<tiles:insertAttribute name="header"></tiles:insertAttribute>
	
	<!-- content 영역 -->
	<tiles:insertAttribute name="content"></tiles:insertAttribute>
	
	<!-- footer 영역  -->
	<tiles:insertAttribute name="footer"></tiles:insertAttribute>
</body>
</html>