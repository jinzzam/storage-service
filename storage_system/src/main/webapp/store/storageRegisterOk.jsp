<%@page import="storage.StorageInfoBean"%>
<%@page import="storage.StorageInfoDBBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
	StorageInfoDBBean db = StorageInfoDBBean.getInstance();
%>
<jsp:useBean class="storage.StorageInfoBean" id="storage"></jsp:useBean>
<jsp:setProperty property="*" name="storage"></jsp:setProperty>
<%
int re = db.confirmID(storage.getS_id());

if(re == 1){
	%>
		<script>
		alert("중복되는 보관소 코드가 존재합니다.");	
		history.back();	//바로 직전 화면으로
		</script>
	<%
}else{
	if(db.insertStorage(storage) == 1){
		%>
			<script>
			alert("보관소가 등록되었습니다.");
			location.href="storage_list.jsp";
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
