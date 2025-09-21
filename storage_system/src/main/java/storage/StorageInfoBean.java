package storage;

public class StorageInfoBean {
	private String s_id;
	private String m_id;
	private String s_name;
	private int s_max;
	private String s_location;
	private String s_address;
	private String company_id;
	
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
	
	
	
	public String getS_location() {
		return s_location;
	}
	public void setS_location(String s_location) {
		this.s_location = s_location;
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

	public String getS_name() {
		return s_name;
	}
	public void setS_name(String s_name) {
		this.s_name = s_name;
	}
	public String getS_id() {
		return s_id;
	}
	public void setS_id(String s_id) {
		this.s_id = s_id;
	}
	public String getM_id() {
		return m_id;
	}
	public void setM_id(String m_id) {
		this.m_id = m_id;
	}
	public int getS_max() {
		return s_max;
	}
	public void setS_max(int s_max) {
		this.s_max = s_max;
	}
	public String getS_address() {
		return s_address;
	}
	public void setS_address(String s_address) {
		this.s_address = s_address;
	}
	public String getCompany_id() {
		return company_id;
	}
	public void setCompany_id(String company_id) {
		this.company_id = company_id;
	}
	
}
