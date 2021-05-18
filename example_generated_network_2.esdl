<?xml version='1.0' encoding='UTF-8'?>
<esdl:EnergySystem xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:esdl="http://www.tno.nl/esdl" name="ES2" description="More complex Energy System created from an Excel file" id="74a369f3-7431-4c9d-acdf-d66a032bec92">
  <instance xsi:type="esdl:Instance" id="c1049f9c-3110-4a23-b953-f3e0adeda901" name="Instance1">
    <area xsi:type="esdl:Area" id="TLA" name="TopLevelArea">
      <area xsi:type="esdl:Area" id="SubArea1" name="SubArea1">
        <asset xsi:type="esdl:GasProducer" name="GasProducer1" power="1000000000.0" id="GP1">
          <port xsi:type="esdl:OutPort" connectedTo="GPipe1IP1" id="GP1OP1" carrier="G" name="Out"/>
        </asset>
        <asset xsi:type="esdl:PowerPlant" efficiency="0.4" name="PowerPlant1" power="1000000000.0" id="PP1">
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
            <point xsi:type="esdl:Point" lat="52.103842911287735" lon="4.466757774353028"/>
            <point xsi:type="esdl:Point" lat="52.11085411729098" lon="4.466757774353028"/>
            <point xsi:type="esdl:Point" lat="52.11085411729098" lon="4.492335319519044"/>
            <point xsi:type="esdl:Point" lat="52.103842911287735" lon="4.492335319519044"/>
            <point xsi:type="esdl:Point" lat="52.103842911287735" lon="4.466757774353028"/>
          </exterior>
        </geometry>
      </area>
      <area xsi:type="esdl:Area" id="SubArea2" name="SubArea2">
        <asset xsi:type="esdl:HeatingDemand" name="HeatingDemand1" power="10000.0" id="HD1">
          <port xsi:type="esdl:InPort" id="HD1IP1" carrier="H" name="In" connectedTo="HP1OP1">
            <profile xsi:type="esdl:SingleValue" value="50.0" id="HD1P1"/>
          </port>
        </asset>
        <asset xsi:type="esdl:ElectricityDemand" name="ElectricityDemand1" power="10000.0" id="ED1">
          <port xsi:type="esdl:InPort" id="ED1IP1" carrier="E" name="In" connectedTo="EN1OP1">
            <profile xsi:type="esdl:SingleValue" value="20.0" id="ED1P1"/>
          </port>
        </asset>
        <asset xsi:type="esdl:HeatPump" name="HeatPump1" COP="3.2" power="4000.0" id="HP1">
          <port xsi:type="esdl:InPort" id="HP1IP1" carrier="E" name="In1" connectedTo="EN1OP1"/>
          <port xsi:type="esdl:OutPort" connectedTo="HD1IP1" id="HP1OP1" carrier="H" name="Out1"/>
        </asset>
        <geometry xsi:type="esdl:Polygon">
          <exterior xsi:type="esdl:SubPolygon">
            <point xsi:type="esdl:Point" lat="52.103842911287735" lon="4.4931936264038095"/>
            <point xsi:type="esdl:Point" lat="52.11085411729098" lon="4.4931936264038095"/>
            <point xsi:type="esdl:Point" lat="52.11085411729098" lon="4.511861801147462"/>
            <point xsi:type="esdl:Point" lat="52.103842911287735" lon="4.511861801147462"/>
            <point xsi:type="esdl:Point" lat="52.103842911287735" lon="4.4931936264038095"/>
          </exterior>
        </geometry>
      </area>
      <geometry xsi:type="esdl:Polygon">
        <exterior xsi:type="esdl:SubPolygon">
          <point xsi:type="esdl:Point" lat="52.103052104592436" lon="4.465641975402833"/>
          <point xsi:type="esdl:Point" lat="52.111618430250196" lon="4.465641975402833"/>
          <point xsi:type="esdl:Point" lat="52.111618430250196" lon="4.5134925842285165"/>
          <point xsi:type="esdl:Point" lat="52.103052104592436" lon="4.5134925842285165"/>
          <point xsi:type="esdl:Point" lat="52.103052104592436" lon="4.465641975402833"/>
        </exterior>
      </geometry>
    </area>
  </instance>
  <energySystemInformation xsi:type="esdl:EnergySystemInformation">
    <carriers xsi:type="esdl:Carriers" id="carrs">
      <carrier xsi:type="esdl:ElectricityCommodity" name="Electricity" id="E"/>
      <carrier xsi:type="esdl:GasCommodity" name="Natural Gas" id="G"/>
      <carrier xsi:type="esdl:HeatCommodity" name="Heat" id="H"/>
    </carriers>
  </energySystemInformation>
</esdl:EnergySystem>
