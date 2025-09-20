<%@page import="member.ManagerBean"%>
<%@page import="member.DeliveryBean"%>
<%@page import="member.ClientBean"%>
<%@page import="member.MemberDBBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
%>
<jsp:useBean class="member.MemberBean" id="member"></jsp:useBean>
<jsp:setProperty property="*" name="member"/>
<%
	String id = (String) session.getAttribute("cur_id");
	member.setU_id(id);
	String type = (String) session.getAttribute("type");
	int re = -1;
	
	MemberDBBean db = MemberDBBean.getInstance();
	if(type.equals("client")){ re = db.updateMember((ClientBean)member); }
	if(type.equals("delivery")){ re = db.updateMember((DeliveryBean)member); }
	if(type.equals("manager")){ re = db.updateMember((ManagerBean)member); }
	
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