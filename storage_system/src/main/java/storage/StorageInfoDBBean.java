package storage;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;

import javax.naming.InitialContext;
import javax.sql.DataSource;



public class StorageInfoDBBean {
	private static StorageInfoDBBean instance = new StorageInfoDBBean();
	
	public static StorageInfoDBBean getInstance() {
		return instance;
	}
	
	public Connection getConnection() throws Exception {
		return ((DataSource) (new InitialContext().lookup("java:comp/env/jdbc/oracle"))).getConnection();
	}
	
	public int insertStorage(StorageInfoBean storage) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		int re = -1; // insert 정상적으로 실행되면 1
//		글번호 최대값+1을 구함 : null 일 때는 1, 아니면 +1
		String insertSql = "insert into storage_info(s_id, m_id, s_location, s_name, s_max, s_address, company_id)"
						  + " values(?,?,?,?,?,?,?)";
		
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(insertSql);
			rs = pstmt.executeQuery();
			
			pstmt.setString(1, storage.getS_id());
			pstmt.setString(2, storage.getM_id());
			pstmt.setString(3, storage.getS_name());
			pstmt.setString(4, storage.getS_location());
			pstmt.setInt(5, storage.getS_max());
			pstmt.setString(6, storage.getS_address());
			pstmt.setString(7, storage.getCompany_id());
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
	
	public ArrayList<StorageInfoBean> storageListF(String pageNumber){
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		//페이지에 관련된 결과값 받기 위한 참조변수
		ResultSet pageSet = null;
		//게시글 총 개수
		int dbCount = 0;
		int absolutePage = 1;
		
		String selectSql = "select s_id, m_id, s_id, s_name, s_max, s_location"
                + ", s_address, company_id from storage_info";
		String countSql = "select count(s_id) from storage_info";
		
		ArrayList<StorageInfoBean> storageList = new ArrayList<StorageInfoBean>();
		
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
			if (dbCount % StorageInfoBean.pageSize == 0) {
//				80/10 = 8페이지
				StorageInfoBean.pageCount = dbCount / StorageInfoBean.pageSize;
			} else {
//				84/10+1 = 9페이지
				StorageInfoBean.pageCount = dbCount / StorageInfoBean.pageSize + 1;
			}
			
			if (pageNumber != null) { //넘겨오는 페이지 번호가 있는 경우
				StorageInfoBean.pageNum = Integer.parseInt(pageNumber);
				//1: 0*10+1=1, 2:1*10+1=11 (1페이지는 1, 2페이지는 11(페이지 기준 게시글))
				absolutePage = (StorageInfoBean.pageNum - 1) * StorageInfoBean.pageSize + 1;
			}
			
			pstmt = conn.prepareStatement(selectSql, ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
			rs = pstmt.executeQuery();
			
			
				rs.absolute(absolutePage);	//페이지의 기준 게시글 셋팅
				int count = 0;
				
				while(count < StorageInfoBean.pageSize && rs.next()) {	//게시글 개수만큼 반복
					StorageInfoBean storage = new StorageInfoBean();
					
					storage.setS_id(rs.getString("s_id"));
					storage.setM_id(rs.getString("m_id"));
					storage.setS_name(rs.getString("s_name"));
					storage.setS_max(rs.getInt("s_max"));
					storage.setS_location(rs.getString("s_location"));
					storage.setS_address(rs.getString("s_address"));
					storage.setCompany_id(rs.getString("company_id"));
					
					storageList.add(storage);
					
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
		return storageList;
	}
	

	public StorageInfoBean getStorage(int s_id) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		StorageInfoBean storage = null;
		String sql="";
		
		try {
			conn = getConnection();
			
			sql = "select s_id, m_id, s_name, s_max, s_location, s_address, company_id"
					+" from storage_info where s_id=?";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, s_id);
			rs = pstmt.executeQuery();

			if(rs.next()) {
				storage = new StorageInfoBean();
				
				storage.setS_id(rs.getString("s_id"));
				storage.setM_id(rs.getString("m_id"));
				storage.setS_name(rs.getString("s_name"));
				storage.setS_location(rs.getString("s_location"));
				storage.setS_max(rs.getInt("s_max"));
				storage.setS_address(rs.getString("s_address"));
				storage.setCompany_id(rs.getString("company_id"));
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
		return storage;
	}
	
	public int deleteStorage(String s_id) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		int re = -1;
		
		try {
			conn = getConnection();
			
			String sql = "delete from storage_info where s_id=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, s_id);
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
	
	public int editStorage_manager(StorageInfoBean storage) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		int re = -1; // insert 정상적으로 실행되면 1
//		글번호 최대값+1을 구함 : null 일 때는 1, 아니면 +1
		String editSql = "update storage_info set s_name=?, s_location=?, s_max=?, s_address=?, company_id=? where s_id=?";
		
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(editSql);
			pstmt.setString(1, storage.getS_name());
			pstmt.setString(2, storage.getS_location());
			pstmt.setInt(3, storage.getS_max());
			pstmt.setString(4, storage.getS_address());
			pstmt.setString(5, storage.getCompany_id());
			pstmt.setString(6, storage.getS_id());
			
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
	
	public StorageInfoBean getFileName(int s_id) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql="";
		StorageInfoBean storage = null;
		
		try {
			conn = getConnection();
			sql = "select fileName, fileRealName from storage_info where s_id=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, s_id);
			rs = pstmt.executeQuery();
			
			//첨부파일이 있으면 
			if(rs.next()) {
				storage = new StorageInfoBean();
				
				storage.setFileName(rs.getString(1));
				storage.setFileRealName(rs.getString(2));
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
		return storage;
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

	
}
