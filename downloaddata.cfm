<cfoutput>
    <cfscript> 
        //FILE NAME
        fileName="yourexcelfile.xlsx" 
        // PATH OF FILE
        theFile=#expandPath(fileName)#; 

        // COPY FILE HEADER (FILE FIELDS) FROM FILE AND PAGE HERE AND ADD COMMA(,) AMONG THEM
        fileFields="UPC Barcode without checkdigit,	12 digit UPC Number,Assignee, Item Code,	Description,	Dealer Price,
                    MSRP,	No Longer Available,	Case Qty,	Image URL,	Web Copy";

        //REPLACE / TO SPACE FROM LIST WORDS
        fileFields=trim(reReplace(fileFields, "/", " ", "all"))
        //REMOVE ALL SPACES FROM LIST WORDS
        fileFields = reReplace(fileFields, "[ _]+", "", "all");
    </cfscript>

    <!--- HEADER FIELDS IN THE ROW --->
    <cfset headerRow="1" />
    <!--- DATA STARTs FROM ROW AND MAX DATA ROW NUMBER--->
    <cfset dataRows="2-10000" />

    <!--- READ XLSX FILE AND GET DATA --->
    <cfspreadsheet action="read" src="#theFile#" excludeHeaderRow="true" headerrow=#headerRow# rows=#dataRows#  query="fileData" 
        columnnames=#fileFields# 
    /> 

    <!--- REMOVE LINE BREAKS FROM FIELDS LIST --->
    <cfset fileFields = reReplace(fileFields,"\s","","ALL")>
    <!--- lIST TO ARRAY FIELDS --->
    <cfset fieldsArray = listToArray (fileFields, ",",false,false)>
    <!----- LOOP THROUGH DATA---->
    <cfset counter=0>
    <cfloop query="fileData"> 
        <cfset counter=counter+1>
        <cfif ItemCode neq ''>
            <!---STRUCT FOR DATA HOLDING---->
            <cfset data=structnew() >
            <!---SET VALUES IN STRUCT VARIABLES---->
            <cfloop array="#fieldsArray#" index="field">
                <cfset data[field]  =  "#fileData['#field#']#">
            </cfloop>
        </cfif>
        <!---DUMP STRUCT DATA--->
        <cfdump var="#data#" >
    </cfloop>
</cfoutput>
