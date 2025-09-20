/**
 * 
 */

//var mem_uid = document.getElementById("mem_uid");
//var mem_pwd = document.getElementById("mem_pwd");
//var mem_pwd2 = document.getElementById("mem_pwd2");
//var mem_name = document.getElementById("mem_name");
//var mem_email = document.getElementById("mem_email");

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
	if(reg_frm.mem_pwd.value.length == 0) {
		alert("패스워드는 반드시 입력해야 합니다.");
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
	if(modi_frm.mem_email.value.length == 0) {
			alert("Email을 써주세요.");
			modi_frm.mem_email.focus();
			return;	
	}
	document.modi_frm.submit();
}	
	
	
//	if(mem_uid == null)	;
//	else if(length(mem_uid) < 4)	alert("아이디는 4글자 이상이어야 합니다.");
//	else if(mem_pwd == null)	alert("패스워드는 반드시 입력해야 합니다.");
//	else if(mem_pwd != mem_pwd2)	alert("패스워드가 일치하지 않습니다.");
//	else if(mem_name == null)	alert("이름을 써주세요.");
//	else if(mem_email == null)	alert("Email을 써주세요.");
//	else alert("회원 가입을 축하드립니다.");
//};