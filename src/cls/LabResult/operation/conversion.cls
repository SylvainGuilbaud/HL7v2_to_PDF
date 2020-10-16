Class LabResult.operation.conversion Extends Ens.BusinessOperation
{

Parameter ADAPTER = "EnsLib.File.OutboundAdapter";

Property Adapter As EnsLib.File.OutboundAdapter;

Parameter INVOCATION = "Queue";

Property PDFgenerator As %String(DISPLAYLIST = ",wk<html>ToPDF,Google Chrome", VALUELIST = ",1,2") [ InitialExpression = 1 ];

Parameter SETTINGS = "PDFgenerator:PDFconversion";

XData MessageMap
{
<MapItems>
    <MapItem MessageType="LabResult.msg.request">
        <Method>toPDF</Method>
    </MapItem>
</MapItems>
}

Method outOfRange(val As %String, range As %String) As %Boolean
{
	set result=0
	set val=$num(val)
	set min=$num($piece(range,"-",1))
	set max=$num($piece(range,"-",2))
	set:(val<min)||(val>max) result=1
	return result
}

Method getDate(val As %String, format As %Integer = 3) As %String
{
	set result=val
	if $length(val)>8 {
		set result=$zdt($zdth($extract(val,1,8)_" "_$extract(val,9,10)_":"_$extract(val,11,12),8,2),format)
	} else {
		set result=$zd($zdh(val,8),format)
	}
	return result
}

Method toPDF(pInput As LabResult.msg.request, Output pOutput As Ens.StringResponse) As %Status
{
	set sc=$$$OK
	
	set pOutput=##class(Ens.StringResponse).%New()	
	set filename=$replace(pInput.PatientID_"-"_pInput.OrderNumber,"^","-")
	set date=$tr($zdt($h,3)," :","__")_"_"
	set HTML=date_filename_".html"
	set:..PDFgenerator=1 PDF="wkhtmltopdf_"_date_filename_".pdf"
	set:..PDFgenerator=2 PDF="Chrome_"_date_filename_".pdf"
	
	do ..Adapter.PutLine(HTML,"<html>")
	do ..Adapter.PutLine(HTML,"<body>")
	do ..Adapter.PutLine(HTML,"<div align=""center"">")
	do ..Adapter.PutLine(HTML,"<h1 style=""color: #29088A;"">Résultat de Laboratoire de "_filename_"</h1>")
	do ..Adapter.PutLine(HTML,"<hr>")
	do ..Adapter.PutLine(HTML,"</div>")
	do ..Adapter.PutLine(HTML,"<h2 style=""color: #29088A;"">"_ $tr(pInput.UniversalService,"^","-") _"</h2>")
	do ..Adapter.PutLine(HTML,"<h3>Date du Résultat: "_ ..getDate(pInput.ObservationDateTime,4) _"</h3>")
	do ..Adapter.PutLine(HTML,"<ul>")
	do ..Adapter.PutLine(HTML,"<li>IPP:</u>"_pInput.PatientID _"</li>")
	do ..Adapter.PutLine(HTML,"<li>Nom Patient:</u>"_pInput.FamilyName_" "_pInput.GivenName _"</li>")
	do ..Adapter.PutLine(HTML,"<li>Né(e) le:</u>"_..getDate(pInput.DOB,4)_"</li>")
	do ..Adapter.PutLine(HTML,"<li>Adresse:</u>"_$replace(pInput.Address,"^"," ") _"</li>")
	do ..Adapter.PutLine(HTML,"</ul>")
	do ..Adapter.PutLine(HTML,"<table border=""1"">")
	do ..Adapter.PutLine(HTML,"<thead>")
	do ..Adapter.PutLine(HTML,"<tr>")
	do ..Adapter.PutLine(HTML,"<th>Test</th>")
	do ..Adapter.PutLine(HTML,"<th>Résultat</th>")
	do ..Adapter.PutLine(HTML,"<th>Unité</th>")
	do ..Adapter.PutLine(HTML,"<th>Valeurs de références</th>")
	do ..Adapter.PutLine(HTML,"<th>Date Observation</th>")
	do ..Adapter.PutLine(HTML,"</tr>")
	do ..Adapter.PutLine(HTML,"</thead>")
	do ..Adapter.PutLine(HTML,"<tbody>")
	for i=1:1:pInput.OBX.Count() {
		do ..Adapter.PutLine(HTML,"<tr>")
	    do ..Adapter.PutLine(HTML,"<td>"_$replace(pInput.OBX.GetAt(i).ObservationIdentifier,"^","-") _"</td>")
	    set val=pInput.OBX.GetAt(i).ObservationValue
	    set range=pInput.OBX.GetAt(i).ReferencesRange
	    set outOfRange=..outOfRange(val,range)
	    do:'outOfRange ..Adapter.PutLine(HTML,"<td style=""color: #31B404;"">"_val _"</td>")
	    do:outOfRange ..Adapter.PutLine(HTML,"<td style=""color: #FF0000;"">"_val _"</td>")
	    do ..Adapter.PutLine(HTML,"<td>"_pInput.OBX.GetAt(i).Unit _"</td>")
	    do ..Adapter.PutLine(HTML,"<td>"_range_"</td>")
	    do ..Adapter.PutLine(HTML,"<td>"_..getDate(pInput.OBX.GetAt(i).ObservationDateTime,3) _"</td>")
	    do ..Adapter.PutLine(HTML,"</tr>")
	}
	do ..Adapter.PutLine(HTML,"</tbody>")
	do ..Adapter.PutLine(HTML,"</table>")
	do ..Adapter.PutLine(HTML,"<ul>")
	do ..Adapter.PutLine(HTML,"<li>Examen prescrit par:</u> CARL STRANGE MD</li>")
	do ..Adapter.PutLine(HTML,"</ul>")
	do ..Adapter.PutLine(HTML,"</body>")
	do ..Adapter.PutLine(HTML,"</html>")
	
	set html=..Adapter.FilePath_"/"_HTML
	set pdf=..Adapter.FilePath_"/"_PDF
	if ..PDFgenerator=1 {
		set command="wkhtmltopdf" 
		set flags="/LOGCMD"
		set args=4
		set args(1)="--footer-center"
		set args(2)="[page]/[topage]"
		set args(3)=html
		set args(4)=pdf
	}
	if ..PDFgenerator=2 {
		if $system.Version.GetPlatform()["Apple" {
			set chrome="/Applications/Google\ Chrome.app/Contents/MacOS/Google\ Chrome"
		}
		if $system.Version.GetPlatform()["Windows" {
			set chrome="C:\Program Files (x86)\Google\Chrome\Application\chrome.exe"
		}
		set command=chrome
		set flags="/LOGCMD /NOQUOTE /SHELL"
		set args=3
		set args(1)="--headless"
		set args(2)="--disable-gpu"
		set args(3)="--print-to-pdf="_pdf_" "_html
		#; set args(4)=html		
	}
	set pdfResult=$zf(-100,flags,command,.args) 
	set pOutput.StringValue=command_"("_pdfResult_")"
	$$$TRACE(pOutput.StringValue)
	
	// Chrome génère des fichiers avec les permissions 600 (-rw-------)
	if (..PDFgenerator=2) && ($system.Version.GetOS()="UNIX") {
		set command="chmod"
		set flags="/LOGCMD"
		set args=2
		set args(1)=644
		set args(2)=pdf
		set chmodResult=$zf(-100,flags,command,.args) 
		$$$TRACE(command_"("_chmodResult_")")
	}
	return sc
}

}
