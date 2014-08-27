<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="s" uri="http://www.springframework.org/security/tags"%>


<nav class="navbar navbar-static">
   <div class="container">
    <div class="navbar-header">
      <a class="navbar-brand logo" href="${pageContext.request.contextPath}"><b>HACO Academy</b></a>
      <a class="navbar-toggle" data-toggle="collapse" data-target=".navbar-collapse">
        <span class="glyphicon glyphicon-chevron-down"></span>
      </a>
    </div>
      <div class="navbar-collapse collapse">
        <ul class="nav navbar-nav">
          <li class="dropdown">
            <a href="#" class="dropdown-toggle" data-toggle="dropdown">학원소개</a>
            <ul class="dropdown-menu">
              <li><a href="${pageContext.request.contextPath}/introduction">학원 소개</a></li>
              <li><a href="${pageContext.request.contextPath}/introductionGreeting">학원장 인사말</a></li>
              <li><a href="${pageContext.request.contextPath}/contectUs">찾아오시는 길</a></li>
            </ul>
          </li>
          <li class="dropdown">
          	<a href="#" class="dropdown-toggle" data-toggle="dropdown">교육과정</a>
          	<ul class="dropdown-menu">
          	 <li><a href="${pageContext.request.contextPath}/lectureregister">수강신청</a></li>
          	 </ul>
          </li>
          <li class="dropdown">
            <a href="#" class="dropdown-toggle" data-toggle="dropdown">열린마당</a>
            <ul class="dropdown-menu">
              <li><a href="${pageContext.request.contextPath}/notice">공지사항</a></li>
              <li><a href="${pageContext.request.contextPath}/qna">질문과 답변</a></li>
              <li><a href="${pageContext.request.contextPath}/community">모임방</a></li>
            </ul>
          </li>
          <li class="dropdown">
            <a href="#" class="dropdown-toggle" data-toggle="dropdown">강의평가</a>
            <ul class="dropdown-menu">
              <li><a href="#">강의평가</a></li>
              <li><a href="#">평가결과</a></li>
            </ul>
          </li>
        </ul>
        <ul class="nav navbar-right navbar-nav">
          <!-- 검색 레이어 
          <li class="dropdown">
            <a href="#" class="dropdown-toggle" data-toggle="dropdown"><i class="glyphicon glyphicon-search"></i></a>
            <ul class="dropdown-menu" style="padding:12px;">
                <form class="form-inline">
     				<button type="submit" class="btn btn-default pull-right"><i class="glyphicon glyphicon-search"></i></button><input type="text" class="form-control pull-left" placeholder="Search">
                </form>
             </ul>
          </li>
           -->
          
		  <s:authorize ifNotGranted="GUEST,STUDENT">
		  	<li><a href="${pageContext.request.contextPath}/login">로그인</a></li> 
		  </s:authorize>
		  <s:authorize ifAnyGranted="GUEST,STUDENT">
		  	<li class="dropdown">
            <a href="#" class="dropdown-toggle" data-toggle="dropdown"><i class="glyphicon glyphicon-user"></i> <i class="glyphicon glyphicon-chevron-down"></i></a>
            <ul class="dropdown-menu">
              <li><a href="${pageContext.request.contextPath}/myPage">마이 페이지</a></li>
              <li class="divider"></li>
              <li><a href="${pageContext.request.contextPath}/memberLogout">로그아웃</a></li>
             </ul>
          </li>
		  </s:authorize>
          
        </ul>
      </div>
    </div>
</nav><!-- /.navbar -->