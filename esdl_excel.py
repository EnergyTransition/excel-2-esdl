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

from openpyxl import load_workbook


def read_ws_to_list(wb, ws_name):
    ws_list = list()
    sheet = wb[ws_name]
    contents = sheet.values

    i = 0
    for row in contents:
        if i == 0:
            keys = row

        if i > 0:
            d = dict(zip(keys, row))
            ws_list.append(d)

        i = i + 1

    return ws_list


def read_ws_to_dict(wb, ws_name):
    wb_dict = dict()
    sheet = wb[ws_name]
    contents = sheet.values

    i = 0
    for row in contents:
        if i == 0:
            keys = row

        if i > 0:
            d = dict(zip(keys, row))
            row_id = d["ID"]
            wb_dict[row_id] = d

        i = i + 1

    return wb_dict


def read_energy_system_data_from_excel(filename):
    wb = load_workbook(filename, data_only=True)

    area_dict = dict()
    building_dict = dict()
    carrier_dict = dict()
    cons_prod_dict = dict()
    conv_dict = dict()
    transp_dict = dict()
    cables_pipes_conns_list = list()
    influxdb_profiles_dict = dict()
    sectors_dict = dict()

    if wb:
        if "Areas" in wb:
            area_dict = read_ws_to_dict(wb, "Areas")
        if "Buildings" in wb:
            building_dict = read_ws_to_dict(wb, "Buildings")
        if "Carriers" in wb:
            carrier_dict = read_ws_to_dict(wb, "Carriers")
        if "ConsumerProducer" in wb:
            cons_prod_dict = read_ws_to_dict(wb, "ConsumerProducer")
        if "Conversion" in wb:
            conv_dict = read_ws_to_dict(wb, "Conversion")
        if "Transport" in wb:
            transp_dict = read_ws_to_dict(wb, "Transport")
        if "CablesPipesConnections" in wb:
            cables_pipes_conns_list = read_ws_to_list(wb, "CablesPipesConnections")
        if "InfluxDBProfiles" in wb:
            influxdb_profiles_dict = read_ws_to_dict(wb, "InfluxDBProfiles")
        if "Sectors" in wb:
            sectors_dict = read_ws_to_dict(wb, "Sectors")

    return area_dict, building_dict, carrier_dict, cons_prod_dict, conv_dict, transp_dict, cables_pipes_conns_list, \
        influxdb_profiles_dict, sectors_dict
