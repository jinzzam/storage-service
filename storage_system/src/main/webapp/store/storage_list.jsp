<%@page import="storage.StorageInfoDBBean"%>
<%@page import="storage.StorageInfoBean"%>
<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.sql.Timestamp"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
%>
<%

	String pageNum = request.getParameter("pageNum");
	String cur_id = (String) session.getAttribute("cur_id");
	
	out.print("@# pageNum=>"+request.getParameter("pageNum"));
	
	if(pageNum == null){
		pageNum="1";
	}
	StorageInfoDBBean db = StorageInfoDBBean.getInstance();
	
//	호출된 메소드의 반환 타입으로 받아주면 됨
	ArrayList<StorageInfoBean> storageList = db.storageListF(pageNum);
	int fileSize=0;
	String s_id, m_id, s_name, s_location, s_address, company_id;
	int s_max;
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
	
%>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<center>
		<h1>저 장 소 목 록</h1>
		<table width="600">
			<tr>
				<td align="right">
<%-- 					<a href="write.jsp">글 쓰 기</a> --%>
					<a href="storageInfo.jsp?pageNum=<%= pageNum %>&id=<%= cur_id %>">신청하기</a>
				</td>
			</tr>
		</table>
	</center>
	<center>
		<table border="1" width="800" cellspacing="0">
			<tr height="25">
				<td width="40" align="center">저장소 번호</td>
				<td width="450" align="center">저장소 이름</td>
				<td width="40" align="center">관리자</td>
				<td width="30" align="center">가용량</td>
				<td width="100" align="center">주소</td>
				<td width="40" align="center">소속회사</td>
			</tr>
			
			<%
				for(int i=0; i<storageList.size(); i++){
					StorageInfoBean storage= storageList.get(i);
					
					s_id = storage.getS_id();
					m_id= storage.getM_id();
					s_max = storage.getS_max();
					s_name = storage.getS_name();
					s_location = storage.getS_location();
					s_address = storage.getS_address();
					company_id = storage.getCompany_id();
			%>
			<tr bgcolor="#f7f7f7"
				onmouseover="this.style.backgroundColor='#eeeeef'"
				onmouseout="this.style.backgroundColor='#f7f7f7'"
				>
<!-- 				표현식으로 컬럼의 데이터를 출력 -->
				<td align="center"><%= s_id %></td>
				<td>
					<a href="storageInfo.jsp?s_id=<%= s_id %>">
						<%= s_name %>
					</a>
				</td>
				<td align="center"><%= m_id %></td>
				<td align="center"><%= s_max %></td>
				<td align="center"><%= s_address %></td>
				<td align="center"><%= company_id %></td>
			<%
				}
			%>
		</table>
		<%= StorageInfoBean.pageNumber(5)%>
	</center>
</body>
</html>
