<%@page import="member.MemberBean"%>
<%@page import="member.MemberDBBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	MemberDBBean db = MemberDBBean.getInstance();
	String id = request.getParameter("id");
	MemberBean member = db.getMember(id);

	if (member == null) {
		out.println("<script>alert('로그인이 필요합니다.');</script>");
		response.sendRedirect("login.jsp");
		return;
	}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>메인 페이지</title>
<link rel="stylesheet" href="../css/main.css">
</head>
<body>

    <div class="page-container">
        <header class="main-header">
            <h1 class="logo">Storage Service</h1>
            <nav class="main-nav">
                <ul>
                    <li><a href="main.jsp?id=<%= id %>" class="nav-link active">메인</a></li>
                    <li><a href="order.jsp" class="nav-link">보관 신청</a></li>
                    <li><a href="../order/order_list.jsp?cur_id=<%= id %>" class="nav-link">신청 목록</a></li>
                    <li><a href="../qna/list.jsp?cur_id=<%= id %>" class="nav-link">고객센터</a></li>
                    <li><a href="memberUpdate.jsp?id=<%= id %>" class="nav-link">회원정보 변경</a></li>
                </ul>
            </nav>
        </header>

        <main class="main-content">
            <div class="welcome-section">
                <p>안녕하세요, <span class="user-name"><%= member.getM_name() %></span>님!</p>
                <p class="welcome-message">Storage Service에 오신 것을 환영합니다. 필요한 서비스를 이용해 보세요.</p>
            </div>
            
            <section class="action-buttons">
                <a href="../order/order.jsp" class="action-button primary">
                    <span class="button-icon">📦</span>
                    <span class="button-text">새 물건 보관 신청</span>
                </a>
                <a href="../order/order_list.jsp?cur_id=<%= id %>" class="action-button secondary">
                    <span class="button-icon">📜</span>
                    <span class="button-text">내 보관 신청 목록 보기</span>
                </a>
                <a href="../qna/list.jsp?cur_id=<%= id %>" class="action-button secondary">
                    <span class="button-icon">💬</span>
                    <span class="button-text">Q&A 게시판</span>
                </a>
            </section>
        </main>

        <footer class="main-footer">
            <form method="post" action="logout.jsp" name="main_frm" class="logout-form">
                <p class="user-info">
                    현재 로그인: <%= member.getM_name() %> (<%= id %>)
                </p>
                <button type="submit" class="logout-button">로그아웃</button>
            </form>
            <p class="copyright">&copy; 2025 Storage Service. All Rights Reserved.</p>
        </footer>
    </div>
</body>
</html>