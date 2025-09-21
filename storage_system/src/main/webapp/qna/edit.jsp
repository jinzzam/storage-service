<%@page import="member.MemberBean"%>
<%@page import="member.MemberDBBean"%>
<%@page import="qna.QnaBean"%>
<%@page import="qna.QnaDBBean"%>
<%@page import="java.time.LocalDateTime"%>
<%@page import="java.sql.Timestamp"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
%>
<%
	String cur_id = (String) session.getAttribute("cur_id");
//**Add a null check to handle a non-logged-in user**
	if (cur_id == null || cur_id.isEmpty()) {
		response.sendRedirect("login.jsp");
		return;
	}

	String pageNum=request.getParameter("pageNum");
	
	int q_id=0;
	if(request.getParameter("q_id") != null){
		q_id = Integer.parseInt(request.getParameter("q_id"));
	}
	
	int q_ref=0, q_step=0, q_level=0;
	String q_title="", q_pwd="", email="", writer_name="";
	
	QnaDBBean db = QnaDBBean.getInstance(); 
	MemberDBBean memberDB = MemberDBBean.getInstance();
	QnaBean qna = db.getQna(q_id);
	MemberBean mem = memberDB.getMember(cur_id);
	
	// You might not need this second null check if the first one is effective
    // However, it's good practice for safety
    if (mem == null) {
        response.sendRedirect("login.jsp");
        return;
    }

	writer_name = mem.getM_name();
	email = mem.getEmail();
	
	//답변글(show.jsp 에서 글번호를 가지고 옴)
	if(q_id != 0){	//casting 오류를 막기 위함
		q_ref = q_id;
	}
	
	if(qna != null){	//답변글이라면
// 		db에 insert 하기 위한 로직
		qna.setQ_ref(q_ref);
		q_step = qna.getQ_step();
		q_level = qna.getQ_level();
		q_title = qna.getQ_title();
		q_pwd = qna.getQ_pwd();
	}
	
%>
<!-- select b_id, b_name, b_email, b_title, b_content, b_date, b_hit, b_pwd, b_ip from boardT where b_id=? -->
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript" src="board.js"></script>
</head>
<body>
	<center>
		<h1>글 올 리 기</h1><br>
		<form method="post" action="edit_ok.jsp?pageNum=<%= pageNum %>&id=<%= cur_id %>" name="write_frm" enctype="multipart/form-data">
<!-- 			화면에 없는 것을 전달할 때 hidden 사용 -->
			<input type="hidden" name="q_id" value="<%= q_id %>">
			<input type="hidden" name="q_ref" value="<%= q_ref %>">
			<input type="hidden" name="q_step" value="<%= q_step %>">
			<input type="hidden" name="q_level" value="<%= q_level %>">
			<input type="hidden" name="writer_id" value="<%= cur_id %>">
			<input type="hidden" name="pageNum" value="<%= pageNum %>">
			<table>
				<tr height="30">
					<td width="80">작성자</td>
					<td width="140">
<!-- 					maxlength : 화면 단에서 데이터베이스 오류를 미리 방지 -->
						<%= writer_name %>
					</td>
					
				</tr>
				<tr height="30">
					<td width="80">글제목</td>
					<td width="460" colspan="3">
<!-- 						<input type="text" name="b_title" size="55" maxlength="80"> -->
						<%
								%>
							<input type="text" name="q_title" size="55" maxlength="80" value="<%= q_title %>">
								<%
						%>
					</td>
				</tr>
				<tr height="30">
					<td colspan="3">
						파&nbsp;&nbsp;일&nbsp;&nbsp;<input type="file" name="fileName" size="40" maxlength="100" value="<%= qna.getFileRealName() %>">
					</td>
				</tr>
				<tr height="30">
					<td colspan="4">
						<textarea name="q_content" cols="65" rows="10" style="﻿overflow-y:scroll; overflow-x:hidden;" value="<%= qna.getQ_content() %>"></textarea>
					</td>
				</tr>
				<tr height="30">
					<td colspan="2">
						암&nbsp;&nbsp;호&nbsp;&nbsp;<input type="password" name="pwd" size="12" maxlength="12">
<!-- 					maxlength: 컬럼의 크기와 맞추기 -->
					</td>
				</tr>
				<tr height="50" align="center">
					<td colspan="4">
						<input type="submit" value="수정완료" onclick="check_ok()">&nbsp;
						<input type="reset" value="다시 작성">&nbsp;
						<input type="button" value="글목록" onclick="location.href='list.jsp?pageNum=<%= pageNum %>&cur_id=<%= cur_id %>'">
					</td>
				</tr>
			</table>
		</form>
	</center>
</body>
</html>