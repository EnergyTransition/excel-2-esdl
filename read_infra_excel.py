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


def read_infra_from_excel(filename):
    wb = load_workbook(filename, data_only=True)

    carrier_dict = dict()
    cons_prod_dict = dict()
    conv_dict = dict()
    transp_dict = dict()
    cables_pipes_conns_list = list()

    if wb:
        sheet = wb["Carriers"]
        contents = sheet.values

        i = 0
        for row in contents:
            if i == 0:
                keys = row

            if i > 0:
                d = dict(zip(keys, row))
                carr_id = d["ID"]
                carrier_dict[carr_id] = d

            i = i + 1

        sheet = wb["ConsumerProducer"]
        contents = sheet.values

        i = 0
        for row in contents:
            if i == 0:
                keys = row

            if i > 0:
                d = dict(zip(keys, row))
                cp_id = d["ID"]
                cons_prod_dict[cp_id] = d

            i = i + 1

        sheet = wb["Conversion"]
        contents = sheet.values

        i = 0
        for row in contents:
            if i == 0:
                keys = row

            if i > 0:
                d = dict(zip(keys, row))
                conv_id = d["ID"]
                conv_dict[conv_id] = d

            i = i + 1

        sheet = wb["Transport"]
        contents = sheet.values

        i = 0
        for row in contents:
            if i == 0:
                keys = row

            if i > 0:
                d = dict(zip(keys, row))
                transp_id = d["ID"]
                transp_dict[transp_id] = d

            i = i + 1

        sheet = wb["CablesPipesConnections"]
        contents = sheet.values

        i = 0
        for row in contents:
            if i == 0:
                keys = row

            if i > 0:
                d = dict(zip(keys, row))
                cables_pipes_conns_list.append(d)

            i = i + 1

    return carrier_dict, cons_prod_dict, conv_dict, transp_dict, cables_pipes_conns_list
