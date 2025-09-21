<%@page import="qna.QnaBean"%>
<%@page import="qna.QnaDBBean"%>
<%@page import="java.io.File"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
%>
<%-- <jsp:useBean class="magic.board.BoardBean" id="board"></jsp:useBean> --%>
<%-- <jsp:setProperty property="*" name="board"></jsp:setProperty> --%>

<%
	String pageNum=request.getParameter("pageNum");
	String cur_id = (String) session.getAttribute("cur_id");

	int q_id = Integer.parseInt(request.getParameter("q_id"));
	String pwd = request.getParameter("pwd");

	QnaDBBean db = QnaDBBean.getInstance();
	
	QnaBean qna= db.getQna(q_id);
	String fName = qna.getFileName();
	String up ="C:\\dev\\storage-service\\storage-service\\.metadata\\.plugins\\org.eclipse.wst.server.core\\tmp0\\wtpwebapps\\storage_system\\upload";
	
	int re = db.deleteQna(q_id, pwd);
	
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