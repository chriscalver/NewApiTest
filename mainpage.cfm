<cfif structKeyExists(form, "deleteId")>
    <cfhttp url="https://www.chriscalver.com/ApiTest/api/Pantry/#form.deleteId#" method="delete" result="deleteResult">
        <cfhttpparam type="header" name="accept" value="application/json">
    </cfhttp>
</cfif>
<cfhttp url="https://www.chriscalver.com/ApiTest/api/Pantry" method="get" result="apiResult" />
<cfset apiData = deserializeJSON(apiResult.FileContent) />
<cfoutput>
<script>
window.apiData = #serializeJSON(apiData)#;
</script>
</cfoutput>
<link rel="stylesheet" type="text/css" href="./styles.css">
<cfoutput>
    <h1 class="pantry-header">
    <img src="https://cdn-icons-png.flaticon.com/128/10971/10971657.png" alt="Pantry Icon" class="pantry-header-icon"> 
        PantryPro Database
    </h1>
    <!-- PantryPro API main page -->
    <cfif NOT (isDefined('addResult') AND structKeyExists(addResult, "StatusCode") AND (addResult.StatusCode EQ 200 OR addResult.StatusCode EQ 201))>
        <button id="showFormBtn" class="form-button" style="margin-bottom:15px; margin-left: 40px;">Add New Pantry Item</button>
        <div class="add-item-form-container" style="display:none;" id="formContainer">
            <form method="post" action="mainpage.cfm" class="add-item-form" id="pantryForm" onsubmit="submitPantryForm(event)">
                <!-- Form fields for PantryPro API -->
                <h2>Add new Item</h2>
                <label for="name">Name:</label><br>
                <input type="text" id="name" name="name" required class="form-input" value="<cfif structKeyExists(form, 'name')>#form.name#</cfif>"><br>
                <label for="description">Description:</label><br>
                <input type="text" id="description" name="description" class="form-input" value="<cfif structKeyExists(form, 'description')>#form.description#</cfif>"><br>
                <label for="location">Location:</label><br>
                <input type="text" id="location" name="location" class="form-input" value="<cfif structKeyExists(form, 'location')>#form.location#</cfif>"><br>
                <!-- Image URL input removed; value will be set to 'picture' on submit -->
                <!-- Image Name input removed; value will be set to 'picture' on submit -->
                <label for="size">Size:</label><br>
                <input type="text" id="size" name="size" class="form-input" value="<cfif structKeyExists(form, 'size')>#form.size#</cfif>"><br>
                <!-- Extra Str One and Two inputs removed; value will be set to 'ExStr' on submit -->
                <!-- Is Active input removed; value will be set to '1' on submit -->
                <!-- Extra Int One and Two inputs removed; value will be set to 'ExInt' on submit -->
                <!-- Last Purchase input removed; value will be set to current timestamp on submit -->
                <!-- Last Updated input removed; value will be set to current timestamp on submit -->
                <label for="isHot">Is Hot:</label><br>
                <input type="checkbox" id="isHot" name="isHot" value="true" class="form-input" <cfif structKeyExists(form, 'isHot')>checked</cfif>> <span>Check for True</span><br>
                <button type="submit" class="form-button">Save New Entry</button>
                <button type="button" class="form-button" id="cancelFormBtn" style="margin-left:10px;">Cancel</button>
            </form>
            <script src="mainpage.js"></script>
            <div id="pantry-message" class="pantry-message"></div>
            </form>
        </div>
        <script>
        document.getElementById('showFormBtn').addEventListener('click', function() {
            document.getElementById('formContainer').style.display = 'block';
            this.style.display = 'none';
        });
        document.getElementById('cancelFormBtn').addEventListener('click', function() {
            document.getElementById('formContainer').style.display = 'none';
            document.getElementById('showFormBtn').style.display = 'inline-block';
        });
        </script>
        </div>
    <cfelse>
        <div class="add-item-form-container">
            <form method="post" action="mainpage.cfm" class="add-item-form">
                <!-- Form fields for PantryPro API -->
                <label for="name">Name:</label><br>
                <input type="text" id="name" name="name" required class="form-input" value=""><br>
                <input type="checkbox" id="isHot" name="isHot" value="true" class="form-input"><span>Check for True</span><br>
                <button type="submit" class="form-button">Submit</button>
            </form>
		</div>
        </cfif>

    <!-- Edit form section (not modal) -->
    <div id="editFormSection" class="add-item-form-container" style="display:none; margin-bottom:20px;">
        <form id="editForm">
            <input type="hidden" name="editId" id="editId">
            <h2>Edit Pantry Item</h2>
            <label for="editName">Name:</label><br>
            <input type="text" id="editName" name="editName" class="form-input" required><br>
            <label for="editDescription">Description:</label><br>
            <input type="text" id="editDescription" name="editDescription" class="form-input"><br>
            <label for="editLocation">Location:</label><br>
            <input type="text" id="editLocation" name="editLocation" class="form-input"><br>
            <label for="editSize">Size:</label><br>
            <input type="text" id="editSize" name="editSize" class="form-input"><br>
            <label for="editIsHot">Is Hot:</label>
            <input type="checkbox" id="editIsHot" name="editIsHot" value="true" class="form-input"> <span>Check for True</span><br>
            <label for="editBarcode">Barcode:</label><br>
            <input type="text" id="editBarcode" name="editBarcode" class="form-input"><br>
            <button type="submit" class="form-button">Save Changes</button>
            <button type="button" class="form-button" id="cancelEditBtn">Cancel</button>
        </form>
    </div>


    
    <table id="pantryTable" border="1" cellpadding="5" cellspacing="0">
        <tr>
            <th>ID</th>
            <th>Name</th>
            <th>Description</th>
            <th>Location</th>
            <th>Size</th>
            <th>Is Hot</th>
         <!---    <th>Is Active</th> --->
           <!---  <th>Last Updated</th>
            <th>Last Purchase</th> --->
            <!--- <th>Image Name</th>
            <th>Image URL</th> --->
            <th>Barcode</th>
          <!---   <th>Extra Str Two</th> --->
           <!---  <th>Extra Int One</th>
            <th>Extra Int Two</th> --->
            <th>Actions</th>
        </tr>
        <cfloop array="#apiData#" index="item">
            <tr>
                <td>#item.id#</td>
                <td>#item.name#</td>
                <td>#item.description#</td>
                <td>#item.location#</td>
                <td>#item.size#</td>
                <td>#item.isHot#</td>
             <!---    <td>#item.isActive#</td> --->
              <!---   <td>#item.lastUpdated#</td>
                <td>#item.lastPurchase#</td> --->
               <!---  <td>#item.imageName#</td>
                <td>#item.imageUrl#</td> --->
                <td>#item.extraStrOne#</td>
             <!---    <td>#item.extraStrTwo#</td> --->
               <!---  <td>#item.extraIntOne#</td>
                <td>#item.extraIntTwo#</td> --->
                <td>
                    <form method="post" action="mainpage.cfm" style="display:inline;">
                        <input type="hidden" name="deleteId" value="#item.id#">
                        <button type="submit" class="form-button delete-button" onclick="return confirm('Are you sure you want to delete this item?');">Delete</button>
                        <button type="button" class="form-button edit-button" style="margin-left:6px;" onclick="showEditForm(#item.id#)">Edit</button>
<script src="mainpage.js"></script>
                    </form>
                </td>
            </tr>
        </cfloop>
    </table>

</cfoutput>
<!-- Footer: affixed to bottom of viewport -->
<div class="footer-affix">
    Powered by ColdFusion<br>
    <img src="https://cdn-icons-png.flaticon.com/512/5968/5968705.png" alt="ColdFusion Logo" class="cf-logo">
</div>