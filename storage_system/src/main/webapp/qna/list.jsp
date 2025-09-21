<%@page import="member.MemberBean"%>
<%@page import="member.MemberDBBean"%>
<%@page import="qna.QnaDBBean"%>
<%@page import="qna.QnaBean"%>
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
	
	MemberDBBean memDB = MemberDBBean.getInstance();
	QnaDBBean db = QnaDBBean.getInstance();
// 	QnaBean qna = db.getQna(qid);
	
//	호출된 메소드의 반환 타입으로 받아주면 됨
	ArrayList<QnaBean> qnaList = db.qnaList(pageNum);
	int q_id=1, q_level=0, fileSize=0;
	String q_type, q_title, writer_id;
	Timestamp q_date;
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");
	
	
//     String writer_name = memDB.getMember(id)
//     String email = mem.getEmail();
	
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
		<h1>게시판에 등록된 글 목록 보기</h1>
		<table width="600">
			<tr>
				<td align="right">
<%-- 					<a href="write.jsp">글 쓰 기</a> --%>
					<a href="write.jsp?pageNum=<%= pageNum %>&id=<%= cur_id %>">글 쓰 기</a>
				</td>
			</tr>
		</table>
	</center>
	<center>
		<table border="1" width="800" cellspacing="0">
			<tr height="25">
				<td width="40" align="center">번호</td>
				<td width="40" align="center">구분</td>
				<td width="80" align="center">첨부파일</td>
				<td width="450" align="center">글제목</td>
				<td width="120" align="center">작성자</td>
				<td width="130" align="center">작성일</td>
			</tr>
			
			<%
				for(int i=0; i<qnaList.size(); i++){
					QnaBean qna= qnaList.get(i);
					
					q_id = qna.getQ_id();
					writer_id = qna.getWriter_id();
					q_type= qna.getQ_type();
					q_title = qna.getQ_title();
					q_date = qna.getQ_date();
					q_level = qna.getQ_level();
					fileSize = qna.getFileSize();
			%>
			<tr bgcolor="#f7f7f7"
				onmouseover="this.style.backgroundColor='#eeeeef'"
				onmouseout="this.style.backgroundColor='#f7f7f7'"
				>
<!-- 				표현식으로 컬럼의 데이터를 출력 -->
				<td align="center"><%= q_id %></td>
				<td align="cetner">구분</td>
				<td>
					<%
						if(fileSize > 0){
							%>
								<img src="./images/zip.gif">
							<%
						}
					%>
				</td>
<%-- 				<td><%= b_title %></td> --%>
				<td>
					<%
//						b_level 기준으로 화살표 이미지를 들여쓰기로 출력
						if(q_level > 0){//답변글
							for(int j=0; j<q_level; j++){//for 기준으로 들여쓰기를 얼마만큼 할것인지 정함
								%>
									&nbsp;&nbsp;&nbsp;&nbsp;
								<%
							}
// 							들여쓰기가 적용된 시점->이미지 추가
							%>
								<img src="./images/AnswerLine.gif" width="16" height="16">
							<%
						}
					%>
<!-- 					글번호를 가지고 글내용 보기 페이지로 이동 -->
<%-- 					<a href="show.jsp?b_id=<%= b_id %>"> --%>
					<a href="show.jsp?q_id=<%= q_id %>&pageNum=<%= pageNum %>&cur_id=<%= cur_id %>">
						<%= q_title %>
					</a>
				</td>
				<td align="center">
					<a href="mailto:<%= db.getWriterEmail(writer_id) %>">
						<%= db.getWriterName(writer_id) %>
					</a>
				</td>
				<td align="center">
<%-- 					<%= b_date %> --%>
					<%= sdf.format(q_date) %>
				</td>
			</tr>
			<%
				}
			%>
		</table>
<%-- 		<%= BoardBean.pageNumer(4) %> --%>
		<%= QnaBean.pageNumber(5)%>
	</center>
</body>
</html>
