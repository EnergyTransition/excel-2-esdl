<?xml version='1.0' encoding='UTF-8'?>
<esdl:EnergySystem xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:esdl="http://www.tno.nl/esdl" description="More complex Energy System created from an Excel file" name="ES2" id="0c8d6e49-c2a4-45f7-a478-a69c7dd8ae99">
  <instance xsi:type="esdl:Instance" name="Instance1" id="8e9863c5-b164-4afe-affa-479796295caf">
    <area xsi:type="esdl:Area" id="TLA" name="TopLevelArea">
      <geometry xsi:type="esdl:Polygon">
        <exterior xsi:type="esdl:SubPolygon">
          <point xsi:type="esdl:Point" lon="4.465641975402833" lat="52.103052104592436"/>
          <point xsi:type="esdl:Point" lon="4.465641975402833" lat="52.111618430250196"/>
          <point xsi:type="esdl:Point" lon="4.5134925842285165" lat="52.111618430250196"/>
          <point xsi:type="esdl:Point" lon="4.5134925842285165" lat="52.103052104592436"/>
          <point xsi:type="esdl:Point" lon="4.465641975402833" lat="52.103052104592436"/>
        </exterior>
      </geometry>
      <area xsi:type="esdl:Area" id="SubArea1" name="SubArea1">
        <asset xsi:type="esdl:GasProducer" id="GP1" name="GasProducer1" power="1000000000.0">
          <port xsi:type="esdl:OutPort" connectedTo="GPipe1IP1" id="GP1OP1" carrier="G" name="Out"/>
        </asset>
        <asset xsi:type="esdl:PowerPlant" id="PP1" name="PowerPlant1" efficiency="0.4" power="1000000000.0">
          <port xsi:type="esdl:InPort" id="PP1IP1" carrier="G" name="In1" connectedTo="GPipe1OP1"/>
          <port xsi:type="esdl:OutPort" connectedTo="ECable1IP1" id="PP1OP1" carrier="E" name="Out1"/>
        </asset>
        <asset xsi:type="esdl:ElectricityNetwork" id="EN1" name="ElectricityNetwork1">
          <port xsi:type="esdl:InPort" id="EN1IP1" carrier="E" name="In1" connectedTo="ECable1OP1"/>
          <port xsi:type="esdl:OutPort" connectedTo="HP1IP1 ED1IP1" id="EN1OP1" carrier="E" name="Out1"/>
        </asset>
        <asset xsi:type="esdl:Pipe" id="GPipe1" name="GasPipe1">
          <port xsi:type="esdl:InPort" id="GPipe1IP1" carrier="G" name="In1" connectedTo="GP1OP1"/>
          <port xsi:type="esdl:OutPort" connectedTo="PP1IP1" id="GPipe1OP1" carrier="G" name="Out1"/>
        </asset>
        <asset xsi:type="esdl:ElectricityCable" id="ECable1" name="ECable1">
          <port xsi:type="esdl:InPort" id="ECable1IP1" carrier="E" name="In1" connectedTo="PP1OP1"/>
          <port xsi:type="esdl:OutPort" connectedTo="EN1IP1" id="ECable1OP1" carrier="E" name="Out1"/>
        </asset>
        <geometry xsi:type="esdl:Polygon">
          <exterior xsi:type="esdl:SubPolygon">
            <point xsi:type="esdl:Point" lon="4.466757774353028" lat="52.103842911287735"/>
            <point xsi:type="esdl:Point" lon="4.466757774353028" lat="52.11085411729098"/>
            <point xsi:type="esdl:Point" lon="4.492335319519044" lat="52.11085411729098"/>
            <point xsi:type="esdl:Point" lon="4.492335319519044" lat="52.103842911287735"/>
            <point xsi:type="esdl:Point" lon="4.466757774353028" lat="52.103842911287735"/>
          </exterior>
        </geometry>
      </area>
      <area xsi:type="esdl:Area" id="SubArea2" name="SubArea2">
        <asset xsi:type="esdl:HeatingDemand" power="10000.0" name="HeatingDemand1" id="HD1">
          <port xsi:type="esdl:InPort" id="HD1IP1" carrier="H" name="In" connectedTo="HP1OP1">
            <profile xsi:type="esdl:SingleValue" value="50.0" id="HD1P1">
              <profileQuantityAndUnit xsi:type="esdl:QuantityAndUnitType" unit="JOULE" physicalQuantity="ENERGY" id="c000f66b-1650-443c-9ec9-5df028e5bfde" description="ENERGY in GJ" multiplier="GIGA"/>
            </profile>
          </port>
        </asset>
        <asset xsi:type="esdl:ElectricityDemand" power="10000.0" name="ElectricityDemand1" id="ED1">
          <port xsi:type="esdl:InPort" id="ED1IP1" carrier="E" name="In" connectedTo="EN1OP1">
            <profile xsi:type="esdl:SingleValue" value="20.0" id="ED1P1">
              <profileQuantityAndUnit xsi:type="esdl:QuantityAndUnitType" unit="JOULE" physicalQuantity="ENERGY" id="f01cac8f-eadc-4e5d-9104-89e4eeb08d61" description="ENERGY in GJ" multiplier="GIGA"/>
            </profile>
          </port>
        </asset>
        <asset xsi:type="esdl:HeatPump" id="HP1" name="HeatPump1" COP="3.2" power="4000.0">
          <port xsi:type="esdl:InPort" id="HP1IP1" carrier="E" name="In1" connectedTo="EN1OP1"/>
          <port xsi:type="esdl:OutPort" connectedTo="HD1IP1" id="HP1OP1" carrier="H" name="Out1"/>
        </asset>
        <geometry xsi:type="esdl:Polygon">
          <exterior xsi:type="esdl:SubPolygon">
            <point xsi:type="esdl:Point" lon="4.4931936264038095" lat="52.103842911287735"/>
            <point xsi:type="esdl:Point" lon="4.4931936264038095" lat="52.11085411729098"/>
            <point xsi:type="esdl:Point" lon="4.511861801147462" lat="52.11085411729098"/>
            <point xsi:type="esdl:Point" lon="4.511861801147462" lat="52.103842911287735"/>
            <point xsi:type="esdl:Point" lon="4.4931936264038095" lat="52.103842911287735"/>
          </exterior>
        </geometry>
      </area>
    </area>
  </instance>
  <energySystemInformation xsi:type="esdl:EnergySystemInformation" id="71ff8bd1-eacc-4653-bc0e-69b8aad1677c">
    <carriers xsi:type="esdl:Carriers" id="carrs">
      <carrier xsi:type="esdl:ElectricityCommodity" id="E" name="Electricity"/>
      <carrier xsi:type="esdl:GasCommodity" id="G" name="Natural Gas"/>
      <carrier xsi:type="esdl:HeatCommodity" id="H" name="Heat"/>
    </carriers>
    <sectors xsi:type="esdl:Sectors" id="a6636a3c-2921-499f-bb7a-77c282102f13"/>
  </energySystemInformation>
</esdl:EnergySystem>
