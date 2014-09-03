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


<input id="current-accordion" type="hidden" value="member,memberOfSiteList" />

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
               <h4>
                  <i class="fa fa-angle-right"></i> 사이트 회원                         
               </h4>
               <hr>         
               <table class="table table-hover">
                  <thead>
                     <tr>
                        <th>번호</th>
                        <th>이름</th>   
                        <th>직무</th>         
                        <th>전화번호</th>                        
                        <th>주소</th>
                        <th>이메일</th>
                        <th>가입일자</th>                                             
                     </tr>
                  </thead>
                  <tbody>
                     <c:forEach var="member" items="${memberList}" varStatus="seq">
                        <tr>
                           <td>${seq.index+1}</td>
                           <td>${member.name}</td>                           
                           <td>${member.job_duty}</td>
                           <td>${member.phone}</td>
                           <td>${member.address}</td>
                           <td>${member.email}</td>
                           <td>${member.create_date}</td>                                    
                        </tr>
                     </c:forEach>
                  </tbody>
               </table>
		       <c:if test="${empty memberList || empty memberList[0]}">
					<h3 style="margin: 80px auto; text-align: center;">결과가 없습니다...</h3>
				</c:if>
				<div class="table-footer">
					<div class="col-sm-12 col-md-12">
						<!-- 페이징 -->
						<ul class="pagination pagination-centered">
			            <!-- 이전 링크 -->
			            <li<c:if test="${beginpage<10}"> class="disabled"</c:if>>
			               <a<c:if test="${beginpage>10}"> href="${pageContext.request.contextPath}/management/memberOfSiteList/${pageSize}/${beginpage-1}"</c:if>>«</a>
			            </li>
			            
			              <!-- 페이지 리스트   -->
			              <c:if test="${beginpage!=0}">
			            <c:forEach var="i" begin="${beginpage}" end="${endpage}" step="1">
			            
			               <c:if test="${i==pageNum}">
			                  <li class="active"><a>${i} <span class="sr-only">(current)</span></a></li>
			               </c:if>
			               <c:if test="${i!=pageNum}">
			                  <li><a href="${pageContext.request.contextPath}/management/memberOfSiteList/${pageSize}/${i}">${i}</a></li>
			               </c:if>
			            </c:forEach>
			            </c:if>
			              <!-- 다음링크 -->
			            <li<c:if test="${endpage>=pagecount}"> class="disabled"</c:if>>
			               <a<c:if test="${endpage<pagecount}"> href="${pageContext.request.contextPath}/management/memberOfSiteList/${pageSize}/${endpage+1}"</c:if>>»</a>
			            </li>
			         </ul>
			      </div>  
		      </div>
            </div>
            <!-- /content-panel -->
         </div>
         <!-- /col-md-12 -->
      </div>
      <!-- row -->
   </section>
</section>

<!--main content end-->


<!-- inclue common script -->
<%@ include file="commonScript.jsp"%>

<!--script for this page-->

