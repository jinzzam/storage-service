<%@page import="qna.QnaDBBean"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@page import="java.util.Enumeration"%>
<%@page import="com.jspsmart.upload.File"%>
<%@page import="com.jspsmart.upload.SmartUpload"%>
<%@page import="java.net.InetAddress"%>
<%@page import="java.sql.Timestamp"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
%>
<jsp:useBean class="qna.QnaBean" id="qna"></jsp:useBean>
<jsp:setProperty property="*" name="qna"></jsp:setProperty>
<% 
	
	String path = request.getRealPath("upload");
	int size = 1024 * 1024;
	int fileSize = 0 ;
	String file="";
	String orifile="";
	
	//DefaultFileRenamePolicy : 파일명 넘버링 처리
	MultipartRequest multi = new MultipartRequest(request, path, size, "UTF-8", new DefaultFileRenamePolicy());
	//파일명 가져오기
	Enumeration files = multi.getFileNames();
	String str = files.nextElement().toString();
	//file : 넘버링 처리된 파일명
	file = multi.getFilesystemName(str);

	if(file != null){
		//orifile : 실제 파일명 (화면에 출력되므로 다른 글의 파일명과 중복될 수 있음)
		orifile = multi.getOriginalFileName(str);
		fileSize = file.getBytes().length;
	}
%>
<%
	
	//파일 업로드 처리 qna
	qna.setQ_type(multi.getParameter("q_type"));
	qna.setWriter_id(multi.getParameter("writer_id"));
	qna.setQ_title(multi.getParameter("q_title"));
	qna.setQ_content(multi.getParameter("q_content"));
	qna.setQ_pwd(multi.getParameter("pwd"));
	
	String pageNum = multi.getParameter("pageNum");
	String id = multi.getParameter("writer_id");
	//답변글 처리
	//정수로 캐스팅
	qna.setQ_id(Integer.parseInt(multi.getParameter("q_id")));
	qna.setQ_ref(Integer.parseInt(multi.getParameter("q_ref")));
	qna.setQ_step(Integer.parseInt(multi.getParameter("q_step")));
	qna.setQ_level(Integer.parseInt(multi.getParameter("q_level")));
	
	if(file != null){
		qna.setFileName(file);
		qna.setFileSize(fileSize);
		qna.setFileRealName(orifile);
	}
	
	//오늘날짜 추가
	qna.setQ_date(new Timestamp(System.currentTimeMillis()));
	
	QnaDBBean db = QnaDBBean.getInstance();
	
	pageNum = request.getParameter("pageNum");
	id = request.getParameter("id");
	if(db.insertQna(qna) == 1){//글쓰기가 정상적으로 완료시
		response.sendRedirect("list.jsp?pageNum="+pageNum);
	}else{//글쓰기가 실패시
		response.sendRedirect("write.jsp?pageNum="+pageNum);
	}
%>