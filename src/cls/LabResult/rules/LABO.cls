/// 
Class LabResult.rules.LABO Extends Ens.Rule.Definition
{

Parameter RuleAssistClass = "EnsLib.HL7.MsgRouter.RuleAssist";

XData RuleDefinition [ XMLNamespace = "http://www.intersystems.com/rule" ]
{
<ruleDefinition alias="" context="EnsLib.HL7.MsgRouter.RoutingEngine" production="LabResult.prod.HL7toPDF">
<ruleSet name="" effectiveBegin="" effectiveEnd="">
<rule name="">
<constraint name="source" value="de Résultats de Laboratoire"></constraint>
<constraint name="docCategory" value="2.3"></constraint>
<constraint name="docName" value="ORU_R01"></constraint>
<when condition="HL7.{MSH:SendingApplication.namespaceID}=&quot;LAB&quot;">
<send transform="LabResult.transfo.HL7toHTML" target="conversion PDF"></send>
<return></return>
</when>
</rule>
</ruleSet>
</ruleDefinition>
}

}
