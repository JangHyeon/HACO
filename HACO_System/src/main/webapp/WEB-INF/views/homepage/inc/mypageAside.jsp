<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="s" uri="http://www.springframework.org/security/tags"%>


<div class="col-md-2">
	<div class="panel panel-default" id="sidebar">
		<div class="panel-heading">메뉴</div>
		<div class="panel-body">
			<ul class="nav nav-stacked">
				<li><a href="${pageContext.request.contextPath}/memberModify">회원정보수정</a></li>
				<li><a href="#">수강내역</a></li>
				<li><a href="${pageContext.request.contextPath}/memberattendance">출석정보</a><li>
				<hr>
				<li><a href="${pageContext.request.contextPath}/memberDelete">회원탈퇴</a></li>
			</ul>

			<hr>

		</div>
		<!--/panel body-->
	</div>
	<!--/panel-->
</div>
