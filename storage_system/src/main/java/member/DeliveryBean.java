package member;

public class DeliveryBean extends MemberBean{
	private String d_company;

	public String getD_company() {
		return d_company;
	}
	public void setd_company(String d_company) {
		this.d_company = d_company;
	}
	
	public DeliveryBean(MemberBean member) {
		super(member);
	}
	public DeliveryBean() {
		super();
	}
	

}
