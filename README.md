Create ESDL from Excel
======================

This is an example implementation that shows how to build up an ESDL network description based on input coming from an Excel file

Install dependencies
```
pip install -r requirements.txt
```

Run script
```
python main.py
```

Excel contents
--------------

The example Excel files have seven tabs:

1. Areas

   This tab is only filled with information in the second example.

   ![Area](doc/Areas.png)

   This tab defines the Areas that will be added to the EnergySystem description.

   | Column | Description |
   | --- | ---|
   | ID | The ID of the Area |
   | Name | The name of the Area |
   | TopLevelArea | Whether or not this Area is the top level area in the ESDL (True or False, there can only be one top level area) |
   | Scope | (Optional) ESDL Scope of the Area |
   | Parent_Area_ID | ID of the parent area this Area belongs to |
   | Area_WKT | (Optional) Well Known Text representation of the geometry of the Area |
   | Sector_ID | The ID of the sector the Area belongs to |

2. Buildings

   This tab defines the Buildings that will be added to the EnergySystem description.

   | Column | Description |
   | --- | ---|
   | ID | The ID of the Building |
   | Name | The name of the Building |
   | ESDLType | The ESDL class name of the Building, must be a subclass of esdl.AbstractBuilding |
   | Lat | (Optional) The lattitude of the location of the Building asset |
   | Lon | (Optional) The longitude of the location of the Building asset |
   | Parent_Area_ID | ID of the area this Building will be added to |
   | Sector_ID | The ID of the sector the Building belongs to |

3. Carriers

   ![Carriers](doc/Carriers.png)

   This tab defines the Commodities and Carriers that will be added to the EnergySystem description.

   | Column | Description |
   | --- | ---|
   | ID | The ID of the Carrier or Commodity |
   | Name | The name of the Carrier or Commodity |
   | ESDLType | The ESDL class name of the Carrier or Commodity |

4. ConsumerProducer

   ![ConsumerProducer](doc/ConsumerProducer.png)

   This tab defines the Consumer and Producer assets that will be added to the EnergySystem description. Consumers are
   added with one InPort, Producers with on OutPort.

   | Column | Description |
   | --- | ---|
   | ID | The ID of the Consumer or Producer asset |
   | Name | The name of the Consumer or Producer asset |
   | ESDLType | The ESDL class name of the Consumer or Producer asset |
   | Lat | (Optional) The lattitude of the location of the Consumer or Producer asset |
   | Lon | (Optional) The longitude of the location of the Consumer or Producer asset |
   | AreaBld_ID | (Optional) The ID of the Area or Building the Consumer or Producer asset will be added to |
   | Power | The power in Watts of the Consumer or Producer asset |
   | Attributex | The name of the attribute of the Conversion asset (x must be an integer number) |
   | Valuex | The value of the attribute of the Conversion asset (x must be an integer number) |
   | Port_ID | The ID of the InPort of the Consumer or the OutPort of the Producer |
   | Carrier_ID | The ID of the carrier that is attached to the Port (see Carriers tab for available Carriers) |
   | Profile_ID | The ID of the profile that is attached to the Port |
   | Profile_ESDLType | Type of the profile that is attached to the Port (SingleValue and InfluxDBProfile supported) |
   | Profile_Physical_Quantity | The physical quantity of the profile (see esdl.PhysicalQuantityEnum for values ) |
   | Profile_Value | Value of the profile that is attached to the Port |
   | Profile_Unit | Unit of th value of the profile that is attached to the Port |
   | Profile_Reference_ID | Reference to an InfluxDBProfile ID |
   | Sector_ID | The ID of the sector the Consumer or Producer asset belongs to |

5. Conversion

   ![Conversion](doc/Conversion.png)

   This tab defines the Conversion assets that will be added to the EnergySystem description. Conversion assets can 
   have one or two InPorts and one or two OutPorts.

   | Column | Description |
   | --- | ---|
   | ID | The ID of the Conversion asset |
   | Name | The name of the Conversion asset |
   | ESDLType | The ESDL class name of the Conversion asset |
   | Lat | (Optional) The lattitude of the location of the Conversion asset |
   | Lon | (Optional) The longitude of the location of the Conversion asset |
   | AreaBld_ID | (Optional) The ID of the Area or Building the Conversion asset will be added to |
   | Power | The power in Watts of the Conversion asset |
   | Attributex | The name of the attribute of the Conversion asset (x must be an integer number) |
   | Valuex | The value of the attribute of the Conversion asset (x must be an integer number) |
   | InPort1_ID | The ID of the first InPort of the Conversion asset |
   | InPort1_Carrier | The ID of the carrier of the first InPort of the Conversion asset |
   | InPort2_ID | The ID of the second InPort of the Conversion asset |
   | InPort2_Carrier | The ID of the carrier of the second InPort of the Conversion asset |
   | OutPort1_ID | The ID of the first OutPort of the Conversion asset |
   | OutPort1_Carrier | The ID of the carrier of the first OutPort of the Conversion asset |
   | OutPort2_ID | The ID of the second OutPort of the Conversion asset |
   | OutPort2_Carrier | The ID of the carrier of the second OutPort of the Conversion asset |
   | Sector_ID | The ID of the sector the Conversion asset belongs to |

6. Transport

   ![Transport](doc/Transport.png)

   This tab is the first tab that defines (part of) the Transport assets that will be added to the EnergySystem
   description. Use this tab for assets like ElectricityNetwork, GasNetwork and so on, if you want them to be
   represented on the map as a Marker icon. Another good example is the Joint asset, that can optionally be used to
   connect cables and or pipes together. These transport assets are added with one InPort and one OutPort.

   | Column | Description |
   | --- | ---|
   | ID | The ID of the Transport asset |
   | Name | The name of the Transport asset |
   | ESDLType | The ESDL class name of the Transport asset |
   | Lat | (Optional) The lattitude of the location of the Transport asset |
   | Lon | (Optional) The longitude of the location of the Transport asset |
   | AreaBld_ID | (Optional) The ID of the Area or Building the Transport asset will be added to |
   | Attributex | The name of the attribute of the Conversion asset (x must be an integer number) |
   | Valuex | The value of the attribute of the Conversion asset (x must be an integer number) |
   | InPort1_ID | The ID of the InPort of the Transport asset |
   | InPort1_Carrier | The ID of the carrier of the InPort of the Transport asset |
   | OutPort1_ID | The ID of the OutPort of the Transport asset |
   | OutPort1_Carrier | The ID of the carrier of the OutPort of the Transport asset |
   | Sector_ID | The ID of the sector the Transport asset belongs to |

7. CablesPipesConnections

   ![CablesPipesConnections](doc/CablesPipesConnections.png)

   This tab is the second tab that defines Transport assets and (logical) connections between assets that will be
   added to the EnergySystem description. Use this tab for ElectricityCables and Pipes, if you want them to be
   represented on the map as a Line between two locations. 'Connection' is a special type that can be entered as a
   value in the ESDLType column. Connections only have two values in the columns From_Port_ID and To_Port_ID.
   
   | Column | Description |
   | --- | ---|
   | ID | The ID of the Transport asset |
   | Name | The name of the Transport asset |
   | ESDLType | The ESDL class name of the Transport asset or 'Connection' |
   | AreaBld_ID | (Optional) The ID of the Area or Building the Cable or Pipe will be added to |
   | From_Port_ID | The ID of the port of the first asset that will be connected |
   | To_Port_ID | The ID of the port of the second asset that will be connected |
   | Attributex | The name of the attribute of the Conversion asset (x must be an integer number) |
   | Valuex | The value of the attribute of the Conversion asset (x must be an integer number) |
   | Sector_ID | The ID of the sector the asset belongs to |

8. InfluxDBProfiles

   This tab defines InfluxDBProfiles that can be referred to from the ConsumerProducer tab. An example value for a
   datetime would be "2018-12-31T23:00:00.0000"

   | ID | The ID of the profile |
   | Name | The name of the profile |
   | Host | The host(name) of the Influx Database server |
   | Port | The port of the Influx Database server |
   | Database | The name of the database |
   | Measurement | The name of the measurement |
   | Field | The name of the field |
   | Start_DateTime | Start date and time of the profile information (format: YYYY-MM-DDThh:mm:ss.zzzz) |
   | End_DateTime | End date and time of the profile information (format: YYYY-MM-DDThh:mm:ss.zzzz) |

9. Sectors

   This tab defines sectors which can be assigned to Areas and Assets.
   
   | Column | Description |
   | --- | ---|
   | ID | The ID of the Sector |
   | Name | The name of the Sector |
   | Description | (Optional) The description of the Sector |
   | Code | (Optional) The code of the Sector |

Examples
========

Simple Energy System
--------------------

The script generates an ESDL file with the name 'example_generated_network.esdl' based on the excel input file with the name 'infrastructure.xlsx'

The ESDL output, when loaded into the ESDL MapEditor, looks like this:

![ESDL Output](doc/ESDL_output.png)

Each commodity/carrier gets its own color:
- Electricity: blue
- Natural Gas: red
- Heat: green

The following assets are shown:
- GasProducer
- Pipe that connects the GasProducer with the PowerPlant (red solid line)
- PowerPlant
- ElectricityCable that connects the PowerPlant to the ElectricityNetwork (blue solid line)
- ElectricityNetwork 
- HeatPump, logically connected to the ElectricityNetwork (blue dashed line)
- HeatingDemand, logically connected to the HeatPump (green dashed line)
- ElectricityDemand, logically connected to the ElectricityNetwork (blue dashed line)

Simple Energy System (with Areas)
---------------------------------

The script generates an ESDL file with the name 'example_generated_network_2.esdl' based on the excel input file with the name 'infrastructure_2.xlsx'

This second example uses Areas with polygons to 'organize' the assets. The assets itself don't have coordinates anymore. When this ESDL is loaded in the ESDL MapEditor,
the MapEditor uses the knowledge that an asset is in a certain area, to assign a random coordinate within the area geometry to this asset.

The ESDL output, when loaded into the ESDL MapEditor, looks like this:

![ESDL Output](doc/ESDL_output_2.png)

Example 3
---------
Example 3 contains InfluxDB profiles, sectors and proper setting of quantities and units for profiles.