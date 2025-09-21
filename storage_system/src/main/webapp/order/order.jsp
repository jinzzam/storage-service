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
		<form method="post" name="order_frm" action="order_oㅎk.jsp">
			<tr>
				<td colspan="2" align="center">
					<h2>보 관 하 기</h2>
					<br> 
				</td>
			</tr>
			<tr>
				<td height="30">저 장 소</td>
				<td width="20">
				지역 : 
				<select name="s_location">
					<option>서울</option>
					<option>대전</option>
					<option>대구</option>
					<option>부산</option>
					<option>제주</option>
				</select>
				</tr>
				<tr>
				</td>
				<td width="30">이 름 </td>
				<td width="20">
				저장소 이름 : 
				<select name="s_name">
					<option>오미자 오령 저장소</option>
					<option>24시간 셀프 스토리</option>
					<option>길모퉁이 미니 저장소</option>
					<option>한테크 공장형 저장소</option>
				</select>
				</td>
			</tr>
			<tr>
				<td height="30">물품 이름</td>
				<td width="80"><input type="text" name="item_name" required="required" size="20" min="4" max="20"></td>
			</tr>
			<tr>
				<td height="30">물품 중량</td>
				<td width="80"><input type="text" name="item_weight" required="required" size="20" min="4" max="20"></td>
			</tr>
			<tr>
				<td height="30">보관 기간</td>
				<td width="80"><input type="date" name="ordered_period" required="required" size="20" min="4" max="20"></td>
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