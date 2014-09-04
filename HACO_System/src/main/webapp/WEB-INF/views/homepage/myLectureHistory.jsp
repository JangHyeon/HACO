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
<link rel="stylesheet" href="${resourceUrl}/Remodal/jquery.remodal.css">


<!-- myPage header column -->
<%@ include file="inc/myLectureHistoryHeader.jsp" %>


<!-- Begin Body -->
<div class="container">
   <div class="no-gutter row">

      <!-- right content column-->
      <div class="col-md-12" id="content">
         <div class="panel">
            <ol class="breadcrumb">
              <li class="active">수강 내역</li>
            </ol>
            
            <!-- Main Content -->
            <div class="panel-body">
               <div class="form-panel">
                      <table class="table table-hover">
                     <thead>
                        <tr>
                           <th class="idx">번호</th>
                           <th>과정명</th>      
                           <th>센터명</th>   
                           <th>시작일시</th>   
                           <th>종료일시</th>   
                           <th>출석확인</th>                        
                           <th>강의평가/수료증발급</th>                           
                        </tr>
                     </thead>
                     <tbody>                        
                        <c:forEach var="myLecture" items="${myLectureList}" varStatus="seq">                        
                        <tr>
                           <td>${seq.index+1}</td>
                           <td><a href="${pageContext.request.contextPath}/lecture?opid=${myLecture.open_course_id}">${myLecture.course_name}</a></td>               
                           <td>${myLecture.location}</td>                           
                           <td>${myLecture.course_start_date}</td>   
                           <td>${myLecture.course_end_date}</td>   
                           <td>
                        <%--       <button type="button" class="btn btn-default btn-sm attendBtn" style="width:80px" value="${myLecture.open_course_id}">   
                                 ${myLecture.now_study}
                              </button>  --%>                             
                              <c:choose>
                                 <c:when test="${myLecture.now_study=='수강중'}">
                                    <button type="button" class="btn btn-warning btn-xs attendBtn" value="${myLecture.open_course_id}">수강중</button>
                                 </c:when>
                                 <c:when test="${myLecture.now_study=='수강완료'}">
                                    <button type="button" class="btn btn-success btn-xs attendBtn" value="${myLecture.open_course_id}">수강완료</button>
                                 </c:when>
                                 <c:when test="${myLecture.now_study=='미개강'}">
                                    <small>미개강</small>
                                 </c:when>
                              </c:choose>
                           </td>    
                           <td>                   
                           
  <!--                           WHEN state_code IS null THEN '평가없음'
                WHEN state_code =1 AND l.is_survey='Y' THEN  '평가활성-평가함'
                WHEN state_code =1 AND l.is_survey='N' THEN '평가활성-평가안함'
                WHEN state_code =0 THEN '평가비활성'
                WHEN state_code =9 THEN '평가CLOSE'
                                 -->
                              <c:choose>
                                 <c:when test="${myLecture.is_survey=='평가활성-평가안함'}">
                                    <button type="button" class="btn btn-default btn-xs evalBtn" value="${myLecture.open_course_id}">강의평가 하기</button>
                                 </c:when>
                                 <c:when test="${myLecture.is_survey=='평가활성-평가함'}">
                                    <button type="button" class="btn btn-default btn-xs certificateBtn">수료증 발급</button>
                                 </c:when>
                             <%--      <c:when test="${myLecture.is_survey=='평가CLOSE'}">
                                    강의평가 CLOSE
                                 </c:when> --%>
                                 <c:otherwise>
                                    <small>평가 미등록</small>
                                 </c:otherwise>
                              </c:choose>
                              
                           </td>            
                        </tr>
                        </c:forEach>
                     </tbody>                     
                  </table>         
                     </div>
               
               <hr style="margin-top:0;display:block;clear:both;">

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
<script src="${resourceUrl}/gazONojfL3/js/jquery.1.9.1.min.js"></script>
<script   src="${resourceUrl}/gazONojfL3/js/bootstrap.3.2.0.min.js"></script>
<script   src="${resourceUrl}/gazONojfL3/js/scripts.js"></script>

<!-- JavaScript jQuery code from Bootply.com editor  -->

<script type="text/javascript">
   $(document).ready(function() {
      
      $('#sidebar').affix({
         offset : {
            top : 230,
            bottom : 100
         }
      });
      
      //강의평가 버튼
        $('.evalBtn').on('click',function(){
           var course_id = $(this).attr("value");
           location.href="${pageContext.request.contextPath}/myLectureEvaluation?open_course_id="+course_id;        
      });
      //수료증 발급 버튼
        $('.certificateBtn').on('click',function(){
           location.href="#";
           alert('준비중입니다...');
      });
      //출결 버튼
        $('.attendBtn').on('click',function(){
           var course_id = $(this).attr("value");
           location.href="${pageContext.request.contextPath}/attenlist?open_course_id="+course_id;        
      });
        
   });
</script>