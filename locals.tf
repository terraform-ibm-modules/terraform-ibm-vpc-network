locals {
  routing_table_route_list = flatten([
    for routing_table in var.routing_table_list : [
      for route in routing_table["routes"] : [
        merge(route, { routing_table_name : routing_table["name"] })
      ]
    ]
  ])
}