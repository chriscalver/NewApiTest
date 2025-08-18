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
    // Assign edit form submit handler
    var editForm = document.getElementById('editForm');
    if (editForm) {
        editForm.onsubmit = function(e) {
            e.preventDefault();
            var id = document.getElementById('editId').value;
            var name = document.getElementById('editName').value;
            var description = document.getElementById('editDescription').value;
            var location = document.getElementById('editLocation').value;
            var size = document.getElementById('editSize').value;
            var isHot = document.getElementById('editIsHot').checked;
            var barcode = document.getElementById('editBarcode').value;
            // Build payload with mock data for missing fields
            var now = new Date().toISOString();
            var payload = {
                id: Number(id),
                name: name,
                description: description,
                location: location,
                imageUrl: "string",
                imageName: "string",
                size: size,
                extraStrOne: barcode,
                extraStrTwo: "string",
                isActive: 0,
                extraIntOne: 0,
                extraIntTwo: 0,
                lastPurchase: now,
                lastUpdated: now,
                isHot: isHot
            };
            var proxyUrl = 'http://localhost:3000/proxy?url=' + encodeURIComponent('https://www.chriscalver.com/ApiTest/api/Pantry?id=' + id);
            var xhr = new XMLHttpRequest();
            xhr.open('POST', proxyUrl, true);
            xhr.setRequestHeader('accept', '*/*');
            xhr.setRequestHeader('Content-Type', 'application/json');
            xhr.setRequestHeader('X-HTTP-Method-Override', 'PUT');
            xhr.onload = function() {
                if (xhr.status === 200) {
                    alert('Pantry Item updated successfully.');
                    window.location.reload();
                } else {
                    alert('Failed to update Pantry Item.');
                }
            };
            xhr.send(JSON.stringify(payload));
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
