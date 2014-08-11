<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="s" uri="http://www.springframework.org/security/tags"%>


<!--external css-->
<link
	href="${pageContext.request.contextPath}/resources/assets/font-awesome/css/font-awesome.css"
	rel="stylesheet" />
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/resources/assets/lineicons/style.css">

<!-- Custom styles for this template -->
<link
	href="${pageContext.request.contextPath}/resources/assets/css/style.css"
	rel="stylesheet">
<link
	href="${pageContext.request.contextPath}/resources/assets/css/style-responsive.css"
	rel="stylesheet">

<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/jquery.fileupload.css">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/upload.css">

<input id="current-accordion" type="hidden"
	value="employeeManagement,employeeRegister" />

<!-- **********************************************************************************************************************************************************
      MAIN CONTENT
      *********************************************************************************************************************************************************** -->
<!--main content start-->
<section id="main-content">
	<section class="wrapper">
		<h3>
			<i class="fa fa-angle-right"></i> 직원 등록
		</h3>

		<!-- BASIC FORM ELELEMNTS -->
		<div class="row mt">
			<div class="col-lg-12">
				<div class="form-panel">
					<h4 class="mb">
						<i class="fa fa-angle-right"></i> 계정 등록
					</h4>
					<form class="form-horizontal style-form" method="get">
						<div class="form-group">
							<label class="col-sm-2 col-sm-2 control-label">사진</label>
							<div class="col-sm-10">
								<div class="cover">
									<!-- 업로드된 파일 -->
									<div id="img-preview"><img class="photo" src=""></div>
									<!-- 부트 스트랩 적용 input버튼 -->
									<!-- The fileinput-button span is used to style the file input field as button -->
									<span class="btn btn-success fileinput-button"> <i
										class="glyphicon glyphicon-plus"></i> <span>사진 선택</span> <!-- The file input field used as target for the file upload widget -->
										<input id="photoUpFile" type="file" name="files[]"
										multiple />
									</span>
									<!-- 업로드 프로그래스바 -->
									<div id="progress_thumbnail" class="progress">
										<div class="progress-bar progress-bar-success"></div>
									</div>

									<p class="dsc">
										사진 크기는 <em>177X236</em> 사이즈에 최적화 되어있습니다.
									</p>

								</div>
								<input type="hidden" id="photo" name="photo">
							</div>
						</div>


						<div class="form-group">
							<label class="col-sm-2 col-sm-2 control-label">Default</label>
							<div class="col-sm-10">
								<input type="text" class="form-control">
							</div>
						</div>
						<div class="form-group">
							<label class="col-sm-2 col-sm-2 control-label">Help text</label>
							<div class="col-sm-10">
								<input type="text" class="form-control"> <span
									class="help-block">A block of help text that breaks onto
									a new line and may extend beyond one line.</span>
							</div>
						</div>
						<div class="form-group">
							<label class="col-sm-2 col-sm-2 control-label">Rounder</label>
							<div class="col-sm-10">
								<input type="text" class="form-control round-form">
							</div>
						</div>
						<div class="form-group">
							<label class="col-sm-2 col-sm-2 control-label">Input
								focus</label>
							<div class="col-sm-10">
								<input class="form-control" id="focusedInput" type="text"
									value="This is focused...">
							</div>
						</div>
						<div class="form-group">
							<label class="col-sm-2 col-sm-2 control-label">Disabled</label>
							<div class="col-sm-10">
								<input class="form-control" id="disabledInput" type="text"
									placeholder="Disabled input here..." disabled>
							</div>
						</div>
						<div class="form-group">
							<label class="col-sm-2 col-sm-2 control-label">Placeholder</label>
							<div class="col-sm-10">
								<input type="text" class="form-control"
									placeholder="placeholder">
							</div>
						</div>
						<div class="form-group">
							<label class="col-sm-2 col-sm-2 control-label">Password</label>
							<div class="col-sm-10">
								<input type="password" class="form-control" placeholder="">
							</div>
						</div>
						<div class="form-group">
							<label class="col-lg-2 col-sm-2 control-label">Static
								control</label>
							<div class="col-lg-10">
								<p class="form-control-static">email@example.com</p>
							</div>
						</div>
					</form>
				</div>
			</div>
			<!-- col-lg-12-->
		</div>
		<!-- /row -->

		<!-- INLINE FORM ELELEMNTS -->
		<div class="row mt">
			<div class="col-lg-12">
				<div class="form-panel">
					<h4 class="mb">
						<i class="fa fa-angle-right"></i> 직원 정보 등록
					</h4>
					<form class="form-inline" role="form">
						<div class="form-group">
							<label class="sr-only" for="exampleInputEmail2">Email
								address</label> <input type="email" class="form-control"
								id="exampleInputEmail2" placeholder="Enter email">
						</div>
						<div class="form-group">
							<label class="sr-only" for="exampleInputPassword2">Password</label>
							<input type="password" class="form-control"
								id="exampleInputPassword2" placeholder="Password">
						</div>
						<button type="submit" class="btn btn-theme">Sign in</button>
					</form>
				</div>
				<!-- /form-panel -->
			</div>
			<!-- /col-lg-12 -->
		</div>
		<!-- /row -->

		<!-- INPUT MESSAGES -->
		<div class="row mt">
			<div class="col-lg-12">
				<div class="form-panel">
					<h4 class="mb">
						<i class="fa fa-angle-right"></i> Input Messages
					</h4>
					<form class="form-horizontal tasi-form" method="get">
						<div class="form-group has-success">
							<label class="col-sm-2 control-label col-lg-2" for="inputSuccess">Input
								with success</label>
							<div class="col-lg-10">
								<input type="text" class="form-control" id="inputSuccess">
							</div>
						</div>
						<div class="form-group has-warning">
							<label class="col-sm-2 control-label col-lg-2" for="inputWarning">Input
								with warning</label>
							<div class="col-lg-10">
								<input type="text" class="form-control" id="inputWarning">
							</div>
						</div>
						<div class="form-group has-error">
							<label class="col-sm-2 control-label col-lg-2" for="inputError">Input
								with error</label>
							<div class="col-lg-10">
								<input type="text" class="form-control" id="inputError">
							</div>
						</div>
					</form>
				</div>
				<!-- /form-panel -->
			</div>
			<!-- /col-lg-12 -->
		</div>
		<!-- /row -->

		<!-- INPUT MESSAGES -->
		<div class="row mt">
			<div class="col-lg-12">
				<div class="form-panel">
					<h4 class="mb">
						<i class="fa fa-angle-right"></i> Checkboxes, Radios & Selects
					</h4>
					<div class="checkbox">
						<label> <input type="checkbox" value=""> Option
							one is this and that&mdash;be sure to include why it's great
						</label>
					</div>

					<div class="radio">
						<label> <input type="radio" name="optionsRadios"
							id="optionsRadios1" value="option1" checked> Option one
							is this and that&mdash;be sure to include why it's great
						</label>
					</div>
					<div class="radio">
						<label> <input type="radio" name="optionsRadios"
							id="optionsRadios2" value="option2"> Option two can be
							something else and selecting it will deselect option one
						</label>
					</div>

					<hr>
					<label class="checkbox-inline"> <input type="checkbox"
						id="inlineCheckbox1" value="option1"> 1
					</label> <label class="checkbox-inline"> <input type="checkbox"
						id="inlineCheckbox2" value="option2"> 2
					</label> <label class="checkbox-inline"> <input type="checkbox"
						id="inlineCheckbox3" value="option3"> 3
					</label>

					<hr>
					<select class="form-control">
						<option>1</option>
						<option>2</option>
						<option>3</option>
						<option>4</option>
						<option>5</option>
					</select> <br> <select multiple class="form-control">
						<option>1</option>
						<option>2</option>
						<option>3</option>
						<option>4</option>
						<option>5</option>
					</select>
				</div>
				<!-- /form-panel -->
			</div>
			<!-- /col-lg-12 -->

			<!-- CUSTOM TOGGLES -->
			<div class="col-lg-12">
				<div class="form-panel">
					<h4 class="mb">
						<i class="fa fa-angle-right"></i> Custom Toggles
					</h4>
					<div class="row mt">
						<div class="col-sm-6 text-center">
							<input type="checkbox" checked="" data-toggle="switch" />
						</div>
						<div class="col-sm-6 text-center">
							<input type="checkbox" data-toggle="switch" />
						</div>
					</div>
					<div class="row mt">
						<div class="col-sm-6 text-center">
							<div class="switch switch-square"
								data-on-label="<i class=' fa fa-check'></i>"
								data-off-label="<i class='fa fa-times'></i>">
								<input type="checkbox" />
							</div>
						</div>
						<div class="col-sm-6 text-center">
							<div class="switch switch-square"
								data-on-label="<i class=' fa fa-check'></i>"
								data-off-label="<i class='fa fa-times'></i>">
								<input type="checkbox" checked="" />
							</div>
						</div>
					</div>
					<div class="row mt">
						<div class="col-sm-6 text-center">
							<input type="checkbox" disabled data-toggle="switch" />
						</div>
						<div class="col-sm-6 text-center">
							<input type="checkbox" checked disabled data-toggle="switch" />
						</div>
					</div>
				</div>
			</div>
		</div>
		<!-- /row -->
	</section>
</section>

<!--main content end-->


<!-- inclue common script -->
<%@ include file="commonScript.jsp"%>

<!--script for this page-->
<script type="text/javascript"
	src="http://code.jquery.com/ui/1.10.3/jquery-ui.js"></script>
<script type="text/javascript"
	src="${pageContext.request.contextPath}/resources/js/jquery.fileupload.js"></script>
<script type="text/javascript"
	src="${pageContext.request.contextPath}/resources/js/upload.js"></script>


<script type="application/javascript">



</script>


