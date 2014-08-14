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
                  <li class="mt" name="mansgement">
                      <a href="sub2" >
                          <i class="fa fa-desktop"></i>
                          <span>Master, Center Only</span>
                      </a>
                  </li>
				  </s:authorize>
				
                  <li class="mt" name="index">
                      <a href="index">
                          <i class="fa fa-dashboard"></i>
                          <span>Dashboard</span>
                      </a>
                  </li>

                  <li class="sub-menu" name="sub1">
                      <a href="javascript:;" >
                          <i class="fa fa-desktop"></i>
                          <span>UI Elements</span>
                      </a>
                      <ul class="sub">
                          <li name="sub1-1"><a  href="general">General</a></li>
                          <li name="sub1-2"><a  href="buttons">Buttons</a></li>
                          <li name="sub1-3"><a  href="panels">Panels</a></li>
                      </ul>
                  </li>
                  
                  <li class="sub-menu" name="sub2">
                      <a href="javascript:;" >
                          <i class="fa fa-cogs"></i>
                          <span>Components</span>
                      </a>
                      <ul class="sub">
                          <li name="sub2-1"><a  href="calendar">Calendar</a></li>
                          <li name="sub2-2"><a  href="gallery">Gallery</a></li>
                          <li name="sub2-3"><a  href="todo_list">Todo List</a></li>
                      </ul>
                  </li>
                  <li class="sub-menu" name="sub3">
                      <a href="javascript:;" >
                          <i class="fa fa-book"></i>
                          <span>Extra Pages</span>
                      </a>
                      <ul class="sub">
                          <li name="sub3-1"><a  href="blank">Blank Page</a></li>
                          <li name="sub3-2"><a  href="login">Login</a></li>
                          <li name="sub3-3"><a  href="lock_screen">Lock Screen</a></li>
                      </ul>
                  </li>
                  <li class="sub-menu" name="sub4">
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
                  </li>

              </ul>
              <!-- sidebar menu end-->
          </div>
      </aside>
      <!--sidebar end-->
      