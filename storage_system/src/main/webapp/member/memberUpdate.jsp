<%@page import="member.MemberBean"%>
<%@page import="member.MemberDBBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
%>
<%
	MemberDBBean db = MemberDBBean.getInstance();
	String id = request.getParameter("id");
	MemberBean member = db.getMember(id);
	String type = member.getM_type();
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>회원 정보 수정</title>
<link rel="stylesheet" href="../css/register.css">
<script type="text/javascript" src="script.js"></script>
</head>
<body>
    <div class="card-container large">
        <div class="form-card">
            <h2 class="form-title">회원 정보 수정</h2>
            <form method="post" name="modi_frm" action="memberUpdateOk.jsp?id=<%= member.getM_id() %>">
                <div class="form-group">
                    <label>User ID</label>
                    <p class="form-text-display"><%= id %></p>
                </div>
                <div class="form-group">
                    <label for="m_name">이름</label>
                    <input type="text" id="m_name" name="m_name" required value="<%= member.getM_name() %>">
                </div>
                <div class="form-group">
                    <label for="email">E-mail</label>
                    <input type="email" id="email" name="email" required value="<%= member.getEmail() %>">
                </div>
                <div class="form-group">
                    <label for="phone">연락처</label>
                    <input type="text" id="phone" name="phone" placeholder="010-XXXX-XXXX" value="<%= member.getPhone()%>">
                </div>
                <div class="form-group">
                    <label for="address">회원 주소</label>
                    <input type="text" id="address" name="address" value="<%= member.getAddress() %>">
                </div>
                <div class="form-group">
                    <label>회원 유형</label>
                    <p class="form-text-display"><%= type %></p>
                </div>
                <% if(type.equals("delivery") || type.equals("manager")){ %>
                    <div class="form-group">
                        <label for="company">직장 코드</label>
                        <input type="text" id="company" name="company" value="<%= member.getCompany() %>">
                    </div>
                <% } %>
                <div class="form-buttons">
                    <button type="submit" class="button button-primary">수정</button>
                    <button type="reset" class="button button-secondary">다시입력</button>
                    <button type="button" class="button button-outline" onclick="location.href='main.jsp?id=<%= id %>'">돌아가기</button>
                </div>
            </form>
        </div>
    </div>
</body>
</html>