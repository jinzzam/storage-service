<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
%>

<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript" src="script.js"></script>
</head>
<body>
	<table width="500" border="1">
		<form method="post" name="storage_frm" action="storageOk.jsp">
			<tr>
				<td colspan="2" align="center">
					<h2>보 관 소 둘 러 보 기</h2>
					<br> 
				</td>
			</tr>
			<tr>
				<td height="30">이  름</td>
				<td width="80"><input type="text" name="s_name" required="required" size="20" min="4" max="10"></td>
			</tr>
			<tr>
				<td height="30">보관소 번호</td>
				<td width="80"><input type="text" name="s_id" required="required" size="20" min="4" max="20"></td>
			</tr>
			<tr>
				<td height="30">관리자</td>
				<td width="80"><input type="text" name="m_id" required="required" size="20" min="4" max="20"></td>
			</tr>
			<tr>
				<td height="30">가용량</td>
				<td width="80"><input type="text" name="s_max" required="required" size="20" min="4" max="20"></td>
			</tr>
			<tr>
				<td height="30">주  소</td>
				<td width="80"><input type="text" name="s_address" required="required" size="20" min="4" max="20"></td>
			</tr>
			<tr>
				<td height="30">소속 회사</td>
				<td width="80"><input type="text" name="company_id" required="required" size="20" min="4" max="20"></td>
			</tr>

				<td colspan="2" align="center">
					<input type="submit" value="보관신청" onclick="check_ok()"> 
					<input type="reset" value="다시입력">
					<input type="button" value="돌아가기" onclick="location.href='main.jsp'">
				</td>
			</tr>
		</form>
	</table>
</body>
</html>