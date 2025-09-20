package member;

public class ManagerBean extends MemberBean{
	private String m_company;
		
	public String getM_company() {
		return m_company;
	}
	public void setM_company(String m_company) {
		this.m_company = m_company;
	}
	
	public ManagerBean(MemberBean member) {
		super(member);
	}
	public ManagerBean() {
		super();
	}
	
}
