<%@page import="java.io.File"%>
<%@page import="magic.board.BoardBean"%>
<%@page import="magic.board.BoardDBBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
%>
<%-- <jsp:useBean class="magic.board.BoardBean" id="board"></jsp:useBean> --%>
<%-- <jsp:setProperty property="*" name="board"></jsp:setProperty> --%>

<%
	String pageNum=request.getParameter("pageNum");

	int b_id = Integer.parseInt(request.getParameter("b_id"));
	String b_pwd = request.getParameter("b_pwd");

	BoardDBBean db = BoardDBBean.getInstance();
	
	BoardBean board = db.getBoard(b_id, false);
	String fName = board.getB_fname();
	String up ="C:\\dev\\work_java\\.metadata\\.plugins\\org.eclipse.wst.server.core\\tmp0\\wtpwebapps\\magicWeb_250912\\upload";
	
	int re = db.deleteBoard(b_id, b_pwd);
	
	if(re == 1){	//게시글이 정상적으로 삭제되었을 때
		//파일이 있으면 파일도 삭제하겠다.
		if(fName != null){
			File file = new File(up + fName);
			file.delete();
		}
		response.sendRedirect("list.jsp?pageNum=" + pageNum);
	}else if(re == 0){
	%>
		<script>
			alert("비밀번호가 틀렸습니다.");		
			history.go(-1);
		</script>
	<%
	} else if (re == -1){
	%>
		<script>
			alert("삭제에 실패했습니다.");
			history.go(-1);
		</script>
	<%
	}
	%>