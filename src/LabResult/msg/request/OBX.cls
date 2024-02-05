Class LabResult.msg.request.OBX Extends (%SerialObject, %XML.Adaptor)
{

Property ObservationIdentifier As %String;

Property ObservationValue As %String;

Property Unit As %String;

Property ReferencesRange As %String;

Property ObservationDateTime As %String;

Storage Default
{
<Data name="OBXState">
<Value name="1">
<Value>ObservationIdentifier</Value>
</Value>
<Value name="2">
<Value>ObservationValue</Value>
</Value>
<Value name="3">
<Value>Unit</Value>
</Value>
<Value name="4">
<Value>ReferencesRange</Value>
</Value>
<Value name="5">
<Value>ObservationDateTime</Value>
</Value>
</Data>
<State>OBXState</State>
<StreamLocation>^LabResult.msg.request.OBXS</StreamLocation>
<Type>%Storage.Serial</Type>
}

}
