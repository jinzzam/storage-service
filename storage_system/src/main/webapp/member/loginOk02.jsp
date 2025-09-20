<%@page import="magic.member.MemberBean"%>
<%@page import="magic.member.MemberDBBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String id = request.getParameter("mem_uid");
	String pwd = request.getParameter("mem_pwd");
	
	MemberDBBean manager = MemberDBBean.getInstance();
	int check = manager.userCheck(id, pwd);
	MemberBean mb = manager.getMember(id);
	
	if(mb == null){//회원 없음
		%>
			<script>
				alert("존재하지 않는 회원");
				history.go(-1);
			</script>
		<%
	}else{//회원 있음
		String name = mb.getMem_name();
		//초기값 -1, 비밀번호가 일치하면 1, 비밀번호가 불일치하면 0
		if(check == 1){
//	 		세션에 사용자 정보 추가
			session.setAttribute("uid", id);
			session.setAttribute("name", name);
			response.sendRedirect("main.jsp");
		}else if(check == 0){
			%>
				<script>
					alert("비밀번호가 맞지 않습니다.");
					history.go(-1);
				</script>
			<%
		}
	}
%>














