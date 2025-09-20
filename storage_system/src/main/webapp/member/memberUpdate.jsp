<%@page import="magic.member.MemberDBBean"%>
<%@page import="magic.member.MemberDBBean02"%>
<%@page import="magic.member.MemberBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
request.setCharacterEncoding("UTF-8");
%>
<%
// 	System.out.println("@#$@#$session.getAttribute(\"mem_uid\") : " + session.getAttribute("mem_uid"));
	String uid = (String) session.getAttribute("mem_uid");
	MemberDBBean manager = MemberDBBean.getInstance();
	MemberBean member = manager.getMember(uid);
	System.out.println("memberUpdate : member : " + member);
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
		<form method="post" name="modi_frm" action="memberUpdateOk.jsp">
			<tr>
				<td colspan="2" align="center">
					<h2>회원 정보 수정</h2>
					<br> '*' 표시 항목은 필수 입력 항목입니다.
				</td>
			</tr>
			<tr>
				<td height="30">User ID</td>
				<td width="80" size="20"><%= uid %></td>
			</tr>
			<tr>
				<td height="30">암호</td>
				<td width="80"><input type="password" name="mem_pwd" required="required" size="20">*</td>
			</tr>
			<tr>
				<td height="30">암호 확인</td>
				<td width="80"><input type="password" name="mem_pwd2" required="required" size="20">*</td>
			</tr>
			<tr>
				<td height="30">이 름</td>
				<td width="80" size="20"><%= member.getMem_name()%></td>
			</tr>
			<tr>
				<td height="30">E-mail</td>
				<td width="80"><input type="text" name="mem_email" required="required" size="20" value="<%= member.getMem_email()%>"></td>
			</tr>
			<tr>
				<td height="30">회원 주소</td>
				<td width="80"><input type="text" name="mem_address" required="required" size="20" value="<%= member.getMem_address()%>"></td>
			</tr>
			<tr>
				<td colspan="2" align="center">
					<input type="submit" value="수정" onclick="update_check_ok()"> 
					<input type="reset" value="다시입력">
					<input type="button" value="수정안함" onclick="location.href='main.jsp'">
				</td>
			</tr>
		</form>
	</table>
</body>
</html>