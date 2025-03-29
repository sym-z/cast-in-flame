extends NavigationRegion2D
class_name NavMeshMaker

@export var nav_agent_radius: float = 80
# TODO make sure both bake calls are needed
func make_mesh(corners):
	var polygon = NavigationPolygon.new()
	polygon.add_outline(corners)
	polygon.agent_radius = nav_agent_radius
	polygon.source_geometry_group_name = "pathfinder_collision"
	polygon.source_geometry_mode = NavigationPolygon.SOURCE_GEOMETRY_GROUPS_EXPLICIT
	NavigationServer2D.bake_from_source_geometry_data(polygon, NavigationMeshSourceGeometryData2D.new());
	navigation_polygon = polygon	
	bake_navigation_polygon()
