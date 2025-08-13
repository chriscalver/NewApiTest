function submitPantryForm(e) {
    e.preventDefault();
    var form = document.getElementById('pantryForm');
    var formData = new FormData(form);
    var xhr = new XMLHttpRequest();
    xhr.open('POST', 'mainpage.cfm', true);
    xhr.onload = function() {
        if (xhr.status === 200 || xhr.status === 201) {
            alert('Pantry Item was successfully added.');
            window.location.reload();
        } else {
            document.getElementById('pantry-message').innerHTML = 'Pantry Item was NOT added.';
        }
    };
    xhr.send(formData);
}
