<%@page import="member.MemberBean"%>
<%@page import="member.MemberDBBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
	MemberDBBean db = MemberDBBean.getInstance();
	String id = request.getParameter("id");
	MemberBean member = db.getMember(id);
	
// **Critical Fix: Add a null check**
	if (member == null) {
		// If the member is null, it means the ID is invalid or the user is not logged in.
		// Redirect to an error page or login page to handle the invalid state.
		out.println("<script>alert('로그인이 필요합니다.');</script>");
		response.sendRedirect("login.jsp");
		return; // Stop further execution of the page
	}
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
				안녕하세요. <%= member.getM_name() %>(id : <%= id %>)님
			</tr>
			<tr>
				<td align="center">
					<input type="submit" value="로그아웃">
					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					<input type="button" value="회원정보변경" onclick="location='memberUpdate.jsp?id=<%= id %>'">
				</td>
			</tr>
		</form>
	</table>
</body>
</html>