<%@page import="company.CompanyInfoBean"%>
<%@page import="company.CompanyInfoDBBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
%>
<%
	String c_id = request.getParameter("c_id");
	CompanyInfoDBBean db = CompanyInfoDBBean.getInstance();
	CompanyInfoBean company = db.getCompanyInfo(c_id);
%>

<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript" src="script.js"></script>
</head>
<body>
	<table width="500" border="1">
		<form method="post" name="cmy_frm" action="storageOk.jsp">
			<tr>
				<td colspan="2" align="center">
					<h2>회 사 정 보</h2>
					<br> 
				</td>
			</tr>
			<tr>
				<td height="30">이  름</td>
				<td width="80"><%= company.getName() %></td>
			</tr>
			<tr>
				<td height="30">회사 번호</td>
				<td width="80"><%= company.getCompany_id() %></td>
			</tr>
			<tr>
				<td height="30">연락처</td>
				<td width="80"><%= company.getTel() %></td>
			</tr>
			<tr>
				<td height="30">주  소</td>
				<td width="80"><%= company.getAddress() %></td>
			</tr>

				<td colspan="2" align="center">
					<input type="submit" value="확인"> 
					<input type="reset" value="다시입력">
					<input type="button" value="돌아가기" onclick="location.href='main.jsp'">
				</td>
			</tr>
		</form>
	</table>
</body>
</html>