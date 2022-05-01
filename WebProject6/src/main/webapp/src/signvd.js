
const id = document.getElementById("id");
const regExpId = /^[a-zA-Z0-9]/;

function checkForm() {
    if (!regExpId.test(id.values.toString)) {
        alert("id: use only english letters and numbers");
        id.focus();
        id.select();
        return false;
    }
}