<%@page import="member.MemberBean"%>
<%@page import="member.MemberDBBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
request.setCharacterEncoding("UTF-8");

// Get the updated values from the form submission
String id = request.getParameter("id");
String m_name = request.getParameter("m_name");
String email = request.getParameter("email");
String phone = request.getParameter("phone");
String address = request.getParameter("address");
String company = request.getParameter("company");

// Get the original member data from the database
MemberDBBean db = MemberDBBean.getInstance();
MemberBean originalMember = new MemberBean();
originalMember = db.getMember(id);

// **Critical Fix: Add a null check for originalMember**
if (originalMember == null) {
    // Handle the error case. The member doesn't exist.
    out.println("<script>alert('회원 정보가 존재하지 않습니다.'); history.back();</script>");
    return; // Stop further execution of the page
}

// Create a new MemberBean object with the updated information
MemberBean updatedMember = new MemberBean();
updatedMember.setM_id(id);
updatedMember.setM_name(m_name);
updatedMember.setEmail(email);
updatedMember.setPhone(phone);
updatedMember.setAddress(address);
updatedMember.setCompany(company); // This will be null if not a manager/delivery type

// Set the password and member type from the original member data
// since they are not being updated on this form
updatedMember.setPwd(originalMember.getPwd());
updatedMember.setM_type(originalMember.getM_type());

// Call the update method
int result = db.updateMember(updatedMember);

if (result == 1) {
    // Redirect to the main page or a success page
    response.sendRedirect("main.jsp?id="+id);
} else {
    // Handle error
    out.println("<script>alert('회원 정보 수정에 실패했습니다.'); history.back();</script>");
}
%>