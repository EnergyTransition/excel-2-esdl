<?xml version='1.0' encoding='UTF-8'?>
<esdl:EnergySystem xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:esdl="http://www.tno.nl/esdl" name="ES1" description="Energy System created from an Excel file" id="9569773e-a874-4f8b-8822-da627d2045b4">
  <instance xsi:type="esdl:Instance" id="f9a6bec4-2d81-4efc-87bf-63da9953744f" name="Instance1">
    <area xsi:type="esdl:Area" id="8d716e31-b5fe-4d7e-a012-91a728c86d69" name="Area1">
      <asset xsi:type="esdl:HeatingDemand" name="HeatingDemand1" power="10000.0" id="HD1">
        <geometry xsi:type="esdl:Point" lat="52.11" lon="4.51"/>
        <port xsi:type="esdl:InPort" id="HD1IP1" carrier="H" name="In" connectedTo="HP1OP1">
          <profile xsi:type="esdl:SingleValue" id="HD1P1" value="50.0">
            <profileQuantityAndUnit xsi:type="esdl:QuantityAndUnitType" unit="JOULE" physicalQuantity="ENERGY" id="52429587-088d-4dfb-afad-23d9cd356211" description="ENERGY in GJ" multiplier="GIGA"/>
          </profile>
        </port>
      </asset>
      <asset xsi:type="esdl:ElectricityDemand" name="ElectricityDemand1" power="10000.0" id="ED1">
        <geometry xsi:type="esdl:Point" lat="52.105" lon="4.51"/>
        <port xsi:type="esdl:InPort" id="ED1IP1" carrier="E" name="In" connectedTo="EN1OP1">
          <profile xsi:type="esdl:SingleValue" id="ED1P1" value="20.0">
            <profileQuantityAndUnit xsi:type="esdl:QuantityAndUnitType" unit="JOULE" physicalQuantity="ENERGY" id="a60dcbf5-fdf1-4b49-a1a8-4ccbafbe98d1" description="ENERGY in GJ" multiplier="GIGA"/>
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
  <energySystemInformation xsi:type="esdl:EnergySystemInformation" id="d2cf29b2-d59a-4a11-b67a-7a95ea139f97">
    <sectors xsi:type="esdl:Sectors" id="a344bb0f-131c-4783-87b3-7030193bd7e2"/>
    <carriers xsi:type="esdl:Carriers" id="carrs">
      <carrier xsi:type="esdl:ElectricityCommodity" name="Electricity" id="E"/>
      <carrier xsi:type="esdl:GasCommodity" name="Natural Gas" id="G"/>
      <carrier xsi:type="esdl:HeatCommodity" name="Heat" id="H"/>
    </carriers>
  </energySystemInformation>
</esdl:EnergySystem>
