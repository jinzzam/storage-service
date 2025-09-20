<%@page import="member.MemberBean"%>
<%@page import="member.MemberDBBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
request.setCharacterEncoding("UTF-8");
%>


<%
	MemberDBBean db = MemberDBBean.getInstance();

	String id = (String)request.getParameter("m_id");
	String pwd = (String)request.getParameter("pwd");
%>

	<%
		int re = db.userCheck(id, pwd);
	
		if(re == -1){
			%>
			<script>
				alert("존재하지 않는 회원.");	
				history.back();	//바로 직전 화면으로
			</script>
			<%
		} else if(re == 1) { //세션에 사용자 정보 추가 후 main.jsp로 이동
				session.setAttribute("cur_id", id);
				response.sendRedirect("main.jsp?id="+id);
			
		} else if(re == 0){
			%>
			<script>
				alert("비밀번호가 맞지 않습니다.");
				history.go(-1);
			</script><%
		}
	%>