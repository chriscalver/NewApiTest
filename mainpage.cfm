<cfhttp url="https://www.chriscalver.com/ApiTest/api/Pantry" method="get" result="apiResult" />
<cfset apiData = deserializeJSON(apiResult.FileContent) />
<link rel="stylesheet" type="text/css" href="./styles.css">
<cfoutput>
    <h1 style="display: flex; align-items: center; justify-content: center; gap: 10px;">
        <img src="https://cdn-icons-png.flaticon.com/64/2721/2721306.png" alt="Database Icon" style="width:96px;height:96px;vertical-align:middle;"> 
        PantryPro Database
    </h1>
    <!-- PantryPro API main page -->
    <div class="add-item-form-container">
        <form method="post" action="mainpage.cfm" class="add-item-form">
            <!-- Form fields for PantryPro API -->
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
            <button type="submit" class="form-button">Preview Payload</button>
        </form>
    </div>
    <cfif structKeyExists(form, "name")>
        <cfset isHotValue = structKeyExists(form, "isHot")>
        <cfset isHotJson = isHotValue ? "true" : "false">
        <cfset now = now()>
        <cfset datestamp = dateFormat(now, "yyyy-mm-dd") & "T" & timeFormat(now, "HH:mm:ss.l")>
        <cfset apiPayload = '{'
            & '"id": 0,'
            & '"name": "#form.name#",'
            & '"description": "#form.description#",'
            & '"location": "#form.location#",'
            & '"imageUrl": "picture",'
            & '"imageName": "picture",'
            & '"size": "#form.size#",'
            & '"extraStrOne": "ExStr",'
            & '"extraStrTwo": "ExStr",'
            & '"isActive": "1",'
            & '"extraIntOne": 1,'
            & '"extraIntTwo": 1,'
            & '"lastPurchase": "#datestamp#",'
            & '"lastUpdated": "#datestamp#",'
            & '"isHot": #isHotJson#'
        & '}'>
        <cfhttp url="https://www.chriscalver.com/ApiTest/api/Pantry" method="post" result="addResult">
            <cfhttpparam type="header" name="accept" value="text/plain">
            <cfhttpparam type="header" name="Content-Type" value="application/json">
            <cfhttpparam type="body" value="#apiPayload#">
        </cfhttp>
        <div class="api-block">
            <strong>JSON Payload Sent:</strong>
            <pre class="api-json">#apiPayload#</pre>
        </div>
        <cfif addResult.StatusCode NEQ 200>
            <div style="color: red; font-weight: bold; font-size: 1.2em; margin-bottom: 10px;">
                API Error (#addResult.StatusCode#):<br>#addResult.FileContent#
            </div>
        </cfif>
        <div class="api-block">
            <strong>Raw API Response:</strong>
            <pre class="api-response">#addResult.FileContent#</pre>
        </div>
        <cfif addResult.StatusCode EQ 200>
            <cfhttp url="https://www.chriscalver.com/ApiTest/api/Pantry" method="get" result="apiResultAfterPost" />
            <cfset apiDataAfterPost = deserializeJSON(apiResultAfterPost.FileContent) />
            <h2>Updated API Data</h2>
            <table border="1" cellpadding="5" cellspacing="0" style="margin-top:20px;">
                <tr>
                    <th>ID</th>
                    <th>Name</th>
                    <th>Description</th>
                    <th>Location</th>
                    <th>Size</th>
                    <th>Is Hot</th>
                    <th>Is Active</th>
                    <th>Last Updated</th>
                    <th>Last Purchase</th>
                    <th>Image Name</th>
                    <th>Image URL</th>
                    <th>Extra Str One</th>
                    <th>Extra Str Two</th>
                    <th>Extra Int One</th>
                    <th>Extra Int Two</th>
                </tr>
                <cfloop array="#apiDataAfterPost#" index="item">
                    <tr>
                        <td>#item.id#</td>
                        <td>#item.name#</td>
                        <td>#item.description#</td>
                        <td>#item.location#</td>
                        <td>#item.size#</td>
                        <td>#item.isHot#</td>
                        <td>#item.isActive#</td>
                        <td>#item.lastUpdated#</td>
                        <td>#item.lastPurchase#</td>
                        <td>#item.imageName#</td>
                        <td>#item.imageUrl#</td>
                        <td>#item.extraStrOne#</td>
                        <td>#item.extraStrTwo#</td>
                        <td>#item.extraIntOne#</td>
                        <td>#item.extraIntTwo#</td>
                    </tr>
                </cfloop>
            </table>
        </cfif>
    </cfif>

    
    <table border="1" cellpadding="5" cellspacing="0">
    
        <tr>
            <th>ID</th>
            <th>Name</th>
            <th>Description</th>
            <th>Location</th>
            <th>Size</th>
            <th>Is Hot</th>
            <th>Is Active</th>
            <th>Last Updated</th>
            <th>Last Purchase</th>
            <th>Image Name</th>
            <th>Image URL</th>
            <th>Extra Str One</th>
            <th>Extra Str Two</th>
            <th>Extra Int One</th>
            <th>Extra Int Two</th>
        </tr>
        <cfloop array="#apiData#" index="item">
            <tr>
                <td>#item.id#</td>
                <td>#item.name#</td>
                <td>#item.description#</td>
                <td>#item.location#</td>
                <td>#item.size#</td>
                <td>#item.isHot#</td>
                <td>#item.isActive#</td>
                <td>#item.lastUpdated#</td>
                <td>#item.lastPurchase#</td>
                <td>#item.imageName#</td>
                <td>#item.imageUrl#</td>
                <td>#item.extraStrOne#</td>
                <td>#item.extraStrTwo#</td>
                <td>#item.extraIntOne#</td>
                <td>#item.extraIntTwo#</td>
            </tr>
        </cfloop>
    </table>
</cfoutput>
