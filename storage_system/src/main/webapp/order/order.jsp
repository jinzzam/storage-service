<%@page import="storage.StorageInfoBean"%>
<%@page import="storage.StorageInfoDBBean"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
%>
<%
	StorageInfoDBBean db = StorageInfoDBBean.getInstance();
	
	ArrayList<StorageInfoBean> storageList = db.storageListF();
	String s_location, s_name;
%>


<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript" src="script.js"></script>
</head>
<body>
	<table width="500" border="1">
		<form method="post" name="order_frm" action="orderOk.jsp">
			<tr>
				<td colspan="2" align="center">
					<h2>보 관 하 기</h2>
					<br> 
				</td>
			</tr>
			<tr>
				<td height="30">저 장 소</td>
				<td width="20">
				<label for="s_location"> 지역 : </label>
				<select name="s_location" id="s_location" required="required">
				<%
					for(int i=0; i<storageList.size(); i++){
						StorageInfoBean storage = storageList.get(i);
						
						s_location = storage.getS_location();
						%><option><%= s_location %></option><%
					}				
				%>
				</select>
				</tr>
				<tr>
				</td>
				<td width="30">이 름 </td>
				<td width="20">
				<label for="s_name"> 저장소 이름 : </label>
				<select name="s_name" id="s_name" required="required">
				<%
					for(int i=0; i<storageList.size(); i++){
						StorageInfoBean storage = storageList.get(i);
						
						s_name = storage.getS_name();
						%><option value="<%= s_name %>"><%= s_name %></option><%
					}				
				%>
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
					<input type="submit" value="보관신청"> 
					<input type="reset" value="다시입력">
					<input type="button" value="돌아가기" onclick="location.href='main.jsp'">
				</td>
			</tr>
		</form>
	</table>
</body>
</html>