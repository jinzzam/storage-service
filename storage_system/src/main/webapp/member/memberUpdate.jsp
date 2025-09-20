<%@page import="member.MemberBean"%>
<%@page import="member.MemberDBBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
request.setCharacterEncoding("UTF-8");
%>
<%
	MemberDBBean db = MemberDBBean.getInstance();
	String id = request.getParameter("id");
	MemberBean member = db.getMember(id);
	String type = member.getM_type();
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript" src="script.js"></script>
</head>
<body>
	<table width="500" border="1">
		<form method="post" name="modi_frm" action="memberUpdateOk.jsp?id=<%= member.getM_id() %>">
			<tr>
				<td colspan="2" align="center">
					<h2>회원 정보 수정</h2>
					<br> '*' 표시 항목은 필수 입력 항목입니다.
				</td>
			</tr>
			<tr>
				<td height="30">User ID</td>
				<td width="80" size="20"><%= id %></td>
			</tr>
			<tr>
				<td height="30">이 름</td>
				<td width="80"><input type="text" name="m_name"  size="20" min="4" max="20" value="<%= member.getM_name() %>">
				</td>
			</tr>
			<tr>
				<td height="30">E-mail</td>
				<td width="80"><input type="email" name="email" size="30" max="30" value="<%= member.getEmail() %>"></td>
			</tr>
			<tr>
				<td height="30">연락처</td>
				<td width="80"><input type="text" name="phone" max="13" size="30" placeholder="010-XXXX-XXXX" value="<%= member.getPhone()%>"></td>
			</tr>
			<tr>
				<td height="30">회원 주소</td>
				<td width="80"><input type="text" name="address" size="20" value="<%= member.getAddress() %>"></td>
			</tr>
			<tr>
				<td height="30">회원 유형</td>
				<td width="80"><%= type %></td>
			</tr>
			<%
				if(type.equals("delivery") || type.equals("manager")){
					%>
					<tr>
						<td height="30">직장 코드</td>
						<td width="80"><input type="text" name="company" size="20"></td>
					</tr>
					<%
				}
			%>
			
			<tr>
				<td colspan="2" align="center">
					<input type="submit" value="수정"> 
					<input type="reset" value="다시입력">
					<input type="button" value="돌아가기" onclick="location.href='main.jsp?id=<%= id %>'">
				</td>
			</tr>
		</form>
	</table>
</body>
</html>