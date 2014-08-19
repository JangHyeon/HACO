<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="s" uri="http://www.springframework.org/security/tags"%>



    <!--external css-->
    <link href="${pageContext.request.contextPath}/resources/assets/font-awesome/css/font-awesome.css" rel="stylesheet" />
        
    <!-- Custom styles for this template -->
    <link href="${pageContext.request.contextPath}/resources/assets/css/style.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/resources/assets/css/style-responsive.css" rel="stylesheet">
    
	<input id="current-accordion" type="hidden" value="lectureEvaluation,evaluationRegister"/>

      <!-- **********************************************************************************************************************************************************
      MAIN CONTENT
      *********************************************************************************************************************************************************** -->
      <!--main content start-->
      <section id="main-content">
          <section class="wrapper">
          	<h3><i class="fa fa-angle-right"></i> 강의평가 등록</h3>
				<div class="row">		
						  	
					<div class="col-lg-12">
						<div class="form-panel">
							<h4 class="mb">
								<i class="fa fa-angle-right"></i> 과정 정보
							</h4>
							<form class="form-horizontal style-form" action="employeeRegister" method="post">
								
		
								<div class="form-group">
									<label class="col-sm-2 col-sm-2 control-label">과정명</label>
									<div class="col-sm-10">
										${evalForm.course_name}
									</div>
								</div>
								<div class="form-group">
									<label class="col-sm-2 col-sm-2 control-label">과목명</label>
									<div class="col-sm-10">
										${evalForm.subject_name}
									</div>
								</div>					
								
								
								<div class="form-group">
									<label class="col-sm-2 col-sm-2 control-label">담당강사</label>
									<div class="col-sm-10">
										${evalForm.name_kor}
									</div>
								</div>	
							
								<div class="form-group">
									<label class="col-sm-2 col-sm-2 control-label">강의 기간</label>
									<div class="col-sm-10">
										${evalForm.course_start_date} ~ ${evalForm.course_end_date}
									</div>
								</div>	
														
							</form>
						</div>
					</div>
					
					<!-- col-lg-12-->
					<div class="col-lg-12 mt">
						<div class="form-panel">
							<h4 class="mb">
								<i class="fa fa-angle-right"></i> 평가 질문 등록
							</h4>							
							<form class="form-horizontal style-form" id="evaluationForm" method="post">
							<div class="form-group">
								<label class="col-sm-2 col-sm-2 control-label">질문 유형</label>
								<div class="col-lg-6">
							    <div class="input-group">	
							    	&nbsp;&nbsp;&nbsp;							     
									<label> <input type="radio" name="type_code"
										id="optionsRadios1" value="1"> 객관식
									</label>
							     	&nbsp;&nbsp;&nbsp;						     	
								 
									<label> <input type="radio" name="type_code"
										id="optionsRadios2" value="2"> 주관식
									</label>		
									&nbsp;&nbsp;											     	  
							     	<button type="button" class="btn btn-default">+</button>							    						  
							    </div>
	  						  </div>
							</div>	
							<div class="form-group">
								<label class="col-sm-2 col-sm-2 control-label">Q</label>
								<div class="col-sm-10">
									<input type="text" class="form-control" name="address_registered">
								</div>
							</div>	
							
							<button type="button" class="btn btn-success" id="submit_btn">등록</button>
							<button type="button" class="btn btn-danger" id="cancle_btn">취소</button>
						</form>				
						</div>
					</div>
					<!-- col-lg-12--> 
                  
				</div><!-- row -->
		</section><! --/wrapper -->
      </section><!-- /MAIN CONTENT -->

      <!--main content end-->
     <script src="//netdna.bootstrapcdn.com/bootstrap/3.0.0-wip/js/bootstrap.min.js"></script>
    
    <!-- inclue common script -->
    <%@ include file="commonScript.jsp" %>

    <!--script for this page-->
  <script type="text/javascript">
      $(function(){          
          $('#multiple_btn').click(function(){
        	  // alert("ddd");
        	  // 큰div에 숨긴 div를 복사. 여기서 keypoint!! .css로 display를 풀어준다. 그리고 .clone()을 사용한다
        	 $('#multiple_question').append($('#multiple_plus').clone().css("display","block")); 
     	  });
          
         $('#easy_question_btn').click(function(){
        	$('#easy_question').append($('#easy_question_plus').clone().css("display","block"));
         }); 
    
         
         // 객관식 답변 처리
         $('#select').change(function(){
        	
        	if($('#select option:selected').val() == 03){
        		$('#three').show();
        		$('#five').hide();
        	}else if($('#select option:selected').val() == 05){
        		$('#five').show();
        		$('#three').hide();
        	}
         });
         
         $('#submit_btn').click(function(){
        	$('#evaluationForm').submit(); 
         });
         
         $('#cancle_btn').click(function(){
         	$('#evaluationForm').submit(); 
          });
         
 });
  </script>
  

