<%@page import="storage.StorageInfoBean"%>
<%@page import="storage.StorageInfoDBBean"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
%>
<%
	StorageInfoDBBean db = StorageInfoDBBean.getInstance();
	
	ArrayList<StorageInfoBean> storageList = db.storageListF();
	String s_location, s_name, s_id;
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>보관 신청</title>
<link rel="stylesheet" href="../css/order.css"> 
<script type="text/javascript" src="script.js"></script>
</head>
<body>
    <div class="card-container large">
        <div class="form-card">
            <h2 class="form-title">보관하기</h2>
            <form method="post" name="order_frm" action="orderOk.jsp">
                <div class="form-group">
                    <label for="s_location">저장소 지역</label>
                    <select name="s_location" id="s_location" required>
                        <option value="">지역을 선택하세요</option>
                        <%
                            for(int i = 0; i < storageList.size(); i++){
                                StorageInfoBean storage = storageList.get(i);
                                s_location = storage.getS_location();
                        %>
                                <option value="<%= s_location %>"><%= s_location %></option>
                        <%
                            }
                        %>
                    </select>
                </div>

                <div class="form-group">
                    <label for="s_name">저장소 이름</label>
                    <select name="s_name" id="s_name" required>
                        <option value="">저장소 이름을 선택하세요</option>
                        <%
                            for(int i = 0; i < storageList.size(); i++){
                                StorageInfoBean storage = storageList.get(i);
                                s_id = storage.getS_id();
                                s_name = storage.getS_name();
                        %>
                                <option value="<%= s_id %>"><%= s_name %></option>
                        <%
                            }
                        %>
                    </select>
                </div>
                
                <div class="form-group">
                    <label for="item_name">물품 이름</label>
                    <input type="text" id="item_name" name="item_name" required minlength="4" maxlength="20">
                </div>
                
                <div class="form-group">
                    <label for="item_weight">물품 중량</label>
                    <input type="number" id="item_weight" name="item_weight" required>
                </div>
                
                <div class="form-group">
                    <label for="ordered_period">보관 기간</label>
                    <input type="date" id="ordered_period" name="ordered_period" required>
                </div>

                <div class="form-buttons">
                    <button type="submit" class="button button-primary">보관신청</button>
                    <button type="reset" class="button button-secondary">다시입력</button>
                    <button type="button" class="button button-outline" onclick="location.href='main.jsp'">돌아가기</button>
                </div>
            </form>
        </div>
    </div>
</body>
</html>