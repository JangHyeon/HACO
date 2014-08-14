<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles" %>    
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="">
    <meta name="author" content="Dashboard">
    <meta name="keyword" content="Dashboard, Bootstrap, Admin, Template, Theme, Responsive, Fluid, Retina">
	<link rel="icon" href="${pageContext.request.contextPath}/resources/favicon.ico" type="image/x-icon" />

	<!-- title 영역 -->
	<title><tiles:getAsString name="title"/> : HACO System</title>

	<!-- Bootstrap core CSS -->
    <link href="${pageContext.request.contextPath}/resources/assets/css/bootstrap.css" rel="stylesheet">
    
    
    <!-- HTML5 shim and Respond.js IE8 support of HTML5 elements and media queries -->
    <!--[if lt IE 9]>
      <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
      <script src="https://oss.maxcdn.com/libs/respond.js/1.4.2/respond.min.js"></script>
    <![endif]-->
  </head>

	<body>
		<section id="container" >
			<!-- header 영역 -->
			<tiles:insertAttribute name="header"></tiles:insertAttribute>
			
			<!-- aside 영역 -->
			<tiles:insertAttribute name="aside"></tiles:insertAttribute>
			
			<!-- content 영역 -->
			<tiles:insertAttribute name="content"></tiles:insertAttribute>
			
			<!-- footer 영역  -->
			<tiles:insertAttribute name="footer"></tiles:insertAttribute>
		</section>		
	</body>
</html>
