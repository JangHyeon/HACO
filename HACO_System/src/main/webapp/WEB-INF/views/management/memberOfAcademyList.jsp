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


<input id="current-accordion" type="hidden" value="member,memberOfAcademyList" />

<!-- **********************************************************************************************************************************************************
      MAIN CONTENT
      *********************************************************************************************************************************************************** -->
<!--main content start-->
<section id="main-content">
   <section class="wrapper">
      <h3>
         <i class="fa fa-angle-right"></i> 회원 조회          
      </h3>      
      <div class="row">

         <div class="col-md-12">
            <div class="content-panel">            
               <!-- 강좌목록 -->
               <div class="btn-group pull-right topToggle">
                 <button id="courseBtn" type="button" class="btn btn-default dropdown-toggle" data-toggle="dropdown">                  
	           		<c:choose>
	           			<c:when test="${not empty course_name}">
	           				<span>${course_name}</span>
	           				<span class="caret"></span>
	        				</button>
	         					<ul class="dropdown-menu" role="menu" id="courseList">
	         						<c:forEach var="course" items="${courseList}">
	         							<li><a href="${pageContext.request.contextPath}/management/memberOfAcademyList?c_id=${course.center_id}&open_course_id=${course.open_course_id}">${course.course_name}</a></li>
	         						</c:forEach>                                                 
	         					</ul>	         					
	           			</c:when>
	           			<c:otherwise>
	           				<span>강좌목록</span>
	           				<span class="caret"></span>
	         				</button>
	         					<ul class="dropdown-menu" role="menu" id="courseList">                                                  
	         					</ul>
	           			</c:otherwise>
	           		</c:choose>                 
               </div>   
               
               <!-- 센터목록 -->
               <div class="btn-group pull-right topToggle">
                 <button id="centerBtn" type="button" class="btn btn-default dropdown-toggle" data-toggle="dropdown" >
                   <span>
                   		<c:choose>
                   			<c:when test="${not empty center_name}">
                   				${center_name}
                   			</c:when>
                   			<c:otherwise>
                   				센터목록
                   			</c:otherwise>
                   		</c:choose>
                   </span>
                   <span class="caret"></span>
                 </button>
                 <ul class="dropdown-menu" role="menu" id="centerList">
                    <li><a href="${pageContext.request.contextPath}/management/memberOfAcademyList?center_id=0">전체 센터</li>
                    <c:forEach var="edu" items="${eduCenterList}">
                       <li name="theCenter" value="${edu.center_id}"><a>${edu.location}</a></li>                                               
                   </c:forEach>                   
                 </ul>
               </div>                      
               <input type="hidden" name="center_name">
               <input type="hidden" name="course_name">
            
               <h4>
                  <i class="fa fa-angle-right"></i> 원생       
               </h4>
               <hr>         
               <table class="table table-hover">
                  <thead>
                     <tr>
                        <th>번호</th>
                        <th>센터명</th>   
                        <th>과정명</th>
                        <th>이름</th>   
                        <th>직무</th>         
                        <th>전화번호</th>                        
                        <!-- <th>주소</th> -->
                        <th>이메일</th>
                        <th>등록일자</th>   
                        <th>등록코드</th>      
                        <th>설문여부</th>                                          
                     </tr>
                  </thead>
                  <tbody>
                     <c:forEach var="member" items="${memberList}" varStatus="seq">
                        <tr>
                           <td>${seq.index+1}</td>
                           <td>${member.location}</a></td>
                           <td>${member.course_name}</a></td>
                           <td>${member.name}</td>                           
                           <td>${member.job_duty}</a></td>
                           <td>${member.phone}</td>
                           <%-- <td>${member.address}</td> --%>
                           <td>${member.email}</td>
                           <td>${member.lecture_register_date}</td>
                           <td>
                           	<c:choose>
                           		<c:when test="${member.lecture_register_code=='1'}">수강신청</c:when>
                           		<c:when test="${member.lecture_register_code=='2'}">수강허가</c:when>
                           		<c:when test="${member.lecture_register_code=='3'}">취소</c:when>
                           		<c:when test="${member.lecture_register_code=='4'}">납부완료</c:when>
                           	</c:choose>
                           </td>
                           <td>${member.is_survey}</td>                                    
                        </tr>
                     </c:forEach>
                  </tbody>
               </table>
            </div>
            <!-- /content-panel -->
         </div>
         <!-- /col-md-12 -->

      </div>
      <!-- row -->
      
      <div class="col-xs-12">
         <!-- 페이징 -->
         <ul class="pagination pagination-centered">
            <!-- 이전 링크 -->
            <li<c:if test="${beginpage<10}"> class="disabled"</c:if>>
               <a<c:if test="${beginpage>10}"> href="${pageContext.request.contextPath}/management/memberOfAcademyList/pageSize/${pageSize}/${beginpage-1}"</c:if>>«</a>
            </li>
            
              <!-- 페이지 리스트   -->
              <c:if test="${beginpage!=0}">
            <c:forEach var="i" begin="${beginpage}" end="${endpage}" step="1">
            
               <c:if test="${i==pageNum}">
                  <li class="active"><a>${i} <span class="sr-only">(current)</span></a></li>
               </c:if>
               <c:if test="${i!=pageNum}">
               	  <c:choose>
               	  	<c:when test="${not empty course_name}">
               	  		<li><a href="${pageContext.request.contextPath}/management/memberOfAcademyList/${pageSize}/${i}?c_id=${param.c_id}&open_course_id=${param.open_course_id}">${i}</a></li>
               	  	</c:when>
               	  	<c:otherwise>
               	  		<li><a href="${pageContext.request.contextPath}/management/memberOfAcademyList/${pageSize}/${i}">${i}</a></li>	
               	  	</c:otherwise>
               	  </c:choose>                  
               </c:if>
            </c:forEach>
            </c:if>
              <!-- 다음링크 -->
            <li<c:if test="${endpage>=pagecount}"> class="disabled"</c:if>>
            	<c:choose>
               	  	<c:when test="${not empty course_name}">
               	  		<a<c:if test="${endpage<pagecount}"> href="${pageContext.request.contextPath}/management/memberOfAcademyList/${pageSize}/${endpage+1}?c_id=${param.c_id}&open_course_id=${param.open_course_id}"</c:if>>»</a>
               	  	</c:when>
               	  	<c:otherwise>
               	  		<a<c:if test="${endpage<pagecount}"> href="${pageContext.request.contextPath}/management/memberOfAcademyList/${pageSize}/${endpage+1}"</c:if>>»</a>
               	  	</c:otherwise>
               	  </c:choose>              
            </li>
         </ul>
      </div>   
      
      
   </section>
</section>

<!--main content end-->


<!-- inclue common script -->
<%@ include file="commonScript.jsp"%>

<!--script for this page-->
<script type="text/javascript">   
$(document).ready(function () {
   //센터목록 선택
    $('#centerList>li[name=theCenter]').on('click',function(){
       $('#centerBtn>span:first-child').text($('a',this).text());          
       var center_id  = $(this).attr('value');   
       //alert("center_id:"+center_id);
       $.ajax({
            type : "GET",
            url : "${pageContext.request.contextPath}/management/getOpenCourseList?center_id="+center_id,
            cache : false,            
            success : function(response) {
               $("#courseList").empty();
               $('#courseBtn>span:first-child').text('강좌목록');
               $.each(response, function(index, item) {
                  //var course = '<li value="'+item.open_course_id+'"><a>'+item.course_name+'</a></li>';  
                  var course = '<li><a href="${pageContext.request.contextPath}/management/memberOfAcademyList?c_id='+center_id+'&open_course_id='+item.open_course_id+'">'+item.course_name+'</a></li>';                  
                  $("#courseList").append(course);
               });
            },
            error : function() {
               alert('Error while request..');
            }
         });      
    }); 
 
    
});
    
</script>

