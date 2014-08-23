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
								
									<form class="form-horizontal style-form" action="employeeRegister" method="post">										
										<c:forEach var="question" items="${questionList}">
											<div class="form-group">
												<label class="col-sm-2 col-sm-2 control-label">질문1</label>
												<div class="col-sm-10">
													${question.question}									
												</div>
											</div>	
											<c:choose>
												<c:when test="${question.type_code=='2'}"> <!-- 주관식일때 -->										
													<div class="form-group">
														<label class="col-sm-2 col-sm-2 control-label">주관식 답변</label>
														<div class="col-sm-10">
															<input type="text" class="form-control" name="name_kor">
														</div>											
													</div>	
												</c:when>
												<c:when test="${question.type_code=='1'}"> <!-- 객관식일때 -->
													<div class="form-group">
														<label class="col-sm-2 col-sm-2 control-label">보기</label>
														<div class="col-lg-6">
													    <div class="input-group">
													    	&nbsp;&nbsp;&nbsp;
													    	<%int idx=0;
													    	List<ArrayList<EvaluationRegister>> examListofList= (List<ArrayList<EvaluationRegister>>)request.getAttribute("examListofList");
													    	examListofList.get(idx);
													    	%>									    	 
													    					     
																<label> <input type="radio" name="job_code"
																	id="optionsRadios1" value="1"> ${exam.example_content}
																</label>
														     	&nbsp;&nbsp;&nbsp;					
														     									
																													
													    </div>
							  						  </div>
													</div>				
												</c:when>											
											</c:choose>														
																							
											<hr style="display:block;clear:both;">
										</c:forEach> 
													    	 	} %>
										<button type="submit" class="btn btn-theme">등록</button>						
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
	$(document).ready(function() {
		
		$('#sidebar').affix({
			offset : {
				top : 230,
				bottom : 100
			}
		});
	});
</script>


<!-- JavaScript jQuery code from Bootply.com editor  -->
<script type="text/javascript">

	
</script>



