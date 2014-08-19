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
 <section id="main-content">
          <section class="wrapper site-min-height">
 <style type="text/css">
        #tbl
        {
            background-color:#FFF;
            color:#000;
            border-collapse:collapse;
            border:1px solid #dddddd;
        }
        
        #headTr
        {
            font-family: Helvetica, Verdana, sans-serif;
            font-size:10px;
            text-align:center;
            color:#7F6A73;
            line-height:1.5em;
            border:1px solid #dddddd;
            width:120px;
            height:10px;
            background:url(/haco/resources/assets/img/headImg.jpg) no-repeat;
        }
        
        #lmonth
        {
            line-height:1.6em;
            vertical-align:top;
            text-align:right;
            color:#dddddd;
            border:1px solid #dddddd;
            width:120px;
            height:100px;
            padding: 2px 6px 2px 2px;
        }
        #sel
        {
            line-height:1.6em;
            vertical-align:top;
            text-align:right;
            border:1px solid #dddddd;
            width:120px;
            height:100px;
            padding: 2px 6px 2px 2px;
        }
        #today
        {
            line-height:1.6em;
            background-color:#ffef3e;
            vertical-align:top;
            text-align:right;
            border:1px solid #dddddd;
            width:120px;
            height:100px;
            padding: 2px 6px 2px 2px;
        }
        
        #sat
        {
            line-height:1.6em;
            vertical-align:top;
            text-align:right;
            color:#00B;
            border:1px solid #dddddd;
            width:120px;
            height:100px;
            padding: 2px 6px 2px 2px;
        }
        
        #sun
        {
            line-height:1.6em;
            vertical-align:top;
            text-align:right;
            color:#F00;
            border:1px solid #dddddd;
            width:120;
            height:100px;
            padding: 2px 6px 2px 2px;
        }
    
    </style>
    <script language="javascript" type="text/javascript">
// <![CDATA[
        function window_onload() {
            now = new Date();
            year = now.getFullYear();
            month = now.getMonth();
            day =  now.getDate();
            
           
            // cmbYear에 option 1900~2100넣기
            var cmbYear = document.getElementById("cmbYear");
            for (var i = 1900; i <= 2100; i++) {
                cmbYear.options[i - 1900] = new Option(i, i);
                if (cmbYear.options[i - 1900].value == year) {
                    cmbYear.options[i - 1900].selected = true; 
                    
                }
            }
            // cmbMonth에 option 1~12넣기
            var cmbMonth = document.getElementById("cmbMonth");
            for (var i = 1; i <= 12; i++) {
                cmbMonth.options[i - 1] = new Option(i, i);
                if (cmbMonth.options[i-1].value == month+1) {
                    cmbMonth.options[i-1].selected = true;
                }
            }
            //2.오늘 날짜의 년/월 가져와서 cmbYear/cmbMonth설정
            cmbYear_onchange();
        }

		function cmbYear_onchange() {
            
            var cmbYear = document.getElementById("cmbYear");
            var cmbMonth = document.getElementById("cmbMonth");
            
            //년도
            var YY = cmbYear.value;
            
            //월
            var mm = cmbMonth.value;
            
            //현재달의 첫날
            var dd = new Date(YY, Number(mm) - 1, 1);
            
            //현제달의 시작 요일(0~6)(0 : 일요일)
            var mod = Number(dd.getDay());
			
            //마지막날
            var currentday = new Date(YY, Number(mm), 1);
            currentday.setDate(currentday.getDate() - 1);
            lastday = currentday.getDate();

            //마지막날
            var listmonth = new Date(YY, Number(mm) - 1, 1);
			listmonth.setDate(listmonth.getDate() - mod);
            var lmlistday;
            var days =["Sun","Mon","Tue","Wed","Thu","Fri","Sat"];
            var msg = "<table id='tbl'>";
            msg +="<tr>";
            for (var i = 0; i <= 6; i++) {
                msg +="<th id='headTr'>";
                msg += days[i];
                msg +="</th>";
            }
            msg +="</tr>";
            msg +="<tr id='tr'>";
            
            for (var i = 0; i <= 5; i++) { // 한달에 최대 5주
                for (var k = 0; k <= 6; k++) { // 한주의 일수 0~6(7일)
                	
                	if (i == 0 && k < mod ) {
               			lmlistday = listmonth.getDate();
               			listmonth.setDate(listmonth.getDate() + 1);
               			
                   		msg += "<td id='lmonth'>" + lmlistday;
                    } else if (7 * i + k + 1 - mod > lastday) {
                		msg += "<td id='lmonth'>" + ((7 * i + k + 1 - mod) - lastday);
                	} else {
                		if(7 * i + k + 1 - mod==day && YY==year && mm==month+1) {
	                    	msg += "<td id='today' onclick='javascript:list(" + year + "," + month + ",";
		                    
		                    msg += p_day(i, k, mod, lastday, dd);
	                    } else {   
	                        if((7 * i + k + 1)%7 == 0){
	                        	msg += "<td id='sat' onclick='javascript:list(" + year + "," + month + ",";
		                    
		                    	msg += p_day(i, k, mod, lastday, dd);
	                        } else {
	                            if((7 * i + k + 1)%7 == 1){
	                            	msg += "<td id='sun' onclick='javascript:list(" + year + "," + month + ",";
		                    
		                    		msg += p_day(i, k, mod, lastday, dd);
	                            } else{
	                            	msg += "<td id='sel' onclick='javascript:list(" + year + "," + month + ",";
		                    
		                  			msg += p_day(i, k, mod, lastday, dd);
	                            }
	                        }
	                        
	                        
	                    }
                	}
                    msg +="</td>";
                }
                msg +="</tr>";
            }

            msg +="</table>";
            var div = document.getElementById("calendar");
            div.innerHTML = msg; 
        }
        
        function p_day(i, k, mod, lastday, dd) {
        	var msg='';
	        if (7 * i + k + 1 <= mod) {
				msg= "&nbsp";
			} else { 
				if (7 * i + k + 1 - mod > lastday) {
					msg= "&nbsp";
				} else {
					msg= 7 * i + k + 1 - mod;
				}
			}
			return msg + ")'" + ">" + msg;
        }
        
        function list(year, month, day) {
        	if((''+month).length==1) month= "0" +month;
        	if((''+day).length==1) day= "0" +day;
        	var check = year + "-" + month + "-" + day;
        	var msg = "<form name='attendancelist' id='attendancelist' action='attendancelist' method='get'>";
        	msg += "<input id='attendancesub' name='attendancesub' type='hidden' value='"+check+"'>";
        	msg += "</form>";
            var div = document.getElementById("attendance");
            div.innerHTML = msg; 
        	document.attendancelist.submit();
        }
// ]]>
    </script>
<body onload="return window_onload()">

<select id="cmbYear" onchange="return cmbYear_onchange()">    
</select>
<select id="cmbMonth" onchange="return cmbYear_onchange()">
</select>
<hr />
<div id="calendar" style="width:850px;border:solid 0px solid;"></div>
<div id="attendance"></div>
</body>
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