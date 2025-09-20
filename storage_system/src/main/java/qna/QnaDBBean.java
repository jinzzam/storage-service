package qna;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.sql.Timestamp;
import java.util.ArrayList;

import javax.naming.InitialContext;
import javax.sql.DataSource;

public class QnaDBBean {
	private static QnaDBBean instance = new QnaDBBean();
	
	public static QnaDBBean getInstance() {
		return instance;
	}
	
	public Connection getConnection() throws Exception {
		return ((DataSource) (new InitialContext().lookup("java:comp/env/jdbc/oracle"))).getConnection();
	}
	
	public int insertQna(QnaBean qna) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		int number;
		int id = qna.getQ_id();
		int ref = qna.getQ_ref();
		int step = qna.getQ_step();
		int level = qna.getQ_level();
		String writer_id = qna.getWriter_id();
		
		int re = -1; // insert 정상적으로 실행되면 1
//		글번호 최대값+1을 구함 : null 일 때는 1, 아니면 +1
		String selectIdSql = "select max(q_id) from QNA";
		String insertSql = "insert into QNA(q_id, q_type, writer_id, q_title, q_content, q_date, q_pwd, q_ref, q_step, q_level"
				              + ", fileName, fileRealName, fileSize)"
							   + " values((select max(q_id)+1 from QNA),?,?,?,?,?,?,?,?,?,?,?,?)";
		
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(selectIdSql);
			rs = pstmt.executeQuery();
			
			if (rs.next()) {
				number = rs.getInt(1)+1;
			} else {
				number = 1;
			}
			
			//1. 글번호를 가지고 오는 경우(답변)
//			2. 글번호를 가지고 오지 않는 경우(신규글)
			if(id != 0) { // 글 번호를 가지고 오는 경우(답변)
//				특정 조건에 step_1로 업데이트
				String updateSql = "update QNA set q_step=q_step + 1 where q_ref=? and q_step > ?";
				pstmt = conn.prepareStatement(updateSql);
				pstmt.setInt(1, ref);
				pstmt.setInt(2, step);
				re = pstmt.executeUpdate();
				
				step = step + 1;
				level = level + 1;
			}else {	//글번호를 가지고 오지 않는 경우(신규글)
				ref = number;
				step = 0;
				level = 0;
			}
			
			pstmt = conn.prepareStatement(insertSql);
			pstmt.setString(1, qna.getQ_type());
			pstmt.setString(2, writer_id);
			pstmt.setString(3, qna.getQ_title());
			pstmt.setString(4, qna.getQ_content());
			pstmt.setTimestamp(5, qna.getQ_date());
			pstmt.setString(6, qna.getQ_pwd());
			pstmt.setInt(7, ref);
			pstmt.setInt(8, step);
			pstmt.setInt(9, level);
			pstmt.setString(10, qna.getFileName());
			pstmt.setString(11, qna.getFileRealName());
			pstmt.setInt(12, qna.getFileSize());
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
	
	public ArrayList<QnaBean> qnaList(String pageNumber){
		Connection conn = null;
		Statement stmt = null;
		ResultSet rs = null;
		
		//페이지에 관련된 결과값 받기 위한 참조변수
		ResultSet pageSet = null;
		//게시글 총 개수
		int dbCount = 0;
		int absolutePage = 1;
		
		//q_id, q_type, writer_id, q_title, q_content, q_date, q_pwd, q_ref, q_step, q_level"
        //+ ", fileName, fileRealName, fileSize
		String selectSql = "select q_id, q_type, writer_id, q_title, q_content, to_char(q_date, 'YYYY-MM-DD HH24:MI')"
						 + ", q_pwd, q_ref, q_step, q_level"
						 + ", fileName, fileSize from QNA"
						 + " order by q_ref desc, q_step asc";
		String countSql = "select count(q_id) from QNA";
		ArrayList<QnaBean> qnaList = new ArrayList<QnaBean>();
		
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
			if (dbCount % QnaBean.pageSize == 0) {
//				80/10 = 8페이지
				QnaBean.pageCount = dbCount / QnaBean.pageSize;
			} else {
//				84/10+1 = 9페이지
				QnaBean.pageCount = dbCount / QnaBean.pageSize + 1;
			}
			
			if (pageNumber != null) { //넘겨오는 페이지 번호가 있는 경우
				QnaBean.pageNum = Integer.parseInt(pageNumber);
				//1: 0*10+1=1, 2:1*10+1=11 (1페이지는 1, 2페이지는 11(페이지 기준 게시글))
				absolutePage = (QnaBean.pageNum - 1) * QnaBean.pageSize + 1;
			}
			
			rs = stmt.executeQuery(selectSql);
			
			if(rs.next()) {
				rs.absolute(absolutePage);	//페이지의 기준 게시글 셋팅
				int count = 0;
				
				while(count < QnaBean.pageSize) {	//게시글 개수만큼 반복
					QnaBean qna = new QnaBean();
					
					qna.setQ_id(rs.getInt(1));
					qna.setQ_type(rs.getString(2));
					qna.setWriter_id(rs.getString(3));
					qna.setQ_title(rs.getString(4));
					qna.setQ_content(rs.getString(5));
					Timestamp q_date_from_db=rs.getTimestamp(6);
					qna.setQ_date(q_date_from_db);
					qna.setQ_pwd(rs.getString(7));
					qna.setQ_ref(rs.getInt(8));
					qna.setQ_step(rs.getInt(9));
					qna.setQ_level(rs.getInt(10));
//					여기까지가 1행을 가져와서 저장
					
//					행의 데이터를 ArrayList 에 저장
					qnaList.add(qna);
					
					//페이지 변경시 처리 위한 로직
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
		return qnaList;
	}
	
	public QnaBean getQna(int qid) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		QnaBean qna = null;
		String sql="";
		
		try {
			conn = getConnection();
			
			
			sql = "select q_id, q_type, writer_id, q_title, q_content, to_char(q_date, 'YYYY-MM-DD HH24:MI')"
				+ ", q_pwd, q_ref, q_step, q_level"
				+ ", fileName, fileSize from QNA where q_id=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, qid);
			rs = pstmt.executeQuery();

			if(rs.next()) {
				qna = new QnaBean();
				
				qna.setQ_id(rs.getInt(1));
				qna.setQ_type(rs.getString(2));
				qna.setWriter_id(rs.getString(3));
				qna.setQ_title(rs.getString(4));
				qna.setQ_content(rs.getString(5));
				qna.setQ_date(rs.getTimestamp(6));
				qna.setQ_pwd(rs.getString(7));
				qna.setQ_ref(rs.getInt(8));
				qna.setQ_step(rs.getInt(9));
				qna.setQ_level(rs.getInt(10));
				qna.setFileName(rs.getString(11));
				qna.setFileRealName(rs.getString(12));
				qna.setFileSize(rs.getInt(13));
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
		return qna;
	}
	
	public int deleteQna(int q_id, String q_pwd) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		int re = -1;
		String sql = "select q_pwd from QNA where q_id=?";
		String sqlGotQwd="";
		
		try {
			conn = getConnection();
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, q_id);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {	//비밀번호가 있으면 참
				sqlGotQwd = rs.getString(1);
				if(sqlGotQwd.equals(q_pwd)) {
					sql = "delete from QNA where q_id=?";
					pstmt = conn.prepareStatement(sql);
					pstmt.setInt(1, q_id);
					pstmt.executeUpdate();
					re = 1;
				} else {
					re = 0;
				}
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
	
	public int editQna(QnaBean qna) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		int re = -1; // insert 정상적으로 실행되면 1
//		글번호 최대값+1을 구함 : null 일 때는 1, 아니면 +1
		String selectSql = "select q_pwd from QNA where q_id=?";
		String editSql = "update QNA set q_title=?, q_content=? where q_id=?";
		String sqlGotPwd="";
		
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(selectSql);
			pstmt.setInt(1, qna.getQ_id());
			rs = pstmt.executeQuery();
			
			if(rs.next()) {	//비밀번호가 있으면 참
				sqlGotPwd = rs.getString(1);
				if(sqlGotPwd.equals(qna.getQ_pwd())) {
					pstmt = conn.prepareStatement(editSql);
					pstmt.setString(1, qna.getQ_title());
					pstmt.setString(2, qna.getQ_content());
					pstmt.setInt(3, qna.getQ_id());
					pstmt.executeUpdate();
					re = 1;
				}else {
					re = 0;
				}
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
	
	public QnaBean getFileName(int q_id) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql="";
		QnaBean qna = null;
		
		try {
			conn = getConnection();
			sql = "select fileName, fileRealName from QNA where q_id=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, q_id);
			rs = pstmt.executeQuery();
			
			//첨부파일이 있으면 
			if(rs.next()) {
				qna= new QnaBean();
				
				qna.setFileName(rs.getString(1));
				qna.setFileRealName(rs.getString(2));
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
		return qna;
	}
	
	public String getWriterName(String writer_id) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql="";
		String name="";
		
		try {
			conn = getConnection();
			sql = "select m_name from memberT where m_id=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, writer_id);
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
	
	public String getWriterEmail(String writer_id) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql="";
		String email="";
		
		try {
			conn = getConnection();
			sql = "select email from memberT where m_id=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, writer_id);
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
