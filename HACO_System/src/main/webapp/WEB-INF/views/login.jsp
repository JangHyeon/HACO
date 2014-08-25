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
		                <span class="pull-right forget">
		                    <a data-toggle="modal" href="login.html#idModal1">계정 </a> / 
		                    <a data-toggle="modal" href="login.html#passModal1"> 비밀번호</a>를 잊으셨나요?
		
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
		
		      </form>	 
		          <!-- idModal1 -->
		          <div aria-hidden="true" aria-labelledby="myModalLabel" role="dialog" tabindex="-1" id="idModal1" class="modal fade">
		              <div class="modal-dialog">
		                  <div class="modal-content">
		                      <div class="modal-header">
		                          <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
		                          <h4 class="modal-title">계정을 잊으셨나요 ?</h4>
		                      </div>
		                      <div class="modal-body">
		                          <p>가입시 입력한 성명과 이메일을 입력해주세요.</p>
		                          <input type="text" placeholder="성명" id="idName" autocomplete="off" class="form-control placeholder-no-fix"><br>
		                          <input type="text" placeholder="Email" id="idEmail" autocomplete="off" class="form-control placeholder-no-fix">
		                          <p id="idMsg"><strong>일치하는 계정이 없습니다.</strong></p>
		                      </div>
		                      <div class="modal-footer">
		                          <button data-dismiss="modal" class="btn btn-default" type="button">Cancel</button>
		                          <button id="findId" class="btn btn-theme" type="button">아이디 찾기</button>
		                      </div>
		                  </div>
		              </div>
		          </div>
		          <!-- modal -->
		          
		          <!-- idModal2 -->
		          <div aria-hidden="true" aria-labelledby="myModalLabel" role="dialog" tabindex="-1" id="idModal2" class="modal fade">
		              <div class="modal-dialog">
		                  <div class="modal-content">
		                      <div class="modal-header">
		                          <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
		                          <h4 class="modal-title">아이디 찾기</h4>
		                      </div>
		                      <div class="modal-body">
		                          <p>입력하신 성명과 이메일로 찾은 아이디입니다.</p>
		                          <h3><Strong id="resultID">일치하는 계정이 없습니다</Strong></h3>
									
		                      </div>
		                      <div class="modal-footer">
		                          <button id="idModalCloseBtn" data-dismiss="modal" class="btn btn-default" type="button">닫기</button>
		                      </div>
		                  </div>
		              </div>
		          </div>
		          <!-- modal -->	
		          
		          
		          <!-- passModal1 -->
		          <div aria-hidden="true" aria-labelledby="myModalLabel" role="dialog" tabindex="-1" id="passModal1" class="modal fade">
		              <div class="modal-dialog">
		                  <div class="modal-content">
		                      <div class="modal-header">
		                          <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
		                          <h4 class="modal-title">비밀번호를 잊으셨나요 ?</h4>
		                      </div>
		                      <div class="modal-body">
		                          <p>가입시 입력한 아이디와 이메일을 입력하시면 임시 비밀번호를 발송해 드립니다.</p>
		                          <input type="text" placeholder="ID" id="passID" autocomplete="off" class="form-control placeholder-no-fix"><br>
		                          <input type="text" placeholder="Email" id="passEmail" autocomplete="off" class="form-control placeholder-no-fix">
		                          <p id="passMsg"><strong>일치하는 계정이 없습니다.</strong></p>
		                      </div>
		                      <div class="modal-footer">
		                          <button data-dismiss="modal" class="btn btn-default" type="button">Cancel</button>
		                          <button id="findPassword" class="btn btn-theme" type="button">비밀번호 찾기</button>
		                      </div>
		                  </div>
		              </div>
		          </div>
		          <!-- modal -->		          
		          
		          <!-- passModal2 -->
		          <div aria-hidden="true" aria-labelledby="myModalLabel" role="dialog" tabindex="-1" id="passModal2" class="modal fade">
		              <div class="modal-dialog">
		                  <div class="modal-content">
		                      <div class="modal-header">
		                          <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
		                          <h4 class="modal-title">임시비밀번호를 발송했습니다.</h4>
		                      </div>
		                      <div class="modal-body">
		                          <p>가입시 입력한 이메일주소로 가셔서 확인해주세요.</p>
		                      </div>
		                      <div class="modal-footer">
		                          <button id="PasswordModalCloseBtn" data-dismiss="modal" class="btn btn-default" type="button">확인</button>
		                      </div>
		                  </div>
		              </div>
		          </div>
		          <!-- modal -->
		          
		          <!-- lodingmodel -->
		          <div aria-hidden="true" aria-labelledby="myModalLabel" role="dialog" tabindex="-1" id="lodingModal" class="modal fade">
		              <div class="modal-dialog">
		                  <div id="loaderImage"></div>
		              </div>
		          </div>
		          <!-- modal -->
		          
		          
		           	
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
        $.backstretch($src, {speed: 800});
        
        $(document).ready(function(){
        	
        	
        	$('.modal').keydown(function(e){    
   	            if(e.keyCode === 13){
	   	            e.preventDefault();
   		            return false;
    	        }
    	    });


			$('#idMsg').hide();
			$('#passMsg').hide();
        	

        	$('#idModal1').on('shown.bs.modal', function () {
        		$('#idName').focus();
        	});
			
        	$('#findId').on('click',function(){
        		$('#idMsg').hide();
        		$.post(
        	    	"/haco/forgetId", 	  //url
        	    	{
        	    		name:$('#idName').val(),
        	    		email:$('#idEmail').val()
        	    	},
        			function(data){
        	    		if(data =='notFindID'){
        	    			$('#idMsg').show();
        	    		}else{
        	    			$('#idMsg').hide();
        	    			$('#resultID').text(data);
        	    			$('#idModal2').modal('show');
        	    		}
        		   	}
        	   	)
        	});
        	
        	

        	$('#passModal1').on('shown.bs.modal', function () {
        		id:$('#passID').focus();
        	});
        	
        	$('#findPassword').on('click',function(){
        		$('#lodingModal').modal({
        			backdrop:false,
        			keyboard:false
        		});
    			$('#passMsg').hide();
        		$.post(
        	    	"/haco/forgetPassword", 	  //url
        	    	{
        	    		id:$('#passID').val(),
        	    		email:$('#passEmail').val()
        	    	},
        			function(data){
        	    		$('#lodingModal').modal('hide');
        	    		if(data =='notFind'){
        	    			$('#passMsg').show();
        	    		}else{
        	    			$('#passMsg').hide();
        	    			$('#passModal2').modal('show');
        	    		}
        		   	}
        	   	)
        	});
        	
        	
        	$('#PasswordModalCloseBtn').on('click',function(){
        		$('#passModal1').modal('hide');      
        		$('#passModal2').modal('hide');        		
        	});
        	
        	
        	
        	$('#idModalCloseBtn').on('click',function(){
        		$('#idModal1').modal('hide');      
        		$('#idModal2').modal('hide');        		
        	});
        });
    </script>

<script type="text/javascript">
	var cSpeed=9;
	var cWidth=128;
	var cHeight=128;
	var cTotalFrames=12;
	var cFrameWidth=128;
	var cImageSrc='${pageContext.request.contextPath}/images/sprites.png';
	
	var cImageTimeout=false;
	var cIndex=0;
	var cXpos=0;
	var cPreloaderTimeout=false;
	var SECONDS_BETWEEN_FRAMES=0;
	
	function startAnimation(){
		
		document.getElementById('loaderImage').style.backgroundImage='url('+cImageSrc+')';
		document.getElementById('loaderImage').style.width=cWidth+'px';
		document.getElementById('loaderImage').style.height=cHeight+'px';
		document.getElementById('loaderImage').style.opacity=0.3;
		document.getElementById('loaderImage').style.margin='0 auto';
		
		//FPS = Math.round(100/(maxSpeed+2-speed));
		FPS = Math.round(100/cSpeed);
		SECONDS_BETWEEN_FRAMES = 1 / FPS;
		
		cPreloaderTimeout=setTimeout('continueAnimation()', SECONDS_BETWEEN_FRAMES/1000);
		
	}
	
	function continueAnimation(){
		
		cXpos += cFrameWidth;
		//increase the index so we know which frame of our animation we are currently on
		cIndex += 1;
		 
		//if our cIndex is higher than our total number of frames, we're at the end and should restart
		if (cIndex >= cTotalFrames) {
			cXpos =0;
			cIndex=0;
		}
		
		if(document.getElementById('loaderImage'))
			document.getElementById('loaderImage').style.backgroundPosition=(-cXpos)+'px 0';
		
		cPreloaderTimeout=setTimeout('continueAnimation()', SECONDS_BETWEEN_FRAMES*1000);
	}
	
	function stopAnimation(){//stops animation
		clearTimeout(cPreloaderTimeout);
		cPreloaderTimeout=false;
	}
	
	function imageLoader(s, fun)//Pre-loads the sprites image
	{
		clearTimeout(cImageTimeout);
		cImageTimeout=0;
		genImage = new Image();
		genImage.onload=function (){cImageTimeout=setTimeout(fun, 0)};
		genImage.onerror=new Function('alert(\'Could not load the image\')');
		genImage.src=s;
	}
	
	//The following code starts the animation
	new imageLoader(cImageSrc, 'startAnimation()');
</script>


  </body>
</html>
