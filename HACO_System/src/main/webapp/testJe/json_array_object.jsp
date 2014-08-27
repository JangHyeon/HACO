<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Creation of array object in javascript using JSON</title>
<script type="text/javascript">
	document.writeln("<h2>JSON array object</h2>");
	
	var books = { "Pascal" : [ 
	      { "Name"  : "Pascal Made Simple", "price" : 700 },
	      { "Name"  : "Guide to Pascal", "price" : 400 }
	   ],                       
	   "Scala"  : [
	      { "Name"  : "Scala for the Impatient", "price" : 1000 }, 
	      { "Name"  : "Scala in Depth", "price" : 1300 }
	   ]    
	}    
	
	var i = 0
	document.writeln("<table border='2'><tr>");
	for(i=0;i<books.Pascal.length;i++)
	{	
	   document.writeln("<td>");
	   document.writeln("<table border='1' width=100 >");
	   document.writeln("<tr><td><b>Name</b></td><td width=50>"
	   + books.Pascal[i].Name+"</td></tr>");
	   document.writeln("<tr><td><b>Price</b></td><td width=50>"
	   + books.Pascal[i].price +"</td></tr>");
	   document.writeln("</table>");
	   document.writeln("</td>");
	}
	
	for(i=0;i<books.Scala.length;i++)
	{
	   document.writeln("<td>");
	   document.writeln("<table border='1' width=100 >");
	   document.writeln("<tr><td><b>Name</b></td><td width=50>"
	   + books.Scala[i].Name+"</td></tr>");
	   document.writeln("<tr><td><b>Price</b></td><td width=50>"
	   + books.Scala[i].price+"</td></tr>");
	   document.writeln("</table>");
	   document.writeln("</td>");
	}
	document.writeln("</tr></table>");
</script>
</head>
<body>

</body>
</html>
