<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="s" uri="http://www.springframework.org/security/tags"%>

    <!--external css-->
    <link href="${pageContext.request.contextPath}/resources/assets/font-awesome/css/font-awesome.css" rel="stylesheet" />
	<link rel="stylesheet" href="http://cdn.oesmith.co.uk/morris-0.4.3.min.css">    
        
    <!-- Custom styles for this template -->
    <link href="${pageContext.request.contextPath}/resources/assets/css/style.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/resources/assets/css/style-responsive.css" rel="stylesheet">

	<input id="current-accordion" type="hidden" value="19,20"/>

      <!-- **********************************************************************************************************************************************************
      MAIN CONTENT
      *********************************************************************************************************************************************************** -->
      <!--main content start-->
      <section id="main-content">
          <section class="wrapper site-min-height">
          <h3><i class="fa fa-angle-right"></i> Morris Charts</h3>
              <!-- page start-->
              <div id="morris">
                  <div class="row mt">
                      <div class="col-lg-6">
                          <div class="content-panel">
                              <h4><i class="fa fa-angle-right"></i> Chart Example 1</h4>
                              <div class="panel-body">
                                  <div id="hero-graph" class="graph"></div>
                              </div>
                          </div>
                      </div>
                      <div class="col-lg-6">
                          <div class="content-panel">
                              <h4><i class="fa fa-angle-right"></i> Chart Example 2</h4>
                              <div class="panel-body">
                                  <div id="hero-bar" class="graph"></div>
                              </div>
                          </div>
                      </div>
                  </div>
                  <div class="row mt">
                      <div class="col-lg-6">
                          <div class="content-panel">
                              <h4><i class="fa fa-angle-right"></i> Chart Example 3</h4>
                              <div class="panel-body">
                                  <div id="hero-area" class="graph"></div>
                              </div>
                          </div>
                      </div>
                      <div class="col-lg-6">
                          <div class="content-panel">
                              <h4><i class="fa fa-angle-right"></i> Chart Example 4</h4>
                              <div class="panel-body">
                                  <div id="hero-donut" class="graph"></div>
                              </div>
                          </div>
                      </div>
                  </div>
              </div>
              <!-- page end-->
          </section>
      </section><!-- /MAIN CONTENT -->

      <!--main content end-->


    <!-- js placed at the end of the document so the pages load faster -->
    <script src="${pageContext.request.contextPath}/resources/assets/js/jquery.js"></script>
    <script src="${pageContext.request.contextPath}/resources/assets/js/bootstrap.min.js"></script>
    <script class="include" type="text/javascript" src="${pageContext.request.contextPath}/resources/assets/js/jquery.cookie.js"></script>
    <script class="include" type="text/javascript" src="${pageContext.request.contextPath}/resources/assets/js/jquery.dcjqaccordion.2.7.js"></script>
    <script src="${pageContext.request.contextPath}/resources/assets/js/jquery.scrollTo.min.js"></script>
    <script src="${pageContext.request.contextPath}/resources/assets/js/jquery.nicescroll.js" type="text/javascript"></script>


    <!--common script for all pages-->
	<script src="http://cdnjs.cloudflare.com/ajax/libs/raphael/2.1.0/raphael-min.js"></script>
	<script src="http://cdn.oesmith.co.uk/morris-0.4.3.min.js"></script>
    <script src="${pageContext.request.contextPath}/resources/assets/js/common-scripts.js"></script>

    <!--script for this page-->
    <script src="${pageContext.request.contextPath}/resources/assets/js/morris-conf.js"></script>
    
  <script>
      //custom select box

      $(function(){
          $('select.styled').customSelect();
      });

  </script>
