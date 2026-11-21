{
	"patcher" : 	{
		"fileversion" : 1,
		"appversion" : { "major" : 9, "minor" : 0, "revision" : 0, "architecture" : "x64", "modernui" : 1 },
		"classnamespace" : "box",
		"rect" : [ 100.0, 100.0, 420.0, 260.0 ],
		"boxes" : [
			{ "box" : { "id" : "obj-1", "maxclass" : "newobj", "text" : "loadbang", "numinlets" : 1, "numoutlets" : 1, "outlettype" : [ "bang" ], "patching_rect" : [ 20.0, 20.0, 60.0, 22.0 ] } },
			{ "box" : { "id" : "obj-2", "maxclass" : "newobj", "text" : "delay 500", "numinlets" : 2, "numoutlets" : 1, "outlettype" : [ "bang" ], "patching_rect" : [ 20.0, 50.0, 60.0, 22.0 ] } },
			{ "box" : { "id" : "obj-3", "maxclass" : "newobj", "text" : "t b b", "numinlets" : 1, "numoutlets" : 2, "outlettype" : [ "bang", "bang" ], "patching_rect" : [ 20.0, 80.0, 40.0, 22.0 ] } },
			{ "box" : { "id" : "obj-4", "maxclass" : "newobj", "text" : "j.spike.a", "numinlets" : 1, "numoutlets" : 1, "outlettype" : [ "" ], "patching_rect" : [ 20.0, 120.0, 60.0, 22.0 ] } },
			{ "box" : { "id" : "obj-5", "maxclass" : "newobj", "text" : "j.spike.b", "numinlets" : 1, "numoutlets" : 1, "outlettype" : [ "" ], "patching_rect" : [ 120.0, 120.0, 60.0, 22.0 ] } },
			{ "box" : { "id" : "obj-6", "maxclass" : "newobj", "text" : "js smoke.js", "numinlets" : 1, "numoutlets" : 1, "outlettype" : [ "" ], "patching_rect" : [ 20.0, 170.0, 80.0, 22.0 ] } },
			{ "box" : { "id" : "obj-7", "maxclass" : "message", "text" : ";max quit", "numinlets" : 2, "numoutlets" : 1, "outlettype" : [ "" ], "patching_rect" : [ 20.0, 210.0, 70.0, 22.0 ] } }
		],
		"lines" : [
			{ "patchline" : { "source" : [ "obj-1", 0 ], "destination" : [ "obj-2", 0 ] } },
			{ "patchline" : { "source" : [ "obj-2", 0 ], "destination" : [ "obj-3", 0 ] } },
			{ "patchline" : { "source" : [ "obj-3", 1 ], "destination" : [ "obj-4", 0 ] } },
			{ "patchline" : { "source" : [ "obj-3", 0 ], "destination" : [ "obj-5", 0 ] } },
			{ "patchline" : { "source" : [ "obj-4", 0 ], "destination" : [ "obj-6", 0 ] } },
			{ "patchline" : { "source" : [ "obj-5", 0 ], "destination" : [ "obj-6", 0 ] } },
			{ "patchline" : { "source" : [ "obj-6", 0 ], "destination" : [ "obj-7", 0 ] } }
		]
	}
}
