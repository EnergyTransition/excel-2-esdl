<?xml version='1.0' encoding='UTF-8'?>
<esdl:EnergySystem xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:esdl="http://www.tno.nl/esdl" name="ES1" description="Energy System created from an Excel file" id="76ac7c4e-e31c-4e63-a920-abf8f6066b06">
  <instance xsi:type="esdl:Instance" id="671fe800-9cec-4363-94ae-2e5844b68785" name="Instance1">
    <area xsi:type="esdl:Area" id="6a0caedb-e67e-4f25-b47b-4fe9b6da65f2" name="Area1">
      <asset xsi:type="esdl:HeatingDemand" name="HeatingDemand1" power="10000.0" id="HD1">
        <geometry xsi:type="esdl:Point" lat="52.11" lon="4.51"/>
        <port xsi:type="esdl:InPort" id="HD1IP1" carrier="H" name="In" connectedTo="HP1OP1">
          <profile xsi:type="esdl:SingleValue" value="50.0" id="HD1P1">
            <profileQuantityAndUnit xsi:type="esdl:QuantityAndUnitType" unit="JOULE" physicalQuantity="ENERGY" id="e38e2baa-56fa-42ac-9486-cf1ae0f2e648" description="ENERGY in GJ" multiplier="GIGA"/>
          </profile>
        </port>
      </asset>
      <asset xsi:type="esdl:ElectricityDemand" name="ElectricityDemand1" power="10000.0" id="ED1">
        <geometry xsi:type="esdl:Point" lat="52.105" lon="4.51"/>
        <port xsi:type="esdl:InPort" id="ED1IP1" carrier="E" name="In" connectedTo="EN1OP1">
          <profile xsi:type="esdl:SingleValue" value="20.0" id="ED1P1">
            <profileQuantityAndUnit xsi:type="esdl:QuantityAndUnitType" unit="JOULE" physicalQuantity="ENERGY" id="be761e4b-092c-4082-a666-2e5d5896268d" description="ENERGY in GJ" multiplier="GIGA"/>
          </profile>
        </port>
      </asset>
      <asset xsi:type="esdl:GasProducer" name="GasProducer1" power="1000000000.0" id="GP1">
        <geometry xsi:type="esdl:Point" lat="52.105" lon="4.47"/>
        <port xsi:type="esdl:OutPort" connectedTo="GPipe1IP1" id="GP1OP1" carrier="G" name="Out"/>
      </asset>
      <asset xsi:type="esdl:HeatPump" name="HeatPump1" COP="3.2" power="4000.0" id="HP1">
        <geometry xsi:type="esdl:Point" lat="52.11" lon="4.5"/>
        <port xsi:type="esdl:InPort" id="HP1IP1" carrier="E" name="In1" connectedTo="EN1OP1"/>
        <port xsi:type="esdl:OutPort" connectedTo="HD1IP1" id="HP1OP1" carrier="H" name="Out1"/>
      </asset>
      <asset xsi:type="esdl:PowerPlant" efficiency="0.4" name="PowerPlant1" power="1000000000.0" id="PP1">
        <geometry xsi:type="esdl:Point" lat="52.105" lon="4.48"/>
        <port xsi:type="esdl:InPort" id="PP1IP1" carrier="G" name="In1" connectedTo="GPipe1OP1"/>
        <port xsi:type="esdl:OutPort" connectedTo="ECable1IP1" id="PP1OP1" carrier="E" name="Out1"/>
      </asset>
      <asset xsi:type="esdl:ElectricityNetwork" name="ElectricityNetwork1" id="EN1">
        <geometry xsi:type="esdl:Point" lat="52.105" lon="4.49"/>
        <port xsi:type="esdl:InPort" id="EN1IP1" carrier="E" name="In1" connectedTo="ECable1OP1"/>
        <port xsi:type="esdl:OutPort" connectedTo="HP1IP1 ED1IP1" id="EN1OP1" carrier="E" name="Out1"/>
      </asset>
      <asset xsi:type="esdl:Pipe" name="GasPipe1" id="GPipe1">
        <geometry xsi:type="esdl:Line">
          <point xsi:type="esdl:Point" lat="52.105" lon="4.47"/>
          <point xsi:type="esdl:Point" lat="52.105" lon="4.48"/>
        </geometry>
        <port xsi:type="esdl:InPort" id="GPipe1IP1" carrier="G" name="In1" connectedTo="GP1OP1"/>
        <port xsi:type="esdl:OutPort" connectedTo="PP1IP1" id="GPipe1OP1" carrier="G" name="Out1"/>
      </asset>
      <asset xsi:type="esdl:ElectricityCable" name="ECable1" id="ECable1">
        <geometry xsi:type="esdl:Line">
          <point xsi:type="esdl:Point" lat="52.105" lon="4.48"/>
          <point xsi:type="esdl:Point" lat="52.105" lon="4.49"/>
        </geometry>
        <port xsi:type="esdl:InPort" id="ECable1IP1" carrier="E" name="In1" connectedTo="PP1OP1"/>
        <port xsi:type="esdl:OutPort" connectedTo="EN1IP1" id="ECable1OP1" carrier="E" name="Out1"/>
      </asset>
    </area>
  </instance>
  <energySystemInformation xsi:type="esdl:EnergySystemInformation" id="b358c5d8-ceef-4fa4-9758-0ba9d57e474f">
    <sectors xsi:type="esdl:Sectors" id="c9710448-3039-4a0e-bf66-7e6146934a4e"/>
    <carriers xsi:type="esdl:Carriers" id="carrs">
      <carrier xsi:type="esdl:ElectricityCommodity" name="Electricity" id="E"/>
      <carrier xsi:type="esdl:GasCommodity" name="Natural Gas" id="G"/>
      <carrier xsi:type="esdl:HeatCommodity" name="Heat" id="H"/>
    </carriers>
  </energySystemInformation>
</esdl:EnergySystem>
