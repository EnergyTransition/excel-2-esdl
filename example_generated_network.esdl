<?xml version='1.0' encoding='UTF-8'?>
<esdl:EnergySystem xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:esdl="http://www.tno.nl/esdl" name="ES1" description="Energy System created from an Excel file" id="0758ab58-ad99-434a-b5dd-251c7d3688ae">
  <instance xsi:type="esdl:Instance" name="Instance1" id="09fdcce0-7dc6-4fb0-8c1a-5760f7b5f689">
    <area xsi:type="esdl:Area" name="Area1" id="d99db3ed-9452-4601-8723-c6c62be06a0a">
      <asset xsi:type="esdl:HeatingDemand" name="HeatingDemand1" power="10000.0" id="HD1">
        <geometry xsi:type="esdl:Point" lon="4.51" lat="52.11"/>
        <port xsi:type="esdl:InPort" connectedTo="HP1OP1" id="HD1IP1" carrier="H" name="In">
          <profile xsi:type="esdl:SingleValue" value="50.0" id="HD1P1"/>
        </port>
      </asset>
      <asset xsi:type="esdl:ElectricityDemand" name="ElectricityDemand1" power="10000.0" id="ED1">
        <geometry xsi:type="esdl:Point" lon="4.51" lat="52.105"/>
        <port xsi:type="esdl:InPort" connectedTo="EN1OP1" id="ED1IP1" carrier="E" name="In">
          <profile xsi:type="esdl:SingleValue" value="20.0" id="ED1P1"/>
        </port>
      </asset>
      <asset xsi:type="esdl:GasProducer" name="GasProducer1" power="1000000000.0" id="GP1">
        <geometry xsi:type="esdl:Point" lon="4.47" lat="52.105"/>
        <port xsi:type="esdl:OutPort" connectedTo="GPipe1IP1" id="GP1OP1" carrier="G" name="Out"/>
      </asset>
      <asset xsi:type="esdl:HeatPump" name="HeatPump1" COP="3.2" power="4000.0" id="HP1">
        <geometry xsi:type="esdl:Point" lon="4.5" lat="52.11"/>
        <port xsi:type="esdl:InPort" connectedTo="EN1OP1" id="HP1IP1" carrier="E" name="In1"/>
        <port xsi:type="esdl:OutPort" connectedTo="HD1IP1" id="HP1OP1" carrier="H" name="Out1"/>
      </asset>
      <asset xsi:type="esdl:PowerPlant" efficiency="0.4" name="PowerPlant1" power="1000000000.0" id="PP1">
        <geometry xsi:type="esdl:Point" lon="4.48" lat="52.105"/>
        <port xsi:type="esdl:InPort" connectedTo="GPipe1OP1" id="PP1IP1" carrier="G" name="In1"/>
        <port xsi:type="esdl:OutPort" connectedTo="ECable1IP1" id="PP1OP1" carrier="E" name="Out1"/>
      </asset>
      <asset xsi:type="esdl:ElectricityNetwork" name="ElectricityNetwork1" id="EN1">
        <geometry xsi:type="esdl:Point" lon="4.49" lat="52.105"/>
        <port xsi:type="esdl:InPort" connectedTo="ECable1OP1" id="EN1IP1" carrier="E" name="In1"/>
        <port xsi:type="esdl:OutPort" connectedTo="HP1IP1 ED1IP1" id="EN1OP1" carrier="E" name="Out1"/>
      </asset>
      <asset xsi:type="esdl:Pipe" name="GasPipe1" id="GPipe1">
        <geometry xsi:type="esdl:Line">
          <point xsi:type="esdl:Point" lon="4.47" lat="52.105"/>
          <point xsi:type="esdl:Point" lon="4.48" lat="52.105"/>
        </geometry>
        <port xsi:type="esdl:InPort" connectedTo="GP1OP1" id="GPipe1IP1" carrier="G" name="In1"/>
        <port xsi:type="esdl:OutPort" connectedTo="PP1IP1" id="GPipe1OP1" carrier="G" name="Out1"/>
      </asset>
      <asset xsi:type="esdl:ElectricityCable" name="ECable1" id="ECable1">
        <geometry xsi:type="esdl:Line">
          <point xsi:type="esdl:Point" lon="4.48" lat="52.105"/>
          <point xsi:type="esdl:Point" lon="4.49" lat="52.105"/>
        </geometry>
        <port xsi:type="esdl:InPort" connectedTo="PP1OP1" id="ECable1IP1" carrier="E" name="In1"/>
        <port xsi:type="esdl:OutPort" connectedTo="EN1IP1" id="ECable1OP1" carrier="E" name="Out1"/>
      </asset>
    </area>
  </instance>
  <energySystemInformation xsi:type="esdl:EnergySystemInformation">
    <carriers xsi:type="esdl:Carriers" id="carrs">
      <carrier xsi:type="esdl:ElectricityCommodity" id="E" name="Electricity"/>
      <carrier xsi:type="esdl:GasCommodity" id="G" name="Natural Gas"/>
      <carrier xsi:type="esdl:HeatCommodity" id="H" name="Heat"/>
    </carriers>
  </energySystemInformation>
</esdl:EnergySystem>
