<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="s" uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<!-- spEL을 활용한 리소스 버전 관리 -->
<spring:eval expression="@baseConfig['app.version']"
   var="applicationVersion" />
<spring:url value="/static-{applicationVersion}" var="resourceUrl">
   <spring:param name="applicationVersion" value="${applicationVersion}" />
</spring:url>

<!--external css-->
<link href="${resourceUrl}/assets/font-awesome/css/font-awesome.css"
   rel="stylesheet" />
<link rel="stylesheet" type="text/css"
   href="${resourceUrl}/assets/lineicons/style.css">

<!-- Custom styles for this template -->
<link href="${resourceUrl}/assets/css/style.css" rel="stylesheet">
<link href="${resourceUrl}/assets/css/style-responsive.css"
   rel="stylesheet">

<link rel="stylesheet" href="${resourceUrl}/css/jquery.fileupload.css">
<link rel="stylesheet" href="${resourceUrl}/css/upload.css">



<!-- **********************************************************************************************************************************************************
      MAIN CONTENT
      *********************************************************************************************************************************************************** -->
<!--main content start-->
<section id="main-content">
   <section class="wrapper">
      <h3>
         <i class="fa fa-angle-right"></i> 프로필 수정
      </h3>

      <form id="employeeUpdateFrm" action="employeeUpdate" method="post">
         <!-- BASIC FORM ELELEMNTS -->         
         <div class="row mt">
            <div class="col-lg-12">
               <div class="content-panel panel-body">
                  <div class="pull-right employeeDetail">
                     HACO SYSTEM
                  </div>
                  <br>
                  <br>                  
                     <div class="form-group">
                              <!-- <label class="col-sm-2 col-sm-2 control-label">사진</label> -->
                              <div class="col-md-12">
                                 <div class="cover">
                                    <!-- 업로드된 파일 -->
                                    <div id="img-preview">
                                       <i id="loadingIcon" class="fa fa-spinner fa-spin fa-5x"></i><img
                                 class="photo"
                                 src="${pageContext.request.contextPath}/employeePhoto/${emp.photo}"
                                 onerror="this.src='${pageContext.request.contextPath}/images/User-Role-Guest-icon.png'">
                                    </div>
                                    <!-- 부트 스트랩 적용 input버튼 -->
                                    <!-- The fileinput-button span is used to style the file input field as button -->
                                    <span class="btn btn-success fileinput-button"> <i
                                       class="glyphicon glyphicon-plus"></i> <span>사진 선택</span><!-- The file input field used as target for the file upload widget -->
                                       <input id="photoUpFile" type="file" name="file" multiple />
                                    </span>
                                    <!-- 업로드 프로그래스바 -->
                                    <div id="progress_thumbnail" class="progress">
                                       <div class="progress-bar progress-bar-success"></div>
                                    </div>
      
                                    <p class="dsc">
                                       사진 크기는 <em>177X236</em> 사이즈에 최적화 되어있습니다.
                                    </p>
      
                                 </div>
                                 <input type="hidden" id="photo" name="photo" value="${emp.photo}">
                             </div>
                          </div>
                  
                     <br>   
                     <fmt:formatNumber var="account_id" value="${emp.account_id}" type="number" />
                     <c:if test="${emp.user_id == account_id}">                  
                        <div class="col-md-12">
                           <h4>아이디</h4>
                           <table class="table">
                              <tr>
                                 <td><b>ID</b></td>
                                 <td><input type="text" 
                                    name="user_id" id="user_id" maxlength="20" class="onlyId"></td>                           
                              </tr>                                 
                           </table>
                        </div>
                     </c:if>                     
                     <div class="col-md-12">
                        <h4>기본 정보</h4>
                        <table class="table">
                           <tr>
                              <td><b>이름</b></td>
                              <td>${emp.name_kor}</td>
                              <td><b>영문 이름</b></td>
                              <td>${emp.name_eng}</td>
                           </tr>
                           <tr>
                              <td><b>성별</b></td>
                              <td>${emp.gender}</td>
                              <td><b>주민 번호</b></td>
                              <td>${emp.resident_registration_num1}-${emp.resident_registration_num2}</td>
                           </tr>
                           <tr>
                              <td><b>실 거주지</b></td>
                              <td class="form-group"><input type="text" class="form-control"
                                 name="address_real" id="address_real" value="${emp.address_real}" maxlength="49" class="onlyAlphanum"></td>
                              <td><b>주민등록 상 주소</b></td>
                              <td class="form-group"><input type="text" class="form-control" name="address_registered" id="address_registered" value="${emp.address_registered}"
                                 maxlength="49" class="onlyAlphanum"></td>
                           </tr>
                           <tr>
                              <td><b>핸드폰 번호</b></td>
                              <td class="form-group">
                              	 <input type="tel" data-registration="true" class="form-control" maxlength="3" name="phone_cell1" id="phone_cell1" value="${emp.phone_cell1}" maxlength="3"><i class="fa fa-minus"></i>
                                 <input type="tel" data-registration="true" class="form-control" maxlength="4" name="phone_cell2" id="phone_cell2" value="${emp.phone_cell2}" maxlength="4"><i class="fa fa-minus"></i>
                                 <input type="tel" data-registration="true" class="form-control" maxlength="4" name="phone_cell3" id="phone_cell3" value="${emp.phone_cell3}" maxlength="4">
                              </td>
                              <td><b>집전화 번호</b></td>
                              <td class="form-group">
                                 <input type="tel" data-registration="true" class="form-control" maxlength="3" name="phone_home1" id="phone_home1" value="${emp.phone_home1}" maxlength="3"><i class="fa fa-minus"></i>
                                 <input type="tel" data-registration="true" class="form-control" maxlength="4" name="phone_home2" id="phone_home2" value="${emp.phone_home2}" maxlength="4" ><i class="fa fa-minus"></i>
                                 <input type="tel" data-registration="true" class="form-control" maxlength="4" name="phone_home3" id="phone_home3" value="${emp.phone_home3}" maxlength="4" >
                              </td>                              
                           </tr>
                           <tr>
                              <td><b>이메일</b></td>
                              <td class="form-group"><input type="text" class="form-control" name="email" id="email" value="${emp.email}" maxlength="50"></td>
                              <td><b>입사일</b></td>
                              <td>${emp.join_date}</td>
                           </tr>

                        </table>
                     </div>

                     <div class="col-md-12">
                        <h4>급여 정보</h4>
                        <table class="table">
                           <tr>
                              <td><b>은행</b></td>
                              <td class="form-group"><input type="text" class="form-control" name="bank" id="bank" value="${emp.bank}" maxlength="24" class="onlyAlphanum"></td>
                              <td><b>계좌 번호</b></td>
                              <td class="form-group"><input type="text" class="form-control" name="bank_account" id="bank_account" value="${emp.bank_account}" maxlength="20" class="onlyNumber"></td>
                           </tr>
                           <tr>
                              <td><b>급여</b></td>
                              <td>${emp.salary}원</td>
                              <td><b>예금주</b></td>
                              <td class="form-group"><input type="text" class="form-control" name="account_owner" id="account_owner" value="${emp.account_owner}" maxlength="5" class="onlyAlphanum"></td>
                           </tr>
                        </table>
                     </div>
                  </div>
                  <button id="registerBtn" type="button" class="btn btn-theme writeBtn">수정</button>
               </div>
               
            </div>
            <!-- col-lg-12-->
         </div>
         <!-- /row -->
      </form>

   </section>
</section>

<!--main content end-->

<!-- lodingmodel -->
<div aria-hidden="true" aria-labelledby="myModalLabel" role="dialog"
   tabindex="-1" id="lodingModal" class="modal fade">
   <div class="modal-dialog">
      <div id="loaderImage"></div>
   </div>
</div>
<!-- modal -->

<!-- inclue common script -->
<%@ include file="commonScript.jsp"%>

<!--script for this page-->
<script type="text/javascript"
   src="http://code.jquery.com/ui/1.10.3/jquery-ui.js"></script>
<script type="text/javascript"
   src="${resourceUrl}/js/jquery.fileupload.js"></script>
<script type="text/javascript" src="${resourceUrl}/js/upload.js"></script>
<script type="text/javascript" src="${resourceUrl}/js/jquery.alphanum.js"></script>

<script type="application/javascript">      
$(document).ready(function(){
   //프로필 정보 수정 완료 시
     var result = ${result};
    if(result>0){
       alert("프로필 정보가 정상적으로 수정되었습니다.");    
    }
   
   //유효성 검사 
   //숫자만 입력 가능하도록 처리 하는 부분
   $(".onlyNumber").numeric();       
    //문자,숫자만 입력- 특수문자입력 불가
    $(".onlyAlphanum").alphanum();
    //알파벳과 숫자만 입력  
    $(".onlyId").keyup(function (event) {
        regexp = /[^a-z0-9]/gi;
        v = $(this).val();
        if (regexp.test(v)) {            
            $(this).val(v.replace(regexp, ''));
        }
    });

    //휴대폰 앞번호
	$('#firstPhoneNumber>li').on('click',function(){
		$('#firstPhoneNumberBtn>span:first-child').text($('a',this).text());
		$('#phoneNum1').val($(this).attr('value'));
	});
    
   //숫자만
   $('input[type=tel]').keyup(function(){
	   $(this).numeric();
   });
   
   $('input[data-registration="true"]').keyup(function(){
 	  if($(this).val().length >= $(this).attr('maxlength')){
 		//다음칸으로 focus를 옮긴다.
 		//next()는 다음 노드를 구하는데,다음 노드가 span임으로 한번더 next시킨다.
 		$(this).next().next().focus();
 	  }else if($(this).val().length ==0 && event.keyCode==8){
 		$(this).prev().prev().focus();
 	  }
    });
   
    
    
   //submit, 유효성 검사
   $('#registerBtn').on('click',function(){
      $('#employeeUpdateFrm').submit();
      });
   $('#employeeUpdateFrm').submit(function(){ 
       if($('#user_id').val() == ""){
           alert("ID를 입력하세요. ID는 추후 변경이 불가능합니다.");
           $('#user_id').focus();
           return false;
       }
       if($('#phone_cell1').val() == ""){
           alert("핸드폰 번호를 입력하세요");
           $('#phone_cell1').focus();
           return false;
       }
       if($('#phone_cell2').val() == ""){
           alert("핸드폰 번호를 입력하세요");
           $('#phone_cell2').focus();
           return false;
       }
       if($('#phone_cell3').val() == ""){
           alert("핸드폰 번호를 입력하세요");
           $('#phone_cell3').focus();
           return false;
       }
       if($('#phone_home1').val() == ""){
           alert("전화번호를 입력하세요");
           $('#phone_home1').focus();
           return false;
       }
       if($('#phone_home2').val() == ""){
           alert("전화번호를 입력하세요");
           $('#phone_home2').focus();
           return false;
       }
       if($('#phone_home3').val() == ""){
           alert("전화번호를 입력하세요");
           $('#phone_home3').focus();
           return false;
       }
       if($('#address_real').val() == ""){
           alert("실주소를 입력하세요");
           $('#address_real').focus();
           return false;
       }
       if($('#address_registered').val() == ""){
           alert("주민등록증상의 주소를 입력하세요");
           $('#address_registered').focus();
           return false;
       }
       if($('#email').val() == ""){
           alert("이메일을 입력하세요");
           $('#email').focus();
           return false;
       }
       if($('#bank').val() == ""){
           alert("은행명을 입력하세요");
           $('#bank').focus();
           return false;
       }
       if($('#bank_account').val() == ""){
           alert("계좌번호를 입력하세요");
           $('#bank_account').focus();
           return false;
       }
       if($('#account_owner').val() == ""){
           alert("계좌주를 입력하세요");
           $('#account_owner').focus();
           return false;
       }
       
       $(window).off('beforeunload');
       $('#registerBtn').off('click');
       $("#registerBtn").attr("disabled", true);
       $('#registerBtn').text('처리중');
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

