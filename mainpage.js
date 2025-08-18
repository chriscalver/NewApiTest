// Show/hide edit form logic
function showEditForm(id) {
    var items = window.apiData || [];
    var item = items.find(function(i) { return i.id == id; });
    if (!item) return;
    document.getElementById('editId').value = item.id;
    document.getElementById('editName').value = item.name;
    document.getElementById('editDescription').value = item.description;
    document.getElementById('editLocation').value = item.location;
    document.getElementById('editSize').value = item.size;
    document.getElementById('editIsHot').checked = item.isHot == true || item.isHot == "true";
    document.getElementById('editBarcode').value = item.extraStrOne || "";
    document.getElementById('editFormSection').style.display = 'block';
    document.getElementById('pantryTable').style.display = 'none';
    document.getElementById('showFormBtn').style.display = 'none';
}
document.addEventListener('DOMContentLoaded', function() {
    var cancelBtn = document.getElementById('cancelEditBtn');
    if (cancelBtn) {
        cancelBtn.onclick = function() {
            document.getElementById('editFormSection').style.display = 'none';
            document.getElementById('pantryTable').style.display = '';
            document.getElementById('showFormBtn').style.display = 'inline-block';
        };
    }
});
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
