<%@page import="storage.StorageInfoBean"%>
<%@page import="storage.StorageInfoDBBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
%>
<%
	String s_name = request.getParameter("s_name");
	String s_id = request.getParameter("s_id");
	int s_max = Integer.parseInt(request.getParameter("s_max"));
	String s_location = request.getParameter("s_location");
	String s_address = request.getParameter("s_address");
	String company_id = request.getParameter("company_id");

	StorageInfoDBBean db = StorageInfoDBBean.getInstance();
	StorageInfoBean originalStorage = new StorageInfoBean();
	originalStorage = db.getStorage(s_id);
	
	if (originalStorage == null) {
	    out.println("<script>alert('회원 정보가 존재하지 않습니다.'); history.back();</script>");
	    return; 
	}
	
	StorageInfoBean updatedStorage = new StorageInfoBean();
	updatedStorage.setS_name(s_name);
	updatedStorage.setS_id(s_id);
	updatedStorage.setS_max(s_max);
	updatedStorage.setS_location(s_location);
	updatedStorage.setS_address(s_address);
	updatedStorage.setCompany_id(company_id);
	
	int result = db.editStorage_manager(updatedStorage);
	
	if(result == 1){
		response.sendRedirect("storage_list.jsp");
	} else {
	    // Handle error
	    out.println("<script>alert('회원 정보 수정에 실패했습니다.'); history.back();</script>");
	}
	
%>