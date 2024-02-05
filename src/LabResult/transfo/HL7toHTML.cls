Class LabResult.transfo.HL7toHTML Extends Ens.DataTransformDTL [ DependsOn = (EnsLib.HL7.Message, LabResult.msg.request) ]
{

Parameter IGNOREMISSINGSOURCE = 1;

Parameter REPORTERRORS = 1;

Parameter TREATEMPTYREPEATINGFIELDASNULL = 0;

XData DTL [ XMLNamespace = "http://www.intersystems.com/dtl" ]
{
<transform sourceClass='EnsLib.HL7.Message' targetClass='LabResult.msg.request' sourceDocType='2.3:ORU_R01' create='new' language='objectscript' >
<foreach property='source.{PIDgrpgrp()}' key='k1' >
<assign value='source.{PIDgrpgrp(k1).PIDgrp.PID:PatientIDInternalID().ID}' property='target.PatientID' action='set' />
<assign value='source.{PIDgrpgrp(k1).PIDgrp.PID:PatientName.familyname}' property='target.FamilyName' action='set' />
<assign value='source.{PIDgrpgrp(k1).PIDgrp.PID:PatientName.givenname}' property='target.GivenName' action='set' />
<assign value='source.{PIDgrpgrp(k1).PIDgrp.PID:DateofBirth}' property='target.DOB' action='set' />
<assign value='source.{PIDgrpgrp(k1).PIDgrp.PID:PatientAddress()}' property='target.Address' action='set' />
<foreach property='source.{PIDgrpgrp(k1).ORCgrp()}' key='k2' >
<assign value='source.{PIDgrpgrp(k1).ORCgrp(k2).OBR:PlacerOrderNumber()}' property='target.OrderNumber' action='set' />
<assign value='source.{PIDgrpgrp(k1).ORCgrp(k2).OBR:UniversalServiceIdentifier}' property='target.UniversalService' action='set' />
<assign value='source.{PIDgrpgrp(k1).ORCgrp(k2).OBR:ObservationDateTime}' property='target.ObservationDateTime' action='set' />
<assign value='source.{PIDgrpgrp(k1).ORCgrp(k2).OBR:OrderingProvider().IDnumberST}' property='target.OrderingProviderID' action='set' />
<assign value='source.{PIDgrpgrp(k1).ORCgrp(k2).OBR:OrderingProvider().givenname}_" "_source.{PIDgrpgrp(k1).ORCgrp(k2).OBR:OrderingProvider().familyname}' property='target.OrderingProviderName' action='set' />
<foreach property='source.{PIDgrpgrp(k1).ORCgrp(k2).OBXgrp()}' key='k3' >
<assign value='source.{PIDgrpgrp(k1).ORCgrp(k2).OBXgrp(k3).OBX:ObservationIdentifier}' property='target.OBX.(k3).ObservationIdentifier' action='set' />
<assign value='source.{PIDgrpgrp(k1).ORCgrp(k2).OBXgrp(k3).OBX:ObservationValue()}' property='target.OBX.(k3).ObservationValue' action='set' />
<assign value='source.{PIDgrpgrp(k1).ORCgrp(k2).OBXgrp(k3).OBX:Units}' property='target.OBX.(k3).Unit' action='set' />
<assign value='source.{PIDgrpgrp(k1).ORCgrp(k2).OBXgrp(k3).OBX:ReferencesRange}' property='target.OBX.(k3).ReferencesRange' action='set' />
<assign value='source.{PIDgrpgrp(k1).ORCgrp(k2).OBXgrp(k3).OBX:DateTimeoftheObservation}' property='target.OBX.(k3).ObservationDateTime' action='set' />
</foreach>
</foreach>
</foreach>
</transform>
}

}
