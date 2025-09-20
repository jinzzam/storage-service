<%@page import="magic.member.MemberBean"%>
<%@page import="magic.member.MemberDBBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
%>
<jsp:useBean class="magic.member.MemberBean" id="member"></jsp:useBean>
<jsp:setProperty property="*" name="member"/>
<%
	String uid = (String) session.getAttribute("mem_uid");
	member.setMem_uid(uid);
	
	MemberDBBean manager = MemberDBBean.getInstance();
	int re = manager.updateMember(member);
	
	if(re == 1){
		%>
			<script>
				alert("입력하신 대로 회원 정보가 수정되었습니다.");
				location.href="main.jsp";
			</script>
		<%
	}else{
		%>
			<script>
				alert("수정이 실패했습니다..");
				history.go(-1);
			</script>
		<%
	}
%>