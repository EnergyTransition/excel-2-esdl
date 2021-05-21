<?xml version='1.0' encoding='UTF-8'?>
<esdl:EnergySystem xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:esdl="http://www.tno.nl/esdl" name="ES3" description="Energy System created from an Excel file with Sectors, InfluxDBProfiles, QuantityAndUnits" id="39d8814f-3b1e-4ad5-bb26-f2451dd113c5">
  <instance xsi:type="esdl:Instance" id="8b2084b6-0482-489c-abf9-ee6681cfe118" name="Instance1">
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
        <asset xsi:type="esdl:HeatingDemand" name="HeatingDemand1" sector="S1" power="10000.0" id="HD1">
          <port xsi:type="esdl:InPort" id="HD1IP1" carrier="H" name="In" connectedTo="HP1OP1">
            <profile xsi:type="esdl:SingleValue" id="HD1P1" value="50.0">
              <profileQuantityAndUnit xsi:type="esdl:QuantityAndUnitType" unit="JOULE" physicalQuantity="ENERGY" id="21bb5781-b103-41b0-b9f7-8829a1bd2f2a" description="ENERGY in GJ" multiplier="GIGA"/>
            </profile>
          </port>
        </asset>
        <asset xsi:type="esdl:ElectricityDemand" name="ElectricityDemand1" sector="S1" power="10000.0" id="ED1">
          <port xsi:type="esdl:InPort" id="ED1IP1" carrier="E" name="In" connectedTo="EN1OP1">
            <profile xsi:type="esdl:InfluxDBProfile" startDate="2018-12-31T23:00:00.000000" host="localhost" database="energy_profiles" id="E1A" name="NEDU_E1A" measurement="standard_profiles" endDate="2019-12-31T22:00:00.000000" multiplier="20.0" port="8086" field="E1A">
              <profileQuantityAndUnit xsi:type="esdl:QuantityAndUnitType" unit="JOULE" physicalQuantity="ENERGY" id="06e754a9-12dd-4ca0-9d3b-f2f825b6ab97" description="ENERGY in GJ" multiplier="GIGA"/>
            </profile>
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
  <energySystemInformation xsi:type="esdl:EnergySystemInformation" id="a632eaa1-ae84-4733-87ae-a25134baf385">
    <sectors xsi:type="esdl:Sectors" id="473f748a-87ee-4b3c-9a06-2bc066d00bc6">
      <sector xsi:type="esdl:Sector" description="Sector 1" id="S1" name="Sector1"/>
    </sectors>
    <carriers xsi:type="esdl:Carriers" id="carrs">
      <carrier xsi:type="esdl:ElectricityCommodity" name="Electricity" id="E"/>
      <carrier xsi:type="esdl:GasCommodity" name="Natural Gas" id="G"/>
      <carrier xsi:type="esdl:HeatCommodity" name="Heat" id="H"/>
    </carriers>
  </energySystemInformation>
</esdl:EnergySystem>
