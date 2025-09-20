<%@page import="qna.QnaBean"%>
<%@page import="qna.QnaDBBean"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
%>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript" src="board.js"></script>
</head>
<body>
<%
	String pageNum=request.getParameter("pageNum");
	
	int q_id = Integer.parseInt(request.getParameter("q_id"));
	QnaDBBean db = QnaDBBean.getInstance();
	QnaBean qna = db.getQna(q_id);
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");
%>
	<center>
		<h1>글 내 용 보 기</h1><br>
		
		<table border="1" width="800" cellspacing="0">
			<tr height="25">
				<td width="20" align="center">글번호</td>
				<td width="40" align="center"><%= qna.getQ_id() %></td>
				<td width="20" align="center">구분</td>
				<td width="40" align="center"><%= qna.getQ_type() %></td>
			</tr>
			<tr height="25">
				<td width="20" align="center">작성자</td>
				<td width="40" align="center"><%= db.getWriterName(qna.getWriter_id()) %></td>
				<td width="20" align="center">작성일</td>
				<td width="40" align="center"><%= sdf.format(qna.getQ_date()) %></td>
			</tr>
			<tr height="25" align="center">
				<td width="100">파&nbsp;&nbsp;일</td>
				<td colspan="3">
				<%-- 
				<%
					if(qna.getB_fname() != null){
						%>
							<img src="./images/zip.gif">
							<a href="../upload/<%= board.getB_fname() %>">
								원본 파일 : <%= board.getB_fname() %>
							</a>
						<%
					}
				%>
				--%>
				<%
					out.print("<p>첨부파일"+"<a href='fileDownload.jsp?fileN="+qna.getQ_id()+"'>"+qna.getFileRealName()+"</a>"+"</p>");
				%>
				</td>
			</tr>
			<tr height="25" colspan="2">
				<td width="40" align="center">글제목</td>
				<td width="80" align="left"><%= qna.getQ_title()%></td>
			</tr>
			<tr height="25" colspan="2">
				<td width="40" align="center">글내용</td>
				<td width="80" align="left"><%= qna.getQ_content()%></td>
			</tr>
			<tr height="25" align="right" colspan="4">
				<td width="40" align="right"><input type="button" value="글수정" onclick="location.href='edit.jsp?q_id=<%= qna.getQ_id()%>&pageNum=<%= pageNum %>'"></td>
				<td width="40" align="right"><input type="button" value="글삭제" onclick="location.href='delete.jsp?q_id=<%= qna.getQ_id()%>&pageNum=<%= pageNum %>'"></td>
				<td width="40" align="right"><input type="button" value="답변글" onclick="location.href='write.jsp?q_id=<%= qna.getQ_id()%>&pageNum=<%= pageNum %>'"></td>
				<td width="40" align="right"><input type="button" value="글목록" onclick="location.href='list.jsp?pageNum=<%= pageNum %>'"></td>
			</tr>
		</table>
	</center>
</body>
</html>