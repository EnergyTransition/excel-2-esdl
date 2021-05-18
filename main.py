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
    add_areas,
    add_buildings,
    add_carriers,
    add_producers_consumers,
    add_conversions,
    add_transports,
    add_cabels_pipes_connections,
)
from read_infra_excel import read_infra_from_excel


if __name__ == "__main__":
    (
        area_dict,
        building_dict,
        carrier_dict,
        cons_prod_dict,
        conv_dict,
        transp_dict,
        cables_pipes_conns_list,
    ) = read_infra_from_excel(r"data\infrastructure.xlsx")

    esh = EnergySystemHandler()
    es = esh.create_empty_energy_system(
        name="ES1",
        es_description="Energy System created from an Excel file",
        inst_title="Instance1",
        area_title="Area1",
    )

    add_areas(esh, es, area_dict)
    add_buildings(esh, es, building_dict)
    add_carriers(esh, es, carrier_dict)
    add_producers_consumers(esh, es, cons_prod_dict)
    add_conversions(esh, es, conv_dict)
    add_transports(esh, es, transp_dict)
    add_cabels_pipes_connections(esh, es, cables_pipes_conns_list)

    print(es)
    esh.save(filename="example_generated_network.esdl")

    (
        area_dict,
        building_dict,
        carrier_dict,
        cons_prod_dict,
        conv_dict,
        transp_dict,
        cables_pipes_conns_list,
    ) = read_infra_from_excel(r"data\infrastructure_2.xlsx")

    es2 = esh.create_empty_energy_system(
        name="ES2",
        es_description="More complex Energy System created from an Excel file",
        inst_title="Instance1",
        area_title="Area1",
    )

    add_areas(esh, es2, area_dict)
    add_buildings(esh, es2, building_dict)
    add_carriers(esh, es2, carrier_dict)
    add_producers_consumers(esh, es2, cons_prod_dict)
    add_conversions(esh, es2, conv_dict)
    add_transports(esh, es2, transp_dict)
    add_cabels_pipes_connections(esh, es2, cables_pipes_conns_list)

    print(es2)
    esh.save(filename="example_generated_network_2.esdl")