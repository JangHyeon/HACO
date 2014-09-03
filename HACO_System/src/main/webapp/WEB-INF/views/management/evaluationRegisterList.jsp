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
    
   <input id="current-accordion" type="hidden" value="lectureEvaluation,${uri}"/>

      <!-- **********************************************************************************************************************************************************
      MAIN CONTENT
      *********************************************************************************************************************************************************** -->
         <!--main content start-->
      <section id="main-content">
          <section class="wrapper">
             <h3><i class="fa fa-angle-right"></i> 
               <c:choose>
               <c:when test="${uri=='evaluationRegisterList'}">강의평가 등록</c:when>
               <c:when test="${uri=='evaluationResultList'}">강의평가 결과</c:when>                                                                                                         
            </c:choose>      
             </h3>
              <div class="row mt">
                 <div class="col-lg-12">
                      <div class="content-panel">
                      <h4><i class="fa fa-angle-right"></i> 개설 과정 목록</h4>
                          <section id="unseen">      
                            <table class="table table-hover">
                              <thead>
                              <tr>                              
                                 <th class="numeric">번호</th>
                                 <th class="numeric">센터명</th>
                                 <th class="numeric">과정명</th>
                                 <th class="numeric">수강일자</th>
                                 <th class="numeric">평가 상태</th>               
                              </tr>
                              </thead>
                              <tbody>                             
                              <c:forEach var="erl" items="${evalRegList}" varStatus="seq">                                 
                                <tr>                
                                   <td class="numeric">${seq.index+1}</td>                  
                                  <td class="numeric">${erl.location}</td>
                                   <td class="numeric">
                                      <c:choose>
                                 <c:when test="${uri=='evaluationRegisterList'}">
                                    <c:choose>
                                       <c:when test="${erl.state_code==-1}">
                                          <a href="${pageContext.request.contextPath}/management/evaluationRegisterform?open_course_id=${erl.open_course_id}">
                                          ${erl.course_name}</a>
                                       </c:when>
                                       <c:otherwise>
                                          <a href="${pageContext.request.contextPath}/management/evaluationRegisterDetail?open_course_id=${erl.open_course_id}">
                                          ${erl.course_name}</a>
                                       </c:otherwise>
                                    </c:choose>
                                 </c:when>
                                 <c:when test="${uri=='evaluationResultList'}">
                                    <a href="${pageContext.request.contextPath}/management/evaluationResult?open_course_id=${erl.open_course_id}">
                                       ${erl.course_name}</a>
                                 </c:when>                                                                                                         
                              </c:choose>      
                                   </td>
                                   <td class="numeric">${erl.course_start_date}~ ${erl.course_end_date}</td>
                                   <td class="numeric">    
                                      <%-- ${erl.state_code}   --%>                             
                                      <c:choose>                                      
                                 <c:when test="${erl.state_code==1}">
                                    <button type="button" class="btn btn-default btn-xs evalBtn" style="width:80px;" 
                                    value="${erl.open_course_id}">설문중</button>                                    
                                 </c:when>
                                 <c:when test="${erl.state_code==0}">비활성</c:when>
                                 <c:when test="${erl.state_code==9}">
                                    <button type="button" class="btn btn-default btn-xs evalBtn" style="width:80px" 
                                    value="${erl.open_course_id}">설문완료</button>      
                                 </c:when>
                                 <c:when test="${erl.state_code==-1}">미등록</c:when>                                                                        
                              </c:choose>   
                              
                                   </td>                                   
                                </tr>
                              </c:forEach>   
                              </tbody>
                          </table>
                          </section>
                  </div><!-- /content-panel -->
               </div><!-- /col-lg-4 -->         
           </div><!-- /row -->
           
           
           <div class="col-xs-12">
            <!-- 페이징 -->
            <ul class="pagination pagination-centered">
               <!-- 이전 링크 -->
               <li<c:if test="${beginpage<10}"> class="disabled"</c:if>>
                  <a<c:if test="${beginpage>10}"> href="${pageContext.request.contextPath}/management/${uri}/pageSize/${pageSize}/pageNum/${beginpage-1}"</c:if>>«</a>
               </li>
               
                 <!-- 페이지 리스트   -->
                 <c:if test="${beginpage!=0}">
               <c:forEach var="i" begin="${beginpage}" end="${endpage}" step="1">
               
                  <c:if test="${i==pageNum}">
                     <li class="active"><a>${i} <span class="sr-only">(current)</span></a></li>
                  </c:if>
                  <c:if test="${i!=pageNum}">
                     <li><a href="${pageContext.request.contextPath}/management/${uri}/pageSize/${pageSize}/pageNum/${i}">${i}</a></li>
                  </c:if>
               </c:forEach>
               </c:if>
                 <!-- 다음링크 -->
               <li<c:if test="${endpage>=pagecount}"> class="disabled"</c:if>>
                  <a<c:if test="${endpage<pagecount}"> href="${pageContext.request.contextPath}/management/${uri}/pageSize/${pageSize}/pageNum/${endpage+1}"</c:if>>»</a>
               </li>
            </ul>
         </div>   
           
        
      </section><!-- /wrapper -->
      </section><!-- /MAIN CONTENT -->

      <!--main content end-->
     <script src="//netdna.bootstrapcdn.com/bootstrap/3.0.0-wip/js/bootstrap.min.js"></script>
     
    <!-- inclue common script -->
    <%@ include file="commonScript.jsp" %>

    <!--script for this page-->
    
<script type="text/javascript">
$(document).ready(function() {
   /* //custom select box
    $('select.styled').customSelect(); */
    
   //평가 상태 버튼
   //설문중
    $('.evalBtn').on('click',function(){
       var course_id = $(this).attr("value");
        location.href="${pageContext.request.contextPath}/management/evaluationResult?open_course_id="+course_id;     
    });
   
   
});      
</script>
  
