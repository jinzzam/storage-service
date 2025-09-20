<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	if(session.getAttribute("cur_id") == null){
		%>
			<jsp:forward page="login.jsp"></jsp:forward>
		<%
	}
%>
<%
	String id = (String) session.getAttribute("cur_id");
	String name = (String) session.getAttribute("cur_name");
%>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<table>
		<form method="post" action="logout.jsp" name="main_frm">
			<tr>
				안녕하세요. <%= name %>(id : <%= id %>)님
			</tr>
			<tr>
				<td align="center">
					<input type="submit" value="로그아웃">
					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					<input type="button" value="회원정보변경" onclick="location='memberUpdate.jsp'">
				</td>
			</tr>
		</form>
	</table>
</body>
</html>