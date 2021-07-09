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

from esdl.esdl_handler import EnergySystemHandler

from create_esdl_objects import (
    add_sectors,
    add_areas,
    add_buildings,
    add_carriers,
    add_producers_consumers,
    add_conversions,
    add_transports,
    add_cabels_pipes_connections,
)
from esdl_excel import read_energy_system_data_from_excel


def convert_excel_to_esdl(excel_filename, esdl_filename, es_name, es_descr, inst_title, area_title):
    (
        area_dict,
        building_dict,
        carrier_dict,
        cons_prod_dict,
        conv_dict,
        transp_dict,
        cables_pipes_conns_list,
        influxdb_profiles_dict,
        sectors_dict,
    ) = read_energy_system_data_from_excel(excel_filename)

    esh = EnergySystemHandler()
    es = esh.create_empty_energy_system(
        name=es_name,
        es_description=es_descr,
        inst_title=inst_title,
        area_title=area_title,
    )

    add_sectors(esh, es, sectors_dict)
    add_areas(esh, es, area_dict)
    add_buildings(esh, es, building_dict)
    add_carriers(esh, es, carrier_dict)
    add_producers_consumers(esh, es, cons_prod_dict, influxdb_profiles_dict)
    add_conversions(esh, es, conv_dict, influxdb_profiles_dict)
    add_transports(esh, es, transp_dict)
    add_cabels_pipes_connections(esh, es, cables_pipes_conns_list)

    esh.save(filename=esdl_filename)


if __name__ == "__main__":
    convert_excel_to_esdl(
        excel_filename=r"data\infrastructure.xlsx",
        esdl_filename="example_generated_network.esdl",
        es_name="ES1",
        es_descr="Energy System created from an Excel file",
        inst_title="Instance1",
        area_title="Area1",
    )

    convert_excel_to_esdl(
        excel_filename=r"data\infrastructure_2.xlsx",
        esdl_filename="example_generated_network_2.esdl",
        es_name="ES2",
        es_descr="More complex Energy System created from an Excel file",
        inst_title="Instance1",
        area_title="Area1",
    )

    convert_excel_to_esdl(
        excel_filename=r"data\infrastructure_3.xlsx",
        esdl_filename="example_generated_network_3.esdl",
        es_name="ES3",
        es_descr="Energy System created from an Excel file with Sectors, InfluxDBProfiles, QuantityAndUnits",
        inst_title="Instance1",
        area_title="Area1",
    )

    convert_excel_to_esdl(
        excel_filename=r"data\infrastructure_4.xlsx",
        esdl_filename="example_generated_network_4.esdl",
        es_name="ES4",
        es_descr="Energy System created from an Excel file with ControlStrategies and MarginalCosts",
        inst_title="Instance1",
        area_title="Area1",
    )
