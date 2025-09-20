package member;

public class MemberBean {
	private String u_id;
	private String u_pwd;
	private String u_name;
	private String u_email;
	private String u_address;
	private String u_phone;
	
	
	public MemberBean(MemberBean member) {
		this.u_id = member.u_id;
		this.u_pwd = member.u_pwd;
		this.u_name = member.u_name;
		this.u_email = member.u_email;
		this.u_address = member.u_address;
		this.u_phone = member.u_phone;
	}
	
	public MemberBean() {
		
	}
	
	public String getU_id() {
		return u_id;
	}
	public void setU_id(String u_id) {
		this.u_id = u_id;
	}
	public String getU_pwd() {
		return u_pwd;
	}
	public void setU_pwd(String u_pwd) {
		this.u_pwd = u_pwd;
	}
	public String getU_name() {
		return u_name;
	}
	public void setU_name(String u_name) {
		this.u_name = u_name;
	}
	public String getU_email() {
		return u_email;
	}
	public void setU_email(String u_email) {
		this.u_email = u_email;
	}
	public String getU_address() {
		return u_address;
	}
	public void setU_address(String u_address) {
		this.u_address = u_address;
	}
	public String getU_phone() {
		return u_phone;
	}
	public void setU_phone(String u_phone) {
		this.u_phone = u_phone;
	}

	
}
