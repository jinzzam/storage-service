package storage;

public class StoredItemsBean {
	private String item_id;
	private String item_name;
	private int item_weight;
	private String s_id;
	private String stored_date;
	private String expire_date;
	
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
	public String getItem_id() {
		return item_id;
	}
	public void setItem_id(String item_id) {
		this.item_id = item_id;
	}
	public String getItem_name() {
		return item_name;
	}
	public void setItem_name(String item_name) {
		this.item_name = item_name;
	}
	public int getItem_weight() {
		return item_weight;
	}
	public void setItem_weight(int item_weight) {
		this.item_weight = item_weight;
	}
	public String getS_id() {
		return s_id;
	}
	public void setS_id(String s_id) {
		this.s_id = s_id;
	}
	public String getStored_date() {
		return stored_date;
	}
	public void setStored_date(String stored_date) {
		this.stored_date = stored_date;
	}
	public String getExpire_date() {
		return expire_date;
	}
	public void setExpire_date(String expire_date) {
		this.expire_date = expire_date;
	}
	
}
