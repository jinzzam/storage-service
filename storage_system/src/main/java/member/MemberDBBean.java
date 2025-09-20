package member;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import javax.naming.InitialContext;
import javax.sql.DataSource;

public class MemberDBBean {
//	jsp 소스에서 MemberDB빈객체 생성을 위한 참조 변수
	private static MemberDBBean instance=new MemberDBBean();
	
//	MemberDBBean 객체 레퍼런스를 리턴하는 메소드
	public static MemberDBBean getInstance() {
		return instance;
	}
	
//	쿼리작업에 사용할 커넥션 객체를 리턴하는 메소드(dbcp 기법)
	public Connection getConnection() throws Exception {
		return ((DataSource) (new InitialContext().lookup("java:comp/env/jdbc/oracle"))).getConnection();
	}
	
	public String confirmTypeOfMember(String id) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		String type="";
		int cre = -1;
		int dre = -1;
		int mre = -1;
		
		try {
			conn = getConnection();
			
			String ClientSql = "select c_id from mem_client where c_id=?";
			pstmt = conn.prepareStatement(ClientSql);
			pstmt.setString(1, id);
			cre = pstmt.executeUpdate();
			
			String DeliverySql = "select d_id from mem_delivery where d_id=?";
			pstmt = conn.prepareStatement(DeliverySql);
			pstmt.setString(1, id);
			dre = pstmt.executeUpdate();
			
			String ManagerSql = "select m_id from mem_manager where m_id=?";
			pstmt = conn.prepareStatement(ManagerSql);
			pstmt.setString(1, id);
			mre = pstmt.executeUpdate();
			
			
			if(cre == 1) { type="client"; }
			if(dre == 1) { type="delivry"; }
			if(mre == 1) { type="manager"; }
			
			return type;
			
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
		return type;
	}
	
	public int insertClient(ClientBean client) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		int re = -1;
		
		String insertClientSql="insert into mem_client(c_id, c_pwd, c_name, c_email, c_address, c_phone) values(?,?,?,?,?,?)";
		
		try {
//			dbcp 기법의 연결 객체
			conn = getConnection();
			pstmt = conn.prepareStatement(insertClientSql);
			pstmt.setString(1, client.getU_id());
			pstmt.setString(2, client.getU_pwd());
			pstmt.setString(3, client.getU_name());
			pstmt.setString(4, client.getU_email());
			pstmt.setString(5, client.getU_address());
			pstmt.setString(6, client.getU_phone());
//			INSERT 문은 executeUpdate 메소드 호출
			re = pstmt.executeUpdate();
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
	public int insertDelivery(DeliveryBean delivery) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		int re = -1;
		
		String insertDeliverySql="insert into mem_delivery(d_id, d_pwd, d_name, d_email, d_address, d_phone, d_company) values(?,?,?,?,?,?,?)";
		
		try {
//			dbcp 기법의 연결 객체
			conn = getConnection();
			pstmt = conn.prepareStatement(insertDeliverySql);
			pstmt.setString(1, delivery.getU_id());
			pstmt.setString(2, delivery.getU_pwd());
			pstmt.setString(3, delivery.getU_name());
			pstmt.setString(4, delivery.getU_email());
			pstmt.setString(5, delivery.getU_address());
			pstmt.setString(6, delivery.getU_phone());
			pstmt.setString(7, delivery.getD_company());
//			INSERT 문은 executeUpdate 메소드 호출
			re = pstmt.executeUpdate();
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
	public int insertManager(ManagerBean manager) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		int re = -1;
		
		String insertManagerSql="insert into mem_manager(m_id, m_pwd, m_name, m_email, m_address, m_phone, m_company) values(?,?,?,?,?,?,?)";
		
		try {
//			dbcp 기법의 연결 객체
			conn = getConnection();
			pstmt = conn.prepareStatement(insertManagerSql);
			pstmt.setString(1, manager.getU_id());
			pstmt.setString(2, manager.getU_pwd());
			pstmt.setString(3, manager.getU_name());
			pstmt.setString(4, manager.getU_email());
			pstmt.setString(5, manager.getU_address());
			pstmt.setString(6, manager.getU_phone());
			pstmt.setString(7, manager.getM_company());
//			INSERT 문은 executeUpdate 메소드 호출
			re = pstmt.executeUpdate();
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
	
	
	public int updateMember(ClientBean member) {
		Connection conn=null;
		PreparedStatement pstmt=null;
		int re=-1;//초기값 -1
		String sql="update mem_client set c_pwd=?, c_email=?, c_phone=?, c_address=? where c_id=?";
		
		try {
//			dbcp 기법의 연결 객체
			conn = getConnection();
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, member.getU_pwd());
			pstmt.setString(2, member.getU_email());
			pstmt.setString(3, member.getU_phone());
			pstmt.setString(4, member.getU_address());
			pstmt.setString(5, member.getU_id());
			re = pstmt.executeUpdate();
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
	public int updateMember(DeliveryBean member) {
		Connection conn=null;
		PreparedStatement pstmt=null;
		int re=-1;//초기값 -1
		String sql="update mem_delivery set d_pwd=?, d_email=?, d_phone=?, d_address=? d_company=? where d_id=?";
		
		try {
//			dbcp 기법의 연결 객체
			conn = getConnection();
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, member.getU_pwd());
			pstmt.setString(2, member.getU_email());
			pstmt.setString(3, member.getU_phone());
			pstmt.setString(4, member.getU_address());
			pstmt.setString(5, member.getD_company());
			pstmt.setString(6, member.getU_id());
			re = pstmt.executeUpdate();
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
	public int updateMember(ManagerBean member) {
		Connection conn=null;
		PreparedStatement pstmt=null;
		int re=-1;//초기값 -1
		String sql="update mem_manager set m_pwd=?, m_email=?, m_phone=?, m_address=?, m_company=? where m_id=?";
		
		try {
//			dbcp 기법의 연결 객체
			conn = getConnection();
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, member.getU_pwd());
			pstmt.setString(2, member.getU_email());
			pstmt.setString(3, member.getU_phone());
			pstmt.setString(4, member.getU_address());
			pstmt.setString(5, member.getM_company());
			pstmt.setString(6, member.getU_id());
			re = pstmt.executeUpdate();
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
	
//	회원 가입시 아이디 중복 확인할 때 사용하는 메소드
	public int confirmID(String id) {
		Connection conn=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		int re=-1;//초기값 -1, 아이디가 중복되면 1
		String sql="select c_id"
				+ "  from mem_client c left outer join mem_delivery d "
				+ "    on c.c_id = d.d_id"
				+ "  left outer join mem_manager m"
				+ "    on m.m_id = c.c_id"
				+ " where c_id=?";
	
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			
			if (rs.next()) {//아이디가 일치하는 로우 존재
				re = 1;
			} else {//해당 아이디가 존재하지 않음
				re = -1;
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
	
//	사용자 인증시 사용하는 메소드
	public int userCheck(String id, String pwd) {
		Connection conn=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		int re=-1;//초기값 -1, 비밀번호가 일치하면 1, 비밀번호가 불일치하면 0
		String db_mem_pwd="";
		String sql="select c_pwd"
				+ "  from mem_client c left outer join mem_delivery d "
				+ "    on c.c_id = d.d_id"
				+ "  left outer join mem_manager m"
				+ "    on m.m_id = c.c_id"
				+ " where c_id=?";
		
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			
			if (rs.next()) {//아이디가 일치하는 로우 존재
				db_mem_pwd = rs.getString(1);
				if (db_mem_pwd.equals(pwd)) {//패스워드도  일치
					re = 1;
				} else {//패스워드가 불일치
					re = 0;
				}
			} else {//해당 아이디가 존재하지 않음
				re = -1;
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
	
//	아이디가 일치하는 멤버의 정보를 얻어오는 메소드
	public MemberBean getMember(String id) {
		Connection conn=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		int re = -1;//초기값 -1
		String memType = "";
//		String db_mem_pwd="";
		String c_sql="select * from mem_client where c_id=?";
		String d_sql="select * from mem_delivery where d_id=?";
		String m_sql="select * from mem_manager where m_id=?";
		MemberBean member=null;
		
		try {
			conn = getConnection();
			for(int i=0; i<3; i++) {
				String sql="";
				if(i==0) {sql.concat(c_sql); memType="client";}
				else if(i==1){sql.concat(d_sql); memType="delivery";}
				else if(i==2) {sql.concat(m_sql); memType="manager";}
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, id);
				rs = pstmt.executeQuery();
				if(rs.next()) re = 1;
				else re = -1;
			}
			
			if (re == 1) {//아이디가 일치하는 로우 존재
				if(memType.equals("client")) member = new ClientBean();
				if(memType.equals("delivery")) member = new DeliveryBean();
				if(memType.equals("manager")) member = new ManagerBean();
				member.setU_id(id);
				member.setU_pwd(rs.getString(2));
				member.setU_name(rs.getString(3));
				member.setU_email(rs.getString(4));
				member.setU_address(rs.getString(5));
				re = 1;
			} else {//해당 아이디가 존재하지 않음
				re = -1;
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
		System.out.println("!@@ MemberDBBean : re : " + re);
		return member;
	}
}
