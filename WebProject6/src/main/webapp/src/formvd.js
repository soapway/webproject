function checkForm(){
	const form = document.getElementById("newWrite")
	const title = form.elements['title'].value.trim();
	if(!title){
		alert("enter title");
		return false;
	}
}
