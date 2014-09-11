<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="s" uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<!-- spEL을 활용한 리소스 버전 관리 -->
<spring:eval expression="@baseConfig['app.version']"
	var="applicationVersion" />
<spring:url value="/static-{applicationVersion}" var="resourceUrl">
	<spring:param name="applicationVersion" value="${applicationVersion}" />
</spring:url>

<!--external css-->
<link href="${resourceUrl}/assets/font-awesome/css/font-awesome.css"
	rel="stylesheet" />
<link rel="stylesheet" type="text/css"
	href="${resourceUrl}/assets/css/zabuto_calendar.css">
<link rel="stylesheet" type="text/css"
	href="${resourceUrl}/assets/js/gritter/css/jquery.gritter.css" />
<link rel="stylesheet" type="text/css"
	href="${resourceUrl}/assets/lineicons/style.css">

<!-- Custom styles for this template -->
<link href="${resourceUrl}/assets/css/style.css" rel="stylesheet">
<link href="${resourceUrl}/assets/css/style-responsive.css"
	rel="stylesheet">


<style type="text/css">
#calendar {
	color: #f0f0f0;
	font: 13px Tahoma;
	padding: 0 10px !important;
	margin-top: 4px;
	
	text-align: center;
	width: 35px;
}

/* calendarOut과 같으니 그냥 calendar로 했습니다 . */ 
.calendarOver {
	color: #FFFFFF;
	font: 9px Tahoma;
	margin-top: 4px;
	text-align: center;
	width: 35px;
}

#tbl {
	width:100%;
	background-color: #FFF;
	color: #000;
	border-collapse: collapse;
	border: 1px solid #dddddd;
}

td {
	cursor: pointer;
}

td:hover {
	color: #fff;
	font-weight: bold;
	font-size: 150%;
}

th[name=headTr] {
	padding: 2px;
	font-family: Helvetica, Verdana, sans-serif;
	font-size: 10px;
	text-align: center;
	color: #7F6A73;
	line-height: 1.5em;
	border: 1px solid #dddddd;
	width: 14.28%;
	height: 10px;
}

td[name=lmonth] {
	line-height: 1.6em;
	vertical-align: top;
	text-align: right;
	color: #dddddd;
	border: 1px solid #dddddd;
	width: 14.28%;
	height: 100px;
	padding: 4px 8px 4px 4px;
}

td[name=sel] {
	line-height: 1.6em;
	vertical-align: top;
	text-align: right;
	border: 1px solid #dddddd;
	width: 14.28%;
	height: 100px;
	padding: 4px 8px 4px 4px;
}

#today {
	line-height: 1.6em;
	background-color: #68dff0;
	font-weight: bold;
	font-size: 150%;
	color: #fff;
	vertical-align: top;
	text-align: right;
	border: 1px solid #dddddd;
	width: 14.28%;
	height: 100px;
	padding: 4px 8px 4px 4px;
}

td[name=sat] {
	line-height: 1.6em;
	vertical-align: top;
	text-align: right;
	color: #00B;
	border: 1px solid #dddddd;
	width: 14.28%;
	height: 100px;
	padding: 4px 8px 4px 4px;
}

td[name=sat]:hover {
	color: #FFF;
}

td[name=sun] {
	line-height: 1.6em;
	vertical-align: top;
	text-align: right;
	color: #F00;
	border: 1px solid #dddddd;
	width: 14.28%;
	height: 100px;
	padding: 4px 8px 4px 4px;
}
td[name=sun]:hover {
	color: #FFF;
}
.dropdown-menu > li{
	cursor: pointer;
}
</style>

<input id="current-accordion" type="hidden" value="attendance" />

<!-- **********************************************************************************************************************************************************
      MAIN CONTENT
      *********************************************************************************************************************************************************** -->
<!--main content start-->
<section id="main-content">
	<section class="wrapper">
		<h3>
			<i class="fa fa-angle-right"></i> 출　석
		</h3>
		<div class="row">
			<div class="col-md-12 mt">
				<div class="content-panel">
					<h4>
						<i class="fa fa-angle-right"></i> 날짜 선택
					</h4>
					
					<hr>
					<div class="topSelect">
						<div class="btn-group">
						  <div class="btn-group">
						    <button id="pageBtn" type="button" class="btn btn-default dropdown-toggle" data-toggle="dropdown">
				              <span id="selectYear"></span>
						      <span class="caret"></span>
						    </button>
						    <ul id="years" class="dropdown-menu pageSize">
						      <c:forEach var="i" begin="2010" end="2020">
						      	<li value="${i}"><a>${i}년</a></li>
						      </c:forEach>
						    </ul>
						  </div>
						  <input id="cmbYear" value="" type="hidden">
						  <div class="btn-group">
						    <button id="pageBtn" type="button" class="btn btn-default dropdown-toggle" data-toggle="dropdown">
						      <span id="selectMonth"></span>
						      <span class="caret"></span>
						    </button>
						    <ul id="months" class="dropdown-menu pageSize">
						      <c:forEach var="m" begin="1" end="12">
						      	<li value="${m}"><a>${m}월</a></li>
						      </c:forEach>
						    </ul>
						  </div>
						</div>
					    <input id="cmbMonth" value="" type="hidden">
					</div>
				
					<div>
						<div id="calendar" style="width: 100%; border: solid 0px solid;"></div>
						<div id="attendance"></div>
					</div>
				</div>
			</div>
		</div>
	</section>
</section>

<!--main content end-->

<!-- inclue common script -->
<%@ include file="commonScript.jsp"%>

<!--script for this page-->
<script type="text/javascript">
	function p_day(i, k, mod, lastday, dd) {
		var msg = '';
		if (7 * i + k + 1 <= mod) {
			msg = "&nbsp";
		} else {
			if (7 * i + k + 1 - mod > lastday) {
				msg = "&nbsp";
			} else {
				msg = 7 * i + k + 1 - mod;
			}
		}
		return msg + ")'" + " onMouseOver="
				+ "this.style.backgroundColor='#FFD777'" + " onMouseOut="
				+ "this.style.backgroundColor=''" + ">" + msg;
	}

	function list(year, month, day) {
		if (('' + month).length == 1)
			month = "0" + month;
		if (('' + day).length == 1)
			day = "0" + day;
		var check = year + "-" + month + "-" + day;
		var msg = "<form name='attendancelist' id='attendancelist' action='attendancelist' method='get'>";
		msg += "<input id='attendancesub' name='attendancesub' type='hidden' value='"+check+"'>";
		msg += "</form>";
		var div = document.getElementById("attendance");
		div.innerHTML = msg;
		document.attendancelist.submit();
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
		var days = [ "Sun", "Mon", "Tue", "Wed", "Thu",
				"Fri", "Sat" ];
		var msg = "<table id='tbl'>";
		msg += "<tr>";
		for (var i = 0; i <= 6; i++) {
			msg += "<th name='headTr'>";
			msg += days[i];
			msg += "</th>";
		}
		msg += "</tr>";
		msg += "<tr name='tr'>";

		for (var i = 0; i <= 5; i++) { // 한달에 최대 5주
			for (var k = 0; k <= 6; k++) { // 한주의 일수 0~6(7일)

				if (i == 0 && k < mod) {
					lmlistday = listmonth.getDate();
					listmonth
							.setDate(listmonth.getDate() + 1);
					msg += "<td name='lmonth'>" + lmlistday;
				} else if (7 * i + k + 1 - mod > lastday) {
					msg += "<td name='lmonth'>"
							+ ((7 * i + k + 1 - mod) - lastday);
				} else {
					if (7 * i + k + 1 - mod == day
							&& YY == year
							&& mm == month + 1) {
						msg += "<td id='today' onclick='javascript:list("
								+ YY + "," + mm + ",";

						msg += p_day(i, k, mod, lastday, dd);
					} else {
						if ((7 * i + k + 1) % 7 == 0) {
							msg += "<td name='sat' onclick='javascript:list("
									+ YY + "," + mm + ",";

							msg += p_day(i, k, mod,
									lastday, dd);
						} else {
							if ((7 * i + k + 1) % 7 == 1) {
								msg += "<td name='sun' onclick='javascript:list("
										+ YY
										+ ","
										+ mm
										+ ",";

								msg += p_day(i, k, mod,
										lastday, dd);
							} else {
								msg += "<td name='sel' onclick='javascript:list("
										+ YY
										+ ","
										+ mm
										+ ",";

								msg += p_day(i, k, mod,
										lastday, dd);
							}
						}

					}
				}
				msg += "</td>";
			}
			msg += "</tr>";
		}

		msg += "</table>";
		var div = document.getElementById("calendar");
		div.innerHTML = msg;
	}
	
	$(document).ready(function() {

		$('#years>li').on('click',function(){
			$('#selectYear').text($('a',this).text());
			$('#cmbYear').val($(this).attr('value'));
			cmbYear_onchange();
		});

		$('#months>li').on('click',function(){
			$('#selectMonth').text($('a',this).text());
			$('#cmbMonth').val($(this).attr('value'));
			cmbYear_onchange();
		});

		now = new Date();
		year = now.getFullYear();
		month = now.getMonth();
		day = now.getDate();

		nowMonth = month+1;
		$('#selectYear').text(year+'년');
		$('#selectMonth').text(nowMonth+'월');
		
		$('#cmbYear').val(year);
		$('#cmbMonth').val(nowMonth);
		
		cmbYear_onchange();

	});
</script>


