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


def add_carriers(esh: EnergySystemHandler, es: EnergySystem, carrier_dict: dict):
    esi = esdl.EnergySystemInformation()
    es.energySystemInformation = esi
    carrs = esdl.Carriers(id="carrs")
    esi.carriers = carrs

    # To dynamically create instances of ESDL objects
    module = importlib.import_module("esdl")

    for carr_id, carr_dict in carrier_dict.items():
        carr_class = getattr(module, carr_dict["ESDLType"])
        carr = carr_class()

        carr.id = carr_id
        carr.name = carr_dict["Name"]

        carrs.carrier.append(carr)
        esh.add_object(carr)


def add_producers_consumers(
    esh: EnergySystemHandler, es: EnergySystem, cons_prod_dict: dict
):
    area = es.instance[0].area

    # To dynamically create instances of ESDL objects
    module = importlib.import_module("esdl")

    for cp_id, cp_info in cons_prod_dict.items():
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
            profile = esdl.SingleValue()
            profile.id = cp_info["Profile_ID"]
            profile.value = float(cp_info["Profile_Value"])
            port.profile.append(profile)

        cp.geometry = esdl.Point(lat=float(cp_info["Lat"]), lon=float(cp_info["Lon"]))

        area.asset.append(cp)
        esh.add_object(cp)


def add_conversions(esh: EnergySystemHandler, es: EnergySystem, conv_dict: dict):
    area = es.instance[0].area

    # To dynamically create instances of ESDL objects
    module = importlib.import_module("esdl")

    for conv_id, conv_info in conv_dict.items():
        conv_class = getattr(module, conv_info["ESDLType"])
        conv = conv_class()

        conv.id = conv_id
        conv.name = conv_info["Name"]
        conv.power = float(conv_info["Power"])

        eff_attr = conv.eClass.findEStructuralFeature(conv_info["Efficiency_attribute"])
        if eff_attr:
            conv.eSet(
                conv_info["Efficiency_attribute"], float(conv_info["Efficiency_value"])
            )
        else:
            print(
                "Item in Conversion tab of excel has invalid Efficiency_attribute...   skipping!"
            )
            continue

        for ipx in range(1, 3):
            if conv_info["InPort" + str(ipx) + "_ID"] != "NULL":
                inp = esdl.InPort(
                    id=conv_info["InPort" + str(ipx) + "_ID"], name="In" + str(ipx)
                )
                inp.carrier = esh.get_by_id(conv_info["InPort" + str(ipx) + "_Carrier"])
                conv.port.append(inp)
                esh.add_object(inp)
        for opx in range(1, 3):
            if conv_info["InPort" + str(opx) + "_ID"] != "NULL":
                outp = esdl.OutPort(
                    id=conv_info["OutPort" + str(opx) + "_ID"], name="Out" + str(opx)
                )
                outp.carrier = esh.get_by_id(
                    conv_info["OutPort" + str(opx) + "_Carrier"]
                )
                conv.port.append(outp)
                esh.add_object(outp)

        conv.geometry = esdl.Point(
            lat=float(conv_info["Lat"]), lon=float(conv_info["Lon"])
        )

        area.asset.append(conv)
        esh.add_object(conv)


def add_transports(esh: EnergySystemHandler, es: EnergySystem, transp_dict: dict):
    area = es.instance[0].area

    # To dynamically create instances of ESDL objects
    module = importlib.import_module("esdl")

    for transp_id, transp_info in transp_dict.items():
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

        transp.geometry = esdl.Point(
            lat=float(transp_info["Lat"]), lon=float(transp_info["Lon"])
        )

        area.asset.append(transp)
        esh.add_object(transp)


def add_cabels_pipes_connections(
    esh: EnergySystemHandler, es: EnergySystem, cables_pipes_conns_list
):
    area = es.instance[0].area

    # To dynamically create instances of ESDL objects
    module = importlib.import_module("esdl")

    for cpc in cables_pipes_conns_list:
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
                inp_location = esdl.Point(
                    lat=from_asset.geometry.lat, lon=from_asset.geometry.lon
                )
            else:
                inp.connectedTo.append(to_port)
                inp.carrier = to_port.carrier

                to_asset = to_port.eContainer()
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
                outp_location = esdl.Point(
                    lat=from_asset.geometry.lat, lon=from_asset.geometry.lon
                )
            else:
                outp.connectedTo.append(to_port)
                outp.carrier = to_port.carrier

                to_asset = to_port.eContainer()
                outp_location = esdl.Point(
                    lat=to_asset.geometry.lat, lon=to_asset.geometry.lon
                )

            link.port.append(outp)
            esh.add_object(outp)

            link.geometry = esdl.Line()
            link.geometry.point.append(inp_location)
            link.geometry.point.append(outp_location)

            area.asset.append(link)
            esh.add_object(link)
