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

<!-- myPage header column -->
<%@ include file="inc/mypageHeader.jsp" %>

<!-- Begin Body -->
<div class="container">
	<div class="no-gutter row">
		
		<!-- left side column -->
		<%@ include file="inc/mypageAside.jsp" %>
		<!-- END/left side column -->


		<!-- right content column-->
		<div class="col-md-10" id="content">
			<div class="panel">
				<ol class="breadcrumb">
				  <li class="active">회원탈퇴</li>
				</ol>
				<div class="panel-body">
					<div class="row content" id="step1">
						<div class="col-sm-12 col-md-4 col-md-offset-1 delete_img">
							<img src="${pageContext.request.contextPath}/images/user-delete.svg"/>
						</div>
						<div class="col-sm-8 col-sm-offset-2 col-md-5 col-md-offset-1 email_text">
							<form id="deleteMemberForm" class="form-horizontal style-form" method="post">
							<div class="textbox">
								<h2 class="title">
									회원탈퇴
								</h2>
								<h5><a>${sessionScope.member.name}</a>님, 정말로 탈퇴하시나요?
								</h5>
								<label class="passwordLabel control-label">패스워드</label>
								<input type="password" class="form-control" id="password" name="password">
								<c:if test="${result=='notmatch'}">
									<strong>비밀번호</strong>가 맞지 않습니다.
								</c:if>
								<div class="btn-group mypageBtn">
									<button id="deleteBtn" class="btn btn-large btn-block btn-danger joinbtn" type="button">탈퇴하기</button>
								</div>
							</div>
							</form>
						</div>
					</div>
					
					<hr style="display:block;clear:both;">

				</div>
				<!--/panel-body-->
			</div>
			<!--/panel-->
			<!--/end right column-->
		</div>
	</div>
</div>

<!-- script references -->
<script src="${resourceUrl}/gazONojfL3/js/jquery.1.9.1.min.js"></script>
<script	src="${resourceUrl}/gazONojfL3/js/bootstrap.3.2.0.min.js"></script>
<script	src="${resourceUrl}/gazONojfL3/js/scripts.js"></script>

<!-- JavaScript jQuery code from Bootply.com editor  -->

<script type="text/javascript">
	$(document).ready(function() {
		
		$('#sidebar').affix({
			offset : {
				top : 230,
				bottom : 100
			}
		});
		$('#deleteBtn').on('click',function(){
			$('#deleteMemberForm').submit();
		});
		var regexpVeryLow = /^.*(?=.{7,20}).*$/;
		$('#deleteMemberForm').submit(function(){
			if($('#password').val() == ""){
                alert("패스워드 입력하세요");
                $('#password').focus();
                return false;
           }else if(!regexpVeryLow.test($('#password').val())) {   
               alert("패스워드는 7~20자 입니다.");
               $('#password').focus();
               return false;
           }
		});
	});
</script>

