package net.axgl.black.assets {
	public class Resource {
		[Embed(source = "world/tiles.png")] public static const TILESET:Class;
		[Embed(source = "world/map_tiny.png")] public static const MAP_TINY:Class;
		[Embed(source = "world/map.png")] public static const MAP:Class;
		[Embed(source = "world/map_large.png")] public static const MAP_LARGE:Class;
		// Fails with 0.9.2, buffer too big. Goal is to make this work.
		[Embed(source = "world/map_giant.png")] public static const MAP_GIANT:Class;
	}
}
