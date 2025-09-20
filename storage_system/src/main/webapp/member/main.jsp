<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	if(session.getAttribute("mem_uid") == null){
		%>
			<jsp:forward page="login.jsp"></jsp:forward>
		<%
	}
%>
<%
	String uid = (String) session.getAttribute("mem_uid");
	String name = (String) session.getAttribute("mem_name");
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
				안녕하세요. <%= name %>(<%= uid %>)님
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