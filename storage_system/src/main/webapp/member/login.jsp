<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<table width="300" border="1" align="center">
		<form method="post" action="loginOk.jsp">	
			<tr>
				<td align="center">사용자 ID</td>
				<td><input type="text" name="mem_uid" size="20"></td>
			</tr>
			<tr>
				<td align="center">비밀번호</td>
				<td><input type="password" name="mem_pwd" size="20"></td>
			</tr>
			<tr>
				<td colspan="2" align="center">
					<input type="submit" value="로그인">
					<input type="button" onclick="location='register.jsp'" value="회원가입">
				</td>
			</tr>
		</form>
	</table>
</body>
</html>