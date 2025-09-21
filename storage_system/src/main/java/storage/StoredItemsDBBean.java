package storage;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import javax.naming.InitialContext;
import javax.sql.DataSource;


public class StoredItemsDBBean {
	private static StoredItemsDBBean instance = new StoredItemsDBBean();
	
	public static StoredItemsDBBean getInstance() {
		return instance;
	}
	
	public Connection getConnection() throws Exception {
		return ((DataSource) (new InitialContext().lookup("java:comp/env/jdbc/oracle"))).getConnection();
	}
	
	public int insertItem(StoredItemsBean item) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		int re = -1; // insert 정상적으로 실행되면 1
//		글번호 최대값+1을 구함 : null 일 때는 1, 아니면 +1
		String insertSql = "insert into stored_items(item_id, item_name, item_weight, s_id, stored_date, expire_date)"
						  + " values(?,?,?,?,?,?)";
		
		
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(insertSql);
			rs = pstmt.executeQuery();
			
			pstmt.setString(1, item.getItem_id());
			pstmt.setString(2, item.getItem_name());
			pstmt.setInt(3, item.getItem_weight());
			pstmt.setString(4, item.getS_id());
			pstmt.setString(5, item.getStored_date());
			pstmt.setString(6, item.getExpire_date());
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
	
	public ArrayList<StoredItemsBean> itemListF(){
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		String selectSql = "select item_id, item_name, item_weight, s_id, stored_date, expire_date"
						+ " from stored_items";
		String countSql = "select count(item_id) from stored_items";
		
		ArrayList<StoredItemsBean> itemList = new ArrayList<StoredItemsBean>();
		
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(countSql, ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
			pstmt.close(); 
			
			pstmt = conn.prepareStatement(selectSql, ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
			rs = pstmt.executeQuery();
			
			int count = 0;
			
			while(count < StoredItemsBean.pageSize && rs.next()) {	//게시글 개수만큼 반복
				StoredItemsBean item = new StoredItemsBean();
				
				item.setItem_id(rs.getString("item_id"));
				item.setItem_name(rs.getString("item_name"));
				item.setItem_weight(rs.getInt("item_weight"));
				item.setS_id(rs.getString("s_id"));
				item.setStored_date(rs.getString("stored_date"));
				item.setExpire_date(rs.getString("expire_date"));
				
				itemList.add(item);
				
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
		return itemList;
	}
	
	
	public ArrayList<StoredItemsBean> itemListF(String pageNumber){
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		//페이지에 관련된 결과값 받기 위한 참조변수
		ResultSet pageSet = null;
		//게시글 총 개수
		int dbCount = 0;
		int absolutePage = 1;
		
		String selectSql = "select item_id, item_name, item_weight, s_id, stored_date, expire_date"
				+ " from stored_items";
		String countSql = "select count(item_id) from stored_items";
		
		ArrayList<StoredItemsBean> itemList = new ArrayList<StoredItemsBean>();
		
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(countSql, ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
			pageSet = pstmt.executeQuery();
			
			if(pageSet.next()) { 	//게시글 총 개수 존재 여부
				dbCount = pageSet.getInt(1); 	//게시글 총 개수
			}
			pageSet.close();
	        pstmt.close(); 
		
			//84건 경우 (84 % 10 = 4)
			//80건 경우 (80 % 10 = 0)
			if (dbCount % StoredItemsBean.pageSize == 0) {
//				80/10 = 8페이지
				StoredItemsBean.pageCount = dbCount / StoredItemsBean.pageSize;
			} else {
//				84/10+1 = 9페이지
				StoredItemsBean.pageCount = dbCount / StoredItemsBean.pageSize + 1;
			}
			
			if (pageNumber != null) { //넘겨오는 페이지 번호가 있는 경우
				StoredItemsBean.pageNum = Integer.parseInt(pageNumber);
				//1: 0*10+1=1, 2:1*10+1=11 (1페이지는 1, 2페이지는 11(페이지 기준 게시글))
				absolutePage = (StoredItemsBean.pageNum - 1) * StoredItemsBean.pageSize + 1;
			}
			
			pstmt = conn.prepareStatement(selectSql, ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
			rs = pstmt.executeQuery();
			
			
				rs.absolute(absolutePage);	//페이지의 기준 게시글 셋팅
				int count = 0;
				
				while(count < StoredItemsBean.pageSize && rs.next()) {	//게시글 개수만큼 반복
					StoredItemsBean item = new StoredItemsBean();
					
					item.setItem_id(rs.getString("item_id"));
					item.setItem_name(rs.getString("item_name"));
					item.setItem_weight(rs.getInt("item_weight"));
					item.setS_id(rs.getString("s_id"));
					item.setStored_date(rs.getString("stored_date"));
					item.setExpire_date(rs.getString("expire_date"));
					
					itemList.add(item);
					
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
		return itemList;
	}
	

	public StoredItemsBean getItem(String item_id) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		StoredItemsBean item = null;
		String sql="";
		
		try {
			conn = getConnection();
			
			sql = "select item_id, item_name, item_weight, s_id, stored_date, expire_date"
					+" from stored_items where item_id=?";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, item_id);
			rs = pstmt.executeQuery();

			if(rs.next()) {
				item = new StoredItemsBean();
				
				item.setItem_id(rs.getString("item_id"));
				item.setItem_name(rs.getString("item_name"));
				item.setItem_weight(rs.getInt("item_weight"));
				item.setS_id(rs.getString("s_id"));
				item.setStored_date(rs.getString("stored_date"));
				item.setExpire_date(rs.getString("expire_date"));
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
		return item;
	}
	
	public int deleteItem(String item_id) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		int re = -1;
		
		try {
			conn = getConnection();
			
			String sql = "delete from stored_items where item_id=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, item_id);
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
	
	public int editItem_client(StoredItemsBean item) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		int re = -1; // insert 정상적으로 실행되면 1
//		글번호 최대값+1을 구함 : null 일 때는 1, 아니면 +1
		String editSql = "update stored_items set item_name=?, item_weight=?, expire_date=? where item_id=?";
		
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(editSql);
			pstmt.setString(1, item.getItem_name());
			pstmt.setInt(2, item.getItem_weight());
			pstmt.setString(3, item.getExpire_date());
			pstmt.setString(3, item.getItem_id());
			
			re = pstmt.executeUpdate();
			
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
	
	public StoredItemsBean getFileName(int item_id) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql="";
		StoredItemsBean item = null;
		
		try {
			conn = getConnection();
			sql = "select fileName, fileRealName from stored_items where item_id=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, item_id);
			rs = pstmt.executeQuery();
			
			//첨부파일이 있으면 
			if(rs.next()) {
				item = new StoredItemsBean();
				
				item.setFileName(rs.getString(1));
				item.setFileRealName(rs.getString(2));
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
		return item;
	}
	
	public String getManagerName(String m_id) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql="";
		String name="";
		
		try {
			conn = getConnection();
			sql = "select m_name from memberT where m_id=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, m_id);
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
	
	public String getCompanyTel(String company_id) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql="";
		String tel="";
		
		try {
			conn = getConnection();
			sql = "select tel from company_info where company_id=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, company_id);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				tel = rs.getString("tel");
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
		return tel;
	}
	
	public int confirmID(String s_id) {
		Connection conn=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		int re = -1;//초기값 -1, 아이디가 중복되면 1
		String sql="select s_id from storage_info where s_id=?";
	
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, s_id);
			rs = pstmt.executeQuery();
			
			if (rs.next()) {
				re = 1;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			try {
				if (pstmt != null) pstmt.close();
				if (conn != null) conn.close();
			} catch (Exception e2) {
				e2.printStackTrace();
			}
		}
		
		return re;
	}

	
}
