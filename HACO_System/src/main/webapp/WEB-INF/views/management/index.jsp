<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib prefix="s" uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<!-- spEL을 활용한 리소스 버전 관리 -->
<spring:eval expression="@baseConfig['app.version']" var="applicationVersion" />
<spring:url value="/static-{applicationVersion}" var="resourceUrl">
	<spring:param name="applicationVersion" value="${applicationVersion}" />
</spring:url>

    <!--external css-->
    <link rel="stylesheet" type="text/css" href="${resourceUrl}/assets/font-awesome/css/font-awesome.css"/>
    <link rel="stylesheet" type="text/css" href="${resourceUrl}/assets/css/zabuto_calendar.css">
    <link rel="stylesheet" type="text/css" href="${resourceUrl}/assets/lineicons/style.css">    
    
    <!-- Custom styles for this template -->
    <link href="${resourceUrl}/assets/css/style.css" rel="stylesheet" type="text/css">
    <link href="${resourceUrl}/assets/css/style-responsive.css" rel="stylesheet" type="text/css">
	<link href="${resourceUrl}/simpleWeather/simpleWeather.css"  rel="stylesheet" type="text/css">
	<input id="current-accordion" type="hidden" value="index"/>

      <!-- **********************************************************************************************************************************************************
      MAIN CONTENT
      *********************************************************************************************************************************************************** -->
      <!--main content start-->
      <section id="main-content">
          <section class="wrapper">

              <div class="row">
                  <div class="col-lg-9 main-chart">
                  
                  	<div class="row mtbox">
                  		<div class="col-md-2 col-sm-2 col-md-offset-1 box0">
                  			<div class="box1">
					  			<i class="fa fa-database fa-4x"></i>
					  			<h3>${totalMemberNumber}</h3>
                  			</div>
					  			<p>HACO Academy<br> 회원 수<br> ${totalMemberNumber}명</p>
                  		</div>
                  		<div class="col-md-2 col-sm-2 box0">
                  			<div class="box1">
					  			<i class="fa fa-user fa-4x"></i>
					  			<h3>${totalStudentNumber}</h3>
                  			</div>
					  			<p>HACO Academy<br> 학원생 수<br> ${totalStudentNumber}명</p>
                  		</div>
                  		<div class="col-md-2 col-sm-2 box0">
                  			<div class="box1">
					  			<i class="fa fa-child fa-4x"></i>
					  			<h3>+${newStudentNumber}</h3>
                  			</div>
					  			<p>이번 달의<br> 신규 학원생 수<br> +${newStudentNumber}명</p>
                  		</div>
                  		<div class="col-md-2 col-sm-2 box0">
                  			<div class="box1">
					  			<i class="fa fa-sign-in fa-4x"></i>
					  			<h3>+${newEmployeeNumber}</h3>
                  			</div>
					  			<p>파릇파릇 !<br>이번달에 입사한<br>신규 직원 수<br> +${newEmployeeNumber}명</p>
                  		</div>
                  		<div class="col-md-2 col-sm-2 box0">
                  			<div class="box1">
					  			<i class="fa fa-upload fa-4x"></i>
					  			<h3>+${newNoticeNumber+newQnaNumber}</h3>
                  			</div>
					  			<p>오늘 새로 올라온 글<br>+${newNoticeNumber+newQnaNumber}건</p>
                  		</div>
                  	</div><!-- /row mt -->	
                  
                      
                      <div class="row mt">
                      <!-- SERVER STATUS PANELS -->
                      	<div class="col-md-4 col-sm-4 mb">
                      		<div class="white-panel pn donut-chart">
                      			<div class="white-header">
						  			<h5>현재 시간</h5>
                      			</div>
								<div class="row">
									<figure id="canvas"></figure>
	                      		</div>
	                      	</div><!--/grey-panel -->
                      	</div><!-- /col-md-4-->
                      	

                      	<div class="col-md-4 col-sm-4 mb">
                      		<div class="white-panel pn">
                      			<div class="white-header">
						  			<h5>답변을 기다리는 질문</h5>
                      			</div>
								<div class="row">
									
	                      		</div>
	                      		<div class="waitAnswer centered">
									<table class="table table-hover index-notice">
										<tbody>
											<c:forEach var="waitAnswer" items="${waitAnswerList}">
												<tr>
													<td><span>－<a href="${pageContext.request.contextPath}/management/qnaView/pageSize/${pageSize}/pageNum/${pageNum}/searchType/${searchType}/searchKey/${searchKey}/qnaId/${waitAnswer.qna_id}">${waitAnswer.title}</a></span></td>
													<td><fmt:formatDate value="${waitAnswer.register_date}" pattern="MM/dd"/></td>
												</tr>
											</c:forEach>
										</tbody>
									</table>
									<c:if test="${empty waitAnswerList || empty waitAnswerList[0]}">
										<h3 style="margin: 80px auto; text-align: center;">질문이 없습니다...</h3>
									</c:if>
	                      		</div>
                      		</div>
                      	</div><!-- /col-md-4 -->
                      	
						<div class="col-md-4 mb">
							<!-- WHITE PANEL - TOP USER -->
							<div class="white-panel pn">
								<div class="white-header">
									<h5>이 달의 우수강사</h5>
								</div>
								<p><div class="centered employeePhoto"><img src="${pageContext.request.contextPath}/employeePhoto/${bestTeacher.photo}" class="employeePhoto-img" width="80" onerror="this.src='${pageContext.request.contextPath}/images/User-Role-Guest-icon.png'"></div></p>
								<p><b>${bestTeacher.name_kor} (${bestTeacher.name_eng})
				              	  <br><small>${bestTeacher.location}</small>
				              	</b></p>
								<div class="row">
									<div class="col-md-6">
										<p class="small mt">MEMBER SINCE</p>
										<p><fmt:formatDate value="${bestTeacher.join_date}" pattern="yyyy.MM"/></p>
									</div>
									<div class="col-md-6">
										<p class="small mt">INCENTIVE</p>
										<p>￦ ${bestIncentive}</p>
									</div>
								</div>
							</div>
						</div><!-- /col-md-4 -->
                      	

                    </div><!-- /row -->
                    
                    				
					<div class="row">
						<!-- TWITTER PANEL -->
						<div class="col-md-4 mb">
                      		<div class="darkblue-panel pn">
                      			<div class="darkblue-header">
						  			<h5>파일 서버 사용량</h5>
                      			</div>
								<canvas id="serverstatus02" height="125" width="200"></canvas>
								<input id="maxStorage" type="hidden" value="${maxStorage}"/>
								<input id="totalFileSize" type="hidden" value="${totalFileSize}"/>
								<input id="totalImageSize" type="hidden" value="${totalImageSize}"/>
								<p data-name="now">April 17, 2014 </p>
								<footer>
									<div class="pull-left">
										<h5><i class="fa fa-hdd-o"></i> ${maxStorage/1024/1024} GB</h5>
									</div>
									<div class="pull-right">
										<h5 id="usePercent">${totalFileSizePercent+totalImageSizePercent}% 사용</h5>
									</div>
								</footer>
                      		</div><!-- /darkblue panel -->
						</div><!-- /col-md-4 -->
						
						
						<div class="col-md-4 mb">
							<!-- WEATHER PANEL -->
							<div class="instagram-panel pn">
								<div id="weather"></div>
							</div>
						</div><!-- /col-md-4 -->
						
						<div class="col-md-4 col-sm-4 mb">
							<!-- REVENUE PANEL -->
							<div class="darkblue-panel pn">
								<div class="darkblue-header">
									<h5>다음 달<br>우수강사 지원금</h5>
								</div>
								<div>
									<i class="fa fa-money fa-7x"></i>
								</div>
								<p><b>￦ ${bestIncentiveStack}</b><br/> 보너스</p>
							</div>
						</div><!-- /col-md-4 -->
						
					</div><!-- /row -->
					
					<div class="row mt">
                      <!--CUSTOM CHART START -->
                      <div class="border-head">
                          <h3>NEW STUDENTS</h3>
                      </div>
                      <input id="barChartLabel" value="${jsonLabel}" type="hidden">
                      <input id="barChartData" value="${jsonData}" type="hidden">
                      <div id="bar-chart-div">
                      <canvas id="bar-chart"></canvas>
                      </div>
                      <!--custom chart end-->
					</div><!-- /row -->	
					
                  </div><!-- /col-lg-9 END SECTION MIDDLE -->
                  
                  
      <!-- **********************************************************************************************************************************************************
      RIGHT SIDEBAR CONTENT
      *********************************************************************************************************************************************************** -->                  
                  
                  <div class="col-lg-3 ds">
                    <!--COMPLETED ACTIONS DONUTS CHART-->
						<h3>NOTIFICATIONS</h3>
                                        
						<c:forEach var="employeeNotice" items="${newEmployeeNoticeList}">
							<div class="desc">
		                      	<div class="thumb">
		                      		<span class="badge bg-theme"><i class="fa fa-clock-o"></i></span>
		                      	</div>
		                      	<div class="details">
		                      		<c:set var="regTime" value="${employeeNotice.register_date_string}" />
		                      		<p>
		                      			<muted>${regTime}
		                      				<c:choose>
		                      				<c:when test="${regTime<60}"><fmt:formatNumber value="${regTime}" pattern="#,##"/>초 전</c:when>
		                      				<c:when test="${regTime<60*60}"><fmt:formatNumber value="${regTime/60}" pattern="#,##"/>분 전</c:when>
		                      				<c:when test="${regTime<60*60*60}"><fmt:formatNumber value="${regTime/60/60}" pattern="#,##"/>시간 전</c:when>
		                      				<c:otherwise><fmt:formatNumber value="${regTime/60/60/24}" pattern="#,##"/>일 전</c:otherwise>
		                      				</c:choose>
		                      			</muted><br/>
		                      		   <a href="#">${employeeNotice.name_kor}</a> ${employeeNotice.title}<br/>
		                      		</p>
		                      	</div>
		                      </div>
						</c:forEach>
                                        
                      

                       <!-- USERS ONLINE SECTION -->
						<h3>TEAM MEMBERS</h3>
                      <!-- First Member -->
                      <div class="desc">
                      	<div class="thumb">
                      		<img class="img-circle" src="${resourceUrl}/assets/img/ui-divya.jpg" width="35px" height="35px" align="">
                      	</div>
                      	<div class="details">
                      		<p><a href="#">DIVYA MANIAN</a><br/>
                      		   <muted>Available</muted>
                      		</p>
                      	</div>
                      </div>
                      <!-- Second Member -->
                      <div class="desc">
                      	<div class="thumb">
                      		<img class="img-circle" src="${resourceUrl}/assets/img/ui-sherman.jpg" width="35px" height="35px" align="">
                      	</div>
                      	<div class="details">
                      		<p><a href="#">DJ SHERMAN</a><br/>
                      		   <muted>I am Busy</muted>
                      		</p>
                      	</div>
                      </div>
                      <!-- Third Member -->
                      <div class="desc">
                      	<div class="thumb">
                      		<img class="img-circle" src="${resourceUrl}/assets/img/ui-danro.jpg" width="35px" height="35px" align="">
                      	</div>
                      	<div class="details">
                      		<p><a href="#">DAN ROGERS</a><br/>
                      		   <muted>Available</muted>
                      		</p>
                      	</div>
                      </div>
                      <!-- Fourth Member -->
                      <div class="desc">
                      	<div class="thumb">
                      		<img class="img-circle" src="${resourceUrl}/assets/img/ui-zac.jpg" width="35px" height="35px" align="">
                      	</div>
                      	<div class="details">
                      		<p><a href="#">Zac Sniders</a><br/>
                      		   <muted>Available</muted>
                      		</p>
                      	</div>
                      </div>
                      <!-- Fifth Member -->
                      <div class="desc">
                      	<div class="thumb">
                      		<img class="img-circle" src="${resourceUrl}/assets/img/ui-sam.jpg" width="35px" height="35px" align="">
                      	</div>
                      	<div class="details">
                      		<p><a href="#">Marcel Newman</a><br/>
                      		   <muted>Available</muted>
                      		</p>
                      	</div>
                      </div>

                        <!-- CALENDAR-->
                        <div id="calendar" class="mb">
                            <div class="panel green-panel no-margin">
                                <div class="panel-body">
                                    <div id="date-popover" class="popover top" style="cursor: pointer; disadding: block; margin-left: 33%; margin-top: -50px; width: 175px;">
                                        <div class="arrow"></div>
                                        <h3 class="popover-title" style="disadding: none;"></h3>
                                        <div id="date-popover-content" class="popover-content"></div>
                                    </div>
                                    <div id="my-calendar"></div>
                                </div>
                            </div>
                        </div><!-- / calendar -->
                      
                  </div><!-- /col-lg-3 -->
              </div><!--/row -->
          </section>
      </section>

      <!--main content end-->
      
      
	<!-- inclue common script -->
    <%@ include file="commonScript.jsp" %>

    <!--script for this page-->    
	<script src="${resourceUrl}/assets/js/zabuto_calendar.js"></script>	
	<script src="${resourceUrl}/assets/js/chart-master/Chart.min.js"></script>
	
	<script src="${resourceUrl}/js/managemnetIndex.js"></script>
	
	<script src="${resourceUrl}/svg.clock.js-master/lib/svg.min.js" type="text/javascript" charset="utf-8"></script>
	<script src="${resourceUrl}/svg.clock.js-master/lib/svg.easing.min.js" type="text/javascript" charset="utf-8"></script>
	<script src="${resourceUrl}/svg.clock.js-master/svg.clock.min.js" type="text/javascript" charset="utf-8"></script>
	<script type="text/javascript" charset="utf-8">
		SVG('canvas').clock('100%').start()
	</script>
	<script src="${resourceUrl}/simpleWeather/jquery.simpleWeather.min.js" type="text/javascript" charset="utf-8"></script>
	<script src="${resourceUrl}/simpleWeather/simpleWeather.js" type="text/javascript" charset="utf-8"></script>
	
	<script>
		$(document).ready(function(){
			 //직원등록 후 
		    var result = ${param.result};
		    var user_id = ${param.user_id};
		    if(result==4){
		       alert("직원 등록을 하였습니다.\n 생성 아이디: "+user_id+ "\n 패스워드: 1004");   
		    }
			
		});
	</script>
