/**
 * 
 */

function check_ok(){
//	if(write_frm.b_name.value.length == 0){
	if(write_frm.b_name.value.length == 0){
		alert("작성자 이름을 써주세요");
		write_frm.b_name.focus;
		return;
	}
	if(write_frm.b_title.value == ""){
		alert("제목을 써주세요");
		write_frm.b_title.focus;
		return;
	}
	if(write_frm.b_content.value == ""){
		alert("내용을 써주세요");
		write_frm.b_content.focus;
		return;
	}
	if(write_frm.b_pwd.value == ""){
		alert("비밀번호를 써주세요");
		write_frm.b_pwd.focus;
		return;
	}

	document.write_frm.submit();
};


function delete_ok(){
	if(d_frm.b_pwd.value == ""){
			alert("비밀번호를 써주세요");
			d_frm.b_pwd.focus;
			return;
	}
	document.d_frm.submit();
};