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
	
	
	public int insertMember(MemberBean member) {
		System.out.println(member.getAddress());
		Connection conn = null;
		PreparedStatement pstmt = null;
		int re = -1;
		
		String insertSql="insert into memberT(m_id, pwd, m_name, email, address, phone, m_type, company) values(?,?,?,?,?,?,?,?)";
		
		try {
//			dbcp 기법의 연결 객체
			conn = getConnection();
			pstmt = conn.prepareStatement(insertSql);
			
			pstmt.setString(1, member.getM_id());
			pstmt.setString(2, member.getPwd());
			pstmt.setString(3, member.getM_name());
			pstmt.setString(4, member.getEmail());
			pstmt.setString(5, member.getAddress());
			pstmt.setString(6, member.getPhone());
			pstmt.setString(7, member.getM_type());
			pstmt.setString(8, member.getCompany());
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
	

	public int updateMember(MemberBean member) {
		Connection conn=null;
		PreparedStatement pstmt=null;
		int re=-1;//초기값 -1
		String sql="update memberT set pwd=?, m_name=?, email=?, address=?, phone=?, m_type=?, company=? where m_id=?";
		
		try {
//			dbcp 기법의 연결 객체
			conn = getConnection();
			pstmt = conn.prepareStatement(sql);
			
			System.out.println(member.getM_id());
			pstmt.setString(1, member.getPwd());
			pstmt.setString(2, member.getM_name());
			pstmt.setString(3, member.getEmail());
			pstmt.setString(4, member.getAddress());
			pstmt.setString(5, member.getPhone());
			pstmt.setString(6, member.getM_type());
			pstmt.setString(7, member.getCompany());
			pstmt.setString(8, member.getM_id());
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
		int re = -1;//초기값 -1, 아이디가 중복되면 1
		String sql="select m_id from memberT where m_id=?";
	
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			
			if (rs.next()) {//아이디가 일치하는 로우 존재
				re = 1;
			} else {//해당 아이디가 존재하지 않음 

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
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		int re = -1;//초기값 -1, 비밀번호가 일치하면 1, 비밀번호가 불일치하면 0
		String db_mem_pwd="";
		String sql="select pwd from memberT where m_id=?";
		
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			
			if (rs.next()) {//아이디가 일치하는 로우 존재
				db_mem_pwd = rs.getString("pwd");
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
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs=null;
		String sql="select m_id, pwd, m_name, email, address, phone, m_type, company from memberT where m_id=?";
		MemberBean member = null;
		
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			
			if (rs.next()) {//아이디가 일치하는 로우 존재
				member = new MemberBean();
				
				member.setM_id(rs.getString("m_id"));
				member.setPwd(rs.getString("pwd"));
				member.setM_name(rs.getString("m_name"));
				member.setEmail(rs.getString("email"));
				member.setAddress(rs.getString("address"));
				member.setPhone(rs.getString("phone"));
				member.setM_type(rs.getString("m_type"));
				member.setCompany(rs.getString("company"));
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
		return member;
	}
}
