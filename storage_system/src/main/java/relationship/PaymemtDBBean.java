package relationship;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import javax.naming.InitialContext;
import javax.sql.DataSource;


public class PaymemtDBBean {
	private static PaymemtDBBean instance = new PaymemtDBBean();
	
	public static PaymemtDBBean getInstance() {
		return instance;
	}
	
	public Connection getConnection() throws Exception {
		return ((DataSource) (new InitialContext().lookup("java:comp/env/jdbc/oracle"))).getConnection();
	}
	
	public PaymentBean getCompanyInfo(String c_id) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		PaymentBean info = null;
		String sql="";
		
		try {
			conn = getConnection();
			
			sql = "select c_id, s_id, company_id, item_id, "
					+"p_basic_price, p_period_price, p_delivery_price, p_total_price"
					+", p_deposit_status from payment";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, c_id);
			rs = pstmt.executeQuery();

			if(rs.next()) {
				info = new PaymentBean();
				
				info.setC_id(rs.getString(1));
				info.setS_id(rs.getString(2));
				info.setCompany_id(rs.getString(3));
				info.setItem_id(rs.getString(4));
				info.setP_basic_price(rs.getInt(5));
				info.setP_period_price(rs.getInt(6));
				info.setP_delivery_price(rs.getInt(7));
				info.setP_total_price(rs.getInt(8));
				info.setP_deposit_status(rs.getString(9));
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
