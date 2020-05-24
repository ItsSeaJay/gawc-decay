extends Node

func post_import(scene):
	print("Post import on ", scene.get_name(), ".tmx")
	
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
				if object.has_meta("type"):
					var type = object.get_meta("type")
					var instance = load(type).instance()
				
					instance.set_position(object.get_position() + Vector2(8, -8))
					
					if instance != null:
						scene.add_child(instance)
						instance.set_owner(scene)
						
						print("Added ", object.get_meta("type"), " at ", object.get_position())
			
			layer.free()
	
	return scene
