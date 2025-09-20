<%-- <%@page import="javax.websocket.Session"%> --%>
<%@page import="member.MemberBean"%>
<%@page import="member.MemberDBBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
request.setCharacterEncoding("UTF-8");
%>
<%
	String id = (String)request.getParameter("mem_uid");
	String pwd = (String)request.getParameter("mem_pwd");
	
	MemberDBBean db = MemberDBBean.getInstance();
	int check = db.userCheck(id, pwd);
	MemberBean member = db.getMember(id);	
%>

	<%
		if(member == null){
			%>
			<script>
				alert("존재하지 않는 회원.");	
				reg_frm.mem_uid.focus();
				history.back();	//바로 직전 화면으로
			</script>
			<%
		}else{
			String name = member.getU_name();
			
			if(check == 1) { //세션에 사용자 정보 추가 후 main.jsp로 이동
				session.setAttribute("cur_id", id);
				session.setAttribute("cur_name", name);
				response.sendRedirect("main.jsp");
			%>
			}else if(check == 0){
			<script>
				alert("비밀번호가 맞지 않습니다.");
				history.go(-1);
			</script><%
			}
		}
	%>