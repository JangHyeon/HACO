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
              
              	  <p class="centered"><a href="profile"><img src="${pageContext.request.contextPath}/resources/assets/img/ui-sam.jpg" class="img-circle" width="60"></a></p>
              	  <h5 class="centered">${sessionScope.employee.name_eng}<br>(${sessionScope.employee.name_kor})</h5>
              	  
              	  <!-- 센터장, 본점장만 -->	
				  <s:authorize ifAnyGranted="MASTER,CENTER">
                  <li class="mt" name="employeeManagement">
                      <a href="employeeManagement" >
                          <i class="fa fa-desktop"></i>
                          <span>직원 관리</span>
                      </a>
                  </li>
				  </s:authorize>
				
                  <li class="mt" name="index">
                      <a href="index">
                          <i class="fa fa-tasks"></i>
                          <span>대쉬보드</span>
                      </a>
                  </li>
				
                  <li class="sub-menu" name="attendance">
                      <a href="attendance">
                          <i class="fa fa-calendar"></i>
                          <span>출　　석</span>
                      </a>
                  </li>

                  <li class="sub-menu" name="course">
                      <a href="javascript:;" >
                          <i class="fa fa-cubes"></i>
                          <span>과　　정</span>
                      </a>
                      <ul class="sub">
                          <li name="sub1-1"><a  href="general">과목등록</a></li>
                          <li name="sub1-2"><a  href="buttons">과정등록</a></li>
                          <li name="educationCenter"><a  href="educationCenter">교육센터</a></li>
                      </ul>
                  </li>
				
                  <li class="sub-menu" name="lectureRegister">
                      <a href="lectureRegister">
                          <i class="fa fa-envelope"></i>
                          <span>수강신청</span>
                      </a>
                  </li>
				
                  <li class="sub-menu" name="lectureEvaluation">
                      <a href="lectureEvaluation">
                          <i class="fa fa-tags"></i>
                          <span>수강후기</span>
                      </a>
                  </li>
                  
                  <li class="sub-menu" name="board">
                      <a href="javascript:;" >
                          <i class="fa fa-comments"></i>
                          <span>게시판</span>
                      </a>
                      <ul class="sub">
                          <li name="notice"><a  href="notice">공지사항</a></li>
                          <li name="qna"><a  href="qna">질문과답변</a></li>
                          <li name="community"><a  href="community">모임방</a></li>
                      </ul>
                  </li>
                  
                  <li class="sub-menu" name="member">
                      <a href="javascript:;" >
                          <i class="fa fa-graduation-cap"></i>
                          <span>원생</span>
                      </a>
                      <ul class="sub">
                          <li name="membersub1"><a  href="panels">신규 목록</a></li>
                          <li name="membersub2"><a  href="basic_table">원생 목록</a></li>
                          <li name="membersub3"><a  href="responsive_table">퇴교 목록</a></li>
                      </ul>
                  </li>
                  
                  <li class="sub-menu" name="employee">
                      <a href="javascript:;" >
                          <i class="fa fa-users"></i>
                          <span>직원</span>
                      </a>
                      <ul class="sub">
                          <li name="sub1"><a  href="morris">센터장</a></li>
                          <li name="sub2"><a  href="gallery">관리직원</a></li>
                          <li name="sub3"><a  href="todo_list">강사</a></li>
                      </ul>
                  </li>
                  
                  <%-- <li class="sub-menu" name="sub4">
                      <a href="javascript:;" >
                          <i class="fa fa-tasks"></i>
                          <span>Forms</span>
                      </a>
                      <ul class="sub">
                          <li name="sub4-1"><a  href="form_component">Form Components</a></li>
                      </ul>
                  </li>
                  <li class="sub-menu" name="sub5">
                      <a href="javascript:;" >
                          <i class="fa fa-th"></i>
                          <span>Data Tables</span>
                      </a>
                      <ul class="sub">
                          <li name="sub5-1"><a  href="basic_table">Basic Table</a></li>
                          <li name="sub5-2"><a  href="responsive_table">Responsive Table</a></li>
                      </ul>
                  </li>
                  <li class="sub-menu" name="sub6">
                      <a href="javascript:;" >
                          <i class=" fa fa-bar-chart-o"></i>
                          <span>Charts</span>
                      </a>
                      <ul class="sub">
                          <li name="sub6-1"><a  href="morris">Morris</a></li>
                          <li name="sub6-2"><a  href="chartjs">Chartjs</a></li>
                      </ul>
                  </li> --%>

              </ul>
              <!-- sidebar menu end-->
          </div>
      </aside>
      <!--sidebar end-->
      