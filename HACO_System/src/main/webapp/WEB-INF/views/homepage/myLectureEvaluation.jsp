<%@page import="java.util.ArrayList"%>
<%@page import="kr.co.haco.VO.EvaluationRegister"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="s" uri="http://www.springframework.org/security/tags"%>

<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/Remodal/jquery.remodal.css">

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
				  <li class="active">강의평가</li>
				</ol>
				
				<!-- Main Content -->
				<div class="panel-body">
				<!--main content start-->
				<%-- <section id="main-content">
					<section class="wrapper"> --%>
						
				
						<!-- BASIC FORM ELELEMNTS -->
						<div class="row mt">
							<div class="col-lg-12">
								<div class="form-panel">
									<h4 class="mb">
										<i class="fa fa-angle-right"></i> Java Framwork1기 2014-08-01~2014-08-01
									</h4>
									<h5>임경균강사</h5> 
									<br>
								
									<form class="form-horizontal style-form" id="evalResultFrm">	
										<input type="hidden" name="open_course_id" value="${param.open_course_id}">	
										<%int idx_examListofList=0; 
										  int idx_question=1;%>																		
										<c:forEach var="question" items="${questionList}"> <!-- 질문리스트 -->
										<div class="quest">
											<div class="form-group">
												<label class="col-sm-2 col-sm-2 control-label">질문<%=idx_question%></label>
												<div class="col-sm-10">${question.question}</div>			
												<input type="hidden" name="question_id" value="${question.question_id}">
												<input type="hidden" name="type_code" value="${question.type_code}">												
											</div>	
											<c:choose>
												<c:when test="${question.type_code=='2'}"> <!-- 주관식일때 -->										
													<div class="form-group">
														<label class="col-sm-2 col-sm-2 control-label">주관식 답변</label>
														<div class="col-sm-10">
															<input type="text" class="form-control" name="answer">
														</div>											
													</div>	
												</c:when>
												<c:when test="${question.type_code=='1'}"> <!-- 객관식일때 -->
													<div class="form-group">
														<label class="col-sm-2 col-sm-2 control-label">보기</label>
														<div class="col-lg-6">
													    <div class="input-group">
													    	<!-- &nbsp;&nbsp;&nbsp; -->
													    	<%													    	
													    	List<ArrayList<EvaluationRegister>> examListofList= (List<ArrayList<EvaluationRegister>>)request.getAttribute("examListofList");
													    	ArrayList<EvaluationRegister> examList = examListofList.get(idx_examListofList);												    	
													    	
													    	for(int i=0;i<examList.size();i++){ %>		     
																<label> <input type="radio" name="example<%=idx_examListofList%>"
																	id="optionsRadios1" value="<%= examList.get(i).getExample_id()%>"><%= examList.get(i).getExample_content()%></label>&nbsp;&nbsp;&nbsp;														     														  								
															<%} 
													    	idx_examListofList++;%>																									
													    </div>
							  						  </div>
													</div>				
												</c:when>											
											</c:choose>
										</div>														
											<%idx_question++;%>														
											<hr style="display:block;clear:both;">
										</c:forEach> 
												    	 	
										<button type="button" class="btn btn-theme" id="uploadBtn">등록</button>						
									</form>
								</div>
							</div>
							<!-- col-lg-12-->
						</div>
						<!-- /row -->
				<%-- 		
					</section>
				</section>
				 --%>
				<!--main content end-->

				</div>
				<!--/panel-body-->
				
			</div>
			<!--/panel-->
			<!--/end right column-->
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
<script src="${pageContext.request.contextPath}/resources/gazONojfL3/js/jquery.1.9.1.min.js"></script>
<script	src="${pageContext.request.contextPath}/resources/gazONojfL3/js/bootstrap.3.2.0.min.js"></script>
<script	src="${pageContext.request.contextPath}/resources/gazONojfL3/js/scripts.js"></script>
<script src="http://dmaps.daum.net/map_js_init/postcode.js"></script>
<script src="${pageContext.request.contextPath}/resources/Remodal/jquery.remodal.min.js"></script>

<!-- JavaScript jQuery code from Bootply.com editor  -->

<script type="text/javascript">
	
</script>


<!-- JavaScript jQuery code from Bootply.com editor  -->
<script type="text/javascript">
$(document).ready(function() {
	//?
	$('#sidebar').affix({
		offset : {
			top : 230,
			bottom : 100
		}
	});
	
	//설문 결과 등록
	$("#uploadBtn").click(function(){	
		var questList = $(".quest").length;	
		//ajax로 보낼 Object
		var sendData = new Object();
		
		//공통데이터
		var commonData = new Object();
		commonData['course_id'] = $("#evalResultFrm").find("input[name='open_course_id']").val();	
		//질문데이터
		var answerData = new Object();
		var main = new Array(); 
		var idx_quest=0;
		var idx_exam=0;
		
		for(var i=0; i<questList; i++){
			sub = new Object();   
			sub['question_id'] =$("#evalResultFrm").find("input[name='question_id']").eq(i).val();			
			var type_code = $("#evalResultFrm").find("input[name='type_code']").eq(i).val();
			sub['type_code'] = type_code;
			//alert("type_code:"+type_code);
			
			//객관식일때
			if(type_code=='1'){				
				sub['example_id'] = $("#evalResultFrm").find("input:radio[name=example"+idx_exam+"]:checked").val();
				idx_exam++;
			}else if(type_code=='2'){
				sub['answer'] = $("#evalResultFrm").find("input[name='answer']").eq(idx_quest).val();	
				idx_quest++;
			}		
			//alert("type_code:"+type_code);
			//alert("question_id:"+sub.question_id);
			//alert("answer:"+sub.answer); 
			
			main[i] = sub;
		}
		answerData['answerData'] = main;
		
		sendData['sub1']=commonData;
		sendData['sub2']=answerData;
		
		var jsonData = JSON.stringify(sendData); //객체를 string화 시켜주는 것.
		alert("jsonData:"+jsonData);		
		console.log(jsonData);
		
 		$.ajax({
            type : "POST",
            dataType : "json",
            url : 'myLectureEvaluation',
            data : {answerList:jsonData},
            success : function(result) {               
                 if(result>0){
                	 console.log(jsonData);
                	 console.log("result:"+result);
                	 alert("설문이 등록되었습니다. 감사합니다.^^");
                	 location.href="myLectureHistory";
                 }
            },error : function(xhr, status, error) {
	             alert("이미 등록한 설문입니다.");	             
	        }           
    	});
		
		
	}); //등록 버튼 클릭 끝
	
});
	
</script>



