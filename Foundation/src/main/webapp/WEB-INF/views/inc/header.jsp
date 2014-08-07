<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="s" uri="http://www.springframework.org/security/tags"%>
<div id="header">
	<div class="top-wrapper">
		<h1 id="logo">
			<a href="${pageContext.request.contextPath}/index.htm"><img src="" alt="로고" /></a>
		</h1>
		<h2 class="hidden">메인메뉴</h2>
		<ul id="mainmenu" class="block_hlist">
			<li><a href="">kosta가이드</a></li>
			<li><a href="">kosta과정</a></li>
			<li><a href="">kosta</a></li>
		</ul>
		<form id="searchform" action="" method="get">
			<fieldset>
				<legend class="hidden"> 과정검색폼 </legend>
				<label for="query">과정검색</label> <input type="text" name="query" />
				<input type="submit" class="button" value="검색" />
			</fieldset>
		</form>
		<h3 class="hidden">로그인메뉴</h3>
		<ul id="loginmenu" class="block_hlist">
			<li><a href="${pageContext.request.contextPath}/index.htm">HOME</a></li>
			
			<%-- 1단계 jstl 사용
			<c:if test="${empty pageContext.request.userPrincipal}">
				<li><a href="${pageContext.request.contextPath}/joinus/login.htm">로그인</a></li>
			</c:if>
			<c:if test="${not empty pageContext.request.userPrincipal}">
				<li><a href="${pageContext.request.contextPath}/j_spring_security_logout">
				(${pageContext.request.userPrincipal.name})로그아웃</a></li>
			</c:if>
			 --%>
			 
			 <!-- 2단계 http://www.springframework.org/security/tags"-->
			 <s:authorize ifNotGranted="ROLE_USER">
			 	<li><a href="${pageContext.request.contextPath}/joinus/login.htm">로그인</a></li>
			 </s:authorize>
			 <s:authentication property="name" var="LoginUser"/>
			 <s:authorize ifAnyGranted="ROLE_USER,ROLE_ADMIN">
			 	<li><a href="${pageContext.request.contextPath}/j_spring_security_logout">
			 	(${LoginUser})로그아웃</a></li>
			 </s:authorize>
			 
			 <!-- 
			 	위 코드 설명
			 	1. <s:authorize ifNotGranted="ROLE_USER">
			 		NOT ROLE_USER (로그인한 사용자가 ROLE_USER 그룹이 아니면)
			 	   </s:authorize>
			 	
			 	2. <s:authorize ifAllGranted="ROLE_USER">
			 		ALL -> AND => ROLE_USER and ROLE_ADMIN(로그인한 사용자.. 둘다 만족할 경우)
			 	   </s:authorize>	
			 	
			 	3. <s:authorize ifAnyGranted="ROLE_USER">
			 		ANY -> OR => ROLE_ALL or ROLE_USER (로그인한 사용자가 아무거나 만족할 경우)
			 	   </s:authorize>	
			  -->
			
			<li><a href="${pageContext.request.contextPath}/joinus/join.htm">회원가입</a></li>
		</ul>
		<h3 class="hidden">회원메뉴</h3>
		<ul id="membermenu" class="clear">
			<li><a href=""><img src="${pageContext.request.contextPath}/images/menuMyPage.png" alt="마이페이지" /></a>
			</li>
			<li><a href="${pageContext.request.contextPath}/customer/notice.htm"><img
					src="${pageContext.request.contextPath}/images/menuCustomer.png" alt="고객센터" /></a></li>
		</ul>
	</div>
</div>
