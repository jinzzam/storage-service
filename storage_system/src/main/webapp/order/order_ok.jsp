<%@page import="storage.PlaceAnOrderDBBean"%>
<%@page import="storage.PlaceAnOrderBean"%>
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
<jsp:useBean class="storage.PlaceAnOrderBean" id="order"></jsp:useBean>
<jsp:setProperty property="*" name="order"></jsp:setProperty>
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
	//파일 업로드 처리 
	order.setOrder_id(multi.getParameter("order_id"));
	order.setOrderer_id(multi.getParameter("orderer_id"));
	order.setS_id(multi.getParameter("s_id"));
	order.setItem_id(multi.getParameter("item_id"));
	order.setItem_name(multi.getParameter("item_name"));
	String pageNum = multi.getParameter("pageNum");
	//정수로 캐스팅
	order.setItem_weight(Integer.parseInt(multi.getParameter("item_weight")));
	
	if(file != null){
		order.setFileName(file);
		order.setFileSize(fileSize);
		order.setFileRealName(orifile);
	}
	
	
	PlaceAnOrderDBBean db = PlaceAnOrderDBBean.getInstance();
	
	pageNum = request.getParameter("pageNum");
	if(db.insertOrder(order) == 1){//글쓰기가 정상적으로 완료시
		response.sendRedirect("list.jsp?pageNum="+pageNum);
	}else{//글쓰기가 실패시
		response.sendRedirect("write.jsp?pageNum="+pageNum);
	}
%>