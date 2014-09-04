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

<link rel="stylesheet" href="${resourceUrl}/Remodal/jquery.remodal.css">



<!-- Begin Body -->
<div class="container">
	<div class="no-gutter row">
		
		<!-- content column-->
		<div class="col-xs-12 col-sm-12 col-md-10 col-md-offset-1 panel" id="joinform">
			<div class="page-header">
				<h1 class="title">
					계정 만들기 <small>정보 입력</small>
				</h1>
			</div>
			
			<!-- 진행바 -->
			<div class="progress progress-striped active">
			  <div class="progress-bar progress-bar-success" style="width: 20%"></div>
			  <div id="joinProgress" class="progress-bar progress-bar-warning" style="width: 0%"></div>
			</div>	
			
			<div class="form-panel">
                      <form id="joinForm" class="form-horizontal style-form" method="post">
                          <div class="page-header">
  							<h3><small>필수 정보</small></h3>
						  </div>
                          <div class="form-group">
                              <label class="col-sm-3 control-label"><i class="fa fa-check fa-lg"></i> 아이디</label>
                              <div class="col-sm-8 idArea">
								  <input type="text" class="form-control" id="id" name="id" disabled>
								  <input type="hidden" id="somecheck" value="no"/>                   
                                  <span class="help-block">4~25자의 영문과 숫자로 사용하실 수 있습니다.</span>
                              </div>
                          </div>
                          <div class="form-group">
                          	 
                              <label class="passwordLabel col-sm-3 control-label"><i class="fa fa-check fa-lg"></i> 패스워드</label>
                              <div class="col-sm-8">
                              		<div id="primary-progress-label">
                              			<span class="label label-default">보안 강도</span>
										<span class="label label-danger">위험</span>
										<span class="label label-warning">낮음</span>
										<span class="label label-success">보통</span>
	                              	    <span class="label label-primary">높음</span>
									</div>
									<div id="primary-progress" class="progress progress-striped active">
										<div class="progress-bar progress-bar-primary" style="width: 0%"></div>
										<div class="progress-bar progress-bar-success" style="width: 0%"></div>
										<div class="progress-bar progress-bar-warning" style="width: 0%"></div>
										<div class="progress-bar progress-bar-danger" style="width: 0%"></div>
									</div>
                              	  
                              	  
                                  <input type="password" class="form-control" id="password" name="password">
                              </div>
                              <label class="col-sm-3 control-label"><i class="fa fa-check fa-lg"></i> 패스워드 재입력</label>
                              <div class="col-sm-8">
                                  <input name="joinpassword" type="password" id="passwordCheck" name="passwordCheck"  class="form-control">
                                  <span class="help-block">7~20자의 영문, 숫자, 특수문자의 조합만 사용 가능합니다. </span>
                              </div>
                          </div>
                          <div class="form-group">
                              <label class="col-sm-3 control-label"><i class="fa fa-check fa-lg"></i> 성명</label>
                              <div class="col-sm-8">
                                  <input type="text" class="form-control" id="name" name="name">
                              </div>
                          </div>
                          <div class="form-group">
                              <label class="col-sm-3 control-label"><i class="fa fa-check fa-lg"></i> 이메일</label>
                              <div class="col-sm-8">
                                  <input type="email" class="form-control" id="email" name="email">
                                  <span class="help-block">실제 사용 중인 이메일 주소가 아니면 비밀번호를 분실 시 찾을 수 없습니다.</span>
                              </div>
                          </div>
                          <div class="form-group phoneNumber">
                              <label class="col-sm-3 control-label"><i class="fa fa-check fa-lg"></i> 휴대폰번호</label>
                              
                              <div class="col-sm-8">
								  <div class="btn-group">
								    <button id="firstPhoneNumberBtn" type="button" class="btn btn-default dropdown-toggle" data-toggle="dropdown">
						              <span>010 </span>
								      <span class="caret"></span>
								    </button>
								    <ul id="firstPhoneNumber" class="dropdown-menu pull-right pageSize">
								      <li value="010"><a>010</a></li>
								      <li value="011"><a>011</a></li>
								      <li value="016"><a>016</a></li>
								      <li value="017"><a>017</a></li>
								      <li value="019"><a>019</a></li>
								    </ul>
								  </div>
                                  <input class="form-control onlyNumber" type="hidden"  id="phoneNum1" name="phoneNum1" maxlength="3" value="010" ><i class="fa fa-minus"></i>
                                  <input class="form-control onlyNumber" type="tel"  id="phoneNum2" name="phoneNum2" maxlength="4"><i class="fa fa-minus"></i>
                                  <input class="form-control onlyNumber" type="tel"  id="phoneNum3" name="phoneNum3" maxlength="4">
                              </div>
                          </div>
                          
                          <div class="page-header">
  							<h3><small>부가 정보</small></h3>
						  </div>
                          
                          <div class="form-group zipcode">
                              <label class="col-sm-3 control-label">우편번호</label>
                              <div class="col-sm-8">
	                              <div class="input-group">
						            <input type="text"  class="form-control" id="zipcode" name="zipcode" readonly="readonly">
						            <span class="input-group-btn">
						              <button id="zipcodeBtn" class="btn btn-large btn-block btn-default" type="button">우편번호 찾기</button>
						            </span>
						          </div>
                              </div>
                          </div>
                          <div class="form-group">
                              <label class="col-sm-3 control-label">주소</label>
                              <div class="col-sm-8">
                                  <input type="text"  class="form-control" id="address" name="address" readonly="readonly">
                                  <input type="text"  class="form-control" id="address_detail" name="address_detail">
                              </div>
                          </div>
                          <div class="form-group">
                              <label class="col-sm-3 control-label">근무 회사명</label>
                              <div class="col-sm-8">
                                  <input type="text"  class="form-control" id="company" name="company">
                              </div>
                          </div>
                          <div class="form-group">
                              <label class="col-sm-3 control-label">직위</label>
                              <div class="col-sm-8">
                                  <input type="text"  class="form-control" id="position" name="position">
                              </div>
                          </div>
                          <div class="form-group">
                              <label class="col-sm-3 control-label">직무</label>
                              <div class="col-sm-8">
                                  <input type="text"  class="form-control" id="job_duty" name="job_duty">
                              </div>
                          </div>
                          <div class="btn-group mypageBtn">
							<button id="joinBtn" class="btn btn-large btn-block btn-warning joinbtn" type="button">가입</button>
						  </div>
                      </form>
                  </div>
		</div>
	</div>
</div>


<div id="zipcodeModal" class="remodal" data-remodal-id="modal"></div>


<!-- lodingmodel -->
<div aria-hidden="true" aria-labelledby="myModalLabel" role="dialog" tabindex="-1" id="lodingModal" class="modal fade">
	<div class="modal-dialog">
		<div id="loaderImage"></div>
	</div>
</div>
<!-- modal -->

<!-- script references -->
<script src="${resourceUrl}/gazONojfL3/js/jquery.1.9.1.min.js"></script>
<script	src="${resourceUrl}/gazONojfL3/js/bootstrap.3.2.0.min.js"></script>
<script	src="${resourceUrl}/gazONojfL3/js/scripts.js"></script>
<script src="http://dmaps.daum.net/map_js_init/postcode.js"></script>
<script src="${resourceUrl}/Remodal/jquery.remodal.min.js"></script>
<script type="text/javascript" src="${resourceUrl}/js/jquery.alphanum.js"></script>

<!-- JavaScript jQuery code from Bootply.com editor  -->
<script type="text/javascript">
	$(document).ready(function(){
		// init join.jsp
		$('#id').attr('disabled',false);
		$('#id').focus();
		$('#joinProgress').css('width','50%');
		
		// 페이지 이탈시 작동
		var beforeUnload = 1;
		$(window).on('beforeunload',function(){
			if(beforeUnload)
				return "저장하지 않고 페이지를 벗어나려 합니다.\n작성중인 내용은 저장되지 않습니다.";
		});
		
		// BackSpace 키 방지 이벤트
	    $(document).keydown(function(e){    
	        if(e.target.nodeName != "INPUT" && e.target.nodeName != "TEXTAREA"){        
	            if(e.keyCode === 8){
	            e.preventDefault();
	            return false;
	            }
	        }
	    });
		

	    $("#id").alphanum();
	    $("#id").css("ime-mode","disabled");
	    $("input[type=tel]").numeric();
		
		//아이디 중복 체크
		$('#id').tooltip({
			animation:false,
			trigger:'manual',
			title:"　이미 존재하는 아이디입니다.　"
		});
		var delay=300;
		var timer = null;
		var cnt = 0;
		var idPush = function(){
			$.post(
	    		"/haco/checkId", 	  //url
	    		"id="+$('#id').val(), //data(send)
				function(data){
	    			if(data =='error'){
	    				$('#id').tooltip('show');
	    				$('#somecheck').val('no');
	    			}else{
	    				//console.log(data.result);
	    				$('#id').tooltip('hide');
	    				$('#somecheck').val('ok');
	    			}
			   	}
	   		)
			
		};
		$('#id').keyup(function(){
			clearTimeout(timer);
			timer = setTimeout(idPush,delay);
		});
		
		
		
		//우편번호
		var $inst = $.remodal.lookup[$('[data-remodal-id=modal]').data('remodal')];
	    var element = document.getElementById('zipcodeModal');
		
	    $('#zipcodeBtn').on('click',function(){
			new daum.Postcode({
				oncomplete: function(data) {
	                // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.
	                // 우편번호와 주소 정보를 해당 필드에 넣고, 커서를 상세주소 필드로 이동한다.
	                $('#zipcode').val(data.postcode);
	                $('#address').val(data.address);

	                //전체 주소에서 연결 번지 및 ()로 묶여 있는 부가정보를 제거하고자 할 경우,
	                //아래와 같은 정규식을 사용해도 된다. 정규식은 개발자의 목적에 맞게 수정해서 사용 가능하다.
	                //var addr = data.address.replace(/(\s|^)\(.+\)$|\S+~\S+/g, '');
	                //document.getElementById('addr').value = addr;

	                $('#address_detail').focus();
	    			$inst.close();
				},
				onresize : function(size) {
	                element.style.height = size.height + "px";
	            },
	            width : '100%',
	            height : '100%'
			}).embed(element);
			$inst.open();
	    });
		
		
        //비밀번호 보안 강도
        var regexpVeryLow = /^.*(?=.{7,20}).*$/;
        var regexpLow = /^.*(?=.{7,20})(?=.*[a-zA-Z0-9]).*$/;
        var regexpNormal = /^.*(?=.{7,20})(?=.*[a-z])(?=.*\d).*$/;
        var regexpNormal2 = /^.*(?=.{7,20})(?=.*[a-z])(?=.*[A-Z]).*$/;
        var regexpHigh = /^.*(?=.{7,20})(?=.*[a-z])(?=.*[A-Z])(?=.*\d).*$/;
        var regexpVeryHigh = /^.*(?=.{7,20})(?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?=.*[~!@#$%^&*()_+]).*$/;
        //var regexpVeryHigh = /^.*(?=.{7,20})(?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?=.*[~!@#$%^&*()_+]).*$/;
        
        $('#password').keyup(function(){
        	if(regexpVeryLow.test($('#password').val())) {
        		$('#primary-progress .progress-bar').css('width','0%');
	    		if(regexpLow.test($('#password').val())) {
	                //alert("영문 포함 7~20자");
            		$('#primary-progress .progress-bar').css('width','0%');
            		$('#primary-progress .progress-bar-danger').css('width','100%');
	        		if(regexpNormal.test($('#password').val()) || regexpNormal2.test($('#password').val())){
		                //alert("영문 대소문자 or 숫자 포함 7~20자");
		        		$('#primary-progress .progress-bar').css('width','0%');
		        		$('#primary-progress .progress-bar-warning').css('width','100%');
		        		if(regexpHigh.test($('#password').val())) {  
			                //alert("영문 대소문자 숫자 포함 7~20자"); 
		            		$('#primary-progress .progress-bar').css('width','0%');
			        		$('#primary-progress .progress-bar-success').css('width','100%');
			        		if(regexpVeryHigh.test($('#password').val())) { 
				                //alert("영문 대소문자 숫자 특문 포함 7~20자");  
        						$('#primary-progress .progress-bar').css('width','0%');
			    				$('#primary-progress .progress-bar-primary').css('width','100%');
			        		}
		        		}
	        		}
	            }
            }else{
                //alert("7~20자");
				$('#primary-progress .progress-bar').css('width','0%');
            }
       });
        
        
       //휴대폰 앞번호
    	$('#firstPhoneNumber>li').on('click',function(){
    		$('#firstPhoneNumberBtn>span:first-child').text($('a',this).text());
    		$('#phoneNum1').val($(this).attr('value'));
    	});
        
       //숫자만
       $('input[type=tel]').keyup(function(){
    	   /* if(((event.keyCode>=48)&&(event.keyCode<=57))
                   ||((event.keyCode>=33)&&(event.keyCode<=40))
                   ||event.keyCode==8
                   ||event.keyCode==9
                   ||event.keyCode==46
         	){
              event.returnValue=true;
         	}else{
              event.returnValue=false;
         	} */
         	
    	   //$(this).removeText();
       		$(this).numeric();
       });
       
       $('input[type=tel]').keyup(function(){
    	  if($(this).val().length >= $(this).attr('maxlength')){
    		//다음칸으로 focus를 옮긴다.
    		//next()는 다음 노드를 구하는데,다음 노드가 span임으로 한번더 next시킨다.
    		$(this).next().next().focus();
    	  }else if($(this).val().length ==0 && event.keyCode==8){
    		$(this).prev().prev().focus();
    	  }
       });
       
       
       
       $('#joinBtn').on('click',function(){
    	   $('#joinForm').submit();
       });

		$('#joinForm').submit(function(){
           var regexpId = /^\d+/i;
           if($('#id').val() == ""){
                alert("아이디를 입력하세요");
                $('#id').addClass('alertFocus');
                $('#id').focus();
                return false;
           }else if($('#id').val().length<4 || $('#id').val().length>25){
                alert("아이디는 4~25자에 맞게 입력하세요");
                $('#id').focus();
                return false;
           }else if ( $('#id').val().match(/[^a-zA-Z0-9]/) != null ) {
           	 	alert("숫자와 영문만 입력할 수 있습니다.");
                $('#id').focus();
                return false;
           }else if(regexpId.test($('#id').val())) {   
               alert("아이디는 영문으로만 시작할 수 있습니다.");
               $('#id').focus();
               return false;
           }else if($('#somecheck').val() == 'no'){
           	alert('아이디가 중복되었습니다.');
               $('#id').focus();
               return false;
           }

           if($('#password').val() == ""){
                alert("패스워드 입력하세요");
                $('#password').focus();
                return false;
           }else if(!regexpVeryLow.test($('#password').val())) {   
               alert("패스워드는 7~20자 입니다.");
               $('#password').focus();
               return false;
           }

           if($('#passwordCheck').val() == ""){
                alert("패스워드를 다시 입력하세요");
                $('#passwordCheck').focus();
                return false;
           }else if($('#password').val() != $('#passwordCheck').val()) {   
               alert("패스워드가 다릅니다.");
               $('#passwordCheck').focus();
               return false;
           }

           var regexpname = /^[가-힣]{2,10}$/;
           //var regexpname = /^[\uac00-\ud7a3]{2,10}$/;//UTF-8
           if($('#name').val() == ""){
                alert("이름을 입력하세요");
                $('#name').focus();
                return false;
           }else if(!regexpname.test( $('#name').val()) ) {   
                alert("한글2-10자로 입력하세요");
                $('#name').focus();
                return false;
           }
           
           var regexpemail = /^([a-z0-9_\.-]+)@([\da-z\.-]+)\.([a-z\.]{2,6})$/;
           if($('#email').val() == ""){
                alert("이메일을 입력하세요");
                $('#email').focus();
                return false;
           }else if(!regexpemail.test( $('#email').val()) ) {   
                alert("이메일 형식에 맞지 않습니다.");
                $('#email').focus();
                return false;
           }
          
           if($('#phoneNum1').val() == "" ||
        		$('#phoneNum2').val() == "" ||
        		$('#phoneNum3').val() == "" ){
               alert("휴대폰 번호를 입력하세요");
               $('#phoneNum3').focus();
               return false;
          }
           
          $(window).off('beforeunload');
    	  $('#joinBtn').off('click');
    	  $("#joinBtn").attr("disabled", true);
    	  $('#joinBtn').text('처리중');
    	  $('#lodingModal').modal({
  			backdrop:false,
  			keyboard:false
  		   });
		});
	
		(function ($) {
		    // 숫자 제외하고 모든 문자 삭제.
		    $.fn.removeText = function(_v){
		        //console.log("removeText: 숫자 제거 합니다.");
		        if (typeof(_v)==="undefined")
		        {
		            $(this).each(function(){
		                this.value = this.value.replace(/[^0-9]/g,'');
		            });
		        }
		        else
		        {
		            return _v.replace(/[^0-9]/g,'');
		        }
		    };
		     
		    // php의 number_format과 같은 효과.
		    $.fn.numberFormat = function(_v){
		        this.proc = function(_v){
		            var tmp = '',
		                number = '',
		                cutlen = 3,
		                comma = ','
		                i = 0,
		                len = _v.length,
		                mod = (len % cutlen),
		                k = cutlen - mod;
		                 
		            for (i; i < len; i++)
		            {
		                number = number + _v.charAt(i);
		                if (i < len - 1)
		                {
		                    k++;
		                    if ((k % cutlen) == 0)
		                    {
		                        number = number + comma;
		                        k = 0;
		                    }
		                }
		            }
		            return number;
		        };
		         
		        var proc = this.proc;
		        if (typeof(_v)==="undefined")
		        {
		            $(this).each(function(){
		                this.value = proc($(this).removeText(this.value));
		            });
		        }
		        else
		        {
		            return proc(_v);
		        }
		    };
		     
		    // 위 두개의 합성.
		    // 콤마 불필요시 numberFormat 부분을 주석처리.
		    $.fn.onlyNumber = function (p) {
		        $(this).each(function(i) {
		            $(this).attr({'style':'text-align:right'});
		             
		            this.value = $(this).removeText(this.value);
		            this.value = $(this).numberFormat(this.value);
		             
		            $(this).bind('keypress keyup',function(e){
		                this.value = $(this).removeText(this.value);
		                this.value = $(this).numberFormat(this.value);
		            });
		        });
		    };
		})(jQuery);
	});
</script>



