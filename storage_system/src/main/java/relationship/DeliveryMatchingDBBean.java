package relationship;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import javax.naming.InitialContext;
import javax.sql.DataSource;


public class DeliveryMatchingDBBean {
	private static DeliveryMatchingDBBean instance = new DeliveryMatchingDBBean();
	
	public static DeliveryMatchingDBBean getInstance() {
		return instance;
	}
	
	public Connection getConnection() throws Exception {
		return ((DataSource) (new InitialContext().lookup("java:comp/env/jdbc/oracle"))).getConnection();
	}
	
	public DeliveryMatchingBean getMatchInfo(String d_id) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		DeliveryMatchingBean match = null;
		String sql="";
		
		try {
			conn = getConnection();
			
			sql = "select d_id, c_id, item_id, delivery_type"
					+" from delivery_matching where d_id=?";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, d_id);
			rs = pstmt.executeQuery();

			if(rs.next()) {
				match = new DeliveryMatchingBean();
				
				match.setD_id(rs.getString(1));
				match.setC_id(rs.getString(2));
				match.setItem_id(rs.getString(3));
				match.setDelivery_type(rs.getString(4));
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
		return match;
	}
	
	
}
