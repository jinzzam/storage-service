package company;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import javax.naming.InitialContext;
import javax.sql.DataSource;


public class CompanyInfoDBBean {
	private static CompanyInfoDBBean instance = new CompanyInfoDBBean();
	
	public static CompanyInfoDBBean getInstance() {
		return instance;
	}
	
	public Connection getConnection() throws Exception {
		return ((DataSource) (new InitialContext().lookup("java:comp/env/jdbc/oracle"))).getConnection();
	}
	
	public CompanyInfoBean getCompanyInfo(String c_id) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		CompanyInfoBean info = null;
		String sql="";
		
		try {
			conn = getConnection();
			
			sql = "select company_id, name, tel, address"
					+" from company_info where company_id=?";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, c_id);
			rs = pstmt.executeQuery();

			if(rs.next()) {
				info = new CompanyInfoBean();
				
				info.setCompany_id(rs.getString("company_id"));
				info.setName(rs.getString("name"));
				info.setTel(rs.getString("tel"));
				info.setAddress(rs.getString("address"));
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
		return info;
	}
	
	
}
