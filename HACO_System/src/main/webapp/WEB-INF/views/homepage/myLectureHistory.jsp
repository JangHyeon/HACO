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
                           <th>강의평가</th>                           
                        </tr>
                     </thead>
                     <tbody>                        
                        <c:forEach var="myLecture" items="${myLectureList}" varStatus="seq">                        
                        <tr>
                           <td>${seq.index+1}</td>
                           <td>${myLecture.course_name}</td>               
                           <td>${myLecture.location}</td>                           
                           <td>${myLecture.course_start_date}</td>   
                           <td>${myLecture.course_end_date}</td>   
                           <td>
                              <button type="button" class="btn btn-default btn-sm attendBtn" style="width:80px" value="${myLecture.open_course_id}">   
                                 ${myLecture.now_study}
                              </button>
                           </td>    
                           <td>                        
                              <c:choose>
                                 <c:when test="${myLecture.is_survey=='N'}">
                                    <button type="button" class="btn btn-default btn-sm evalBtn" style="width:100px" value="${myLecture.open_course_id}">강의평가 하기</button>
                                 </c:when>
                                 <c:when test="${myLecture.is_survey=='Y'}">
                                    <button type="button" class="btn btn-default btn-sm certificateBtn" style="width:100px">수료증 발급</button>
                                 </c:when>
                              </c:choose>
                              
                           </td>            
                        </tr>
                        </c:forEach>
                     </tbody>                     
                  </table>         
                     </div>
               
               <hr style="display:block;clear:both;">

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
      });
      //출결 버튼
        $('.attendBtn').on('click',function(){
           var course_id = $(this).attr("value");
           location.href="${pageContext.request.contextPath}/attenlist?open_course_id="+course_id;        
      });
        
   });
</script>