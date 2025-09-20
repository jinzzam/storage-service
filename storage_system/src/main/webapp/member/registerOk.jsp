<%@page import="magic.member.MemberDBBean02"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
%>
<jsp:useBean class="magic.member.MemberBean" id="mb"></jsp:useBean>
<jsp:setProperty property="*" name="mb"></jsp:setProperty>

<%!MemberDBBean02 manager = MemberDBBean02.getInstance();%>
	<%
// 		mb.setMem_uid(request.getParameter(mb.getMem_uid()));
// 		mb.setMem_pwd(request.getParameter(mb.getMem_pwd()));
// 		mb.setMem_name(request.getParameter(mb.getMem_name()));
// 		mb.setMem_email(request.getParameter(mb.getMem_email()));
// 		mb.setMem_address(request.getParameter(mb.getMem_address()));
		
		if(manager.confirmID(mb.getMem_uid()) == 1){
			%>
			<script>
			alert("중복되는 아이디가 존재합니다.");	
			history.back();	//바로 직전 화면으로
			</script>
			<%
			
		}else{
			int re = manager.insertMember(mb);
			if(re == 1){
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