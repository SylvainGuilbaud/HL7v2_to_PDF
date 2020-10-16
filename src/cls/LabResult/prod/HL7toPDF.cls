Class LabResult.prod.HL7toPDF Extends Ens.Production
{

XData ProductionDefinition
{
<Production Name="LabResult.prod.HL7toPDF" TestingEnabled="true" LogGeneralTraceEvents="true">
  <Description></Description>
  <ActorPoolSize>2</ActorPoolSize>
  <Item Name="de Résultats de Laboratoire" Category="Résultats de Laboratoire" ClassName="EnsLib.HL7.Service.FileService" PoolSize="1" Enabled="true" Foreground="false" Comment="" LogTraceEvents="false" Schedule="">
    <Setting Target="Host" Name="MessageSchemaCategory">2.3</Setting>
    <Setting Target="Host" Name="TargetConfigNames">LABO</Setting>
    <Setting Target="Adapter" Name="FilePath">/Users/guilbaud/data/LabResult/in</Setting>
    <Setting Target="Adapter" Name="ArchivePath"></Setting>
    <Setting Target="Adapter" Name="FileSpec">*.hl7</Setting>
    <Setting Target="Host" Name="ArchiveIO">0</Setting>
  </Item>
  <Item Name="LABO" Category="Résultats de Laboratoire" ClassName="EnsLib.HL7.MsgRouter.RoutingEngine" PoolSize="1" Enabled="true" Foreground="false" Comment="" LogTraceEvents="false" Schedule="">
    <Setting Target="Host" Name="Validation"></Setting>
    <Setting Target="Host" Name="BusinessRuleName">LabResult.rules.LABO</Setting>
  </Item>
  <Item Name="conversion PDF" Category="Résultats de Laboratoire" ClassName="LabResult.operation.conversion" PoolSize="1" Enabled="true" Foreground="false" Comment="" LogTraceEvents="true" Schedule="">
    <Setting Target="Adapter" Name="FilePath">/Users/guilbaud/data/LabResult/pdf</Setting>
    <Setting Target="Adapter" Name="Overwrite">0</Setting>
    <Setting Target="Host" Name="PDFgenerator">2</Setting>
    <Setting Target="Host" Name="ArchiveIO">0</Setting>
  </Item>
</Production>
}

}
