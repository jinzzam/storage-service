package qna;

import java.sql.Date;
import java.sql.Timestamp;

public class QnaBean {
	private int q_id;
	private String q_type;
	private String writer_id;
	private String q_title;
	private String q_content;
	private Timestamp q_date;
	private String q_pwd;
	private int q_ref=0;
	private int q_step=0;
	private int q_level=0;
	
	private String fileName;
	private String fileRealName;
	private int fileSize;
	
	public static int pageSize = 10;	//한 페이지당 10개 출력물
	public static int pageCount = 1;	//페이지 개수 지정 변수
	public static int pageNum = 1;	//페이지 번호
	//리턴 : [이전] + 페이지번호 + [다음]
	// limit 페이지 화면 출력 갯수 (pdf는 4개씩)
	public static String pageNumber(int limit) {
		String str = "";
		int temp = (pageNum - 1) % limit;
		int startPage = pageNum - temp;
		
		//[이전] 출력 여부
		if((startPage - limit) > 0) {
			str = "<a href='list.jsp?pageNum="+(startPage - 1) +"'>[이전]</a>&nbsp;&nbsp;";
		}
		
		//페이지 번호 나열하기
		for (int i = startPage; i < (startPage + limit); i++) {
			if(i == pageNum) {
				str += "<a href='list.jsp?pageNum="+i+"'>"+"{"+i+"}</a>&nbsp;&nbsp;";	//현제 페이지
			}else {
				str += "<a href='list.jsp?pageNum="+i+"'>"+"["+i+"]</a>&nbsp;&nbsp;";
			}
			if(i >= pageCount) break;
		}
		
		//[다음] 출력 여부
		if((startPage + limit) <= pageCount) {
			str += "<a href='list.jsp?pageNum="+(startPage + limit) +"'>[다음]</a>";
		}
		
		return str;
	}
	
	
	public Timestamp getQ_date() {
		return q_date;
	}
	public void setQ_date(Timestamp q_date) {
		this.q_date = q_date;
	}
	public int getQ_id() {
		return q_id;
	}
	public void setQ_id(int q_id) {
		this.q_id = q_id;
	}
	public String getQ_type() {
		return q_type;
	}
	public void setQ_type(String q_type) {
		this.q_type = q_type;
	}
	public String getWriter_id() {
		return writer_id;
	}
	public void setWriter_id(String writer_id) {
		this.writer_id = writer_id;
	}
	public String getQ_title() {
		return q_title;
	}
	public void setQ_title(String q_title) {
		this.q_title = q_title;
	}
	public String getQ_content() {
		return q_content;
	}
	public void setQ_content(String q_content) {
		this.q_content = q_content;
	}
	
	public String getQ_pwd() {
		return q_pwd;
	}
	public void setQ_pwd(String q_pwd) {
		this.q_pwd = q_pwd;
	}
	public int getQ_ref() {
		return q_ref;
	}
	public void setQ_ref(int q_ref) {
		this.q_ref = q_ref;
	}
	public int getQ_step() {
		return q_step;
	}
	public void setQ_step(int q_step) {
		this.q_step = q_step;
	}
	public int getQ_level() {
		return q_level;
	}
	public void setQ_level(int q_level) {
		this.q_level = q_level;
	}
	public String getFileName() {
		return fileName;
	}
	public void setFileName(String fileName) {
		this.fileName = fileName;
	}
	public String getFileRealName() {
		return fileRealName;
	}
	public void setFileRealName(String fileRealName) {
		this.fileRealName = fileRealName;
	}
	public int getFileSize() {
		return fileSize;
	}
	public void setFileSize(int fileSize) {
		this.fileSize = fileSize;
	}
	
	
	
}
