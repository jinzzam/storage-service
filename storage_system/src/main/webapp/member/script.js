/**
 * 
 */


function check_ok(){
	if(reg_frm.mem_uid.value == "") {
		alert("아이디를 써주세요.");
		reg_frm.mem_uid.focus();
		return;	
	}
	if(reg_frm.mem_uid.value.length < 4) {
		alert("아이디는 4글자 이상이어야 합니다.");
		reg_frm.mem_uid.focus();
		return;	
	}
	if(reg_frm.mem_pwd.value.length < 4) {
		alert("패스워드는 4글자 이상이어야 합니다.");
		reg_frm.mem_pwd.focus();
		return;	
	}
	if(reg_frm.mem_pwd.value != reg_frm.mem_pwd2.value) {
		alert("패스워드가 일치하지 않습니다.");
		reg_frm.mem_pwd2.focus();
		return;	
	}
	if(reg_frm.mem_name.value.length == 0) {
		alert("이름을 써주세요.");
		reg_frm.mem_name.focus();
		return;	
	}
	if(reg_frm.mem_email.value.length == 0) {
		alert("Email을 써주세요.");
		reg_frm.mem_email.focus();
		return;	
	}
	if(reg_frm.mem_phone.value.length == 0) {
		alert("연락처를 써주세요.");
		reg_frm.mem_phone.focus();
		return;	
	}
	if(reg_frm.mem_address.value.length == 0) {
		alert("주소를 써주세요.");
		reg_frm.mem_address.focus();
		return;	
	}
	
	//회원가입 성공 시
	// 폼이름이 reg_frm 에서 action 속성의 파일을 호출
	document.reg_frm.submit();
};
	

function update_check_ok(){
	if(modi_frm.mem_pwd.value.length == 0) {
			alert("패스워드는 반드시 입력해야 합니다.");
			modi_frm.mem_pwd.focus();
			return;	
	}
	if(modi_frm.mem_pwd.value != modi_frm.mem_pwd2.value) {
			alert("패스워드가 일치하지 않습니다.");
			modi_frm.mem_pwd2.focus();
			return;	
	}
	
	document.modi_frm.submit();
}	
	