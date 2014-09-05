<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="s" uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<!-- spEL을 활용한 리소스 버전 관리 -->
<spring:eval expression="@baseConfig['app.version']" var="applicationVersion" />
<spring:url value="/static-{applicationVersion}" var="resourceUrl">
   <spring:param name="applicationVersion" value="${applicationVersion}" />
</spring:url>


    <!--external css-->
    <link href="${resourceUrl}/assets/font-awesome/css/font-awesome.css" rel="stylesheet" />
        
    <!-- Custom styles for this template -->
    <link href="${resourceUrl}/assets/css/style.css" rel="stylesheet">
    <link href="${resourceUrl}/assets/css/style-responsive.css" rel="stylesheet">
    
   <input id="current-accordion" type="hidden" value="lectureEvaluation,evaluationRegisterList"/>

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
                     
                     <form class="form-horizontal style-form" id="evaluationForm" action="evaluationRegisterform" method="post">
                     <input type="hidden" name="open_course_id" value="${param.open_course_id}">
                     <div class="form-group">
                        <label class="col-sm-2 col-sm-2 control-label">강의평가 활성여부</label>
                        <div class="col-lg-6">
                            <div class="input-group">   
                               &nbsp;&nbsp;&nbsp;                          
                              <label> <input type="radio" name="state_code"
                                  value="1" checked> 활성
                              </label>
                                &nbsp;&nbsp;&nbsp;                         
                              <label> <input type="radio" name="state_code"
                                  value="0"> 비활성
                              </label>                                                                        
                            </div>
                         </div>
                     </div>   
                     <div class="form-group">
                        <label class="col-sm-2 col-sm-2 control-label">질문 유형</label>
                        <div class="col-lg-6">
                            <div class="input-group">   
                               &nbsp;&nbsp;&nbsp;                          
                              <label> <input type="radio" name="type"
                                 id="essay_question_type" value="1"> 객관식
                              </label>
                                &nbsp;&nbsp;&nbsp;                         
                              <label> <input type="radio" name="type"
                                 id="multiple_choice_type" value="2"> 주관식
                              </label>      
                              &nbsp;&nbsp;                                           
                                <button type="button" class="btn btn-default" id="select_question_btn">+</button>                                             
                            </div>
                         </div>
                     </div>                     
                     <!-- 질문 생성 위치 -->
                     <div id="question_place" >
                                                
                     </div>               
                     
                     
                       
                       <!--  ----------------------------------------------------------------- -->               
                     
                     <button type="button" class="btn btn-success" id="submit_btn">등록</button>
                     <button type="button" class="btn btn-danger" id="cancle_btn">취소</button>
                  </form>         
                  
                  <!--  ----------------------------------------------------------------- -->
                     <!-- 주관식 질문 틀 -->
                     <div class="form-group" id="essay_question" style="display:none">
                        <label class="col-sm-2 col-sm-2 control-label" id="essay_question_label" >Q_주관식</label>
                        <input type="hidden" name="type_code" value="2">
                        <div class="col-sm-8 input-group">
                           <input type="text" class="form-control noInput" id="essay_question_input" name="question">
                        </div>
                     </div>   
                     <!-- 객관식 질문 틀 -->
                     <div class="form-group" id="multiple_choice" style="display:none">
                        <label class="col-sm-2 col-sm-2 control-label" id="multiple_choice_label">Q_객관식</label>
                        <input type="hidden" name="type_code" value="1">
                        <div class="col-sm-8 input-group" >
                           <input type="text" class="form-control noInput" id="multiple_choice_input" name="question">
                        </div>   
                        <!-- 보기 --> 
                        <div id="multiple_choice_items_place">
                           <div id="multiple_choice_items">                     
                              <label class="col-sm-2 col-sm-2 control-label" id="multiple_choice_items_label">&nbsp;A1</label>
                              <div class="col-sm-10">                        
                                  <div>                                                   
                                    <label> 
                                       <input type="hidden" id="example_content_delimiter" name="example_content" value="0">
                                       <input type="text" class="form-control noInput" id="example_content" name="example_content">
                                    </label>                                                                           
                                      <button type="button" class="btn btn-default items_btn" id="multiple_choice_items_btn" >+</button>                                             
                                  </div>
                                  </div>
                               </div>                            
                          </div>                            
                       </div>      
                       <!-- 객관식 보기 틀 -->   
                       <div id="multiple_choice_items_tool" style="display:none">                     
                        <label class="col-sm-2 col-sm-2 control-label" id="multiple_choice_items_label">A1</label>
                        <div class="col-sm-10">                        
                            <div>                                                   
                              <label> 
                                 <input type="text" class="form-control" id="example_content" name="example_content">
                              </label>                                                 
                                                                         
                           </div>
                          </div>
                       </div>           
                       <!-- 객관식 보기 틀 끝 -->
                  </div>
               </div>
               <!-- col-lg-12--> 
                  
            </div><!-- row -->
      </section><!--/wrapper -->
      </section><!-- /MAIN CONTENT -->

      <!--main content end-->
     <%-- <script src="//code.jquery.com/jquery-1.10.2.min.js"></script> --%>
     <script src="//netdna.bootstrapcdn.com/bootstrap/3.0.0-wip/js/bootstrap.min.js"></script>
     
    <!-- inclue common script -->
    <%@ include file="commonScript.jsp" %>

    <!--script for this page-->
  <script type="text/javascript">
     $(function(){      

        //객관식,주관식 질문 선택
        var cnt=0;
       $("#select_question_btn").click(function(){          
          var type_code = $("input:radio[name=type]:checked").val();
          
           if(type_code == 1){ //객관식             
              cnt++;             
             var newDiv = $("#multiple_choice").clone(true).css("display","block");          
             //객관식 질문 div의 id값 셋팅
             $(newDiv).attr("id", "multiple_choice"+cnt);
             //보기증가 버튼의 id,value값을 질문div의 일련번호와 동일하게 셋팅. - 어떤 질문의 보기를 증가한 것인지 체크하기 위해.
             $(newDiv).find("#multiple_choice_items_btn").val(cnt);
             $(newDiv).find("#multiple_choice_items_btn").attr("id", "multiple_choice_items_btn_"+cnt);
             //label의 text를 설정 - 예) Q1, Q2, Q3... 
             $(newDiv).children("#multiple_choice_label").text("Q"+cnt);
              //form으로 한번에 전송되므로  보기 input의 name 은 example_content로 동일 - 어떤 질문의 보기인지 구분자를 | 로 설정, 
              //구분자 또한 input 의 name은 example_content로 동일.
             $(newDiv).find("#example_content_delimiter").val("|");       
              //question_place div에 clone한 div를 붙인다. -  appen()함수는 순차적으로 밑에 붙여진다.
             $("#question_place").append(newDiv); 
          }else if(type_code == 2){ //주관식          
             cnt++;             
             var newDiv = $("#essay_question").clone(true).css("display","block");          
             //주관식 질문 div의 id값 셋팅
             $(newDiv).attr("id", "essay_question"+cnt);
             //label의 text를 설정 - 예) Q1, Q2, Q3... 
             $(newDiv).children("#essay_question_label").text("Q"+cnt);  
             //question_place div에 clone한 div를 붙인다. -  appen()함수는 순차적으로 밑에 붙여진다.
             $("#question_place").append(newDiv);                          
          }  
       });
       
        //객관식 보기 증가  
       var idx = new Array();
        //idx를 1로 초기화 : 객관식 질문은 질문 20개 범위안에서 올릴 수 있다.
        for(var i=0; i<21; i++){
           idx[i]=1; 
        }        
        function addItems(btn,btnVal) {
           //각 객관식 질문의 index
           idx[btnVal] = idx[btnVal]+1;          
           
           var btnId = btn.attr("id");
           //그 버튼의 질문 div 중 첫번째 객체. - eq(0)을 안해주면 항상 첫번째 객관식 질문이 선택된다.
          var itemsDiv = btn.parents("div").parents("div").parents("div").parents("div").parents("div").eq(0);
          //alert("itemsDiv:"+itemsDiv.attr("id"));   
          var place = itemsDiv.find("#multiple_choice_items_place");
                    
         var newDiv1 = $("#multiple_choice_items_tool").clone(true).css("display","block");          
         $(newDiv1).attr("id", "multiple_choice_items_"+idx[btnVal]);
         $(newDiv1).children("#multiple_choice_items_label").text("A"+idx[btnVal]);      
          place.append(newDiv1);                  
      }      
        
       $(".items_btn").click(function(){         
          //보기증가 + 버튼을 클릭하면, 해당 질문의 value값, 즉 질문index를 가져와서
          //버튼 객체와, 질문의 index 값을 함수에 전달한다. 
          var btnVal = $(this).val();          
          //alert("btnVal:"+btnVal);
          addItems($(this),btnVal); 
       });      
       
       //등록버튼: submit
       $("#submit_btn").click(function(){
           $("#evaluationForm").submit(); 
        });
    });
  </script>
  
