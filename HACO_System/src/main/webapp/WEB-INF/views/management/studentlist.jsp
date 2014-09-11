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

<!--external css-->
<link
	href="${resourceUrl}/assets/font-awesome/css/font-awesome.css"
	rel="stylesheet" />
<link rel="stylesheet" type="text/css"
	href="${resourceUrl}/assets/css/zabuto_calendar.css">
<link rel="stylesheet" type="text/css"
	href="${resourceUrl}/assets/js/gritter/css/jquery.gritter.css" />
<link rel="stylesheet" type="text/css"
	href="${resourceUrl}/assets/lineicons/style.css">

<!-- Custom styles for this template -->
<link
	href="${resourceUrl}/assets/css/style.css"
	rel="stylesheet">
<link
	href="${resourceUrl}/assets/css/style-responsive.css"
	rel="stylesheet">


<input id="current-accordion" type="hidden" value="mansgement" />

<!-- **********************************************************************************************************************************************************
      MAIN CONTENT
      *********************************************************************************************************************************************************** -->
<!--main content start-->
<%-- 		<script type="text/javascript">
	function course_write(obj){
		alert(obj.course_id);
		document.stdentlist.open_course_id.value=obj.course_id;
		alert(obj.course_id);
		document.stdentlist.submit();
	}
			</script> --%>

 <section id="main-content">
 	<section class="wrapper site-min-height">
 	
 	<script type="text/javascript">
 		function check_click(obj, a_id) {
 			var obj_a = document.insertatt.check_a;
 			var obj_b = document.insertatt.check_b;
 			var obj_c = document.insertatt.check_c;
 			var obj_d = document.insertatt.check_d;
 			var id = document.insertatt.account_id;
 			var obj_sel;
 			
 			
 			if (obj_a[0].name == obj.name) {obj_sel = 'a';}
 			else if (obj_b[0].name == obj.name) {obj_sel = 'b';}
 			else if (obj_c[0].name == obj.name) {obj_sel = 'c';}
 			else if (obj_d[0].name == obj.name) {obj_sel = 'd';}
 			
 			var no;
			
 			for (var i = 0; i < obj_a.length; i++){
 				if (id[i].value == a_id) {no=i;break;}
 			}
 			
			
 			if (obj_sel == 'a') {
 				obj_a[no].innerHTML="<i class='fa fa-check'></i>";
 				obj_b[no].innerHTML="";
 				obj_c[no].innerHTML="";
 				obj_d[no].innerHTML="";
 				document.insertatt.attendance_code[no].value = obj_a[no].value;
 			} else if (obj_sel == 'b') {
 				obj_a[no].innerHTML="";
 				obj_b[no].innerHTML="<i class='fa fa-check'></i>";
 				obj_c[no].innerHTML="";
 				obj_d[no].innerHTML="";
 				document.insertatt.attendance_code[no].value = obj_b[no].value;
 			} else if (obj_sel == 'c') {
 				obj_a[no].innerHTML="";
 				obj_b[no].innerHTML="";
 				obj_c[no].innerHTML="<i class='fa fa-check'></i>";
 				obj_d[no].innerHTML="";
 				document.insertatt.attendance_code[no].value = obj_c[no].value;
 			} else if (obj_sel == 'd') {
 				obj_a[no].innerHTML="";
 				obj_b[no].innerHTML="";
 				obj_c[no].innerHTML="";
 				obj_d[no].innerHTML="<i class='fa fa-check'></i>";
 				document.insertatt.attendance_code[no].value = obj_d[no].value;
 			}
 			document.insertatt.attendance_code[no].submit();
		}
 	</script>
 	<form name='insertatt' id='insertatt' action='studentlist' method='GET'>
 		<div class="row mt">
                  <div class="col-md-12">
                      <div class="content-panel">
                      	<input type="hidden" name="open_course_id" value="${open_course_id}"/>
                          <table class="table table-striped table-advance table-hover">
	                  	  	  <h4><i class="fa fa-angle-right"></i>수강생목록</h4>
	                  	  	  <hr>
                              <thead>
                              <tr>
                                  <th>이름</th>
                                  <th>전화번호</th>
                                  <th>출석</th>
                                  <th>지각</th>
                                  <th>조퇴</th>
                                  <th>결석</th>
                              </tr>
                              </thead>
                              <tbody>
  	      	           	      <c:forEach var="b" items="${getstudentlist}">
								<tr>
									<td>${b.name}</td>
									<td>${b.phone}</td>
                                    <td>
                                    	<input name="attendance_date" type="hidden" value="${date.seldate}"/>
                                    	<input name="account_id" type="hidden" value="${b.account_id}"/>
                                    	<input name="center_id" type="hidden" value="${b.center_id}"/>
                                    	<input name="lecture_register_id" type="hidden" value="${b.lecture_register_id}"/>
                                    	<input name="attendance_code" type="hidden" value="${b.attendance_code}"/>
                                    	
                                      	<button id='check_a' name='check_a' style="width:24px;height:22px;"
                                      			type="button" onclick="check_click(this, ${b.account_id})"
                                      			value="1" class="btn btn-default btn-xs<s:authorize ifAnyGranted="TEACHER"> disabled</s:authorize>">
                                      			<c:if test="${b.attendance_code=='1'}"><i class="fa fa-check"></i></c:if>
                                      	</button>
                                    </td>
                                    <td>
                                     	<button id='check_b' name='check_b' style="width:24px;height:22px;"
                                     			type="button" onclick="check_click(this, ${b.account_id})" 
                                     			value="2" class="btn btn-info btn-xs<s:authorize ifAnyGranted="TEACHER"> disabled</s:authorize>">
                                     			<c:if test="${b.attendance_code=='2'}"><i class="fa fa-check"></i></c:if>
                                     	</button>
                                    </td>
                                    <td>
                                      	<button id='check_c' name='check_c' style="width:24px;height:22px;" 
                                      			type="button" onclick="check_click(this, ${b.account_id})" 
                                      			value="3" class="btn btn-warning btn-xs<s:authorize ifAnyGranted="TEACHER"> disabled</s:authorize>">
                                      			<c:if test="${b.attendance_code=='3'}"><i class="fa fa-check"></i></c:if>
                                      	</button>
                                   	</td>
                                    <td>
                                   	  	<button id='check_d' name='check_d' style="width:24px;height:22px;" 
                                   	  			type="button" onclick="check_click(this, ${b.account_id})" 
                                   	  			value="4" class="btn btn-success btn-xs<s:authorize ifAnyGranted="TEACHER"> disabled</s:authorize>">
                                   	  			<c:if test="${b.attendance_code=='4'}"><i class="fa fa-check"></i></c:if>
                                   	  	</button>
                                   	</td>
                             	</tr>
                             	</c:forEach>
                              </tbody>
                          </table>
                          <c:if test="${empty getstudentlist || empty getstudentlist[0]}">
								<h3 style="margin: 80px auto; text-align: center;">수강생이 없습니다...</h3>
						  </c:if>
                          <s:authorize ifAnyGranted="MASTER,CENTER,MANAGER">
                          <div class="btn-group submitBtn">
							<button id="submitBtn" class="btn btn-large btn-block btn-success joinbtn" type="button">출석 갱신하기</button>
						  </div>
						  </s:authorize>
                      </div><!-- /content-panel -->
                  </div><!-- /col-md-12 -->
              </div><!-- /row -->
		</form>
	</section>
</section>

<!--main content end-->


<!-- inclue common script -->
<%@ include file="commonScript.jsp"%>

<script>
	$(document).ready(function(){
		$('#submitBtn').click(function(){
			$('#insertatt').submit();
		});
	});
</script>
