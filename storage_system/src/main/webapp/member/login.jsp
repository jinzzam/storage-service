<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>로그인</title>
<link rel="stylesheet" href="../css/login.css">
<script type="text/javascript" src="script.js"></script>
</head>
<body>
    <div class="card-container large">
        <div class="form-card">
            <h2 class="form-title">로그인</h2>
            <form method="post" action="loginOk.jsp" name="login_frm">
                <div class="form-group">
                    <label for="m_id">사용자 ID</label>
                    <input type="text" id="m_id" name="m_id" required>
                </div>
                <div class="form-group">
                    <label for="pwd">비밀번호</label>
                    <input type="password" id="pwd" name="pwd" required>
                </div>
                <div class="form-buttons login-buttons">
                    <button type="submit" class="button button-primary" onclick="check_login()">로그인</button>
                    <button type="button" class="button button-outline" onclick="location='register.jsp'">회원가입</button>
                </div>
            </form>
        </div>
    </div>
</body>
</html>