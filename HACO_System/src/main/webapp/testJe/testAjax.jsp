<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script type="text/javascript">
	var main = new Array(); // json의 전체를 가리키는 배열
	sub = new Object();     // 객체 값 입력후 main배열의 0번 index에 셋팅
	sub['key1'] = 'value1'; 
	sub['key2'] = 'value2';
	sub['key3'] = 'value3';
	main[0] = sub;
	 
	sub = new Object();      // 객체 값 입력후 main배열의 1번 index에 셋팅
	sub['key1'] = 'value4';
	sub['key2'] = 'value5';
	sub['key3'] = 'value6';
	main[1] = sub;
	 
	sub = new Object();      // 객체 값 입력후 main배열의 2번 index에 셋팅
	sub['key1'] = 'value7';
	sub['key2'] = 'value8';
	sub['key3'] = 'value9';
	main[2] = sub;
	
	//jsonObject라는 변수에 json형식으로 key이름은 list, value 배열은 이전에 만들었던 main 배열을 넣는다
	var jsonObject = {list:main}; 
	
	 
	//json데이터의 값 출력
	for(var i=0; i<jsonObject.list.length; i++) {
	    var obj = jsonObject.list[i];
	    alert(obj.key1+" , "+obj.key2 + " , " + obj.key3);
	}
</script>
</head>
<body>

</body>
</html>