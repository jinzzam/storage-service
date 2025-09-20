<%@page import="magic.board.BoardBean"%>
<%@page import="magic.board.BoardDBBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
%>
<%
	String pageNum=request.getParameter("pageNum");

	int b_id = Integer.parseInt(request.getParameter("b_id"));
%>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript" src="board.js"></script>
</head>
<body>
	<form method="post" action="delete_ok.jsp?b_id=<%= b_id %>&pageNum=<%= pageNum %>" name="d_frm">
		<h1>글 삭 제 하 기</h1>
		<h3>
			>> 암호를 입력하세요. <<
		</h3><br>
		암 호 &nbsp; <input type="password" name="b_pwd" size="12" maxlength="12">
		<input type="submit" value="글삭제" onclick="delete_ok()">
		&nbsp;&nbsp;&nbsp;
		<input type="reset" value="다시 작성">
		&nbsp;&nbsp;&nbsp;
		<input type="button" value="글목록" onclick="location.href='list.jsp?pageNum=<%= pageNum %>'">
	</form>
</body>
</html>