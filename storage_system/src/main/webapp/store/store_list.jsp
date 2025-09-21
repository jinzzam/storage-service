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
	ArrayList<StorageInfoBean> storeList = db.storageList(pageNum);
	int fileSize=0;
	String order_id, item_name, writer_id, orderer_id, confirm_status;
	Date ordered_date, ordered_period;
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");
	
%>
<!-- *.정렬 기준 -->
<!-- 한글 기본은 좌측 정렬 -->
<!-- 숫자는 우측 -->
<!-- 중앙 정렬(자리수 고정): 코드, 주민번호, 학번, 사번 -->
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
					<a href="order.jsp?pageNum=<%= pageNum %>&id=<%= cur_id %>">신청하기</a>
				</td>
			</tr>
		</table>
	</center>
	<center>
		<table border="1" width="800" cellspacing="0">
			<tr height="25">
				<td width="40" align="center">번호</td>
				<td width="80" align="center">첨부파일</td>
				<td width="450" align="center">물품 이름</td>
				<td width="120" align="center">작성자</td>
				<td width="130" align="center">신청일</td>
				<td width="130" align="center">만료일</td>
				<td width="40" align="center">수락여부</td>
			</tr>
			
			<%
				for(int i=0; i<orderList.size(); i++){
					StorageInfoBean store= orderList.get(i);
					
					order_id = order.getOrder_id();
					item_name = order.getItem_name();
					orderer_id = order.getOrderer_id();
					ordered_date = order.getOrdered_date();
					ordered_period = order.getOrdered_period();
					confirm_status = order.getConfirm_status();
					fileSize = order.getFileSize();
			%>
			<tr bgcolor="#f7f7f7"
				onmouseover="this.style.backgroundColor='#eeeeef'"
				onmouseout="this.style.backgroundColor='#f7f7f7'"
				>
<!-- 				표현식으로 컬럼의 데이터를 출력 -->
				<td align="center"><%= order_id %></td>
				<td>
					<%
						if(fileSize > 0){
							%>
								<img src="../images/zip.gif">
							<%
						}
					%>
				</td>
				<td>
					<a href="show_item.jsp?order_id=<%= order_id %>&pageNum=<%= pageNum %>&cur_id=<%= cur_id %>">
						<%= item_name %>
					</a>
				</td>
				<td align="center">
					<a href="mailto:<%= db.getOrdererEmail(orderer_id)%>">
						<%= db.getOrdererName(orderer_id) %>
					</a>
				</td>
				<td align="center">
					<%= sdf.format(ordered_date) %>
				</td>
				<td align="center">
					<%= sdf.format(ordered_period) %>
				</td>
			</tr>
			<%
				}
			%>
		</table>
<%-- 		<%= BoardBean.pageNumer(4) %> --%>
		<%= PlaceAnOrderBean.pageNumber(5)%>
	</center>
</body>
</html>
