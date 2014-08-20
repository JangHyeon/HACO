<%@page import="kr.co.haco.VO.OpenCourse"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="s" uri="http://www.springframework.org/security/tags"%>

<!--external css-->
<link
	href="${pageContext.request.contextPath}/resources/assets/font-awesome/css/font-awesome.css"
	rel="stylesheet" />
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/resources/assets/css/zabuto_calendar.css">
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/resources/assets/js/gritter/css/jquery.gritter.css" />
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/resources/assets/lineicons/style.css">

<!-- Custom styles for this template -->
<link
	href="${pageContext.request.contextPath}/resources/assets/css/style.css"
	rel="stylesheet">
<link
	href="${pageContext.request.contextPath}/resources/assets/css/style-responsive.css"
	rel="stylesheet">


<input id="current-accordion" type="hidden" value="mansgement" />

<!-- **********************************************************************************************************************************************************
      MAIN CONTENT
      *********************************************************************************************************************************************************** -->
<!--main content start-->
<script type="text/javascript">
	function course_write(obj){
		document.stdentlist.openid.value=obj.course_id;
		document.stdentlist.submit();
	}
</script>

 <section id="main-content">
 	<section class="wrapper site-min-height">
			<h1>과정목록</h1>
				<table width="600" cellpadding="3" border="1px">
						<tr>
							<th width="270">제목</th>
							<th width="50">번호</th>
							<th width="120">날짜1</th>
							<th width="120">날짜2</th>
		
						</tr>	

					<c:forEach var="b" items="${getattenlist}">
						<tr>
							<a onclick="course_write(this)" course_id="${b.open_course_id}"><td>${b.course_name}</td></a>
							<td>${b.open_course_id}</td>
							<td>${b.course_start_date}</td>
							<td>${b.course_end_date}</td>
						</tr>
					</c:forEach>

				</table>
		<form name='stdentlist' id='stdentlist' action='stdentlist' method='get'>
			<input type="hidden" name="openid" id="openid" value="${b.open_course_id}"/>
		</form>
  </section>
</section>
<!--main content end-->


<!-- inclue common script -->
<%@ include file="commonScript.jsp"%>

<!--script for this page-->

    
    
    <!-- js placed at the end of the document so the pages load faster -->
    <script src="${pageContext.request.contextPath}/resources/assets/js/jquery.js"></script>
    <script src="${pageContext.request.contextPath}/resources/assets/js/jquery-ui-1.9.2.custom.min.js"></script>
    <script src="${pageContext.request.contextPath}/resources/assets/js/bootstrap.min.js"></script>
    <script src="${pageContext.request.contextPath}/resources/assets/js/jquery.scrollTo.min.js"></script>
    <script src="${pageContext.request.contextPath}/resources/assets/js/jquery.nicescroll.js" type="text/javascript"></script>


    <!--common script for all pages-->
    <script src="${pageContext.request.contextPath}/resources/assets/js/common-scripts.js"></script>

    <!--script for this page-->
 
   
  <script>
      //custom select box

      $(function(){
          
      });

  </script>