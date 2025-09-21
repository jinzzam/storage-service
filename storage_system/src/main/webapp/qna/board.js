/**
 * 
 */

function check_ok(){

	if(write_frm.b_title.value == ""){
		alert("제목을 써주세요");
		write_frm.title.focus;
		return;
	}
	if(write_frm.content.value == ""){
		alert("내용을 써주세요");
		write_frm.content.focus;
		return;
	}
	if(write_frm.pwd.value == ""){
		alert("비밀번호를 써주세요");
		write_frm.pwd.focus;
		return;
	}

	document.write_frm.submit();
};


function delete_ok(){
	if(del_frm.pwd.value == ""){
			alert("비밀번호를 써주세요");
			del_frm.pwd.focus;
			return;
	}
	document.del_frm.submit();
};