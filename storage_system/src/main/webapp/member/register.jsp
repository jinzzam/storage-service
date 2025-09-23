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
<title>회원가입</title>
<link rel="stylesheet" href="../css/register.css">
<script type="text/javascript" src="script.js"></script>
</head>
<body>
    <div class="card-container large">
        <div class="form-card">
            <h2 class="form-title">회원가입 신청</h2>
            <p class="form-subtitle">* 표시 항목은 필수 입력 항목입니다.</p>
            <form method="post" name="reg_frm" action="registerOk.jsp">
                <div class="form-group">
                    <label for="m_id">User ID *</label>
                    <input type="text" id="m_id" name="m_id" required minlength="4" maxlength="10">
                </div>
                <div class="form-group">
                    <label for="pwd">암호 *</label>
                    <input type="password" id="pwd" name="pwd" required minlength="4" maxlength="20">
                </div>
                <div class="form-group">
                    <label for="pwd2">암호 확인 *</label>
                    <input type="password" id="pwd2" name="pwd2" required minlength="4" maxlength="20">
                </div>
                <div class="form-group">
                    <label for="m_name">이름 *</label>
                    <input type="text" id="m_name" name="m_name" required>
                </div>
                <div class="form-group">
                    <label for="email">E-mail *</label>
                    <input type="email" id="email" name="email" required maxlength="30">
                </div>
                <div class="form-group">
                    <label for="phone">연락처</label>
                    <input type="text" id="phone" name="phone" maxlength="13" placeholder="010-XXXX-XXXX 형태로 작성해주세요.">
                </div>
                <div class="form-group">
                    <label for="address">회원 주소</label>
                    <input type="text" id="address" name="address">
                </div>
                <div class="form-group">
                    <label>회원 유형</label>
                    <div class="radio-group">
                        <label><input type="radio" name="m_type" value="client" checked> 일반 회원</label>
                        <label><input type="radio" name="m_type" value="delivery"> 배송 직원</label>
                        <label><input type="radio" name="m_type" value="manager"> 공간 관리자</label>
                    </div>
                </div>

                <div class="form-buttons">
                    <button type="submit" class="button button-primary" onclick="check_ok()">등록</button>
                    <button type="reset" class="button button-secondary">다시입력</button>
                    <button type="button" class="button button-outline" onclick="location.href='login.jsp'">돌아가기</button>
                </div>
            </form>
        </div>
    </div>
</body>
</html>