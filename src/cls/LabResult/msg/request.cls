Class LabResult.msg.request Extends Ens.Request
{

Property PatientID As %String;

Property FamilyName As %String;

Property GivenName As %String;

Property DOB As %String;

Property Address As %String;

Property OrderNumber As %String;

Property UniversalService As %String;

Property ObservationDateTime As %String;

Property OrderingProviderID As %String;

Property OrderingProviderName As %String;

Property OBX As list Of LabResult.msg.request.OBX;

Storage Default
{
<Data name="requestDefaultData">
<Subscript>"request"</Subscript>
<Value name="1">
<Value>PatientID</Value>
</Value>
<Value name="2">
<Value>FamilyName</Value>
</Value>
<Value name="3">
<Value>GivenName</Value>
</Value>
<Value name="4">
<Value>DOB</Value>
</Value>
<Value name="5">
<Value>Address</Value>
</Value>
<Value name="6">
<Value>OrderNumber</Value>
</Value>
<Value name="7">
<Value>UniversalService</Value>
</Value>
<Value name="8">
<Value>ObservationDateTime</Value>
</Value>
<Value name="9">
<Value>OrderingProviderID</Value>
</Value>
<Value name="10">
<Value>OrderingProviderName</Value>
</Value>
<Value name="11">
<Value>OBX</Value>
</Value>
</Data>
<DefaultData>requestDefaultData</DefaultData>
<Type>%Storage.Persistent</Type>
}

}
