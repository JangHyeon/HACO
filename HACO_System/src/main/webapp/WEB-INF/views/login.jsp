<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="s" uri="http://www.springframework.org/security/tags"%>

<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="">
    <meta name="author" content="Dashboard">
    <meta name="keyword" content="Dashboard, Bootstrap, Admin, Template, Theme, Responsive, Fluid, Retina">

	<!-- favicon -->
	<link rel="icon" href="${pageContext.request.contextPath}/resources/favicon.ico" type="image/x-icon" />
    
    
    <title>DASHGUM - Bootstrap Admin Template</title>

    <!-- Bootstrap core CSS -->
    <link href="${pageContext.request.contextPath}/resources/assets/css/bootstrap.css" rel="stylesheet">
    <!--external css-->
    <link href="${pageContext.request.contextPath}/resources/assets/font-awesome/css/font-awesome.css" rel="stylesheet" />
        
    <!-- Custom styles for this template -->
    <link href="${pageContext.request.contextPath}/resources/assets/css/style.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/resources/assets/css/style-responsive.css" rel="stylesheet">

    <!-- HTML5 shim and Respond.js IE8 support of HTML5 elements and media queries -->
    <!--[if lt IE 9]>
      <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
      <script src="https://oss.maxcdn.com/libs/respond.js/1.4.2/respond.min.js"></script>
    <![endif]-->
  </head>

  <body>

      <!-- **********************************************************************************************************************************************************
      MAIN CONTENT
      *********************************************************************************************************************************************************** -->
	
	  <div id="login-page">
	  	<div class="container">
	  	
		      <form class="form-login" action="${pageContext.request.contextPath}/LoginProcessing" method="post">
		        <h2 class="form-login-heading">Login now</h2>
		        <div class="login-wrap">
		            <input name="id" type="text" class="form-control" placeholder="User ID" autofocus>
		            <br>
		            <input name="pwd" type="password" class="form-control" placeholder="Password">
		            
					<!-- 로그아웃 성공 -->
					<c:if test="${param.logout=='success'}">
						<div class="alert alert-dismissable login">
						  <button type="button" class="close" data-dismiss="alert" aria-hidden="true">×</button>
						  <strong>Info!</strong><br>정상적으로 로그아웃되었습니다.
						</div>
					</c:if>
		            
		            <c:if test="${param.error != null}">
						<div>
							
							<!-- LoginFailureHandler에서 예외처리 -->
							<c:if test="${SPRING_SECURITY_LAST_EXCEPTION != null}">
								<c:if test="${SPRING_SECURITY_LAST_EXCEPTION=='Bad credentials'}">
									<div class="alert alert-dismissable login">
									  <strong>Info!</strong><br>아이디 / 비밀번호를 확인해주세요.
									</div>
								</c:if>
								<c:if test="${SPRING_SECURITY_LAST_EXCEPTION=='Maximum sessions of 1 for this principal exceeded'}">
									<div class="alert alert-dismissable login">
									  <button type="button" class="close" data-dismiss="alert" aria-hidden="true">×</button>
									  <strong>Info!</strong><br>해당 계정은 이미 로그인 되어있습니다.
									</div>
								</c:if>
							</c:if>
							
							<!-- LoginSuccessHandler에서 권한처리-->
							<c:if test="${param.error=='denied'}">
								<div class="alert alert-danger login">
								  <strong>경고!</strong><br>권한이 부족합니다.
								</div>
							</c:if>
							
							<!-- Security-context.xml > security:session-management 세션 설정 -->
							<!-- 중복 로그인시 기존 로그인 로그아웃 -->
							<c:if test="${param.error=='expired'}">
								<div class="alert alert-warning login">
								  <button type="button" class="close" data-dismiss="alert" aria-hidden="true">×</button>
								  <strong>Warning!</strong><br>다른 장소에서 로그인이 되어<br> 로그아웃 되었습니다.
								</div>
							</c:if>		
						</div>
						
					</c:if>
		            
		            
		            <label class="checkbox">
		                <span class="pull-right">
		                    <a data-toggle="modal" href="login.html#myModal"> 비밀번호를 잊으셨나요?</a>
		
		                </span>
		            </label>
		            <button class="btn btn-theme btn-block" href="index.html" type="submit"><i class="fa fa-lock"></i>  로그인</button>
		            <hr>
		            
		            <div class="registration">
		                계정을 보유하시지 않으신가요?<br/>
		                <a class="" href="${pageContext.request.contextPath}/joinIntro">
		                    계정 생성
		                </a>
		            </div>
		
		        </div>
		
		          <!-- Modal -->
		          <div aria-hidden="true" aria-labelledby="myModalLabel" role="dialog" tabindex="-1" id="myModal" class="modal fade">
		              <div class="modal-dialog">
		                  <div class="modal-content">
		                      <div class="modal-header">
		                          <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
		                          <h4 class="modal-title">Forgot Password ?</h4>
		                      </div>
		                      <div class="modal-body">
		                          <p>Enter your e-mail address below to reset your password.</p>
		                          <input type="text" name="email" placeholder="Email" autocomplete="off" class="form-control placeholder-no-fix">
		
		                      </div>
		                      <div class="modal-footer">
		                          <button data-dismiss="modal" class="btn btn-default" type="button">Cancel</button>
		                          <button class="btn btn-theme" type="button">Submit</button>
		                      </div>
		                  </div>
		              </div>
		          </div>
		          <!-- modal -->
		      </form>	  	
	  	</div>
	  </div>

    <!-- js placed at the end of the document so the pages load faster -->
    <script src="${pageContext.request.contextPath}/resources/assets/js/jquery.js"></script>
    <script src="${pageContext.request.contextPath}/resources/assets/js/bootstrap.min.js"></script>

    <!--BACKSTRETCH-->
    <!-- You can use an image of whatever size. This script will stretch to fit in any screen size.-->
    <script type="text/javascript" src="${pageContext.request.contextPath}/resources/assets/js/jquery.backstretch.min.js"></script>
    <script>
    	$src = "${pageContext.request.contextPath}/resources/assets/img/login-bg.jpg";
        $.backstretch($src, {speed: 500});
    </script>

  </body>
</html>
