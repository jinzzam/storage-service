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
				<td height="30">연락처</td>
				<td width="80"><input type="text" name="mem_phone" max="13" size="40" placeholder="010-XXXX-XXXX 형태로 작성해주세요."></td>
			</tr>
			<tr>
				<td height="30">회원 주소</td>
				<td width="80"><input type="text" name="mem_address" required="required" size="20" value="<%= member.getMem_address()%>"></td>
			</tr>
			<tr>
				<td height="30">회원 유형</td>
				<td width="80">
					<input type="radio" name="mem_type" value="일반 회원">일반 회원
					<input type="radio" name="mem_type" value="배송 직원">배송 직원
					<input type="radio" name="mem_type" value="공간 관리자">공간 관리자
				</td>
			</tr>
			<tr>
				<td height="30">직원 직책</td>
				<td width="80">
					<input type="radio" name="emp_type" value="사장">사장
					<input type="radio" name="emp_type" value="부장">부장
					<input type="radio" name="emp_type" value="과장">과장
					<input type="radio" name="emp_type" value="대리">대리
					<input type="radio" name="emp_type" value="사원">사원
					<input type="radio" name="emp_type" value="기타">기타
					<input type="text" name="emp_etc_type" size="25" placeholder="직책을 입력하세요.">
				</td>
			</tr>
			<tr>
				<td colspan="2" align="center">
					<input type="submit" value="수정" onclick="update_check_ok()"> 
					<input type="reset" value="다시입력">
					<input type="button" value="돌아가기" onclick="location.href='main.jsp'">
				</td>
			</tr>
		</form>
	</table>
</body>
</html>