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
		int number=1;

		
		int re = -1; // insert 정상적으로 실행되면 1
//		글번호 최대값+1을 구함 : null 일 때는 1, 아니면 +1
		String selectIdSql = "select max(order_id) from storage_info";
		String insertSql = "insert into storage_info(s_id, m_id, s_name, s_max, s_address, company_id"
				         + ", fileName, fileRealName, fileSize)"
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
			
			pstmt.setString(1, storage.getS_id());
			pstmt.setString(2, storage.getM_id());
			pstmt.setString(3, storage.getS_name());
			pstmt.setInt(4, storage.getS_max());
			pstmt.setString(5, storage.getS_address());
			pstmt.setString(6, storage.getCompany_id());
			pstmt.setString(7, storage.getFileName());
			pstmt.setString(8, storage.getFileRealName());
			pstmt.setInt(9, storage.getFileSize());
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
	
	public ArrayList<StorageInfoBean> storageList(String pageNumber){
		Connection conn = null;
		Statement stmt = null;
		ResultSet rs = null;
		
		//페이지에 관련된 결과값 받기 위한 참조변수
		ResultSet pageSet = null;
		//게시글 총 개수
		int dbCount = 0;
		int absolutePage = 1;
		
		String selectSql = "select s_id, m_id, s_name, s_max, s_address, company_id"
						+ ", fileName, fileRealName, fileSize"
						 + " from storage_info";
		String countSql = "select count(s_id) from storage_info";
		
		ArrayList<StorageInfoBean> storageList = new ArrayList<StorageInfoBean>();
		
		try {
			conn = getConnection();
			//페이지 처리를 위한 메소드 파라미터 추가 (Oracle 방식)
			stmt = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
			pageSet = stmt.executeQuery(countSql);
			
			if(pageSet.next()) { 	//게시글 총 개수 존재 여부
				dbCount = pageSet.getInt(1); 	//게시글 총 개수
				pageSet.close();	//자원 반납
			}
			
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
			
			rs = stmt.executeQuery(selectSql);
			
			if(rs.next()) {
				rs.absolute(absolutePage);	//페이지의 기준 게시글 셋팅
				int count = 0;
				
				while(count < StorageInfoBean.pageSize) {	//게시글 개수만큼 반복
					StorageInfoBean storage = new StorageInfoBean();
					
					storage.setS_id(rs.getString("s_id"));
					storage.setM_id(rs.getString("m_id"));
					storage.setS_name(rs.getString("s_name"));
					storage.setS_max(rs.getInt("s_max"));
					storage.setS_address(rs.getString("s_address"));
					storage.setCompany_id(rs.getString("company_id"));
					storage.setFileName(rs.getString("fileRealName"));
					storage.setFileRealName(rs.getString("fileRealName"));
					storage.setFileSize(rs.getInt("fileSize"));
//					여기까지가 1행을 가져와서 저장
					
//					행의 데이터를 ArrayList 에 저장
					storageList.add(storage);
					
					if (rs.isLast()) {
						break;
					}else {
						rs.next();
					}
					count++;
				}
			}
			
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			try {
				if(rs != null) rs.close();
				if(stmt != null) stmt.close();
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
			
			sql = "select s_id, m_id, s_name, s_max, s_address, company_id"
					+", fileName, fileRealName, fileSize"
					+" from storage_info where s_id=?";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, s_id);
			rs = pstmt.executeQuery();

			if(rs.next()) {
				storage = new StorageInfoBean();
				
				storage.setS_id(rs.getString("s_id"));
				storage.setM_id(rs.getString("m_id"));
				storage.setS_name(rs.getString("s_name"));
				storage.setS_max(rs.getInt("s_max"));
				storage.setS_address(rs.getString("s_address"));
				storage.setCompany_id(rs.getString("company_id"));
				storage.setFileName(rs.getString("fileRealName"));
				storage.setFileRealName(rs.getString("fileRealName"));
				storage.setFileSize(rs.getInt("fileSize"));
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
		String editSql = "update storage_info set s_name=?, s_max=?, s_address=?, company_id=? where s_id=?";
		
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(editSql);
			pstmt.setString(1, storage.getS_name());
			pstmt.setInt(2, storage.getS_max());
			pstmt.setString(3, storage.getS_address());
			pstmt.setString(4, storage.getS_id());
			
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
	
	public String getManagerName(String s_id) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql="";
		String name="";
		
		try {
			conn = getConnection();
			sql = "select m_name from memberT where m_id=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, s_id);
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
