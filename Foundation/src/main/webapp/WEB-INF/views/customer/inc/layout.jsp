<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles" %> 
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>
	<!-- title 영역 -->
	<tiles:getAsString name="title"/> 
</title>
<link href="notice.css" type="text/css" rel="stylesheet" />
</head>
<body>	
		<!-- header 영역 -->
		<tiles:insertAttribute name="header"></tiles:insertAttribute>
		<!-- visual 영역 -->
		<tiles:insertAttribute name="visual"></tiles:insertAttribute>
		<!-- main 영역 -->
		<div id="main">
			<div class="top-wrapper clear">
				<!-- content 영역 -->
				<tiles:insertAttribute name="content"></tiles:insertAttribute>
				<!-- navi  영역 -->
				<tiles:insertAttribute name="aside"></tiles:insertAttribute>
			</div>
		</div>
		<!-- footer 영역 -->
		<tiles:insertAttribute name="footer"></tiles:insertAttribute>
</body>
</html>
