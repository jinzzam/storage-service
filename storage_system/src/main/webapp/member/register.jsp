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

		<form method="post" name="reg_frm" action="registerOk.jsp">

			<tr>

				<td colspan="2" align="center">

					<h2>회원가입 신청</h2> <br> '*' 표시 항목은 필수 입력 항목입니다.

				</td>

			</tr>

			<tr>

				<td height="30">User ID</td>

				<td width="80"><input type="text" name="m_id"
					required="required" size="20" min="4" max="10">*</td>

			</tr>

			<tr>

				<td height="30">암호</td>

				<td width="80"><input type="password" name="pwd"
					required="required" size="20" min="4" max="20">*</td>

			</tr>

			<tr>

				<td height="30">암호 확인</td>

				<td width="80"><input type="password" name="pwd2"
					required="required" size="20" min="4" max="20">*</td>

			</tr>

			<tr>

				<td height="30">이 름</td>

				<td width="80"><input type="text" name="m_name"
					required="required" size="20">*</td>

			</tr>

			<tr>

				<td height="30">E-mail</td>

				<td width="80"><input type="email" name="email"
					required="required" size="30" max="30">*</td>

			</tr>

			<tr>

				<td height="30">연락처</td>

				<td width="80"><input type="text" name="phone" max="13"
					size="40" placeholder="010-XXXX-XXXX 형태로 작성해주세요."></td>

			</tr>

			<tr>

				<td height="30">회원 주소</td>

				<td width="80"><input type="text" name="address" size="40"></td>

			</tr>

			<tr>
			<tr>

				<td height="30">회원 유형</td>

				<td width="80"><label><input type="radio" name="m_type"
						value="client">일반 회원</label> <label><input type="radio"
						name="m_type" value="delivery">배송 직원</label> <label><input
						type="radio" name="m_type" value="manager">공간 관리자</label></td>

			</tr>



			<td colspan="2" align="center"><input type="submit" value="등록"
				onclick="check_ok()"> <input type="reset" value="다시입력">

				<input type="button" value="돌아가기"
				onclick="location.href='login.jsp'"></td>

			</tr>

		</form>

	</table>

</body>

</html>