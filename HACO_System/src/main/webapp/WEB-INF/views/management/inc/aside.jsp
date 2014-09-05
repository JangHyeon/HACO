<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="s" uri="http://www.springframework.org/security/tags"%>


<!-- **********************************************************************************************************************************************************
      MAIN SIDEBAR MENU
      *********************************************************************************************************************************************************** -->
      <!--sidebar start-->
      <aside>
          <div id="sidebar"  class="nav-collapse ">
              <!-- sidebar menu start-->
              <ul class="sidebar-menu" id="nav-accordion">
              
              	  <div class="centered employeePhoto">
              	  	<a href="${pageContext.request.contextPath}/management/employeeDetail">
              	  		<img src="${pageContext.request.contextPath}/employeePhoto/${sessionScope.employee.photo}" class="employeePhoto-img" width="80" onerror="this.src='${pageContext.request.contextPath}/images/gray-ori-User-Role-Guest-icon.png'">
              	  	</a>
              	  </div>
              	  <h5 class="centered">
              	  ${sessionScope.employee.name_kor}
              	  <br>${sessionScope.employee.name_eng}
              	  <br><small>${sessionScope.employee.location}</small></h5>

			  	    
              	  <!-- 센터장, 본점장만 -->	
				  <s:authorize ifAnyGranted="MASTER,CENTER">
				  <li class="mt sub-menu" name="employeeManagement">
                      <a href="javascript:;" >
                          <i class="fa fa-desktop"></i>
                          <span>직원관리</span>
                      </a>
                      <ul class="sub">
                          <li name="employeeRegister"><a  href="${pageContext.request.contextPath}/management/employeeRegister">직원등록</a></li>
                      </ul>
                  </li>
				  </s:authorize>
				  
				
                  <li class="sub-menu" name="attendance">
                      <a href="${pageContext.request.contextPath}/management/attendance">
                          <i class="fa fa-calendar"></i>
                          <span>출　　석</span>
                      </a>
                  </li>

                  <li class="sub-menu" name="course">
                      <a href="javascript:;" >
                          <i class="fa fa-cube"></i>
                          <span>과　　정</span>
                      </a>
                      <ul class="sub">
                          <li name="subjectRegister"><a  href="${pageContext.request.contextPath}/management/subjectRegister">과목등록</a></li>
                          <li name="courseRegister"><a  href="${pageContext.request.contextPath}/management/courseRegister">과정등록</a></li>
                          <li name="centerRegister"><a  href="${pageContext.request.contextPath}/management/centerRegister">교육센터</a></li>
                      </ul>
                  </li>
				
                  <li class="sub-menu" name="lectureRegister">
                      <a href="${pageContext.request.contextPath}/management/lectureRegister">
                          <i class="fa fa-envelope"></i>
                          <span>수강신청</span>
                      </a>
                       <ul class="sub">
                  		    <li name="lectureRegister"><a  href="${pageContext.request.contextPath}/management/lectureRegister">수강신청목록</a></li>
					   		<li name="lectureRegisterComplete"><a  href="${pageContext.request.contextPath}/management/lectureRegisterComplete">수강신청완료</a></li>
					   </ul>
                  </li>
				
                  <li class="sub-menu" name="lectureEvaluation">
                      <a href="javascript:;">
                          <i class="fa fa-tags"></i>
                          <span>강의평가</span>
                      </a>
                      <ul class="sub">
                      		<li name="evaluationRegisterList"><a href="${pageContext.request.contextPath}/management/evaluationRegisterList">평가등록</a></li>
                      		<li name="evaluationResultList"><a href="${pageContext.request.contextPath}/management/evaluationResultList">평가 결과</a></li>                      		
                      </ul>
                  </li>
                  
                  <li class="sub-menu" name="board">
                      <a href="javascript:;" >
                          <i class="fa fa-comments"></i>
                          <span>게시판</span>
                      </a>
                      <ul class="sub">
                          <li name="notice"><a  href="${pageContext.request.contextPath}/management/notice">공지사항</a></li>
                          <li name="qna"><a  href="${pageContext.request.contextPath}/management/qna">질문과답변</a></li>
                          <%-- <li name="community"><a  href="${pageContext.request.contextPath}/management/community">모임방</a></li> --%>
                      </ul>
                  </li>
                  
                  <li class="sub-menu" name="member">
                      <a href="javascript:;" >
                          <i class="fa fa-graduation-cap"></i>
                          <span>원생 조회</span>
                      </a>
                      <ul class="sub">
                          <li name="memberOfSiteList"><a  href="${pageContext.request.contextPath}/management/memberOfSiteList">회원 목록</a></li>
                          <li name="memberOfAcademyList"><a  href="${pageContext.request.contextPath}/management/memberOfAcademyList">원생 목록</a></li>
                          <%-- <li name="leaveMemberList"><a  href="${pageContext.request.contextPath}/management/memberOfLeaveList">퇴교 목록</a></li> --%>
                      </ul>
                  </li>
                  
                  <li class="sub-menu" name="employee">
                      <a href="javascript:;" >
                          <i class="fa fa-user"></i>
                          <span>직원 조회</span>
                      </a>
                      <ul class="sub">
                          <li name="center"><a  href="${pageContext.request.contextPath}/management/center">센터장</a></li>                          
                          <li name="teacher"><a  href="${pageContext.request.contextPath}/management/teacher">강사</a></li>
                          <li name="manager"><a  href="${pageContext.request.contextPath}/management/manager">관리직원</a></li>
                      </ul>
                  </li>
              </ul>
              <!-- sidebar menu end-->
          </div>
      </aside>
      <!--sidebar end-->
      
