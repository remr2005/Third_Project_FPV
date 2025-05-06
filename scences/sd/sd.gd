extends Node3D

var map_width = 50
var map_height = 50
var max_height = 10.0
var noise_scale = 0.1
var noise = FastNoiseLite.new()

func _ready():
	var mesh_data = create_terrain_mesh(map_width, map_height)
	
	var terrain_mesh = ArrayMesh.new()
	terrain_mesh.add_surface_from_arrays(Mesh.PRIMITIVE_TRIANGLES, mesh_data)
	
	var mesh_instance = MeshInstance3D.new()
	mesh_instance.mesh = terrain_mesh
	add_child(mesh_instance)
	
	# Коллизия
	var collision_shape = CollisionShape3D.new()
	var concave_shape = ConcavePolygonShape3D.new()
	
	# Получаем вершины треугольников
	var faces = []
	var vertices = mesh_data[Mesh.ARRAY_VERTEX]
	var indices = mesh_data[Mesh.ARRAY_INDEX]
	for i in range(0, indices.size(), 3):
		var i1 = indices[i]
		var i2 = indices[i + 1]
		var i3 = indices[i + 2]
		faces.append(vertices[i1])
		faces.append(vertices[i2])
		faces.append(vertices[i3])
	
	concave_shape.set_faces(faces)
	collision_shape.shape = concave_shape
	add_child(collision_shape)

func create_terrain_mesh(width: int, height: int) -> Array:
	var vertices = []
	var indices = []
	
	for y in range(height):
		for x in range(width):
			var height_at_point = noise.get_noise_2d(x * noise_scale, y * noise_scale) * max_height
			vertices.append(Vector3(x, height_at_point, y))
	
	for y in range(height - 1):
		for x in range(width - 1):
			var i1 = y * width + x
			var i2 = i1 + 1
			var i3 = (y + 1) * width + x
			var i4 = i3 + 1
			
			indices.append(i1)
			indices.append(i2)
			indices.append(i3)
			
			indices.append(i2)
			indices.append(i4)
			indices.append(i3)
	
	var arrays = []
	arrays.resize(Mesh.ARRAY_MAX)
	arrays[Mesh.ARRAY_VERTEX] = PackedVector3Array(vertices)
	arrays[Mesh.ARRAY_INDEX] = PackedInt32Array(indices)
	return arrays

