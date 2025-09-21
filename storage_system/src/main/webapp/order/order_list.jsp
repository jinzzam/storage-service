<%@page import="java.util.Date"%>
<%@page import="storage.PlaceAnOrderDBBean"%>
<%@page import="storage.PlaceAnOrderBean"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.sql.Timestamp"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
%>
<%
	PlaceAnOrderDBBean db = PlaceAnOrderDBBean.getInstance();

	String pageNum = request.getParameter("pageNum");
	String cur_id = (String) session.getAttribute("cur_id");
	
	out.print("@# pageNum=>"+request.getParameter("pageNum"));
	
	if(pageNum == null){
		pageNum="1";
	}
	
//	호출된 메소드의 반환 타입으로 받아주면 됨
	ArrayList<PlaceAnOrderBean> orderList = db.orderListF(pageNum);
	int fileSize=0;
	String order_id="", item_name="", orderer_id="", confirm_status="";
	String ordered_date="", ordered_period="";
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
	
%>

<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<center>
		<h1>보 관 신 청 목 록</h1>
		<table width="600">
			<tr>
				<td align="right">
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
					PlaceAnOrderBean order= orderList.get(i);
					
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
				onmouseout="this.style.backgroundColor='#f7f7f7'">
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
					<%= ordered_date %>
				</td>
				<td align="center">
					<%= ordered_period %>
				</td>
				<td align="center">
					<%= confirm_status %>
				</td>
			</tr>
			<%
				}
			%>
		</table>
		<%= PlaceAnOrderBean.pageNumber(5)%>
	</center>
</body>
</html>