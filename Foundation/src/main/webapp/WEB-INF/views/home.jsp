<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>
<!-- 합쳐지고 최소화된 최신 CSS -->
<link rel="stylesheet" href="resources/css/bootstrap.min.css" media="screen">
<!-- 합쳐지고 최소화된 최신 자바스크립트 -->
<script src="resources/js/bootstrap.min.js"></script>
<!-- jQuery (부트스트랩의 자바스크립트 플러그인을 위해 필요한) -->
<script src="//code.jquery.com/jquery.js"></script>
<!-- 모든 합쳐진 플러그인을 포함하거나 (아래) 필요한 각각의 파일들을 포함하세요 -->
<script src="resources/js/bootstrap.min.js"></script>
<html>
<head>
	<title>Home</title>
</head>
<body>
<h1>
<button class="btn btn-primary btn-lg" data-toggle="modal" data-target="#myModal">Hello world!</button>

<!-- Modal -->
<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
        <h4 class="modal-title">Modal title</h4>
      </div>
      <div class="modal-body">
        ...
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
        <button type="button" class="btn btn-primary">Save changes</button>
      </div>
    </div><!-- /.modal-content -->
  </div><!-- /.modal-dialog -->
</div><!-- /.modal -->  
</h1>

<P>  The time on the server is ${serverTime}. </P>
</body>
</html>
