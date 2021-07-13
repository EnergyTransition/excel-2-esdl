<?xml version='1.0' encoding='UTF-8'?>
<esdl:EnergySystem xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:esdl="http://www.tno.nl/esdl" description="Energy System created from an Excel file" name="ES1" id="daaec325-8463-4887-8b55-0572d762a938">
  <instance xsi:type="esdl:Instance" name="Instance1" id="9badfa4a-edfc-4912-a238-481fd0dc9e41">
    <area xsi:type="esdl:Area" name="Area1" id="5cc840d2-885a-4bc9-915d-34f0cc8cd6f7">
      <asset xsi:type="esdl:HeatingDemand" power="10000.0" name="HeatingDemand1" id="HD1">
        <port xsi:type="esdl:InPort" id="HD1IP1" carrier="H" name="In" connectedTo="HP1OP1">
          <profile xsi:type="esdl:SingleValue" value="50.0" id="HD1P1">
            <profileQuantityAndUnit xsi:type="esdl:QuantityAndUnitType" unit="JOULE" physicalQuantity="ENERGY" id="5ae89d3d-c7ff-4ac9-a0c4-82a37bd40745" description="ENERGY in GJ" multiplier="GIGA"/>
          </profile>
        </port>
        <geometry xsi:type="esdl:Point" lon="4.51" lat="52.11"/>
      </asset>
      <asset xsi:type="esdl:ElectricityDemand" power="10000.0" name="ElectricityDemand1" id="ED1">
        <port xsi:type="esdl:InPort" id="ED1IP1" carrier="E" name="In" connectedTo="EN1OP1">
          <profile xsi:type="esdl:SingleValue" value="20.0" id="ED1P1">
            <profileQuantityAndUnit xsi:type="esdl:QuantityAndUnitType" unit="JOULE" physicalQuantity="ENERGY" id="bb4a126c-8c54-4c60-8132-d4d992bb313a" description="ENERGY in GJ" multiplier="GIGA"/>
          </profile>
        </port>
        <geometry xsi:type="esdl:Point" lon="4.51" lat="52.105"/>
      </asset>
      <asset xsi:type="esdl:GasProducer" id="GP1" name="GasProducer1" power="1000000000.0">
        <port xsi:type="esdl:OutPort" connectedTo="GPipe1IP1" id="GP1OP1" carrier="G" name="Out"/>
        <geometry xsi:type="esdl:Point" lon="4.47" lat="52.105"/>
      </asset>
      <asset xsi:type="esdl:HeatPump" id="HP1" name="HeatPump1" COP="3.2" power="4000.0">
        <port xsi:type="esdl:InPort" id="HP1IP1" carrier="E" name="In1" connectedTo="EN1OP1"/>
        <port xsi:type="esdl:OutPort" connectedTo="HD1IP1" id="HP1OP1" carrier="H" name="Out1"/>
        <geometry xsi:type="esdl:Point" lon="4.5" lat="52.11"/>
      </asset>
      <asset xsi:type="esdl:PowerPlant" id="PP1" name="PowerPlant1" efficiency="0.4" power="1000000000.0">
        <port xsi:type="esdl:InPort" id="PP1IP1" carrier="G" name="In1" connectedTo="GPipe1OP1"/>
        <port xsi:type="esdl:OutPort" connectedTo="ECable1IP1" id="PP1OP1" carrier="E" name="Out1"/>
        <geometry xsi:type="esdl:Point" lon="4.48" lat="52.105"/>
      </asset>
      <asset xsi:type="esdl:ElectricityNetwork" name="ElectricityNetwork1" id="EN1">
        <port xsi:type="esdl:InPort" id="EN1IP1" carrier="E" name="In1" connectedTo="ECable1OP1"/>
        <port xsi:type="esdl:OutPort" connectedTo="HP1IP1 ED1IP1" id="EN1OP1" carrier="E" name="Out1"/>
        <geometry xsi:type="esdl:Point" lon="4.49" lat="52.105"/>
      </asset>
      <asset xsi:type="esdl:Pipe" name="GasPipe1" id="GPipe1">
        <port xsi:type="esdl:InPort" id="GPipe1IP1" carrier="G" name="In1" connectedTo="GP1OP1"/>
        <port xsi:type="esdl:OutPort" connectedTo="PP1IP1" id="GPipe1OP1" carrier="G" name="Out1"/>
        <geometry xsi:type="esdl:Line">
          <point xsi:type="esdl:Point" lon="4.47" lat="52.105"/>
          <point xsi:type="esdl:Point" lon="4.48" lat="52.105"/>
        </geometry>
      </asset>
      <asset xsi:type="esdl:ElectricityCable" name="ECable1" id="ECable1">
        <port xsi:type="esdl:InPort" id="ECable1IP1" carrier="E" name="In1" connectedTo="PP1OP1"/>
        <port xsi:type="esdl:OutPort" connectedTo="EN1IP1" id="ECable1OP1" carrier="E" name="Out1"/>
        <geometry xsi:type="esdl:Line">
          <point xsi:type="esdl:Point" lon="4.48" lat="52.105"/>
          <point xsi:type="esdl:Point" lon="4.49" lat="52.105"/>
        </geometry>
      </asset>
    </area>
  </instance>
  <energySystemInformation xsi:type="esdl:EnergySystemInformation" id="a67f7033-072c-4113-a251-a79e0bdd0dcd">
    <carriers xsi:type="esdl:Carriers" id="carrs">
      <carrier xsi:type="esdl:ElectricityCommodity" id="E" name="Electricity"/>
      <carrier xsi:type="esdl:GasCommodity" id="G" name="Natural Gas"/>
      <carrier xsi:type="esdl:HeatCommodity" id="H" name="Heat"/>
    </carriers>
    <sectors xsi:type="esdl:Sectors" id="b2c5cf75-eb95-4e20-9adb-d9fb12dfeb3a"/>
  </energySystemInformation>
</esdl:EnergySystem>
