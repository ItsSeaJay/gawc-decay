extends Node

func post_import(scene):
	for layer in scene.get_children():
		# This is a tile layer
		if layer is TileMap:
			var tilemap : TileMap = layer as TileMap
			var tileset : TileSet = tilemap.get_tileset()
			
			for cell in tilemap.get_used_cells():
				pass
		elif layer is Node2D:
			# This is an object layer
			for object in layer.get_children():
				if object.has_meta("scene"):
					print(object.get_meta_list())
					
					var instance = load(get_meta("type")).instance()
					
					instance.set_global_position(object.get_global_position())
					
					if instance != null:
						scene.add_child(instance)
						instance.set_owner(scene)
			
			layer.free()
	
	return scene
