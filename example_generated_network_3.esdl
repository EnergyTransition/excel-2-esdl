<?xml version='1.0' encoding='UTF-8'?>
<esdl:EnergySystem xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:esdl="http://www.tno.nl/esdl" description="Energy System created from an Excel file with Sectors, InfluxDBProfiles, QuantityAndUnits" name="ES3" id="23cf01c8-e70a-497e-8f90-0c252ed1838d">
  <instance xsi:type="esdl:Instance" name="Instance1" id="47568766-7d73-46d1-8246-64b266f73c2f">
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
        <asset xsi:type="esdl:HeatingDemand" power="10000.0" name="HeatingDemand1" sector="S1" id="HD1">
          <port xsi:type="esdl:InPort" id="HD1IP1" carrier="H" name="In" connectedTo="HP1OP1">
            <profile xsi:type="esdl:SingleValue" value="50.0" id="HD1P1">
              <profileQuantityAndUnit xsi:type="esdl:QuantityAndUnitType" unit="JOULE" physicalQuantity="ENERGY" id="58499c26-ac44-4edd-b539-6679d2333c5e" description="ENERGY in GJ" multiplier="GIGA"/>
            </profile>
          </port>
        </asset>
        <asset xsi:type="esdl:ElectricityDemand" power="10000.0" name="ElectricityDemand1" sector="S1" id="ED1">
          <port xsi:type="esdl:InPort" id="ED1IP1" carrier="E" name="In" connectedTo="EN1OP1">
            <profile xsi:type="esdl:InfluxDBProfile" host="localhost" field="E1A" id="E1A" name="NEDU_E1A" endDate="2019-12-31T22:00:00.000000" multiplier="20.0" port="8086" measurement="standard_profiles" startDate="2018-12-31T23:00:00.000000" database="energy_profiles">
              <profileQuantityAndUnit xsi:type="esdl:QuantityAndUnitType" unit="JOULE" physicalQuantity="ENERGY" id="2d197015-ba6a-4b6f-839b-685ee17a52bb" description="ENERGY in GJ" multiplier="GIGA"/>
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
  <energySystemInformation xsi:type="esdl:EnergySystemInformation" id="ba5215a5-1894-404e-805d-7356bc0e4252">
    <carriers xsi:type="esdl:Carriers" id="carrs">
      <carrier xsi:type="esdl:ElectricityCommodity" id="E" name="Electricity"/>
      <carrier xsi:type="esdl:GasCommodity" id="G" name="Natural Gas"/>
      <carrier xsi:type="esdl:HeatCommodity" id="H" name="Heat"/>
    </carriers>
    <sectors xsi:type="esdl:Sectors" id="17993773-5b4b-40d7-a144-c76293f86d65">
      <sector xsi:type="esdl:Sector" description="Sector 1" name="Sector1" id="S1"/>
    </sectors>
  </energySystemInformation>
</esdl:EnergySystem>
