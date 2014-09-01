<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="s" uri="http://www.springframework.org/security/tags"%>

<!-- **********************************************************************************************************************************************************
      TOP BAR CONTENT & NOTIFICATIONS
      *********************************************************************************************************************************************************** -->
      <!--header start-->
      <header class="header black-bg">
              <div class="sidebar-toggle-box">
                  <div class="fa fa-bars tooltips" data-placement="right" data-original-title="Toggle Navigation"></div>
              </div>
            <!--logo start-->
            <a href="${pageContext.request.contextPath}/management/index" class="logo"><b>HACO SYSTEM</b></a>
            <!--logo end-->
            
            <div class="top-menu">
				<ul class="nav pull-right top-menu">
					<li id="fat-menu" class="dropdown">
					<a href="#" id="drop3" role="button" class="mypage dropdown-toggle" data-toggle="dropdown">MyPage<b class="caret"></b>					</a>
					<ul class="dropdown-menu" role="menu" aria-labelledby="drop3">
						<li role="presentation" class="dropdown-header">MyPage</li>
						<li role="presentation"><a role="menuitem" tabindex="-1" href="${pageContext.request.contextPath}/management/employeeDetail">프로필</a></li>
						<li role="presentation"><a role="menuitem" tabindex="-1" href="${pageContext.request.contextPath}/management/employeeUpdate">회원정보 수정</a></li>
						<%-- <li role="presentation"><a role="menuitem" tabindex="-1" href="${pageContext.request.contextPath}/logout">비밀번호 수정</a></li> --%>
						<li role="presentation" class="divider"></li>
						<li role="presentation"><a role="menuitem" tabindex="-1" href="${pageContext.request.contextPath}/logout">로그아웃</a></li>
					</ul>
					</li>
				</ul>
				
            	<ul class="nav pull-right top-menu">
                    <li><a class="logout" href="${pageContext.request.contextPath}">Haco Academy</a></li>
            	</ul>
			<%-- 
			
			<sec:authorize ifAllGranted="ROLE_USER,ROLE_ADMIN"></sec:authorize>  
			: 사용자가 ROLE_USER,ROLE_ADMIN 두개의 권한을 다 가져야 볼수 있음.
			<sec:authorize ifNotGranted="ROLE_USER,ROLE_ADMIN"></sec:authorize>
			: 사용자가 ROLE_USER,ROLE_ADMIN 중 하나라도 가지고 있으면 볼수 없음. 
			<sec:authorize ifAnyGranted="ROLE_USER,ROLE_ADMIN"></sec:authorize>
			: 사용자가 ROLE_USER,ROLE_ADMIN 중 하나라도 가지고 있으면 볼 수 있음. 
			
			 --%>			 

			 <!-- : 접속자의 권한  -->
			 <%-- <s:authentication property="Authorities"/><br> --%>
			 
			 <!-- : 키로 설정한 값 (principle) -->
			 <%-- <s:authentication property="name"/> --%>
			 
			 <!-- : authentication에 저장된 모든 값 -->
			 <!-- <s:authentication property="principal"/> -->
 
            </div>

        </header>
      <!--header end-->
      