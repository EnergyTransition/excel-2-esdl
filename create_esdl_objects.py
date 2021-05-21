#  This work is based on original code developed and copyrighted by TNO 2020.
#  Subsequent contributions are licensed to you by the developers of such code and are
#  made available to the Project under one or several contributor license agreements.
#
#  This work is licensed to you under the Apache License, Version 2.0.
#  You may obtain a copy of the license at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
#  Contributors:
#      TNO         - Initial implementation
#  Manager:
#      TNO

import importlib

import esdl
from esdl import EnergySystem
from esdl.esdl_handler import EnergySystemHandler
from shape import Shape
from uuid import uuid4
from pyecore.ecore import EDate


multiplier_dict = {
    "k": "KILO",
    "M": "MEGA",
    "G": "GIGA",
    "T": "TERA"
}

unit_dict = {
    "W": "WATT",
    "J": "JOULE"
}


def create_qau(physical_quantity_string, unit_string):
    qau = esdl.QuantityAndUnitType(
        id=str(uuid4()),
        physicalQuantity=esdl.PhysicalQuantityEnum.from_string(physical_quantity_string),
        description=physical_quantity_string + ' in ' + unit_string
    )

    # Assume unit_string contains 1 or 2 characters for now
    qau.unit = esdl.UnitEnum.from_string(unit_dict[unit_string[-1]])
    if len(unit_string) == 2:
        qau.multiplier = esdl.MultiplierEnum.from_string(multiplier_dict[unit_string[0]])

    return qau


def set_attribute_value(esdl_object, attribute_name, value):
    attr = esdl_object.eClass.findEStructuralFeature(attribute_name)
    if attr:
        if value == "":
            attr_value = attr.eType.default_value
        else:
            attr_value = attr.eType.from_string(value)
        esdl_object.eSet(attribute_name, attr_value)
    else:
        print(f"Object {esdl_object.name}/{esdl_object.id} has invalid attribute {attribute_name}...   skipping!")
    return attr


def set_attributes_values(esdl_object, info_dict):
    for key in info_dict:
        if key.startswith("Attribute"):
            nr = key.replace("Attribute", "")
            if info_dict[key] is not None:
                set_attribute_value(esdl_object, info_dict[key], info_dict["Value"+nr])


def add_sectors(
    esh: EnergySystemHandler, es: EnergySystem, sector_dict
):
    esi = es.energySystemInformation
    if not esi:
        esi = esdl.EnergySystemInformation(id=str(uuid4()))
        es.energySystemInformation = esi
        esh.add_object(esi)

    sectors = esdl.Sectors(id=str(uuid4()))
    esi.sectors = sectors
    esh.add_object(sectors)

    for sect_id, sect_dict in sector_dict.items():
        if not sect_dict["ID"]:
            print("Reading invalid ID for Sectors (or empty line at end of Excel worksheet). Stopping...")
            break

        sector = esdl.Sector(
            id=sect_dict["ID"],
            name=sect_dict["Name"],
        )
        if sect_dict["Description"] not in [None, "", "NULL"]:
            sector.description = sect_dict["Description"]
        if sect_dict["Code"] not in [None, "", "NULL"]:
            sector.code = sect_dict["Code"]
        sectors.sector.append(sector)
        esh.add_object(sector)


def add_areas(esh: EnergySystemHandler, es: EnergySystem, area_dict: dict):
    found_top_level_area = False
    tl_area = es.instance[0].area

    for area_id, ar_dict in area_dict.items():
        if not ar_dict["ID"]:
            print("Reading invalid ID for Areas (or empty line at end of Excel worksheet). Stopping...")
            break
        if ar_dict["TopLevelArea"].upper() == "TRUE":
            if found_top_level_area:
                print("Error in Excel input - Areas tab contains more than one top level area")
                exit(1)
            found_top_level_area = True

            # remove current toplevel area from EnergySystem
            es.instance[0].area.delete()

            if ar_dict["Scope"] in [None, "", "NULL"]:
                tl_area_scope = esdl.AreaScopeEnum.from_string('UNDEFINED')
            else:
                tl_area_scope = esdl.AreaScopeEnum.from_string(ar_dict["Scope"])
            tl_area = esdl.Area(id=ar_dict["ID"], name=ar_dict["Name"], scope=tl_area_scope)

            if ar_dict["Area_WKT"] not in [None, "", "NULL"]:
                shape = Shape.parse_wkt(ar_dict["Area_WKT"])
                tl_area.geometry = shape.get_esdl()

            if "Sector_ID" in ar_dict and ar_dict["Sector_ID"] not in [None, "", "NULL"]:
                tl_area.sector = esh.get_by_id(ar_dict["Sector_ID"])

            es.instance[0].area = tl_area
            esh.add_object(tl_area)
        else:
            if ar_dict["Scope"] in [None, "", "NULL"]:
                sub_area_scope = esdl.AreaScopeEnum.from_string('UNDEFINED')
            else:
                sub_area_scope = esdl.AreaScopeEnum.from_string(ar_dict["Scope"])
            sub_area = esdl.Area(id=ar_dict["ID"], name=ar_dict["Name"], scope=sub_area_scope)

            if ar_dict["Area_WKT"] not in [None, "", "NULL"]:
                shape = Shape.parse_wkt(ar_dict["Area_WKT"])
                sub_area.geometry = shape.get_esdl()

            if "Sector_ID" in ar_dict and ar_dict["Sector_ID"] not in [None, "", "NULL"]:
                tl_area.sector = esh.get_by_id(ar_dict["Sector_ID"])

            if ar_dict["Parent_Area_ID"] in [None, "", "NULL"]:
                # Add to top level area
                tl_area.area.append(sub_area)
            else:
                # Find Parent Area
                parent_area = esh.get_by_id(ar_dict["Parent_Area_ID"])
                if not parent_area:
                    print(f"Parent Area of Area with ID {ar_dict['ID']} not found - adding to top level area")
                    tl_area.area.append(sub_area)
                else:
                    parent_area.area.append(sub_area)
            esh.add_object(sub_area)


def add_buildings(esh: EnergySystemHandler, es: EnergySystem, building_dict: dict):
    # To dynamically create instances of ESDL objects
    module = importlib.import_module("esdl")
    tl_area = es.instance[0].area

    for bld_id, bld_dict in building_dict.items():
        if not bld_dict["ESDLType"]:
            print(
                "Reading invalid ESDLType for Buildings (or empty line at end of Excel worksheet). Stopping...")
            break
        bld_class = getattr(module, bld_dict["ESDLType"])
        bld = bld_class()
        if not isinstance(bld, esdl.AbstractBuilding):
            raise Exception("Only subtypes of esdl.AbstractBuilding can be used as ESDLType in the Buildings tab")

        bld.id = bld_dict["ID"]
        bld.name = bld_dict["Name"]

        if bld_dict["Lat"] not in [None, "", "NULL"] and bld_dict["Lon"] not in [None, "", "NULL"]:
            bld.geometry = esdl.Point(lat=float(bld_dict["Lat"]), lon=float(bld_dict["Lon"]))

        if "Sector_ID" in bld_dict and bld_dict["Sector_ID"] not in [None, "", "NULL"]:
            bld.sector = esh.get_by_id(bld_dict["Sector_ID"])

        if bld_dict["Parent_Area_ID"] in [None, "", "NULL"]:
            tl_area.asset.append(bld)
        else:
            area = esh.get_by_id(bld_dict["Parent_Area_ID"])
            if not area:
                print(f"Parent Area of Building with ID {bld_dict['ID']} not found - adding to top level area")
                tl_area.asset.append(bld)
            else:
                area.asset.append(bld)
        esh.add_object(bld)


def add_carriers(esh: EnergySystemHandler, es: EnergySystem, carrier_dict: dict):
    esi = es.energySystemInformation
    if not esi:
        esi = esdl.EnergySystemInformation(id=str(uuid4()))
        es.energySystemInformation = esi
        esh.add_object(esi)
    carrs = esdl.Carriers(id="carrs")
    esi.carriers = carrs

    # To dynamically create instances of ESDL objects
    module = importlib.import_module("esdl")

    for carr_id, carr_dict in carrier_dict.items():
        if not carr_dict["ESDLType"]:
            print(
                "Reading invalid ESDLType for Carriers (or empty line at end of Excel worksheet). Stopping..."
            )
            break
        carr_class = getattr(module, carr_dict["ESDLType"])
        carr = carr_class()

        carr.id = carr_id
        carr.name = carr_dict["Name"]

        carrs.carrier.append(carr)
        esh.add_object(carr)


def add_producers_consumers(
    esh: EnergySystemHandler, es: EnergySystem, cons_prod_dict: dict, influxdb_profile_dict: dict
):
    tl_area = es.instance[0].area

    # To dynamically create instances of ESDL objects
    module = importlib.import_module("esdl")

    for cp_id, cp_info in cons_prod_dict.items():
        if not cp_info["ESDLType"]:
            print(
                "Reading invalid ESDLType for ProcudersConsumers (or empty line at end of Excel worksheet). Stopping..."
            )
            break
        cp_class = getattr(module, cp_info["ESDLType"])
        cp = cp_class()

        cp.id = cp_id
        cp.name = cp_info["Name"]
        cp.power = float(cp_info["Power"])

        if isinstance(cp, esdl.Consumer):
            port = esdl.InPort()
            port.name = "In"
        elif isinstance(cp, esdl.Producer):
            port = esdl.OutPort()
            port.name = "Out"
        else:
            print(
                "Item in ConsumerProducer tab of excel is not an esdl.Consumer nor an esdl.Producer...   skipping!"
            )
            continue

        cp.port.append(port)
        port.id = cp_info["Port_ID"]
        esh.add_object(port)
        port.carrier = esh.get_by_id(cp_info["Carrier_ID"])

        if cp_info["Profile_ESDLType"] == "SingleValue":
            profile = esdl.SingleValue(
                id=cp_info["Profile_ID"],
                value=float(cp_info["Profile_Value"]),
                profileQuantityAndUnit=create_qau(cp_info["Profile_Physical_Quantity"], cp_info["Profile_Unit"])
            )
            port.profile.append(profile)
        elif cp_info["Profile_ESDLType"] == "InfluxDBProfile":
            influxdb_profile_data = influxdb_profile_dict[cp_info["Profile_Reference_ID"]]
            profile = esdl.InfluxDBProfile(
                id=influxdb_profile_data["ID"],
                name=influxdb_profile_data["Name"],
                host=influxdb_profile_data["Host"],
                port=int(influxdb_profile_data["Port"]),
                database=influxdb_profile_data["Database"],
                measurement=influxdb_profile_data["Measurement"],
                field=influxdb_profile_data["Field"],
                startDate=EDate.from_string(influxdb_profile_data["Start_DateTime"]),
                endDate=EDate.from_string(influxdb_profile_data["End_DateTime"]),
                multiplier=float(cp_info["Profile_Value"]),
                profileQuantityAndUnit=create_qau(cp_info["Profile_Physical_Quantity"], cp_info["Profile_Unit"])
            )
            port.profile.append(profile)

        if cp_info["Lat"] not in [None, "", "NULL"] and cp_info["Lon"] not in [None, "", "NULL"]:
            cp.geometry = esdl.Point(lat=float(cp_info["Lat"]), lon=float(cp_info["Lon"]))

        if "Sector_ID" in cp_info and cp_info["Sector_ID"] not in [None, "", "NULL"]:
            cp.sector = esh.get_by_id(cp_info["Sector_ID"])

        if cp_info["AreaBld_ID"] in [None, "", "NULL"]:
            tl_area.asset.append(cp)
        else:
            asset_container = esh.get_by_id(cp_info["AreaBld_ID"])
            if not asset_container:
                print(f"Parent container of asset with ID {cp_info['ID']} not found - adding to top level area")
                tl_area.asset.append(cp)
            else:
                asset_container.asset.append(cp)
        esh.add_object(cp)


def add_conversions(esh: EnergySystemHandler, es: EnergySystem, conv_dict: dict):
    tl_area = es.instance[0].area

    # To dynamically create instances of ESDL objects
    module = importlib.import_module("esdl")

    for conv_id, conv_info in conv_dict.items():
        if not conv_info["ESDLType"]:
            print("Reading invalid ESDLType for Conversions (or empty line at end of Excel worksheet). Stopping...")
            break
        conv_class = getattr(module, conv_info["ESDLType"])
        conv = conv_class()

        conv.id = conv_id
        conv.name = conv_info["Name"]
        conv.power = float(conv_info["Power"])

        set_attributes_values(conv, conv_info)

        for ipx in range(1, 3):
            if conv_info["InPort" + str(ipx) + "_ID"] not in [None, "", "NULL"]:
                inp = esdl.InPort(
                    id=conv_info["InPort" + str(ipx) + "_ID"], name="In" + str(ipx)
                )
                inp.carrier = esh.get_by_id(conv_info["InPort" + str(ipx) + "_Carrier"])
                conv.port.append(inp)
                esh.add_object(inp)
        for opx in range(1, 3):
            if conv_info["OutPort" + str(opx) + "_ID"] not in [None, "", "NULL"]:
                outp = esdl.OutPort(
                    id=conv_info["OutPort" + str(opx) + "_ID"], name="Out" + str(opx)
                )
                outp.carrier = esh.get_by_id(
                    conv_info["OutPort" + str(opx) + "_Carrier"]
                )
                conv.port.append(outp)
                esh.add_object(outp)

        if conv_info["Lat"] not in [None, "", "NULL"] and conv_info["Lon"] not in [None, "", "NULL"]:
            conv.geometry = esdl.Point(
                lat=float(conv_info["Lat"]), lon=float(conv_info["Lon"])
            )

        if "Sector_ID" in conv_info and conv_info["Sector_ID"] not in [None, "", "NULL"]:
            conv.sector = esh.get_by_id(conv_info["Sector_ID"])

        if conv_info["AreaBld_ID"] in [None, "", "NULL"]:
            tl_area.asset.append(conv)
        else:
            asset_container = esh.get_by_id(conv_info["AreaBld_ID"])
            if not asset_container:
                print(f"Parent container of asset with ID {conv_info['ID']} not found - adding to top level area")
                tl_area.asset.append(conv)
            else:
                asset_container.asset.append(conv)
        esh.add_object(conv)


def add_transports(esh: EnergySystemHandler, es: EnergySystem, transp_dict: dict):
    tl_area = es.instance[0].area

    # To dynamically create instances of ESDL objects
    module = importlib.import_module("esdl")

    for transp_id, transp_info in transp_dict.items():
        if not transp_info["ESDLType"]:
            print("Reading invalid ESDLType for Transports (or empty line at end of Excel worksheet). Stopping...")
            break
        transp_class = getattr(module, transp_info["ESDLType"])
        transp = transp_class()

        transp.id = transp_id
        transp.name = transp_info["Name"]

        inp = esdl.InPort(id=transp_info["InPort1_ID"], name="In1")
        inp.carrier = esh.get_by_id(transp_info["InPort1_Carrier"])
        transp.port.append(inp)
        esh.add_object(inp)

        outp = esdl.OutPort(id=transp_info["OutPort1_ID"], name="Out1")
        outp.carrier = esh.get_by_id(transp_info["OutPort1_Carrier"])
        transp.port.append(outp)
        esh.add_object(outp)

        if transp_info["Lat"] not in [None, "", "NULL"] and transp_info["Lon"] not in [None, "", "NULL"]:
            transp.geometry = esdl.Point(
                lat=float(transp_info["Lat"]), lon=float(transp_info["Lon"])
            )

        if "Sector_ID" in transp_info and transp_info["Sector_ID"] not in [None, "", "NULL"]:
            transp.sector = esh.get_by_id(transp_info["Sector_ID"])

        if transp_info["AreaBld_ID"] in [None, "", "NULL"]:
            tl_area.asset.append(transp)
        else:
            asset_container = esh.get_by_id(transp_info["AreaBld_ID"])
            if not asset_container:
                print(f"Parent container of asset with ID {transp_info['ID']} not found - adding to top level area")
                tl_area.asset.append(transp)
            else:
                asset_container.asset.append(transp)
        esh.add_object(transp)


def add_cabels_pipes_connections(
    esh: EnergySystemHandler, es: EnergySystem, cables_pipes_conns_list
):
    tl_area = es.instance[0].area

    # To dynamically create instances of ESDL objects
    module = importlib.import_module("esdl")

    for cpc in cables_pipes_conns_list:
        if not cpc["From_Port_ID"]:
            print(
                "Reading invalid From_Port_ID for CablesPipesConnections (or empty line at end of Excel worksheet)."
                + "Stopping..."
            )
            break
        inp_location = None
        outp_location = None

        from_port = esh.get_by_id(cpc["From_Port_ID"])
        to_port = esh.get_by_id(cpc["To_Port_ID"])

        if type(from_port) == type(to_port):
            print(
                f'Ports of same type cannot be connected (ID: {cpc["ID"]})...   skipping!'
            )
            continue

        if cpc["ESDLType"] == "Connection":
            from_port.connectedTo.append(to_port)
        else:
            link_class = getattr(module, cpc["ESDLType"])
            link = link_class()

            link.id = cpc["ID"]
            link.name = cpc["Name"]

            inp = esdl.InPort(id=cpc["ID"] + "IP1", name="In1")
            if isinstance(from_port, esdl.OutPort):
                inp.connectedTo.append(from_port)
                inp.carrier = from_port.carrier

                from_asset = from_port.eContainer()
                if from_asset.geometry:
                    inp_location = esdl.Point(
                        lat=from_asset.geometry.lat, lon=from_asset.geometry.lon
                    )
            else:
                inp.connectedTo.append(to_port)
                inp.carrier = to_port.carrier

                to_asset = to_port.eContainer()
                if to_asset.geometry:
                    inp_location = esdl.Point(
                        lat=to_asset.geometry.lat, lon=to_asset.geometry.lon
                    )

            link.port.append(inp)
            esh.add_object(inp)

            outp = esdl.OutPort(id=cpc["ID"] + "OP1", name="Out1")
            if isinstance(from_port, esdl.InPort):
                outp.connectedTo.append(from_port)
                outp.carrier = from_port.carrier

                from_asset = from_port.eContainer()
                if from_asset.geometry:
                    outp_location = esdl.Point(
                        lat=from_asset.geometry.lat, lon=from_asset.geometry.lon
                    )
            else:
                outp.connectedTo.append(to_port)
                outp.carrier = to_port.carrier

                to_asset = to_port.eContainer()
                if to_asset.geometry:
                    outp_location = esdl.Point(
                        lat=to_asset.geometry.lat, lon=to_asset.geometry.lon
                    )

            link.port.append(outp)
            esh.add_object(outp)

            if inp_location and outp_location:
                link.geometry = esdl.Line()
                link.geometry.point.append(inp_location)
                link.geometry.point.append(outp_location)

            if "Sector_ID" in cpc and cpc["Sector_ID"] not in [None, "", "NULL"]:
                link.sector = esh.get_by_id(cpc["Sector_ID"])

            if cpc["AreaBld_ID"] in [None, "", "NULL"]:
                tl_area.asset.append(link)
            else:
                asset_container = esh.get_by_id(cpc["AreaBld_ID"])
                if not asset_container:
                    print(f"Parent container of asset with ID {cpc['ID']} not found - adding to top level area")
                    tl_area.asset.append(link)
                else:
                    asset_container.asset.append(link)
            esh.add_object(link)
