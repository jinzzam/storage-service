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

	ArrayList<QnaBean> qnaList = db.qnaList(pageNum);
	int q_id, q_level, fileSize;
	String q_type, q_title, writer_id;
	Timestamp q_date;
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");
	
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Q&A 게시판</title>
<link rel="stylesheet" href="../css/qna_list.css">
</head>
<body>
    <div class="qna-container">
        <header class="qna-header">
            <h1 class="qna-title">QnA 게시판</h1>
            <a href="write.jsp?pageNum=<%= pageNum %>&id=<%= cur_id %>" class="write-button">글 쓰기</a>
        </header>

        <main class="qna-main">
            <div class="qna-list">
                <div class="list-header">
                    <div class="list-column-header id">번호</div>
                    <div class="list-column-header type">구분</div>
                    <div class="list-column-header file">첨부파일</div>
                    <div class="list-column-header title">글제목</div>
                    <div class="list-column-header writer">작성자</div>
                    <div class="list-column-header date">작성일</div>
                </div>

                <%
                for(int i = 0; i < qnaList.size(); i++){
                    QnaBean qna = qnaList.get(i);
                    
                    q_id = qna.getQ_id();
                    writer_id = qna.getWriter_id();
                    q_type = qna.getQ_type();
                    q_title = qna.getQ_title();
                    q_date = qna.getQ_date();
                    q_level = qna.getQ_level();
                    fileSize = qna.getFileSize();
                %>
                <a href="show.jsp?q_id=<%= q_id %>&pageNum=<%= pageNum %>&cur_id=<%= cur_id %>" class="list-item">
                    <div class="list-column id"><%= q_id %></div>
                    <div class="list-column type"><%= q_type %></div>
                    <div class="list-column file">
                        <% if(fileSize > 0){ %>
                            <img src="../images/zip.gif" alt="첨부파일" class="file-icon">
                        <% } %>
                    </div>
                    <div class="list-column title">
                        <%
                            if(q_level > 0){
                                for(int j=0; j<q_level; j++){ %>
                                    &nbsp;&nbsp;&nbsp;
                                <% } %>
                                <img src="../images/AnswerLine.gif" alt="답변글" class="answer-icon">
                        <% } %>
                        <%= q_title %>
                    </div>
                    <div class="list-column writer">
                        <a href="mailto:<%= db.getWriterEmail(writer_id) %>">
                            <%= db.getWriterName(writer_id) %>
                        </a>
                    </div>
                    <div class="list-column date"><%= sdf.format(q_date) %></div>
                </a>
                <%
                }
                %>
            </div>
            <div class="pagination">
                <%= QnaBean.pageNumber(5)%>
            </div>
        </main>
    </div>
</body>
</html>