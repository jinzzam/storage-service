<%@page import="member.MemberDBBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
%>
<%!	MemberDBBean db = MemberDBBean.getInstance();  %>

<jsp:useBean class="member.MemberBean" id="member"></jsp:useBean>
<jsp:setProperty property="*" name="member"></jsp:setProperty>

<%-- <jsp:getProperty property="*" name="member"></jsp:getProperty> --%>


<%
	int re = db.confirmID(member.getId());
	
	if(re == 1){
		%>
		<script>
		alert("중복되는 아이디가 존재합니다.");	
		history.back();	//바로 직전 화면으로
		</script>
		<%
	}else{
		if(db.insertMember(member) == 1){
			%>
			<script>
			alert("회원가입을 축하드립니다.\n회원으로 로그인 해주세요.");
			location.href="login.jsp";
			</script>
			<%
		}else{
			%>
			<script>
			alert("회원가입에 실패했습니다..");
			location.href="login.jsp";
			</script>
			<%
		}
	}
	%>