<%@page import="kr.co.haco.VO.EvaluationRegister"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
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
          	<h3><i class="fa fa-angle-right"></i> 강의평가 항목 조회</h3>
				<div class="row">		
						  	
					<div class="col-lg-12">
						<div class="form-panel">
							<h4 class="mb">
								<i class="fa fa-angle-right"></i> 과정 정보
							</h4>
							<form class="form-horizontal style-form">	
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
								<i class="fa fa-angle-right"></i> 평가 질문 조회
							</h4>							
							<form class="form-horizontal style-form">	
							<%int idx_examListofList=0; 
							  int idx_question=1;%>																		
							<c:forEach var="question" items="${questionList}"> <!-- 질문리스트 -->		
								<c:choose>
									<c:when test="${question.type_code=='2'}"> <!-- 주관식일때 -->				
										<div class="form-group">
											<label class="col-sm-2 col-sm-2 control-label">질문<%=idx_question%></label>
											<div class="col-sm-10">
												${question.question}
											</div>
										</div>	
									</c:when>
									<c:when test="${question.type_code=='1'}"> <!-- 객관식일때 -->
										<div class="form-group" id="multiple_choice" >
											<label class="col-sm-2 col-sm-2 control-label" id="multiple_choice_label">질문<%=idx_question%></label>								
											<div class="col-sm-8 input-group" >
												<input type="text" class="form-control" readonly="readonly" value="ㅋㅋㅋ" style="border:0px;background-color:white">
											</div>	
											<label class="col-sm-2 col-sm-2 control-label" id="multiple_choice_items_label">&nbsp;보기</label>
											<div class="col-sm-10">		
												<%													    	
													List<ArrayList<EvaluationRegister>> examListofList= (List<ArrayList<EvaluationRegister>>)request.getAttribute("examListofList");
													ArrayList<EvaluationRegister> examList = examListofList.get(idx_examListofList);											    	
													for(int i=0;i<examList.size();i++){ %>					
													 <%=i+1%>.<%= examList.get(i).getExample_content()%>&nbsp;&nbsp;&nbsp;
							  					
							  					<%} 											  
												  idx_examListofList++;%>
											 </div> 			
				  						</div>				
									</c:when>	
								</c:choose>
								<%idx_question++; %>
							</c:forEach>
														
						    </form>
							<button type="button" class="btn btn-default items_btn" id="multiple_choice_items_btn" >목록</button>
						</div>
					</div>
					<!-- col-lg-12--> 
                  
				</div><!-- row -->
		</section><! --/wrapper -->
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
    			$(newDiv).attr("id", "multiple_choice"+cnt);
    			
    			$(newDiv).find("#multiple_choice_items_btn").val(cnt);
    			$(newDiv).find("#multiple_choice_items_btn").attr("id", "multiple_choice_items_btn_"+cnt); 			
    			$(newDiv).children("#multiple_choice_label").text("Q"+cnt);  			   
    			$(newDiv).find("#example_content_delimiter").val("|"); 			
    			$("#question_place").append(newDiv); 
    		}else if(type_code == 2){ //주관식 			
    			cnt++;    			
    			var newDiv = $("#essay_question").clone(true).css("display","block");    		
    			$(newDiv).attr("id", "essay_question"+cnt);
    			$(newDiv).children("#essay_question_label").text("Q"+cnt);    			
    			$("#question_place").append(newDiv);    			             
    		}  
    	});
    	
  		//객관식 보기 증가  
    	var idx = new Array();
  		//idx를 1로 초기화 : 객관식 질문은 최대 20개 올릴 수 있다.
  		for(var i=0; i<21; i++){
  			idx[i]=1; 
  		}  		
  		function addItems(btn,btnVal) {
  			idx[btnVal] = idx[btnVal]+1; 			
  			
  			var btnId = btn.attr("id");
		 	var itemsDiv = btn.parents("div").parents("div").parents("div").parents("div").parents("div").eq(0);
		 	//alert("itemsDiv:"+itemsDiv.attr("id"));	
		 	var place = itemsDiv.find("#multiple_choice_items_place");
		 			 	
			var newDiv1 = $("#multiple_choice_items_tool").clone(true).css("display","block");    		
			$(newDiv1).attr("id", "multiple_choice_items_"+idx[btnVal]);
			$(newDiv1).children("#multiple_choice_items_label").text("A"+idx[btnVal]);		
		 	place.append(newDiv1);						
		}  	 
  		
    	$(".items_btn").click(function(){   		   		
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
  

