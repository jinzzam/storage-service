<%@page import="storage.StoredItemsBean"%>
<%@page import="storage.PlaceAnOrderBean"%>
<%@page import="storage.StoredItemsDBBean"%>
<%@page import="storage.PlaceAnOrderDBBean"%>
<%@page import="storage.StorageInfoBean"%>
<%@page import="storage.StorageInfoDBBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
	PlaceAnOrderDBBean orderDB = PlaceAnOrderDBBean.getInstance();
	StorageInfoDBBean storageDB = StorageInfoDBBean.getInstance();
	StoredItemsDBBean itemDB = StoredItemsDBBean.getInstance();
	
	
	String cur_id = (String) session.getAttribute("cur_id");
%>
<%-- <jsp:useBean class="storage.PlaceAnOrderBean" id="order"></jsp:useBean> --%>
<%-- <jsp:setProperty property="*" name="order"></jsp:setProperty> --%>
<%-- <jsp:useBean class="storage.StorageInfoBean" id="storage"></jsp:useBean> --%>
<%-- <jsp:setProperty property="*" name="storage"></jsp:setProperty> --%>
<%-- <jsp:useBean class="storage.StoredItemsBean" id="item"></jsp:useBean> --%>
<%-- <jsp:setProperty property="*" name="item"></jsp:setProperty> --%>
<%
	String order_id;
	String orderer_id = cur_id;
	String s_id = request.getParameter("s_id");
	System.out.println("@@@## s_id=>"+s_id);
	String item_id;
	String item_name = request.getParameter("item_name");
	int item_weight = Integer.parseInt(request.getParameter("item_weight"));
	String ordered_date;
	String ordered_period = request.getParameter("ordered_period");
	String confirm_status="0";

	StorageInfoBean storage = storageDB.getStorage(s_id);
	int remain_weight = storage.getS_max();
	if(remain_weight < item_weight){
		%>
			<script>
				alert("보관소 용량이 물품에 비해 부족합니다.\n이번 신청은 반려됩니다.");
				history.back();
			</script>
		<%
	}
	PlaceAnOrderBean order = new PlaceAnOrderBean();
	StoredItemsBean item = new StoredItemsBean();
	
	//PlaceAnOrderDBBean
	//StorageInfoBean
	//StoredItemsBean
// 	order.setOrder_id(order_id);
	order.setOrderer_id(cur_id);
	order.setS_id(s_id);
	order.setItem_id(item.getItem_id());
	order.setItem_name(item_name);
	order.setItem_weight(item_weight);
	order.setOrdered_period(ordered_period);
	order.setConfirm_status(confirm_status);
	if(orderDB.insertOrder(order) == 1){
		%>	
		<script>
			alert("신청 완료.");
		</script>
		<%
	}
	
	item.setItem_name(item_name);
	item.setItem_weight(item_weight);
	item.setS_id(s_id);
	item.setExpire_date(ordered_period);
	if(itemDB.insertItem(item) == 1){
		%>
		<script>
			alert("아이템 예비 등록 완료.");
			location.href="../store/storage_list.jsp";
		</script>
		<%
	}
	
	
%>
