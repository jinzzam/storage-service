package storage;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import javax.naming.InitialContext;
import javax.sql.DataSource;



public class PlaceAnOrderDBBean {
	private static PlaceAnOrderDBBean instance = new PlaceAnOrderDBBean();
	
	public static PlaceAnOrderDBBean getInstance() {
		return instance;
	}
	
	public Connection getConnection() throws Exception {
		return ((DataSource) (new InitialContext().lookup("java:comp/env/jdbc/oracle"))).getConnection();
	}
	
	public int insertOrder(PlaceAnOrderBean order) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		int number = 0;

		
		int re = -1; // insert 정상적으로 실행되면 1
//		글번호 최대값+1을 구함 : null 일 때는 1, 아니면 +1
		String selectIdSql = "select max(order_id) from place_an_order";
		String insertSql = "insert into place_an_order(order_id, s_id, item_id, item_name, item_weight"
				         + ", ordered_date, ordered_period, confirm_status)"
						  + " values(?,?,?,?,?,?,?,?,?)";
		
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(selectIdSql);
			rs = pstmt.executeQuery();
			
			if (rs.next()) {
				number = rs.getInt(1)+1;
			} else {
				number = 1;
			}
			pstmt = conn.prepareStatement(insertSql);
			
			pstmt.setString(1, order.getOrder_id());
			pstmt.setString(2, order.getOrderer_id());
			pstmt.setString(3, order.getS_id());
			pstmt.setString(4, order.getItem_id());
			pstmt.setString(5, order.getItem_name());
			pstmt.setInt(6, order.getItem_weight());
			pstmt.setString(7, order.getOrdered_date());
			pstmt.setString(8, order.getOrdered_period());
			pstmt.setString(9, order.getConfirm_status());
//			insert 문은 executeUpdate 메소드 호출
			re = pstmt.executeUpdate();
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			try {
				if(pstmt != null) pstmt.close();
				if(conn != null) conn.close();
			}catch(Exception e2) {
				e2.printStackTrace();
			}
		}
		return re;
	}
	
	public ArrayList<PlaceAnOrderBean> orderListF(String pageNumber){
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		//페이지에 관련된 결과값 받기 위한 참조변수
		ResultSet pageSet = null;
		//게시글 총 개수
		int dbCount = 0;
		int absolutePage = 1;
		
		String selectSql = "select order_id, orderer_id, s_id, item_id, item_name, item_weight"
                + ", ordered_date, ordered_period, confirm_status, fileSize"
                + " from place_an_order";
		String countSql = "select count(order_id) from place_an_order";
		
		ArrayList<PlaceAnOrderBean> orderList = new ArrayList<PlaceAnOrderBean>();
		
		try {
			conn = getConnection();
			//페이지 처리를 위한 메소드 파라미터 추가 (Oracle 방식)
			pstmt = conn.prepareStatement(countSql, ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
			pageSet = pstmt.executeQuery();
			
			if(pageSet.next()) { 	//게시글 총 개수 존재 여부
				dbCount = pageSet.getInt(1); 	//게시글 총 개수
			}
			pageSet.close();
	        pstmt.close(); 
		
			
			//84건 경우 (84 % 10 = 4)
			//80건 경우 (80 % 10 = 0)
			if (dbCount % PlaceAnOrderBean.pageSize == 0) {
//				80/10 = 8페이지
				PlaceAnOrderBean.pageCount = dbCount / PlaceAnOrderBean.pageSize;
			} else {
//				84/10+1 = 9페이지
				PlaceAnOrderBean.pageCount = dbCount / PlaceAnOrderBean.pageSize + 1;
			}
			
			if (pageNumber != null) { //넘겨오는 페이지 번호가 있는 경우
				PlaceAnOrderBean.pageNum = Integer.parseInt(pageNumber);
				//1: 0*10+1=1, 2:1*10+1=11 (1페이지는 1, 2페이지는 11(페이지 기준 게시글))
				absolutePage = (PlaceAnOrderBean.pageNum - 1) * PlaceAnOrderBean.pageSize + 1;
			}
			
			pstmt = conn.prepareStatement(selectSql, ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
			rs = pstmt.executeQuery();
			
				rs.absolute(absolutePage);	//페이지의 기준 게시글 셋팅
				int count = 0;
				
				while(count < PlaceAnOrderBean.pageSize && rs.next()) {	//게시글 개수만큼 반복
					PlaceAnOrderBean order = new PlaceAnOrderBean();
					
					order.setOrder_id(rs.getString("order_id"));
					order.setOrderer_id(rs.getString("orderer_id"));
					order.setS_id(rs.getString("s_id"));
					order.setItem_id(rs.getString("item_id"));
					order.setItem_name(rs.getString("item_name"));
					order.setItem_weight(rs.getInt("item_weight"));
					
					order.setOrdered_date(rs.getString("ordered_date"));
					order.setOrdered_period(rs.getString("ordered_period"));
					order.setConfirm_status(rs.getString("confirm_status"));
					order.setFileSize(rs.getInt("fileSize"));
//					여기까지가 1행을 가져와서 저장
					
//					행의 데이터를 ArrayList 에 저장
					orderList.add(order);
					
					count++;
				}
			
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			try {
				if(rs != null) rs.close();
				if(pstmt != null) pstmt.close();
				if(conn != null) conn.close();
			}catch(Exception e2) {
				e2.printStackTrace();
			}
		}
		return orderList;
	}
	

	public PlaceAnOrderBean getOrder(int order_id) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		PlaceAnOrderBean order = null;
		String sql="";
		
		try {
			conn = getConnection();
			
			sql = "select order_id, s_id, item_id, item_name, item_weight"
				+ ", ordered_date, ordered_period, confirm_status"
				+ "from place_an_order where order_id=?";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, order_id);
			rs = pstmt.executeQuery();

			if(rs.next()) {
				order = new PlaceAnOrderBean();
				
				order.setOrder_id("order_id");
				order.setOrderer_id(rs.getString("orderer_id"));
				order.setS_id(rs.getString("s_id"));
				order.setItem_id(rs.getString("item_id"));
				order.setItem_name(rs.getString("item_name"));
				order.setItem_weight(rs.getInt("item_weight"));
				order.setOrdered_date(rs.getString("ordered_date"));
				order.setOrdered_period(rs.getString("ordered_period"));
				order.setConfirm_status(rs.getString("confirm_status"));
			}
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			try {
				if(rs != null) rs.close();
				if(pstmt != null) pstmt.close();
				if(conn != null) conn.close();
			}catch(Exception e2) {
				e2.printStackTrace();
			}
		}
		return order;
	}
	
	public int deleteOrder(int order_id) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		int re = -1;
		
		try {
			conn = getConnection();
			
			String sql = "delete from place_an_order where order_id=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, order_id);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {	
				re = 1;
			} 

		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			try {
				if(rs != null) rs.close();
				if(pstmt != null) pstmt.close();
				if(conn != null) conn.close();
			}catch(Exception e2) {
				e2.printStackTrace();
			}
		}
		return re;
	}
	
	public int editOrder_user(PlaceAnOrderBean order) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		int re = -1; // insert 정상적으로 실행되면 1
//		글번호 최대값+1을 구함 : null 일 때는 1, 아니면 +1
		String editSql = "update place_an_order set item_name=?, item_weight=?, orderd_period=? where order_id=?";
		
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(editSql);
			pstmt.setString(1, order.getItem_name());
			pstmt.setInt(1, order.getItem_weight());
			pstmt.setString(2, order.getOrdered_period());
			pstmt.setString(3, order.getOrder_id());
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) {	//비밀번호가 있으면 참
				re = 1;
			}
			
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			try {
				if(rs != null) rs.close();
				if(pstmt != null) pstmt.close();
				if(conn != null) conn.close();
			}catch(Exception e2) {
				e2.printStackTrace();
			}
		}
		return re;
	}
	
	public PlaceAnOrderBean getFileName(int order_id) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql="";
		PlaceAnOrderBean order = null;
		
		try {
			conn = getConnection();
			sql = "select fileName, fileRealName from place_an_order where order_id=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, order_id);
			rs = pstmt.executeQuery();
			
			//첨부파일이 있으면 
			if(rs.next()) {
				order= new PlaceAnOrderBean();
				
				order.setFileName(rs.getString(1));
				order.setFileRealName(rs.getString(2));
			}
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			try {
				if(rs != null) rs.close();
				if(pstmt != null) pstmt.close();
				if(conn != null) conn.close();
			}catch(Exception e2) {
				e2.printStackTrace();
			}
		}
		return order;
	}
	
	public String getOrdererName(String orderer_id) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql="";
		String name="";
		
		try {
			conn = getConnection();
			sql = "select m_name from memberT where m_id=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, orderer_id);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				name = rs.getString("m_name");
			}
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			try {
				if(rs != null) rs.close();
				if(pstmt != null) pstmt.close();
				if(conn != null) conn.close();
			}catch(Exception e2) {
				e2.printStackTrace();
			}
		}
		return name;
	}
	
	public String getOrdererEmail(String orderer_id) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql="";
		String email="";
		
		try {
			conn = getConnection();
			sql = "select email from memberT where m_id=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, orderer_id);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				email = rs.getString("email");
			}
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			try {
				if(rs != null) rs.close();
				if(pstmt != null) pstmt.close();
				if(conn != null) conn.close();
			}catch(Exception e2) {
				e2.printStackTrace();
			}
		}
		return email;
	}

	
}
