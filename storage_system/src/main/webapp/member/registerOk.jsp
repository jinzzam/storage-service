<%@page import="member.ClientBean"%>
<%@page import="member.MemberDBBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
%>
<jsp:useBean class="member.MemberBean" id="member"></jsp:useBean>
<jsp:useBean class="member.ClientBean" id="Cmember"></jsp:useBean>
<jsp:useBean class="member.DeliveryBean" id="Dmember"></jsp:useBean>
<jsp:useBean class="member.ManagerBean" id="Mmember"></jsp:useBean>
<jsp:setProperty property="*" name="member"></jsp:setProperty>


<%
	MemberDBBean db = MemberDBBean.getInstance();
	String memberType = request.getParameter("mem_type");
	int re = -1;
	
		if(db.confirmID(member.getU_id()) == 1){
			%>
			<script>
			alert("중복되는 아이디가 존재합니다.");	
			history.back();	//바로 직전 화면으로
			</script>
			<%
		}else{
			
			if(memberType.equals("client")) { re = db.insertClient(Cmember); }
			if(memberType.equals("delivery")) { re = db.insertDelivery(Dmember); }
			if(memberType.equals("manager")) { re = db.insertManager(Mmember); }
			
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