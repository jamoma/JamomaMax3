{
	"patcher": {
		"fileversion": 1,
		"appversion": {
			"major": 7,
			"minor": 0,
			"revision": 5,
			"architecture": "x86",
			"modernui": 1
		},
		"rect": [
			438.0,
			220.0,
			900.0,
			665.0
		],
		"bglocked": 0,
		"openinpresentation": 1,
		"default_fontsize": 12.0,
		"default_fontface": 0,
		"default_fontname": "Arial",
		"gridonopen": 1,
		"gridsize": [
			15.0,
			15.0
		],
		"gridsnaponopen": 1,
		"objectsnaponopen": 1,
		"statusbarvisible": 2,
		"toolbarvisible": 0,
		"lefttoolbarpinned": 0,
		"toptoolbarpinned": 0,
		"righttoolbarpinned": 0,
		"bottomtoolbarpinned": 0,
		"toolbars_unpinned_last_save": 0,
		"tallnewobj": 0,
		"boxanimatetime": 200,
		"enablehscroll": 1,
		"enablevscroll": 1,
		"devicewidth": 0.0,
		"description": "",
		"digest": "",
		"tags": "",
		"style": "",
		"subpatcher_template": "",
		"title": "mapper",
		"boxes": [
			{
				"box": {
					"id": "obj-214",
					"linecount": 2,
					"maxclass": "message",
					"numinlets": 2,
					"numoutlets": 1,
					"outlettype": [
						""
					],
					"patching_rect": [
						1349.5,
						71.2,
						101.0,
						35.0
					],
					"style": "default",
					"text": "function/parameters"
				}
			},
			{
				"box": {
					"fontface": 1,
					"fontname": "Arial",
					"id": "obj-218",
					"maxclass": "comment",
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [
						572.333374,
						39.4,
						150.0,
						21.0
					],
					"presentation": 1,
					"presentation_rect": [
						565.0,
						52.0,
						63.0,
						21.0
					],
					"style": "",
					"text": "clipmode:"
				}
			},
			{
				"box": {
					"id": "obj-216",
					"maxclass": "newobj",
					"numinlets": 2,
					"numoutlets": 2,
					"outlettype": [
						"",
						""
					],
					"patching_rect": [
						556.0,
						157.6,
						142.0,
						22.0
					],
					"style": "",
					"text": "substitute set setsymbol"
				}
			},
			{
				"box": {
					"id": "obj-176",
					"maxclass": "newobj",
					"numinlets": 1,
					"numoutlets": 4,
					"outlettype": [
						"",
						"",
						"",
						""
					],
					"patching_rect": [
						556.0,
						122.2,
						105.0,
						22.0
					],
					"style": "",
					"text": "j.remote clipmode"
				}
			},
			{
				"box": {
					"id": "obj-172",
					"maxclass": "tab",
					"mode": 1,
					"numinlets": 1,
					"numoutlets": 3,
					"outlettype": [
						"int",
						"",
						""
					],
					"parameter_enable": 0,
					"patching_rect": [
						556.0,
						77.8,
						200.0,
						24.0
					],
					"presentation": 1,
					"presentation_rect": [
						630.0,
						52.0,
						150.0,
						22.0
					],
					"style": "",
					"tabs": [
						"none",
						"low",
						"high",
						"both"
					]
				}
			},
			{
				"box": {
					"fontname": "Arial",
					"fontsize": 11.595187,
					"id": "obj-175",
					"maxclass": "message",
					"numinlets": 2,
					"numoutlets": 1,
					"outlettype": [
						""
					],
					"patching_rect": [
						3658.5,
						1027.0,
						83.0,
						21.0
					],
					"style": "",
					"text": "savewindow 1"
				}
			},
			{
				"box": {
					"id": "obj-119",
					"maxclass": "newobj",
					"numinlets": 1,
					"numoutlets": 2,
					"outlettype": [
						"bang",
						"int"
					],
					"patching_rect": [
						9.0,
						239.8,
						34.0,
						22.0
					],
					"style": "",
					"text": "t b 1"
				}
			},
			{
				"box": {
					"id": "obj-257",
					"maxclass": "message",
					"numinlets": 2,
					"numoutlets": 1,
					"outlettype": [
						""
					],
					"patching_rect": [
						248.166626,
						71.8,
						89.0,
						22.0
					],
					"style": "",
					"text": "model:address"
				}
			},
			{
				"box": {
					"id": "obj-256",
					"maxclass": "newobj",
					"numinlets": 1,
					"numoutlets": 2,
					"outlettype": [
						"int",
						"model:address"
					],
					"patching_rect": [
						127.5,
						165.4,
						106.0,
						22.0
					],
					"style": "",
					"text": "t 0 model:address"
				}
			},
			{
				"box": {
					"id": "obj-255",
					"maxclass": "toggle",
					"numinlets": 1,
					"numoutlets": 1,
					"outlettype": [
						"int"
					],
					"parameter_enable": 0,
					"patching_rect": [
						21.0,
						338.2,
						24.0,
						24.0
					],
					"style": ""
				}
			},
			{
				"box": {
					"id": "obj-253",
					"maxclass": "newobj",
					"numinlets": 2,
					"numoutlets": 1,
					"outlettype": [
						""
					],
					"patching_rect": [
						21.0,
						376.6,
						43.0,
						22.0
					],
					"style": "",
					"text": "gate"
				}
			},
			{
				"box": {
					"id": "obj-252",
					"maxclass": "newobj",
					"numinlets": 2,
					"numoutlets": 2,
					"outlettype": [
						"bang",
						"bang"
					],
					"patching_rect": [
						9.0,
						202.0,
						67.0,
						22.0
					],
					"style": "",
					"text": "onebang 1"
				}
			},
			{
				"box": {
					"id": "obj-251",
					"maxclass": "newobj",
					"numinlets": 2,
					"numoutlets": 2,
					"outlettype": [
						"bang",
						""
					],
					"patching_rect": [
						9.0,
						165.4,
						36.0,
						22.0
					],
					"style": "",
					"text": "sel 1"
				}
			},
			{
				"box": {
					"id": "obj-250",
					"maxclass": "newobj",
					"numinlets": 2,
					"numoutlets": 2,
					"outlettype": [
						"",
						""
					],
					"patching_rect": [
						52.083313,
						338.2,
						45.833374,
						22.0
					],
					"style": "",
					"text": "zl reg"
				}
			},
			{
				"box": {
					"id": "obj-249",
					"linecount": 2,
					"maxclass": "newobj",
					"numinlets": 2,
					"numoutlets": 2,
					"outlettype": [
						"",
						""
					],
					"patching_rect": [
						88.0,
						248.2,
						100.0,
						35.0
					],
					"style": "",
					"text": "routepass model:address"
				}
			},
			{
				"box": {
					"id": "obj-245",
					"maxclass": "newobj",
					"numinlets": 1,
					"numoutlets": 1,
					"outlettype": [
						"int"
					],
					"patching_rect": [
						9.0,
						129.4,
						42.0,
						22.0
					],
					"style": "",
					"text": "active"
				}
			},
			{
				"box": {
					"fontname": "Arial",
					"fontsize": 12.0,
					"id": "obj-239",
					"maxclass": "newobj",
					"numinlets": 1,
					"numoutlets": 1,
					"outlettype": [
						""
					],
					"patching_rect": [
						32.166748,
						610.6,
						100.0,
						22.0
					],
					"style": "",
					"text": "prepend active"
				}
			},
			{
				"box": {
					"fontname": "Arial",
					"fontsize": 12.0,
					"id": "obj-231",
					"linecount": 2,
					"maxclass": "newobj",
					"numinlets": 1,
					"numoutlets": 3,
					"outlettype": [
						"",
						"",
						""
					],
					"patching_rect": [
						32.166748,
						557.8,
						78.5,
						35.0
					],
					"style": "",
					"text": "j.receive data/active"
				}
			},
			{
				"box": {
					"fontname": "Arial",
					"id": "obj-196",
					"maxclass": "live.text",
					"mode": 0,
					"numinlets": 1,
					"numoutlets": 2,
					"outlettype": [
						"",
						""
					],
					"parameter_enable": 1,
					"patching_rect": [
						265.166626,
						357.4,
						43.0,
						22.0
					],
					"presentation": 1,
					"presentation_rect": [
						241.875015,
						628.085938,
						32.916656,
						20.0
					],
					"saved_attribute_attributes": {
						"valueof": {
							"parameter_longname": "live.text[7]",
							"parameter_shortname": "live.text",
							"parameter_type": 2,
							"parameter_mmax": 1.0,
							"parameter_enum": [
								"val1",
								"val2"
							]
						}
					},
					"text": "Get",
					"varname": "live.text[1]",
					"fontface": 1
				}
			},
			{
				"box": {
					"arrows": 3,
					"border": 3.0,
					"id": "obj-223",
					"justification": 1,
					"maxclass": "live.line",
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [
						664.791687,
						760.1,
						5.0,
						100.0
					],
					"presentation": 1,
					"presentation_rect": [
						226.083344,
						627.085938,
						64.5,
						24.25
					]
				}
			},
			{
				"box": {
					"fontname": "Arial",
					"id": "obj-95",
					"maxclass": "live.text",
					"mode": 0,
					"numinlets": 1,
					"numoutlets": 2,
					"outlettype": [
						"",
						""
					],
					"parameter_enable": 1,
					"patching_rect": [
						833.833374,
						357.4,
						43.0,
						22.0
					],
					"presentation": 1,
					"presentation_rect": [
						499.333374,
						376.25,
						36.916626,
						20.0
					],
					"saved_attribute_attributes": {
						"valueof": {
							"parameter_longname": "live.text[8]",
							"parameter_shortname": "live.text",
							"parameter_type": 2,
							"parameter_mmax": 1.0,
							"parameter_enum": [
								"val1",
								"val2"
							]
						}
					},
					"text": "Get",
					"varname": "live.text",
					"fontface": 1
				}
			},
			{
				"box": {
					"arrows": 3,
					"border": 3.0,
					"id": "obj-219",
					"justification": 1,
					"maxclass": "live.line",
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [
						1293.0,
						364.6,
						5.0,
						100.0
					],
					"presentation": 1,
					"presentation_rect": [
						505.791687,
						356.625,
						24.0,
						59.25
					]
				}
			},
			{
				"box": {
					"id": "obj-217",
					"linecount": 3,
					"maxclass": "message",
					"numinlets": 2,
					"numoutlets": 1,
					"outlettype": [
						""
					],
					"patching_rect": [
						3648.0,
						946.6,
						104.0,
						49.0
					],
					"style": "",
					"text": "window flags grow, window exec"
				}
			},
			{
				"box": {
					"id": "obj-228",
					"maxclass": "newobj",
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [
						2388.0,
						343.0,
						109.0,
						22.0
					],
					"style": "",
					"text": "print 2_DISPATCH"
				}
			},
			{
				"box": {
					"id": "obj-227",
					"maxclass": "newobj",
					"numinlets": 2,
					"numoutlets": 2,
					"outlettype": [
						"",
						""
					],
					"patching_rect": [
						1881.0,
						1027.0,
						51.0,
						22.0
					],
					"style": "",
					"text": "route 0."
				}
			},
			{
				"box": {
					"id": "obj-225",
					"maxclass": "newobj",
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [
						2167.5,
						569.8,
						92.0,
						22.0
					],
					"style": "",
					"text": "print SETARG2"
				}
			},
			{
				"box": {
					"id": "obj-224",
					"maxclass": "button",
					"numinlets": 1,
					"numoutlets": 1,
					"outlettype": [
						"bang"
					],
					"patching_rect": [
						2049.0,
						701.8,
						24.0,
						24.0
					],
					"style": ""
				}
			},
			{
				"box": {
					"id": "obj-199",
					"maxclass": "newobj",
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [
						2066.5,
						847.0,
						69.0,
						22.0
					],
					"style": "",
					"text": "print ARR2"
				}
			},
			{
				"box": {
					"id": "obj-197",
					"maxclass": "newobj",
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [
						1918.0,
						847.0,
						69.0,
						22.0
					],
					"style": "",
					"text": "print ARR1"
				}
			},
			{
				"box": {
					"id": "obj-184",
					"maxclass": "newobj",
					"numinlets": 1,
					"numoutlets": 1,
					"outlettype": [
						""
					],
					"patching_rect": [
						1801.800049,
						1039.0,
						56.0,
						22.0
					],
					"style": "",
					"text": "deferlow"
				}
			},
			{
				"box": {
					"id": "obj-182",
					"maxclass": "newobj",
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [
						1918.0,
						337.0,
						71.0,
						22.0
					],
					"style": "",
					"text": "print PUSH"
				}
			},
			{
				"box": {
					"id": "obj-117",
					"maxclass": "newobj",
					"numinlets": 2,
					"numoutlets": 2,
					"outlettype": [
						"",
						""
					],
					"patching_rect": [
						2073.0,
						316.6,
						68.0,
						22.0
					],
					"style": "",
					"text": "route bang"
				}
			},
			{
				"box": {
					"id": "obj-97",
					"maxclass": "newobj",
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [
						2112.5,
						1033.0,
						81.0,
						22.0
					],
					"style": "",
					"text": "print RESIZE"
				}
			},
			{
				"box": {
					"id": "obj-25",
					"maxclass": "newobj",
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [
						1769.0,
						670.6,
						96.0,
						22.0
					],
					"style": "",
					"text": "print DISPATCH"
				}
			},
			{
				"box": {
					"id": "obj-14",
					"maxclass": "newobj",
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [
						1977.25,
						1013.8,
						77.0,
						22.0
					],
					"style": "",
					"text": "print ARRAY"
				}
			},
			{
				"box": {
					"id": "obj-235",
					"maxclass": "newobj",
					"numinlets": 1,
					"numoutlets": 2,
					"outlettype": [
						"int",
						""
					],
					"patching_rect": [
						1751.5,
						992.2,
						46.0,
						22.0
					],
					"style": "",
					"text": "t 0 l"
				}
			},
			{
				"box": {
					"id": "obj-234",
					"maxclass": "newobj",
					"numinlets": 2,
					"numoutlets": 1,
					"outlettype": [
						""
					],
					"patching_rect": [
						1751.5,
						955.0,
						54.0,
						22.0
					],
					"style": "",
					"text": "gate 1 0"
				}
			},
			{
				"box": {
					"id": "obj-229",
					"maxclass": "newobj",
					"numinlets": 1,
					"numoutlets": 1,
					"outlettype": [
						""
					],
					"patching_rect": [
						1881.0,
						281.8,
						100.0,
						22.0
					],
					"style": "",
					"text": "prepend push"
				}
			},
			{
				"box": {
					"id": "obj-11",
					"linecount": 2,
					"maxclass": "newobj",
					"numinlets": 2,
					"numoutlets": 1,
					"outlettype": [
						""
					],
					"patcher": {
						"fileversion": 1,
						"appversion": {
							"major": 7,
							"minor": 0,
							"revision": 5,
							"architecture": "x86",
							"modernui": 1
						},
						"rect": [
							487.0,
							161.0,
							640.0,
							480.0
						],
						"bglocked": 0,
						"openinpresentation": 0,
						"default_fontsize": 12.0,
						"default_fontface": 0,
						"default_fontname": "Arial",
						"gridonopen": 1,
						"gridsize": [
							15.0,
							15.0
						],
						"gridsnaponopen": 1,
						"objectsnaponopen": 1,
						"statusbarvisible": 2,
						"toolbarvisible": 1,
						"lefttoolbarpinned": 0,
						"toptoolbarpinned": 0,
						"righttoolbarpinned": 0,
						"bottomtoolbarpinned": 0,
						"toolbars_unpinned_last_save": 0,
						"tallnewobj": 0,
						"boxanimatetime": 200,
						"enablehscroll": 1,
						"enablevscroll": 1,
						"devicewidth": 0.0,
						"description": "",
						"digest": "",
						"tags": "",
						"style": "",
						"subpatcher_template": "",
						"boxes": [
							{
								"box": {
									"fontname": "Arial",
									"fontsize": 12.0,
									"id": "obj-170",
									"maxclass": "newobj",
									"numinlets": 2,
									"numoutlets": 2,
									"outlettype": [
										"",
										""
									],
									"patching_rect": [
										50.0,
										112.0,
										57.0,
										22.0
									],
									"style": "",
									"text": "route set"
								}
							},
							{
								"box": {
									"id": "obj-175",
									"maxclass": "newobj",
									"numinlets": 2,
									"numoutlets": 1,
									"outlettype": [
										"int"
									],
									"patching_rect": [
										50.0,
										184.6,
										29.5,
										22.0
									],
									"style": "",
									"text": "!- 2"
								}
							},
							{
								"box": {
									"id": "obj-176",
									"maxclass": "newobj",
									"numinlets": 2,
									"numoutlets": 1,
									"outlettype": [
										"int"
									],
									"patching_rect": [
										50.0,
										145.0,
										35.0,
										22.0
									],
									"style": "",
									"text": "== 0"
								}
							},
							{
								"box": {
									"id": "obj-177",
									"maxclass": "newobj",
									"numinlets": 2,
									"numoutlets": 2,
									"outlettype": [
										"",
										""
									],
									"patching_rect": [
										50.0,
										223.0,
										54.0,
										22.0
									],
									"style": "",
									"text": "gate 2 0"
								}
							},
							{
								"box": {
									"id": "obj-178",
									"maxclass": "newobj",
									"numinlets": 2,
									"numoutlets": 2,
									"outlettype": [
										"",
										""
									],
									"patching_rect": [
										85.0,
										268.6,
										39.0,
										22.0
									],
									"style": "",
									"text": "zl.nth"
								}
							},
							{
								"box": {
									"comment": "",
									"id": "obj-179",
									"maxclass": "inlet",
									"numinlets": 0,
									"numoutlets": 1,
									"outlettype": [
										""
									],
									"patching_rect": [
										50.0,
										40.0,
										30.0,
										30.0
									],
									"presentation": 1,
									"presentation_rect": [
										572.700012,
										587.5,
										30.0,
										30.0
									],
									"style": ""
								}
							},
							{
								"box": {
									"comment": "",
									"id": "obj-180",
									"maxclass": "inlet",
									"numinlets": 0,
									"numoutlets": 1,
									"outlettype": [
										""
									],
									"patching_rect": [
										7.0,
										40.0,
										30.0,
										30.0
									],
									"presentation": 1,
									"presentation_rect": [
										607.700012,
										587.5,
										30.0,
										30.0
									],
									"style": ""
								}
							},
							{
								"box": {
									"comment": "",
									"id": "obj-181",
									"maxclass": "outlet",
									"numinlets": 1,
									"numoutlets": 0,
									"patching_rect": [
										61.5,
										367.0,
										30.0,
										30.0
									],
									"presentation": 1,
									"presentation_rect": [
										584.200012,
										860.0,
										30.0,
										30.0
									],
									"style": ""
								}
							}
						],
						"lines": [
							{
								"patchline": {
									"destination": [
										"obj-176",
										0
									],
									"disabled": 0,
									"hidden": 0,
									"source": [
										"obj-170",
										0
									]
								}
							},
							{
								"patchline": {
									"destination": [
										"obj-178",
										1
									],
									"disabled": 0,
									"hidden": 0,
									"source": [
										"obj-170",
										0
									]
								}
							},
							{
								"patchline": {
									"destination": [
										"obj-177",
										0
									],
									"disabled": 0,
									"hidden": 0,
									"source": [
										"obj-175",
										0
									]
								}
							},
							{
								"patchline": {
									"destination": [
										"obj-175",
										0
									],
									"disabled": 0,
									"hidden": 0,
									"source": [
										"obj-176",
										0
									]
								}
							},
							{
								"patchline": {
									"destination": [
										"obj-178",
										0
									],
									"disabled": 0,
									"hidden": 0,
									"source": [
										"obj-177",
										1
									]
								}
							},
							{
								"patchline": {
									"destination": [
										"obj-181",
										0
									],
									"disabled": 0,
									"hidden": 0,
									"source": [
										"obj-177",
										0
									]
								}
							},
							{
								"patchline": {
									"destination": [
										"obj-181",
										0
									],
									"disabled": 0,
									"hidden": 0,
									"source": [
										"obj-178",
										0
									]
								}
							},
							{
								"patchline": {
									"destination": [
										"obj-170",
										0
									],
									"disabled": 0,
									"hidden": 0,
									"source": [
										"obj-179",
										0
									]
								}
							},
							{
								"patchline": {
									"destination": [
										"obj-177",
										1
									],
									"disabled": 0,
									"hidden": 0,
									"source": [
										"obj-180",
										0
									]
								}
							}
						]
					},
					"patching_rect": [
						739.166748,
						751.0,
						67.0,
						35.0
					],
					"saved_object_attributes": {
						"description": "",
						"digest": "",
						"globalpatchername": "",
						"style": "",
						"tags": ""
					},
					"style": "",
					"text": "p fromArray"
				}
			},
			{
				"box": {
					"fontface": 0,
					"fontname": "Arial",
					"fontsize": 12.0,
					"id": "obj-12",
					"maxclass": "newobj",
					"numinlets": 1,
					"numoutlets": 4,
					"outlettype": [
						"",
						"",
						"",
						""
					],
					"patching_rect": [
						787.166748,
						714.4,
						123.0,
						22.0
					],
					"style": "",
					"text": "j.remote output/index"
				}
			},
			{
				"box": {
					"fontface": 0,
					"fontname": "Arial",
					"fontsize": 12.0,
					"id": "obj-9",
					"maxclass": "newobj",
					"numinlets": 1,
					"numoutlets": 4,
					"outlettype": [
						"",
						"",
						"",
						""
					],
					"patching_rect": [
						534.666748,
						1032.4,
						111.0,
						22.0
					],
					"style": "",
					"text": "j.remote rampTime"
				}
			},
			{
				"box": {
					"annotation": "none",
					"fontname": "Arial",
					"fontsize": 12.0,
					"format": 6,
					"id": "obj-7",
					"maxclass": "flonum",
					"numinlets": 1,
					"numoutlets": 2,
					"outlettype": [
						"",
						"bang"
					],
					"parameter_enable": 0,
					"patching_rect": [
						483.666748,
						1032.4,
						49.0,
						23.0
					],
					"presentation": 1,
					"presentation_rect": [
						630.0,
						26.0,
						57.0,
						23.0
					],
					"style": ""
				}
			},
			{
				"box": {
					"fontface": 1,
					"fontname": "Arial",
					"id": "obj-6",
					"maxclass": "comment",
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [
						911.333374,
						52.6,
						150.0,
						21.0
					],
					"presentation": 1,
					"presentation_rect": [
						722.333374,
						26.0,
						77.0,
						21.0
					],
					"style": "",
					"text": "Output unit:"
				}
			},
			{
				"box": {
					"fontface": 1,
					"fontname": "Arial",
					"id": "obj-2",
					"maxclass": "comment",
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [
						913.333374,
						27.4,
						150.0,
						21.0
					],
					"presentation": 1,
					"presentation_rect": [
						588.333374,
						26.0,
						44.0,
						21.0
					],
					"style": "",
					"text": "Ramp:"
				}
			},
			{
				"box": {
					"id": "obj-190",
					"maxclass": "newobj",
					"numinlets": 1,
					"numoutlets": 1,
					"outlettype": [
						"bang"
					],
					"patching_rect": [
						118.666748,
						100.0,
						65.0,
						22.0
					],
					"style": "",
					"text": "closebang"
				}
			},
			{
				"box": {
					"fontface": 1,
					"fontname": "Arial",
					"fontsize": 12.0,
					"id": "obj-213",
					"maxclass": "comment",
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [
						891.300049,
						181.6,
						51.0,
						21.0
					],
					"presentation": 1,
					"presentation_rect": [
						26.333344,
						50.0,
						53.0,
						21.0
					],
					"style": "",
					"text": "Output:"
				}
			},
			{
				"box": {
					"fontface": 1,
					"fontname": "Arial",
					"id": "obj-194",
					"maxclass": "comment",
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [
						72.0,
						1001.8,
						150.0,
						21.0
					],
					"presentation": 1,
					"presentation_rect": [
						453.333344,
						50.0,
						44.0,
						21.0
					],
					"style": "",
					"text": "Index:"
				}
			},
			{
				"box": {
					"fontface": 1,
					"fontname": "Arial",
					"id": "obj-193",
					"maxclass": "comment",
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [
						72.0,
						969.4,
						150.0,
						21.0
					],
					"presentation": 1,
					"presentation_rect": [
						453.333344,
						26.0,
						44.0,
						21.0
					],
					"style": "",
					"text": "Index:"
				}
			},
			{
				"box": {
					"annotation": "none",
					"automation": "Off",
					"automationon": "On",
					"fontname": "Arial",
					"fontsize": 12.0,
					"id": "obj-174",
					"maxclass": "live.text",
					"numinlets": 1,
					"numoutlets": 2,
					"outlettype": [
						"",
						""
					],
					"parameter_enable": 1,
					"patching_rect": [
						4025.833252,
						388.0,
						115.0,
						20.0
					],
					"presentation": 1,
					"presentation_rect": [
						630.0,
						418.0,
						255.0,
						21.0
					],
					"saved_attribute_attributes": {
						"valueof": {
							"parameter_longname": "live.text[5]",
							"parameter_shortname": "live.text[1]",
							"parameter_type": 2,
							"parameter_mmax": 1.0,
							"parameter_enum": [
								"Off",
								"On"
							]
						}
					},
					"text": "Output Threshold Off",
					"texton": "Output Threshold On",
					"varname": "live.text[2]",
					"fontface": 1
				}
			},
			{
				"box": {
					"fontname": "Arial",
					"fontsize": 12.0,
					"id": "obj-186",
					"maxclass": "newobj",
					"numinlets": 1,
					"numoutlets": 4,
					"outlettype": [
						"",
						"",
						"",
						""
					],
					"patching_rect": [
						4025.833252,
						356.8,
						188.0,
						22.0
					],
					"style": "",
					"text": "j.remote output/threshold/active"
				}
			},
			{
				"box": {
					"annotation": "none",
					"automation": "Off",
					"automationon": "On",
					"fontname": "Arial",
					"fontsize": 12.0,
					"id": "obj-188",
					"maxclass": "live.text",
					"numinlets": 1,
					"numoutlets": 2,
					"outlettype": [
						"",
						""
					],
					"parameter_enable": 1,
					"patching_rect": [
						4025.833252,
						312.4,
						115.0,
						20.0
					],
					"presentation": 1,
					"presentation_rect": [
						630.0,
						147.0,
						255.0,
						21.0
					],
					"saved_attribute_attributes": {
						"valueof": {
							"parameter_longname": "live.text[6]",
							"parameter_shortname": "live.text[1]",
							"parameter_type": 2,
							"parameter_mmax": 1.0,
							"parameter_enum": [
								"Off",
								"On"
							]
						}
					},
					"text": "Input Threshold Off",
					"texton": "Input Threshold On",
					"varname": "live.text[3]",
					"fontface": 1
				}
			},
			{
				"box": {
					"fontname": "Arial",
					"fontsize": 12.0,
					"id": "obj-189",
					"maxclass": "newobj",
					"numinlets": 1,
					"numoutlets": 4,
					"outlettype": [
						"",
						"",
						"",
						""
					],
					"patching_rect": [
						4025.833252,
						281.2,
						188.0,
						22.0
					],
					"style": "",
					"text": "j.remote input/threshold/active"
				}
			},
			{
				"box": {
					"annotation": "none",
					"id": "obj-102",
					"maxclass": "led",
					"numinlets": 1,
					"numoutlets": 1,
					"outlettype": [
						"int"
					],
					"parameter_enable": 0,
					"patching_rect": [
						4506.833008,
						548.2,
						20.0,
						20.0
					],
					"presentation": 1,
					"presentation_rect": [
						865.0,
						183.0,
						20.0,
						20.0
					],
					"style": ""
				}
			},
			{
				"box": {
					"annotation": "none",
					"id": "obj-103",
					"maxclass": "led",
					"numinlets": 1,
					"numoutlets": 1,
					"outlettype": [
						"int"
					],
					"parameter_enable": 0,
					"patching_rect": [
						4506.833008,
						669.4,
						20.0,
						20.0
					],
					"presentation": 1,
					"presentation_rect": [
						865.0,
						266.0,
						20.0,
						20.0
					],
					"style": ""
				}
			},
			{
				"box": {
					"annotation": "none",
					"id": "obj-20",
					"maxclass": "led",
					"numinlets": 1,
					"numoutlets": 1,
					"outlettype": [
						"int"
					],
					"parameter_enable": 0,
					"patching_rect": [
						4506.833008,
						926.8,
						20.0,
						20.0
					],
					"presentation": 1,
					"presentation_rect": [
						865.0,
						540.5,
						20.0,
						20.0
					],
					"style": ""
				}
			},
			{
				"box": {
					"fontname": "Arial",
					"fontsize": 12.0,
					"id": "obj-21",
					"linecount": 2,
					"maxclass": "newobj",
					"numinlets": 1,
					"numoutlets": 4,
					"outlettype": [
						"",
						"",
						"",
						""
					],
					"patching_rect": [
						4506.833008,
						878.8,
						112.0,
						35.0
					],
					"style": "",
					"text": "j.remote output/going.down"
				}
			},
			{
				"box": {
					"annotation": "none",
					"id": "obj-22",
					"maxclass": "led",
					"numinlets": 1,
					"numoutlets": 1,
					"outlettype": [
						"int"
					],
					"parameter_enable": 0,
					"patching_rect": [
						4506.833008,
						806.2,
						20.0,
						20.0
					],
					"presentation": 1,
					"presentation_rect": [
						865.0,
						453.0,
						20.0,
						20.0
					],
					"style": ""
				}
			},
			{
				"box": {
					"fontname": "Arial",
					"fontsize": 12.0,
					"id": "obj-24",
					"linecount": 2,
					"maxclass": "newobj",
					"numinlets": 1,
					"numoutlets": 4,
					"outlettype": [
						"",
						"",
						"",
						""
					],
					"patching_rect": [
						4506.833008,
						759.4,
						100.0,
						35.0
					],
					"style": "",
					"text": "j.remote output/going.up"
				}
			},
			{
				"box": {
					"fontface": 1,
					"fontname": "Arial",
					"fontsize": 12.0,
					"id": "obj-98",
					"linecount": 2,
					"maxclass": "comment",
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [
						3868.0,
						825.4,
						151.0,
						35.0
					],
					"presentation": 1,
					"presentation_rect": [
						630.0,
						540.5,
						197.0,
						21.0
					],
					"style": "",
					"text": "(Actions when output going down to)"
				}
			},
			{
				"box": {
					"fontface": 1,
					"fontname": "Arial",
					"fontsize": 12.0,
					"id": "obj-105",
					"linecount": 2,
					"maxclass": "comment",
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [
						3868.0,
						706.0,
						151.0,
						35.0
					],
					"presentation": 1,
					"presentation_rect": [
						630.0,
						453.0,
						180.0,
						21.0
					],
					"style": "",
					"text": "(Actions when output going up to)"
				}
			},
			{
				"box": {
					"fontname": "Arial",
					"fontsize": 12.0,
					"id": "obj-106",
					"linecount": 2,
					"maxclass": "newobj",
					"numinlets": 1,
					"numoutlets": 4,
					"outlettype": [
						"",
						"",
						"",
						""
					],
					"patching_rect": [
						4347.833008,
						878.8,
						156.0,
						35.0
					],
					"style": "",
					"text": "j.remote output/going.down/action.3"
				}
			},
			{
				"box": {
					"fontname": "Arial",
					"fontsize": 12.0,
					"id": "obj-27",
					"maxclass": "newobj",
					"numinlets": 2,
					"numoutlets": 2,
					"outlettype": [
						"",
						""
					],
					"patching_rect": [
						4347.833008,
						852.4,
						64.0,
						22.0
					],
					"style": "",
					"text": "route text"
				}
			},
			{
				"box": {
					"annotation": "none",
					"autoscroll": 0,
					"border": 1.0,
					"fontname": "Arial",
					"fontsize": 12.0,
					"id": "obj-108",
					"keymode": 1,
					"lines": 1,
					"maxclass": "textedit",
					"numinlets": 1,
					"numoutlets": 4,
					"outlettype": [
						"",
						"int",
						"",
						""
					],
					"parameter_enable": 0,
					"patching_rect": [
						4347.833008,
						825.4,
						150.0,
						20.0
					],
					"presentation": 1,
					"presentation_rect": [
						630.0,
						606.5,
						253.0,
						20.0
					],
					"rounded": 0.0,
					"style": "",
					"text": "none"
				}
			},
			{
				"box": {
					"fontname": "Arial",
					"fontsize": 12.0,
					"id": "obj-28",
					"linecount": 2,
					"maxclass": "newobj",
					"numinlets": 1,
					"numoutlets": 4,
					"outlettype": [
						"",
						"",
						"",
						""
					],
					"patching_rect": [
						4186.833008,
						878.8,
						156.0,
						35.0
					],
					"style": "",
					"text": "j.remote output/going.down/action.2"
				}
			},
			{
				"box": {
					"fontname": "Arial",
					"fontsize": 12.0,
					"id": "obj-30",
					"maxclass": "newobj",
					"numinlets": 2,
					"numoutlets": 2,
					"outlettype": [
						"",
						""
					],
					"patching_rect": [
						4186.833008,
						852.4,
						64.0,
						22.0
					],
					"style": "",
					"text": "route text"
				}
			},
			{
				"box": {
					"annotation": "none",
					"autoscroll": 0,
					"border": 1.0,
					"fontname": "Arial",
					"fontsize": 12.0,
					"id": "obj-31",
					"keymode": 1,
					"lines": 1,
					"maxclass": "textedit",
					"numinlets": 1,
					"numoutlets": 4,
					"outlettype": [
						"",
						"int",
						"",
						""
					],
					"parameter_enable": 0,
					"patching_rect": [
						4186.833008,
						825.4,
						150.0,
						20.0
					],
					"presentation": 1,
					"presentation_rect": [
						630.0,
						584.5,
						253.0,
						20.0
					],
					"rounded": 0.0,
					"style": "",
					"text": "none"
				}
			},
			{
				"box": {
					"fontname": "Arial",
					"fontsize": 12.0,
					"id": "obj-33",
					"linecount": 2,
					"maxclass": "newobj",
					"numinlets": 1,
					"numoutlets": 4,
					"outlettype": [
						"",
						"",
						"",
						""
					],
					"patching_rect": [
						4025.833252,
						878.8,
						156.0,
						35.0
					],
					"style": "",
					"text": "j.remote output/going.down/action.1"
				}
			},
			{
				"box": {
					"fontname": "Arial",
					"fontsize": 12.0,
					"id": "obj-34",
					"maxclass": "newobj",
					"numinlets": 2,
					"numoutlets": 2,
					"outlettype": [
						"",
						""
					],
					"patching_rect": [
						4025.833252,
						852.4,
						64.0,
						22.0
					],
					"style": "",
					"text": "route text"
				}
			},
			{
				"box": {
					"annotation": "none",
					"autoscroll": 0,
					"border": 1.0,
					"fontname": "Arial",
					"fontsize": 12.0,
					"id": "obj-35",
					"keymode": 1,
					"lines": 1,
					"maxclass": "textedit",
					"numinlets": 1,
					"numoutlets": 4,
					"outlettype": [
						"",
						"int",
						"",
						""
					],
					"parameter_enable": 0,
					"patching_rect": [
						4025.833252,
						825.4,
						150.0,
						20.0
					],
					"presentation": 1,
					"presentation_rect": [
						630.0,
						562.5,
						253.0,
						20.0
					],
					"rounded": 0.0,
					"style": "",
					"text": "none"
				}
			},
			{
				"box": {
					"fontname": "Arial",
					"fontsize": 12.0,
					"id": "obj-36",
					"linecount": 2,
					"maxclass": "newobj",
					"numinlets": 1,
					"numoutlets": 4,
					"outlettype": [
						"",
						"",
						"",
						""
					],
					"patching_rect": [
						4347.833008,
						759.4,
						150.0,
						35.0
					],
					"style": "",
					"text": "j.remote output/going.up/action.3"
				}
			},
			{
				"box": {
					"fontname": "Arial",
					"fontsize": 12.0,
					"id": "obj-38",
					"maxclass": "newobj",
					"numinlets": 2,
					"numoutlets": 2,
					"outlettype": [
						"",
						""
					],
					"patching_rect": [
						4347.833008,
						733.0,
						64.0,
						22.0
					],
					"style": "",
					"text": "route text"
				}
			},
			{
				"box": {
					"annotation": "none",
					"autoscroll": 0,
					"border": 1.0,
					"fontname": "Arial",
					"fontsize": 12.0,
					"id": "obj-39",
					"keymode": 1,
					"lines": 1,
					"maxclass": "textedit",
					"numinlets": 1,
					"numoutlets": 4,
					"outlettype": [
						"",
						"int",
						"",
						""
					],
					"parameter_enable": 0,
					"patching_rect": [
						4347.833008,
						706.0,
						150.0,
						20.0
					],
					"presentation": 1,
					"presentation_rect": [
						630.0,
						518.5,
						253.0,
						20.0
					],
					"rounded": 0.0,
					"style": "",
					"text": "none"
				}
			},
			{
				"box": {
					"fontname": "Arial",
					"fontsize": 12.0,
					"id": "obj-40",
					"linecount": 2,
					"maxclass": "newobj",
					"numinlets": 1,
					"numoutlets": 4,
					"outlettype": [
						"",
						"",
						"",
						""
					],
					"patching_rect": [
						4186.833008,
						759.4,
						150.0,
						35.0
					],
					"style": "",
					"text": "j.remote output/going.up/action.2"
				}
			},
			{
				"box": {
					"fontname": "Arial",
					"fontsize": 12.0,
					"id": "obj-42",
					"maxclass": "newobj",
					"numinlets": 2,
					"numoutlets": 2,
					"outlettype": [
						"",
						""
					],
					"patching_rect": [
						4186.833008,
						733.0,
						64.0,
						22.0
					],
					"style": "",
					"text": "route text"
				}
			},
			{
				"box": {
					"annotation": "none",
					"autoscroll": 0,
					"border": 1.0,
					"fontname": "Arial",
					"fontsize": 12.0,
					"id": "obj-44",
					"keymode": 1,
					"lines": 1,
					"maxclass": "textedit",
					"numinlets": 1,
					"numoutlets": 4,
					"outlettype": [
						"",
						"int",
						"",
						""
					],
					"parameter_enable": 0,
					"patching_rect": [
						4186.833008,
						706.0,
						150.0,
						20.0
					],
					"presentation": 1,
					"presentation_rect": [
						630.0,
						496.5,
						253.0,
						20.0
					],
					"rounded": 0.0,
					"style": "",
					"text": "none"
				}
			},
			{
				"box": {
					"fontname": "Arial",
					"fontsize": 12.0,
					"id": "obj-123",
					"linecount": 2,
					"maxclass": "newobj",
					"numinlets": 1,
					"numoutlets": 4,
					"outlettype": [
						"",
						"",
						"",
						""
					],
					"patching_rect": [
						4025.833252,
						759.4,
						150.0,
						35.0
					],
					"style": "",
					"text": "j.remote output/going.up/action.1"
				}
			},
			{
				"box": {
					"fontname": "Arial",
					"fontsize": 12.0,
					"id": "obj-45",
					"maxclass": "newobj",
					"numinlets": 2,
					"numoutlets": 2,
					"outlettype": [
						"",
						""
					],
					"patching_rect": [
						4025.833252,
						733.0,
						64.0,
						22.0
					],
					"style": "",
					"text": "route text"
				}
			},
			{
				"box": {
					"annotation": "none",
					"autoscroll": 0,
					"border": 1.0,
					"fontname": "Arial",
					"fontsize": 12.0,
					"id": "obj-46",
					"keymode": 1,
					"lines": 1,
					"maxclass": "textedit",
					"numinlets": 1,
					"numoutlets": 4,
					"outlettype": [
						"",
						"int",
						"",
						""
					],
					"parameter_enable": 0,
					"patching_rect": [
						4025.833252,
						706.0,
						150.0,
						20.0
					],
					"presentation": 1,
					"presentation_rect": [
						630.0,
						474.5,
						253.0,
						20.0
					],
					"rounded": 0.0,
					"style": "",
					"text": "none"
				}
			},
			{
				"box": {
					"fontname": "Arial",
					"fontsize": 12.0,
					"id": "obj-104",
					"linecount": 2,
					"maxclass": "newobj",
					"numinlets": 1,
					"numoutlets": 4,
					"outlettype": [
						"",
						"",
						"",
						""
					],
					"patching_rect": [
						4506.833008,
						620.8,
						100.0,
						35.0
					],
					"style": "",
					"text": "j.remote input/going.down"
				}
			},
			{
				"box": {
					"fontname": "Arial",
					"fontsize": 12.0,
					"id": "obj-101",
					"linecount": 2,
					"maxclass": "newobj",
					"numinlets": 1,
					"numoutlets": 4,
					"outlettype": [
						"",
						"",
						"",
						""
					],
					"patching_rect": [
						4506.833008,
						501.4,
						100.0,
						35.0
					],
					"style": "",
					"text": "j.remote input/going.up"
				}
			},
			{
				"box": {
					"fontface": 1,
					"fontname": "Arial",
					"fontsize": 12.0,
					"id": "obj-50",
					"linecount": 2,
					"maxclass": "comment",
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [
						3868.0,
						567.4,
						146.0,
						35.0
					],
					"presentation": 1,
					"presentation_rect": [
						630.0,
						271.0,
						190.0,
						21.0
					],
					"style": "",
					"text": "(Actions when input going down to)"
				}
			},
			{
				"box": {
					"fontface": 1,
					"fontname": "Arial",
					"fontsize": 12.0,
					"id": "obj-52",
					"linecount": 2,
					"maxclass": "comment",
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [
						3868.0,
						448.0,
						162.0,
						35.0
					],
					"presentation": 1,
					"presentation_rect": [
						630.0,
						183.0,
						179.0,
						21.0
					],
					"style": "",
					"text": "(Actions when input going up to)"
				}
			},
			{
				"box": {
					"fontname": "Arial",
					"fontsize": 12.0,
					"id": "obj-54",
					"linecount": 2,
					"maxclass": "newobj",
					"numinlets": 1,
					"numoutlets": 4,
					"outlettype": [
						"",
						"",
						"",
						""
					],
					"patching_rect": [
						4347.833008,
						620.8,
						150.0,
						35.0
					],
					"style": "",
					"text": "j.remote input/going.down/action.3"
				}
			},
			{
				"box": {
					"fontname": "Arial",
					"fontsize": 12.0,
					"id": "obj-57",
					"maxclass": "newobj",
					"numinlets": 2,
					"numoutlets": 2,
					"outlettype": [
						"",
						""
					],
					"patching_rect": [
						4347.833008,
						594.4,
						64.0,
						22.0
					],
					"style": "",
					"text": "route text"
				}
			},
			{
				"box": {
					"annotation": "none",
					"autoscroll": 0,
					"border": 1.0,
					"fontname": "Arial",
					"fontsize": 12.0,
					"id": "obj-59",
					"keymode": 1,
					"lines": 1,
					"maxclass": "textedit",
					"numinlets": 1,
					"numoutlets": 4,
					"outlettype": [
						"",
						"int",
						"",
						""
					],
					"parameter_enable": 0,
					"patching_rect": [
						4347.833008,
						567.4,
						150.0,
						20.0
					],
					"presentation": 1,
					"presentation_rect": [
						630.0,
						337.0,
						253.0,
						20.0
					],
					"rounded": 0.0,
					"style": "",
					"text": "none"
				}
			},
			{
				"box": {
					"fontname": "Arial",
					"fontsize": 12.0,
					"id": "obj-92",
					"linecount": 2,
					"maxclass": "newobj",
					"numinlets": 1,
					"numoutlets": 4,
					"outlettype": [
						"",
						"",
						"",
						""
					],
					"patching_rect": [
						4186.833008,
						620.8,
						150.0,
						35.0
					],
					"style": "",
					"text": "j.remote input/going.down/action.2"
				}
			},
			{
				"box": {
					"fontname": "Arial",
					"fontsize": 12.0,
					"id": "obj-60",
					"maxclass": "newobj",
					"numinlets": 2,
					"numoutlets": 2,
					"outlettype": [
						"",
						""
					],
					"patching_rect": [
						4186.833008,
						594.4,
						64.0,
						22.0
					],
					"style": "",
					"text": "route text"
				}
			},
			{
				"box": {
					"annotation": "none",
					"autoscroll": 0,
					"border": 1.0,
					"fontname": "Arial",
					"fontsize": 12.0,
					"id": "obj-94",
					"keymode": 1,
					"lines": 1,
					"maxclass": "textedit",
					"numinlets": 1,
					"numoutlets": 4,
					"outlettype": [
						"",
						"int",
						"",
						""
					],
					"parameter_enable": 0,
					"patching_rect": [
						4186.833008,
						567.4,
						150.0,
						20.0
					],
					"presentation": 1,
					"presentation_rect": [
						630.0,
						315.0,
						253.0,
						20.0
					],
					"rounded": 0.0,
					"style": "",
					"text": "none"
				}
			},
			{
				"box": {
					"fontname": "Arial",
					"fontsize": 12.0,
					"id": "obj-61",
					"linecount": 2,
					"maxclass": "newobj",
					"numinlets": 1,
					"numoutlets": 4,
					"outlettype": [
						"",
						"",
						"",
						""
					],
					"patching_rect": [
						4025.833252,
						620.8,
						150.0,
						35.0
					],
					"style": "",
					"text": "j.remote input/going.down/action.1"
				}
			},
			{
				"box": {
					"fontname": "Arial",
					"fontsize": 12.0,
					"id": "obj-69",
					"maxclass": "newobj",
					"numinlets": 2,
					"numoutlets": 2,
					"outlettype": [
						"",
						""
					],
					"patching_rect": [
						4025.833252,
						594.4,
						64.0,
						22.0
					],
					"style": "",
					"text": "route text"
				}
			},
			{
				"box": {
					"annotation": "none",
					"autoscroll": 0,
					"border": 1.0,
					"fontname": "Arial",
					"fontsize": 12.0,
					"id": "obj-72",
					"keymode": 1,
					"lines": 1,
					"maxclass": "textedit",
					"numinlets": 1,
					"numoutlets": 4,
					"outlettype": [
						"",
						"int",
						"",
						""
					],
					"parameter_enable": 0,
					"patching_rect": [
						4025.833252,
						567.4,
						150.0,
						20.0
					],
					"presentation": 1,
					"presentation_rect": [
						630.0,
						293.0,
						253.0,
						20.0
					],
					"rounded": 0.0,
					"style": "",
					"text": "none"
				}
			},
			{
				"box": {
					"fontname": "Arial",
					"fontsize": 12.0,
					"id": "obj-73",
					"linecount": 2,
					"maxclass": "newobj",
					"numinlets": 1,
					"numoutlets": 4,
					"outlettype": [
						"",
						"",
						"",
						""
					],
					"patching_rect": [
						4347.833008,
						501.4,
						150.0,
						35.0
					],
					"style": "",
					"text": "j.remote input/going.up/action.3"
				}
			},
			{
				"box": {
					"fontname": "Arial",
					"fontsize": 12.0,
					"id": "obj-74",
					"maxclass": "newobj",
					"numinlets": 2,
					"numoutlets": 2,
					"outlettype": [
						"",
						""
					],
					"patching_rect": [
						4347.833008,
						475.0,
						64.0,
						22.0
					],
					"style": "",
					"text": "route text"
				}
			},
			{
				"box": {
					"annotation": "none",
					"autoscroll": 0,
					"border": 1.0,
					"fontname": "Arial",
					"fontsize": 12.0,
					"id": "obj-128",
					"keymode": 1,
					"lines": 1,
					"maxclass": "textedit",
					"numinlets": 1,
					"numoutlets": 4,
					"outlettype": [
						"",
						"int",
						"",
						""
					],
					"parameter_enable": 0,
					"patching_rect": [
						4347.833008,
						448.0,
						150.0,
						20.0
					],
					"presentation": 1,
					"presentation_rect": [
						630.0,
						249.0,
						253.0,
						20.0
					],
					"rounded": 0.0,
					"style": "",
					"text": "none"
				}
			},
			{
				"box": {
					"fontname": "Arial",
					"fontsize": 12.0,
					"id": "obj-129",
					"linecount": 2,
					"maxclass": "newobj",
					"numinlets": 1,
					"numoutlets": 4,
					"outlettype": [
						"",
						"",
						"",
						""
					],
					"patching_rect": [
						4186.833008,
						501.4,
						150.0,
						35.0
					],
					"style": "",
					"text": "j.remote input/going.up/action.2"
				}
			},
			{
				"box": {
					"fontname": "Arial",
					"fontsize": 12.0,
					"id": "obj-140",
					"maxclass": "newobj",
					"numinlets": 2,
					"numoutlets": 2,
					"outlettype": [
						"",
						""
					],
					"patching_rect": [
						4186.833008,
						475.0,
						64.0,
						22.0
					],
					"style": "",
					"text": "route text"
				}
			},
			{
				"box": {
					"annotation": "none",
					"autoscroll": 0,
					"border": 1.0,
					"fontname": "Arial",
					"fontsize": 12.0,
					"id": "obj-155",
					"keymode": 1,
					"lines": 1,
					"maxclass": "textedit",
					"numinlets": 1,
					"numoutlets": 4,
					"outlettype": [
						"",
						"int",
						"",
						""
					],
					"parameter_enable": 0,
					"patching_rect": [
						4186.833008,
						448.0,
						150.0,
						20.0
					],
					"presentation": 1,
					"presentation_rect": [
						630.0,
						227.0,
						253.0,
						20.0
					],
					"rounded": 0.0,
					"style": "",
					"text": "none"
				}
			},
			{
				"box": {
					"fontname": "Arial",
					"fontsize": 12.0,
					"id": "obj-161",
					"linecount": 2,
					"maxclass": "newobj",
					"numinlets": 1,
					"numoutlets": 4,
					"outlettype": [
						"",
						"",
						"",
						""
					],
					"patching_rect": [
						4025.833252,
						501.4,
						150.0,
						35.0
					],
					"style": "",
					"text": "j.remote input/going.up/action.1"
				}
			},
			{
				"box": {
					"fontname": "Arial",
					"fontsize": 12.0,
					"id": "obj-162",
					"maxclass": "newobj",
					"numinlets": 2,
					"numoutlets": 2,
					"outlettype": [
						"",
						""
					],
					"patching_rect": [
						4025.833252,
						475.0,
						64.0,
						22.0
					],
					"style": "",
					"text": "route text"
				}
			},
			{
				"box": {
					"annotation": "none",
					"autoscroll": 0,
					"border": 1.0,
					"fontname": "Arial",
					"fontsize": 12.0,
					"id": "obj-164",
					"keymode": 1,
					"lines": 1,
					"maxclass": "textedit",
					"numinlets": 1,
					"numoutlets": 4,
					"outlettype": [
						"",
						"int",
						"",
						""
					],
					"parameter_enable": 0,
					"patching_rect": [
						4025.833252,
						448.0,
						150.0,
						20.0
					],
					"presentation": 1,
					"presentation_rect": [
						630.0,
						205.0,
						253.0,
						20.0
					],
					"rounded": 0.0,
					"style": "",
					"text": "none"
				}
			},
			{
				"box": {
					"floatoutput": 1,
					"id": "obj-70",
					"knobshape": 5,
					"maxclass": "slider",
					"numinlets": 1,
					"numoutlets": 1,
					"outlettype": [
						""
					],
					"parameter_enable": 0,
					"patching_rect": [
						416.166626,
						745.6,
						83.0,
						17.0
					],
					"presentation": 1,
					"presentation_rect": [
						16.833344,
						124.0,
						483.0,
						21.0
					],
					"size": 1.0,
					"style": "",
					"thickness": 46.0
				}
			},
			{
				"box": {
					"fontface": 1,
					"fontname": "Arial",
					"fontsize": 12.0,
					"id": "obj-67",
					"maxclass": "comment",
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [
						416.166626,
						706.6,
						128.0,
						21.0
					],
					"presentation": 1,
					"presentation_rect": [
						194.333344,
						124.0,
						128.0,
						21.0
					],
					"style": "",
					"text": "(Slide to emulate input)"
				}
			},
			{
				"box": {
					"angle": 270.0,
					"border": 1,
					"id": "obj-15",
					"maxclass": "panel",
					"mode": 0,
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [
						72.0,
						1031.8,
						78.0,
						21.0
					],
					"presentation": 1,
					"presentation_rect": [
						19.333344,
						124.0,
						478.0,
						22.0
					],
					"proportion": 0.39,
					"rounded": 0,
					"style": "",
					"varname": "parameter[1]_panel[1]"
				}
			},
			{
				"box": {
					"fontname": "Arial",
					"fontsize": 12.0,
					"id": "obj-58",
					"maxclass": "newobj",
					"numinlets": 6,
					"numoutlets": 1,
					"outlettype": [
						""
					],
					"patching_rect": [
						416.166626,
						773.8,
						94.0,
						22.0
					],
					"style": "",
					"text": "scale 0. 1. 0. 1."
				}
			},
			{
				"box": {
					"fontname": "Arial",
					"fontsize": 12.0,
					"id": "obj-49",
					"maxclass": "newobj",
					"numinlets": 1,
					"numoutlets": 1,
					"outlettype": [
						""
					],
					"patching_rect": [
						416.166626,
						833.2,
						100.0,
						22.0
					],
					"style": "",
					"text": "j.send data/in.1"
				}
			},
			{
				"box": {
					"id": "obj-5",
					"linecount": 2,
					"maxclass": "newobj",
					"numinlets": 1,
					"numoutlets": 0,
					"patcher": {
						"fileversion": 1,
						"appversion": {
							"major": 7,
							"minor": 0,
							"revision": 5,
							"architecture": "x86",
							"modernui": 1
						},
						"rect": [
							59.0,
							104.0,
							640.0,
							480.0
						],
						"bglocked": 0,
						"openinpresentation": 0,
						"default_fontsize": 12.0,
						"default_fontface": 0,
						"default_fontname": "Arial",
						"gridonopen": 1,
						"gridsize": [
							15.0,
							15.0
						],
						"gridsnaponopen": 1,
						"objectsnaponopen": 1,
						"statusbarvisible": 2,
						"toolbarvisible": 1,
						"lefttoolbarpinned": 0,
						"toptoolbarpinned": 0,
						"righttoolbarpinned": 0,
						"bottomtoolbarpinned": 0,
						"toolbars_unpinned_last_save": 0,
						"tallnewobj": 0,
						"boxanimatetime": 200,
						"enablehscroll": 1,
						"enablevscroll": 1,
						"devicewidth": 0.0,
						"description": "",
						"digest": "",
						"tags": "",
						"style": "",
						"subpatcher_template": "",
						"boxes": [
							{
								"box": {
									"id": "obj-67",
									"maxclass": "message",
									"numinlets": 2,
									"numoutlets": 1,
									"outlettype": [
										""
									],
									"patching_rect": [
										50.0,
										157.0,
										29.5,
										22.0
									],
									"style": "",
									"text": "0"
								}
							},
							{
								"box": {
									"id": "obj-49",
									"maxclass": "newobj",
									"numinlets": 2,
									"numoutlets": 2,
									"outlettype": [
										"",
										""
									],
									"patching_rect": [
										50.0,
										112.0,
										68.0,
										22.0
									],
									"style": "",
									"text": "route bang"
								}
							},
							{
								"box": {
									"id": "obj-194",
									"maxclass": "newobj",
									"numinlets": 1,
									"numoutlets": 0,
									"patching_rect": [
										99.0,
										203.8,
										143.0,
										22.0
									],
									"style": "",
									"text": "s #0.parameterslength"
								}
							},
							{
								"box": {
									"id": "obj-193",
									"maxclass": "newobj",
									"numinlets": 2,
									"numoutlets": 2,
									"outlettype": [
										"",
										""
									],
									"patching_rect": [
										99.0,
										157.0,
										39.0,
										22.0
									],
									"style": "",
									"text": "zl.len"
								}
							},
							{
								"box": {
									"comment": "",
									"id": "obj-2",
									"maxclass": "inlet",
									"numinlets": 0,
									"numoutlets": 1,
									"outlettype": [
										""
									],
									"patching_rect": [
										50.0,
										40.0,
										30.0,
										30.0
									],
									"style": ""
								}
							}
						],
						"lines": [
							{
								"patchline": {
									"destination": [
										"obj-194",
										0
									],
									"disabled": 0,
									"hidden": 0,
									"source": [
										"obj-193",
										0
									]
								}
							},
							{
								"patchline": {
									"destination": [
										"obj-49",
										0
									],
									"disabled": 0,
									"hidden": 0,
									"source": [
										"obj-2",
										0
									]
								}
							},
							{
								"patchline": {
									"destination": [
										"obj-193",
										0
									],
									"disabled": 0,
									"hidden": 0,
									"source": [
										"obj-49",
										1
									]
								}
							},
							{
								"patchline": {
									"destination": [
										"obj-67",
										0
									],
									"disabled": 0,
									"hidden": 0,
									"source": [
										"obj-49",
										0
									]
								}
							},
							{
								"patchline": {
									"destination": [
										"obj-194",
										0
									],
									"disabled": 0,
									"hidden": 0,
									"source": [
										"obj-67",
										0
									]
								}
							}
						]
					},
					"patching_rect": [
						1510.5,
						274.0,
						79.0,
						35.0
					],
					"saved_object_attributes": {
						"description": "",
						"digest": "",
						"globalpatchername": "",
						"style": "",
						"tags": ""
					},
					"style": "",
					"text": "p array/resize"
				}
			},
			{
				"box": {
					"fontface": 1,
					"fontname": "Arial",
					"fontsize": 12.0,
					"hidden": 1,
					"id": "obj-77",
					"maxclass": "comment",
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [
						1636.5,
						734.2,
						143.0,
						21.0
					],
					"presentation": 1,
					"presentation_rect": [
						268.333344,
						98.0,
						142.0,
						21.0
					],
					"style": "",
					"text": "(Use Max function to edit)",
					"varname": "function_parameter_label"
				}
			},
			{
				"box": {
					"fontface": 1,
					"fontname": "Arial",
					"fontsize": 12.0,
					"id": "obj-78",
					"maxclass": "comment",
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [
						1486.5,
						734.2,
						138.0,
						21.0
					],
					"presentation": 1,
					"presentation_rect": [
						270.333344,
						98.0,
						138.0,
						21.0
					],
					"style": "",
					"text": "(No function parameters)",
					"varname": "no_parameter_label"
				}
			},
			{
				"box": {
					"id": "obj-3",
					"maxclass": "newobj",
					"numinlets": 1,
					"numoutlets": 2,
					"outlettype": [
						"",
						"int"
					],
					"patching_rect": [
						2379.611084,
						883.6,
						30.0,
						22.0
					],
					"style": "",
					"text": "t l 1"
				}
			},
			{
				"box": {
					"id": "obj-238",
					"maxclass": "newobj",
					"numinlets": 1,
					"numoutlets": 2,
					"outlettype": [
						"",
						""
					],
					"patching_rect": [
						1885.0,
						1067.8,
						29.5,
						22.0
					],
					"style": "",
					"text": "t l l"
				}
			},
			{
				"box": {
					"id": "obj-237",
					"maxclass": "newobj",
					"numinlets": 3,
					"numoutlets": 4,
					"outlettype": [
						"",
						"bang",
						"bang",
						""
					],
					"patcher": {
						"fileversion": 1,
						"appversion": {
							"major": 7,
							"minor": 0,
							"revision": 5,
							"architecture": "x86",
							"modernui": 1
						},
						"rect": [
							153.0,
							79.0,
							1612.0,
							975.4
						],
						"bglocked": 0,
						"openinpresentation": 0,
						"default_fontsize": 12.0,
						"default_fontface": 0,
						"default_fontname": "Arial",
						"gridonopen": 1,
						"gridsize": [
							15.0,
							15.0
						],
						"gridsnaponopen": 1,
						"objectsnaponopen": 1,
						"statusbarvisible": 2,
						"toolbarvisible": 1,
						"lefttoolbarpinned": 0,
						"toptoolbarpinned": 0,
						"righttoolbarpinned": 0,
						"bottomtoolbarpinned": 0,
						"toolbars_unpinned_last_save": 0,
						"tallnewobj": 0,
						"boxanimatetime": 200,
						"enablehscroll": 1,
						"enablevscroll": 1,
						"devicewidth": 0.0,
						"description": "",
						"digest": "",
						"tags": "",
						"style": "",
						"subpatcher_template": "",
						"boxes": [
							{
								"box": {
									"id": "obj-27",
									"linecount": 2,
									"maxclass": "newobj",
									"numinlets": 1,
									"numoutlets": 0,
									"patcher": {
										"fileversion": 1,
										"appversion": {
											"major": 7,
											"minor": 0,
											"revision": 5,
											"architecture": "x86",
											"modernui": 1
										},
										"rect": [
											1242.0,
											402.0,
											640.0,
											480.0
										],
										"bglocked": 0,
										"openinpresentation": 0,
										"default_fontsize": 12.0,
										"default_fontface": 0,
										"default_fontname": "Arial",
										"gridonopen": 1,
										"gridsize": [
											15.0,
											15.0
										],
										"gridsnaponopen": 1,
										"objectsnaponopen": 1,
										"statusbarvisible": 2,
										"toolbarvisible": 1,
										"lefttoolbarpinned": 0,
										"toptoolbarpinned": 0,
										"righttoolbarpinned": 0,
										"bottomtoolbarpinned": 0,
										"toolbars_unpinned_last_save": 0,
										"tallnewobj": 0,
										"boxanimatetime": 200,
										"enablehscroll": 1,
										"enablevscroll": 1,
										"devicewidth": 0.0,
										"description": "",
										"digest": "",
										"tags": "",
										"style": "",
										"subpatcher_template": "",
										"boxes": [
											{
												"box": {
													"id": "obj-8",
													"maxclass": "newobj",
													"numinlets": 1,
													"numoutlets": 2,
													"outlettype": [
														"bang",
														"bang"
													],
													"patching_rect": [
														50.0,
														108.6,
														100.0,
														22.0
													],
													"style": "",
													"text": "b"
												}
											},
											{
												"box": {
													"id": "obj-9",
													"linecount": 3,
													"maxclass": "message",
													"numinlets": 2,
													"numoutlets": 1,
													"outlettype": [
														""
													],
													"patching_rect": [
														50.0,
														205.8,
														267.0,
														49.0
													],
													"style": "",
													"text": "script sendbox parameter[2]_label hidden 0, script sendbox parameter[2]_umenu hidden 0, script sendbox parameter[2]_panel hidden 0"
												}
											},
											{
												"box": {
													"id": "obj-6",
													"maxclass": "newobj",
													"numinlets": 1,
													"numoutlets": 0,
													"patching_rect": [
														50.0,
														279.0,
														109.0,
														22.0
													],
													"style": "",
													"text": "s #0.thispatcher"
												}
											},
											{
												"box": {
													"comment": "",
													"id": "obj-1",
													"maxclass": "inlet",
													"numinlets": 0,
													"numoutlets": 1,
													"outlettype": [
														""
													],
													"patching_rect": [
														50.0,
														15.0,
														30.0,
														30.0
													],
													"style": ""
												}
											}
										],
										"lines": [
											{
												"patchline": {
													"destination": [
														"obj-8",
														0
													],
													"disabled": 0,
													"hidden": 0,
													"source": [
														"obj-1",
														0
													]
												}
											},
											{
												"patchline": {
													"destination": [
														"obj-9",
														0
													],
													"disabled": 0,
													"hidden": 0,
													"source": [
														"obj-8",
														0
													]
												}
											},
											{
												"patchline": {
													"destination": [
														"obj-6",
														0
													],
													"disabled": 0,
													"hidden": 0,
													"source": [
														"obj-9",
														0
													]
												}
											}
										]
									},
									"patching_rect": [
										809.0,
										544.0,
										113.0,
										35.0
									],
									"saved_object_attributes": {
										"description": "",
										"digest": "",
										"globalpatchername": "",
										"style": "",
										"tags": ""
									},
									"style": "",
									"text": "p GUI_update_script"
								}
							},
							{
								"box": {
									"id": "obj-23",
									"maxclass": "message",
									"numinlets": 2,
									"numoutlets": 1,
									"outlettype": [
										""
									],
									"patching_rect": [
										595.0,
										293.2,
										50.0,
										22.0
									],
									"style": "",
									"text": "none"
								}
							},
							{
								"box": {
									"id": "obj-35",
									"maxclass": "newobj",
									"numinlets": 1,
									"numoutlets": 2,
									"outlettype": [
										"bang",
										""
									],
									"patching_rect": [
										749.0,
										282.4,
										37.0,
										22.0
									],
									"style": "",
									"text": "t b l"
								}
							},
							{
								"box": {
									"id": "obj-34",
									"maxclass": "newobj",
									"numinlets": 3,
									"numoutlets": 3,
									"outlettype": [
										"",
										"",
										""
									],
									"patching_rect": [
										419.833344,
										239.2,
										168.0,
										22.0
									],
									"style": "",
									"text": "route float int"
								}
							},
							{
								"box": {
									"id": "obj-33",
									"maxclass": "newobj",
									"numinlets": 4,
									"numoutlets": 4,
									"outlettype": [
										"",
										"",
										"",
										""
									],
									"patching_rect": [
										106.5,
										173.2,
										959.0,
										22.0
									],
									"style": "",
									"text": "route parameter.1 parameter.2 curveList"
								}
							},
							{
								"box": {
									"id": "obj-31",
									"maxclass": "newobj",
									"numinlets": 1,
									"numoutlets": 2,
									"outlettype": [
										"bang",
										""
									],
									"patching_rect": [
										419.833344,
										282.4,
										37.0,
										22.0
									],
									"style": "",
									"text": "t b l"
								}
							},
							{
								"box": {
									"id": "obj-30",
									"maxclass": "newobj",
									"numinlets": 1,
									"numoutlets": 2,
									"outlettype": [
										"bang",
										""
									],
									"patching_rect": [
										106.5,
										282.4,
										37.0,
										22.0
									],
									"style": "",
									"text": "t b l"
								}
							},
							{
								"box": {
									"id": "obj-28",
									"maxclass": "newobj",
									"numinlets": 1,
									"numoutlets": 2,
									"outlettype": [
										"listdump",
										""
									],
									"patching_rect": [
										1011.666748,
										282.4,
										68.0,
										22.0
									],
									"style": "",
									"text": "t listdump l"
								}
							},
							{
								"box": {
									"id": "obj-41",
									"linecount": 2,
									"maxclass": "newobj",
									"numinlets": 1,
									"numoutlets": 1,
									"outlettype": [
										""
									],
									"patcher": {
										"fileversion": 1,
										"appversion": {
											"major": 7,
											"minor": 0,
											"revision": 5,
											"architecture": "x86",
											"modernui": 1
										},
										"rect": [
											656.0,
											185.0,
											667.0,
											686.2
										],
										"bglocked": 0,
										"openinpresentation": 0,
										"default_fontsize": 12.0,
										"default_fontface": 0,
										"default_fontname": "Arial",
										"gridonopen": 1,
										"gridsize": [
											15.0,
											15.0
										],
										"gridsnaponopen": 1,
										"objectsnaponopen": 1,
										"statusbarvisible": 2,
										"toolbarvisible": 1,
										"lefttoolbarpinned": 0,
										"toptoolbarpinned": 0,
										"righttoolbarpinned": 0,
										"bottomtoolbarpinned": 0,
										"toolbars_unpinned_last_save": 0,
										"tallnewobj": 0,
										"boxanimatetime": 200,
										"enablehscroll": 1,
										"enablevscroll": 1,
										"devicewidth": 0.0,
										"description": "",
										"digest": "",
										"tags": "",
										"style": "",
										"subpatcher_template": "",
										"boxes": [
											{
												"box": {
													"fontname": "Arial",
													"fontsize": 12.0,
													"id": "obj-174",
													"maxclass": "newobj",
													"numinlets": 2,
													"numoutlets": 2,
													"outlettype": [
														"",
														""
													],
													"patching_rect": [
														78.0,
														109.6,
														89.0,
														22.0
													],
													"style": "",
													"text": "route curveList"
												}
											},
											{
												"box": {
													"fontname": "Arial",
													"fontsize": 12.0,
													"id": "obj-23",
													"maxclass": "comment",
													"numinlets": 1,
													"numoutlets": 0,
													"patching_rect": [
														260.166626,
														157.0,
														211.0,
														20.0
													],
													"style": "",
													"text": "-1 to ignore the base of the first curve."
												}
											},
											{
												"box": {
													"fontname": "Arial",
													"fontsize": 12.0,
													"id": "obj-24",
													"maxclass": "newobj",
													"numinlets": 2,
													"numoutlets": 1,
													"outlettype": [
														"int"
													],
													"patching_rect": [
														126.416626,
														428.2,
														32.5,
														22.0
													],
													"style": "",
													"text": "+ 1"
												}
											},
											{
												"box": {
													"fontname": "Arial",
													"fontsize": 12.0,
													"id": "obj-25",
													"maxclass": "newobj",
													"numinlets": 2,
													"numoutlets": 1,
													"outlettype": [
														"int"
													],
													"patching_rect": [
														126.0,
														397.0,
														32.5,
														22.0
													],
													"style": "",
													"text": "i"
												}
											},
											{
												"box": {
													"fontname": "Arial",
													"fontsize": 12.0,
													"id": "obj-26",
													"maxclass": "newobj",
													"numinlets": 2,
													"numoutlets": 2,
													"outlettype": [
														"",
														""
													],
													"patching_rect": [
														50.0,
														467.8,
														95.0,
														22.0
													],
													"style": "",
													"text": "zl join"
												}
											},
											{
												"box": {
													"fontname": "Arial",
													"fontsize": 12.0,
													"id": "obj-27",
													"maxclass": "newobj",
													"numinlets": 1,
													"numoutlets": 2,
													"outlettype": [
														"",
														"bang"
													],
													"patching_rect": [
														50.0,
														365.8,
														95.0,
														22.0
													],
													"style": "",
													"text": "t l b"
												}
											},
											{
												"box": {
													"fontname": "Arial",
													"fontsize": 12.0,
													"id": "obj-28",
													"maxclass": "message",
													"numinlets": 2,
													"numoutlets": 1,
													"outlettype": [
														""
													],
													"patching_rect": [
														50.0,
														497.8,
														126.0,
														22.0
													],
													"style": "",
													"text": "$1 $2, setcurve $4 $3"
												}
											},
											{
												"box": {
													"fontname": "Arial",
													"fontsize": 12.0,
													"id": "obj-29",
													"maxclass": "newobj",
													"numinlets": 2,
													"numoutlets": 2,
													"outlettype": [
														"",
														""
													],
													"patching_rect": [
														50.0,
														193.0,
														49.0,
														22.0
													],
													"style": "",
													"text": "zl iter 5"
												}
											},
											{
												"box": {
													"fontname": "Arial",
													"fontsize": 12.0,
													"id": "obj-30",
													"maxclass": "newobj",
													"numinlets": 1,
													"numoutlets": 3,
													"outlettype": [
														"",
														"int",
														"bang"
													],
													"patching_rect": [
														50.0,
														157.0,
														198.0,
														22.0
													],
													"style": "",
													"text": "t l -1 b"
												}
											},
											{
												"box": {
													"fontname": "Arial",
													"fontsize": 12.0,
													"id": "obj-31",
													"maxclass": "newobj",
													"numinlets": 2,
													"numoutlets": 2,
													"outlettype": [
														"",
														""
													],
													"patching_rect": [
														88.0,
														259.6,
														57.0,
														22.0
													],
													"style": "",
													"text": "zl slice 2"
												}
											},
											{
												"box": {
													"fontname": "Arial",
													"fontsize": 12.0,
													"id": "obj-32",
													"linecount": 2,
													"maxclass": "message",
													"numinlets": 2,
													"numoutlets": 1,
													"outlettype": [
														""
													],
													"patching_rect": [
														229.0,
														244.0,
														63.0,
														35.0
													],
													"style": "",
													"text": "clear, domain 1."
												}
											},
											{
												"box": {
													"fontname": "Arial",
													"fontsize": 12.0,
													"id": "obj-86",
													"maxclass": "newobj",
													"numinlets": 2,
													"numoutlets": 2,
													"outlettype": [
														"",
														""
													],
													"patching_rect": [
														50.0,
														332.2,
														95.0,
														22.0
													],
													"style": "",
													"text": "zl join"
												}
											},
											{
												"box": {
													"fontname": "Arial",
													"fontsize": 12.0,
													"id": "obj-85",
													"maxclass": "newobj",
													"numinlets": 1,
													"numoutlets": 1,
													"outlettype": [
														""
													],
													"patcher": {
														"fileversion": 1,
														"appversion": {
															"major": 7,
															"minor": 0,
															"revision": 5,
															"architecture": "x86",
															"modernui": 1
														},
														"rect": [
															916.0,
															566.0,
															311.0,
															358
														],
														"bglocked": 0,
														"openinpresentation": 0,
														"default_fontsize": 12.0,
														"default_fontface": 0,
														"default_fontname": "Arial",
														"gridonopen": 1,
														"gridsize": [
															15.0,
															15.0
														],
														"gridsnaponopen": 1,
														"objectsnaponopen": 1,
														"statusbarvisible": 2,
														"toolbarvisible": 1,
														"lefttoolbarpinned": 0,
														"toptoolbarpinned": 0,
														"righttoolbarpinned": 0,
														"bottomtoolbarpinned": 0,
														"toolbars_unpinned_last_save": 0,
														"tallnewobj": 0,
														"boxanimatetime": 200,
														"enablehscroll": 1,
														"enablevscroll": 1,
														"devicewidth": 0.0,
														"description": "",
														"digest": "",
														"tags": "",
														"style": "",
														"subpatcher_template": "",
														"boxes": [
															{
																"box": {
																	"fontname": "Arial",
																	"fontsize": 12.0,
																	"id": "obj-31",
																	"maxclass": "newobj",
																	"numinlets": 2,
																	"numoutlets": 2,
																	"outlettype": [
																		"bang",
																		""
																	],
																	"patching_rect": [
																		22.0,
																		58.0,
																		39.0,
																		20.0
																	],
																	"style": "",
																	"text": "sel 0."
																}
															},
															{
																"box": {
																	"fontname": "Arial",
																	"fontsize": 12.0,
																	"id": "obj-28",
																	"maxclass": "newobj",
																	"numinlets": 1,
																	"numoutlets": 1,
																	"outlettype": [
																		""
																	],
																	"patching_rect": [
																		174.5,
																		263.2,
																		102.0,
																		20.0
																	],
																	"style": "",
																	"text": "expr exp($f1) - 1."
																}
															},
															{
																"box": {
																	"fontname": "Arial",
																	"fontsize": 12.0,
																	"id": "obj-19",
																	"maxclass": "newobj",
																	"numinlets": 1,
																	"numoutlets": 1,
																	"outlettype": [
																		""
																	],
																	"patching_rect": [
																		55.5,
																		263.2,
																		109.0,
																		20.0
																	],
																	"style": "",
																	"text": "expr 1. - exp(- $f1)"
																}
															},
															{
																"box": {
																	"fontname": "Arial",
																	"fontsize": 12.0,
																	"id": "obj-18",
																	"maxclass": "newobj",
																	"numinlets": 2,
																	"numoutlets": 1,
																	"outlettype": [
																		"int"
																	],
																	"patching_rect": [
																		55.5,
																		175.6,
																		32.5,
																		20.0
																	],
																	"style": "",
																	"text": "+ 1"
																}
															},
															{
																"box": {
																	"fontname": "Arial",
																	"fontsize": 12.0,
																	"id": "obj-17",
																	"maxclass": "newobj",
																	"numinlets": 2,
																	"numoutlets": 1,
																	"outlettype": [
																		"int"
																	],
																	"patching_rect": [
																		55.5,
																		148.0,
																		32.5,
																		20.0
																	],
																	"style": "",
																	"text": "< 0."
																}
															},
															{
																"box": {
																	"fontname": "Arial",
																	"fontsize": 12.0,
																	"id": "obj-16",
																	"maxclass": "newobj",
																	"numinlets": 2,
																	"numoutlets": 2,
																	"outlettype": [
																		"",
																		""
																	],
																	"patching_rect": [
																		55.5,
																		216.4,
																		138.0,
																		20.0
																	],
																	"style": "",
																	"text": "gate 2"
																}
															},
															{
																"box": {
																	"fontname": "Arial",
																	"fontsize": 12.0,
																	"id": "obj-15",
																	"maxclass": "newobj",
																	"numinlets": 1,
																	"numoutlets": 2,
																	"outlettype": [
																		"float",
																		"float"
																	],
																	"patching_rect": [
																		42.0,
																		120.4,
																		32.5,
																		20.0
																	],
																	"style": "",
																	"text": "t f f"
																}
															},
															{
																"box": {
																	"fontname": "Arial",
																	"fontsize": 12.0,
																	"id": "obj-6",
																	"maxclass": "newobj",
																	"numinlets": 1,
																	"numoutlets": 1,
																	"outlettype": [
																		""
																	],
																	"patching_rect": [
																		42.0,
																		92.8,
																		131.0,
																		20.0
																	],
																	"style": "",
																	"text": "expr log($f1)/2.718282"
																}
															},
															{
																"box": {
																	"comment": "",
																	"id": "obj-83",
																	"maxclass": "inlet",
																	"numinlets": 0,
																	"numoutlets": 1,
																	"outlettype": [
																		""
																	],
																	"patching_rect": [
																		22.0,
																		16.0,
																		25.0,
																		25.0
																	],
																	"style": ""
																}
															},
															{
																"box": {
																	"comment": "",
																	"id": "obj-84",
																	"maxclass": "outlet",
																	"numinlets": 1,
																	"numoutlets": 0,
																	"patching_rect": [
																		55.5,
																		310.0,
																		25.0,
																		25.0
																	],
																	"style": ""
																}
															}
														],
														"lines": [
															{
																"patchline": {
																	"destination": [
																		"obj-16",
																		1
																	],
																	"disabled": 0,
																	"hidden": 0,
																	"midpoints": [
																		51.5,
																		206.8,
																		184.0,
																		206.8
																	],
																	"source": [
																		"obj-15",
																		0
																	]
																}
															},
															{
																"patchline": {
																	"destination": [
																		"obj-17",
																		0
																	],
																	"disabled": 0,
																	"hidden": 0,
																	"source": [
																		"obj-15",
																		1
																	]
																}
															},
															{
																"patchline": {
																	"destination": [
																		"obj-19",
																		0
																	],
																	"disabled": 0,
																	"hidden": 0,
																	"source": [
																		"obj-16",
																		0
																	]
																}
															},
															{
																"patchline": {
																	"destination": [
																		"obj-28",
																		0
																	],
																	"disabled": 0,
																	"hidden": 0,
																	"source": [
																		"obj-16",
																		1
																	]
																}
															},
															{
																"patchline": {
																	"destination": [
																		"obj-18",
																		0
																	],
																	"disabled": 0,
																	"hidden": 0,
																	"source": [
																		"obj-17",
																		0
																	]
																}
															},
															{
																"patchline": {
																	"destination": [
																		"obj-16",
																		0
																	],
																	"disabled": 0,
																	"hidden": 0,
																	"source": [
																		"obj-18",
																		0
																	]
																}
															},
															{
																"patchline": {
																	"destination": [
																		"obj-84",
																		0
																	],
																	"disabled": 0,
																	"hidden": 0,
																	"source": [
																		"obj-19",
																		0
																	]
																}
															},
															{
																"patchline": {
																	"destination": [
																		"obj-84",
																		0
																	],
																	"disabled": 0,
																	"hidden": 0,
																	"midpoints": [
																		184.0,
																		298.0,
																		65.0,
																		298.0
																	],
																	"source": [
																		"obj-28",
																		0
																	]
																}
															},
															{
																"patchline": {
																	"destination": [
																		"obj-6",
																		0
																	],
																	"disabled": 0,
																	"hidden": 0,
																	"source": [
																		"obj-31",
																		1
																	]
																}
															},
															{
																"patchline": {
																	"destination": [
																		"obj-15",
																		0
																	],
																	"disabled": 0,
																	"hidden": 0,
																	"source": [
																		"obj-6",
																		0
																	]
																}
															},
															{
																"patchline": {
																	"destination": [
																		"obj-31",
																		0
																	],
																	"disabled": 0,
																	"hidden": 0,
																	"source": [
																		"obj-83",
																		0
																	]
																}
															}
														]
													},
													"patching_rect": [
														126.0,
														298.6,
														83.0,
														22.0
													],
													"saved_object_attributes": {
														"description": "",
														"digest": "",
														"globalpatchername": "",
														"style": "",
														"tags": ""
													},
													"style": "",
													"text": "p base2factor"
												}
											},
											{
												"box": {
													"fontname": "Arial",
													"fontsize": 12.0,
													"id": "obj-33",
													"maxclass": "newobj",
													"numinlets": 2,
													"numoutlets": 2,
													"outlettype": [
														"",
														""
													],
													"patching_rect": [
														50.0,
														226.0,
														57.0,
														22.0
													],
													"style": "",
													"text": "zl slice 2"
												}
											},
											{
												"box": {
													"fontname": "Arial",
													"fontsize": 12.0,
													"id": "obj-34",
													"maxclass": "newobj",
													"numinlets": 1,
													"numoutlets": 1,
													"outlettype": [
														"bang"
													],
													"patching_rect": [
														229.0,
														193.0,
														60.0,
														22.0
													],
													"style": "",
													"text": "loadbang"
												}
											},
											{
												"box": {
													"comment": "",
													"id": "obj-39",
													"maxclass": "inlet",
													"numinlets": 0,
													"numoutlets": 1,
													"outlettype": [
														""
													],
													"patching_rect": [
														50.0,
														40.0,
														30.0,
														30.0
													],
													"style": ""
												}
											},
											{
												"box": {
													"comment": "",
													"id": "obj-40",
													"maxclass": "outlet",
													"numinlets": 1,
													"numoutlets": 0,
													"patching_rect": [
														133.5,
														596.2,
														30.0,
														30.0
													],
													"style": ""
												}
											}
										],
										"lines": [
											{
												"patchline": {
													"destination": [
														"obj-30",
														0
													],
													"disabled": 0,
													"hidden": 0,
													"source": [
														"obj-174",
														0
													]
												}
											},
											{
												"patchline": {
													"destination": [
														"obj-25",
														1
													],
													"disabled": 0,
													"hidden": 0,
													"midpoints": [
														135.916626,
														463.0,
														164.458374,
														463.0,
														164.458374,
														385.0,
														149.0,
														385.0
													],
													"source": [
														"obj-24",
														0
													]
												}
											},
											{
												"patchline": {
													"destination": [
														"obj-26",
														1
													],
													"disabled": 0,
													"hidden": 0,
													"source": [
														"obj-24",
														0
													]
												}
											},
											{
												"patchline": {
													"destination": [
														"obj-24",
														0
													],
													"disabled": 0,
													"hidden": 0,
													"source": [
														"obj-25",
														0
													]
												}
											},
											{
												"patchline": {
													"destination": [
														"obj-28",
														0
													],
													"disabled": 0,
													"hidden": 0,
													"source": [
														"obj-26",
														0
													]
												}
											},
											{
												"patchline": {
													"destination": [
														"obj-25",
														0
													],
													"disabled": 0,
													"hidden": 0,
													"source": [
														"obj-27",
														1
													]
												}
											},
											{
												"patchline": {
													"destination": [
														"obj-26",
														0
													],
													"disabled": 0,
													"hidden": 0,
													"source": [
														"obj-27",
														0
													]
												}
											},
											{
												"patchline": {
													"destination": [
														"obj-40",
														0
													],
													"disabled": 0,
													"hidden": 0,
													"source": [
														"obj-28",
														0
													]
												}
											},
											{
												"patchline": {
													"destination": [
														"obj-33",
														0
													],
													"disabled": 0,
													"hidden": 0,
													"source": [
														"obj-29",
														0
													]
												}
											},
											{
												"patchline": {
													"destination": [
														"obj-25",
														1
													],
													"disabled": 0,
													"hidden": 0,
													"source": [
														"obj-30",
														1
													]
												}
											},
											{
												"patchline": {
													"destination": [
														"obj-29",
														0
													],
													"disabled": 0,
													"hidden": 0,
													"source": [
														"obj-30",
														0
													]
												}
											},
											{
												"patchline": {
													"destination": [
														"obj-34",
														0
													],
													"disabled": 0,
													"hidden": 0,
													"source": [
														"obj-30",
														2
													]
												}
											},
											{
												"patchline": {
													"destination": [
														"obj-85",
														0
													],
													"disabled": 0,
													"hidden": 0,
													"source": [
														"obj-31",
														1
													]
												}
											},
											{
												"patchline": {
													"destination": [
														"obj-40",
														0
													],
													"disabled": 0,
													"hidden": 0,
													"source": [
														"obj-32",
														0
													]
												}
											},
											{
												"patchline": {
													"destination": [
														"obj-31",
														0
													],
													"disabled": 0,
													"hidden": 0,
													"source": [
														"obj-33",
														1
													]
												}
											},
											{
												"patchline": {
													"destination": [
														"obj-86",
														0
													],
													"disabled": 0,
													"hidden": 0,
													"source": [
														"obj-33",
														0
													]
												}
											},
											{
												"patchline": {
													"destination": [
														"obj-32",
														0
													],
													"disabled": 0,
													"hidden": 0,
													"source": [
														"obj-34",
														0
													]
												}
											},
											{
												"patchline": {
													"destination": [
														"obj-30",
														0
													],
													"disabled": 0,
													"hidden": 0,
													"source": [
														"obj-39",
														0
													]
												}
											},
											{
												"patchline": {
													"destination": [
														"obj-86",
														1
													],
													"disabled": 0,
													"hidden": 0,
													"source": [
														"obj-85",
														0
													]
												}
											},
											{
												"patchline": {
													"destination": [
														"obj-27",
														0
													],
													"disabled": 0,
													"hidden": 0,
													"source": [
														"obj-86",
														0
													]
												}
											}
										]
									},
									"patching_rect": [
										1083.666748,
										440.8,
										159.0,
										35.0
									],
									"saved_object_attributes": {
										"description": "",
										"digest": "",
										"globalpatchername": "",
										"style": "",
										"tags": ""
									},
									"style": "",
									"text": "p freehand2function_reformat"
								}
							},
							{
								"box": {
									"id": "obj-17",
									"linecount": 2,
									"maxclass": "newobj",
									"numinlets": 1,
									"numoutlets": 0,
									"patcher": {
										"fileversion": 1,
										"appversion": {
											"major": 7,
											"minor": 0,
											"revision": 5,
											"architecture": "x86",
											"modernui": 1
										},
										"rect": [
											1246.0,
											134.0,
											640.0,
											508.6
										],
										"bglocked": 0,
										"openinpresentation": 0,
										"default_fontsize": 12.0,
										"default_fontface": 0,
										"default_fontname": "Arial",
										"gridonopen": 1,
										"gridsize": [
											15.0,
											15.0
										],
										"gridsnaponopen": 1,
										"objectsnaponopen": 1,
										"statusbarvisible": 2,
										"toolbarvisible": 1,
										"lefttoolbarpinned": 0,
										"toptoolbarpinned": 0,
										"righttoolbarpinned": 0,
										"bottomtoolbarpinned": 0,
										"toolbars_unpinned_last_save": 0,
										"tallnewobj": 0,
										"boxanimatetime": 200,
										"enablehscroll": 1,
										"enablevscroll": 1,
										"devicewidth": 0.0,
										"description": "",
										"digest": "",
										"tags": "",
										"style": "",
										"subpatcher_template": "",
										"boxes": [
											{
												"box": {
													"id": "obj-9",
													"maxclass": "message",
													"numinlets": 2,
													"numoutlets": 1,
													"outlettype": [
														""
													],
													"patching_rect": [
														50.0,
														293.4,
														267.0,
														22.0
													],
													"style": "",
													"text": "script sendbox function_parameter_bpf hidden 0"
												}
											},
											{
												"box": {
													"id": "obj-6",
													"maxclass": "newobj",
													"numinlets": 1,
													"numoutlets": 0,
													"patching_rect": [
														50.0,
														426.6,
														109.0,
														22.0
													],
													"style": "",
													"text": "s #0.thispatcher"
												}
											},
											{
												"box": {
													"comment": "",
													"id": "obj-1",
													"maxclass": "inlet",
													"numinlets": 0,
													"numoutlets": 1,
													"outlettype": [
														"bang"
													],
													"patching_rect": [
														50.0,
														15.0,
														30.0,
														30.0
													],
													"style": ""
												}
											}
										],
										"lines": [
											{
												"patchline": {
													"destination": [
														"obj-9",
														0
													],
													"disabled": 0,
													"hidden": 0,
													"source": [
														"obj-1",
														0
													]
												}
											},
											{
												"patchline": {
													"destination": [
														"obj-6",
														0
													],
													"disabled": 0,
													"hidden": 0,
													"source": [
														"obj-9",
														0
													]
												}
											}
										]
									},
									"patching_rect": [
										1060.666748,
										544.0,
										113.0,
										35.0
									],
									"saved_object_attributes": {
										"description": "",
										"digest": "",
										"globalpatchername": "",
										"style": "",
										"tags": ""
									},
									"style": "",
									"text": "p GUI_update_script"
								}
							},
							{
								"box": {
									"id": "obj-16",
									"maxclass": "newobj",
									"numinlets": 1,
									"numoutlets": 2,
									"outlettype": [
										"bang",
										""
									],
									"patching_rect": [
										1060.666748,
										325.6,
										42.0,
										22.0
									],
									"style": "",
									"text": "t b l"
								}
							},
							{
								"box": {
									"comment": "",
									"id": "obj-18",
									"maxclass": "outlet",
									"numinlets": 1,
									"numoutlets": 0,
									"patching_rect": [
										1083.666748,
										875.8,
										30.0,
										30.0
									],
									"presentation": 1,
									"presentation_rect": [
										713.5,
										578.5,
										30.0,
										30.0
									],
									"style": ""
								}
							},
							{
								"box": {
									"id": "obj-12",
									"linecount": 2,
									"maxclass": "newobj",
									"numinlets": 1,
									"numoutlets": 0,
									"patcher": {
										"fileversion": 1,
										"appversion": {
											"major": 7,
											"minor": 0,
											"revision": 5,
											"architecture": "x86",
											"modernui": 1
										},
										"rect": [
											1246.0,
											530.0,
											640.0,
											480.0
										],
										"bglocked": 0,
										"openinpresentation": 0,
										"default_fontsize": 12.0,
										"default_fontface": 0,
										"default_fontname": "Arial",
										"gridonopen": 1,
										"gridsize": [
											15.0,
											15.0
										],
										"gridsnaponopen": 1,
										"objectsnaponopen": 1,
										"statusbarvisible": 2,
										"toolbarvisible": 1,
										"lefttoolbarpinned": 0,
										"toptoolbarpinned": 0,
										"righttoolbarpinned": 0,
										"bottomtoolbarpinned": 0,
										"toolbars_unpinned_last_save": 0,
										"tallnewobj": 0,
										"boxanimatetime": 200,
										"enablehscroll": 1,
										"enablevscroll": 1,
										"devicewidth": 0.0,
										"description": "",
										"digest": "",
										"tags": "",
										"style": "",
										"subpatcher_template": "",
										"boxes": [
											{
												"box": {
													"id": "obj-4",
													"maxclass": "message",
													"numinlets": 2,
													"numoutlets": 1,
													"outlettype": [
														""
													],
													"patching_rect": [
														50.0,
														82.2,
														29.5,
														22.0
													],
													"style": "",
													"text": "$1"
												}
											},
											{
												"box": {
													"id": "obj-10",
													"maxclass": "newobj",
													"numinlets": 1,
													"numoutlets": 2,
													"outlettype": [
														"bang",
														""
													],
													"patching_rect": [
														50.0,
														145.8,
														43.0,
														22.0
													],
													"style": "",
													"text": "t b l"
												}
											},
											{
												"box": {
													"id": "obj-6",
													"maxclass": "newobj",
													"numinlets": 1,
													"numoutlets": 0,
													"patching_rect": [
														74.0,
														294.6,
														109.0,
														22.0
													],
													"style": "",
													"text": "s #0.thispatcher"
												}
											},
											{
												"box": {
													"id": "obj-5",
													"maxclass": "message",
													"numinlets": 2,
													"numoutlets": 1,
													"outlettype": [
														""
													],
													"patching_rect": [
														74.0,
														246.6,
														227.0,
														22.0
													],
													"style": "",
													"text": "script sendbox parameter[2]_label set $1"
												}
											},
											{
												"box": {
													"id": "obj-3",
													"maxclass": "newobj",
													"numinlets": 1,
													"numoutlets": 1,
													"outlettype": [
														"int"
													],
													"patcher": {
														"fileversion": 1,
														"appversion": {
															"major": 7,
															"minor": 0,
															"revision": 5,
															"architecture": "x86",
															"modernui": 1
														},
														"rect": [
															2440.0,
															307.0,
															640.0,
															480.0
														],
														"bglocked": 0,
														"openinpresentation": 0,
														"default_fontsize": 12.0,
														"default_fontface": 0,
														"default_fontname": "Arial",
														"gridonopen": 1,
														"gridsize": [
															15.0,
															15.0
														],
														"gridsnaponopen": 1,
														"objectsnaponopen": 1,
														"statusbarvisible": 2,
														"toolbarvisible": 1,
														"lefttoolbarpinned": 0,
														"toptoolbarpinned": 0,
														"righttoolbarpinned": 0,
														"bottomtoolbarpinned": 0,
														"toolbars_unpinned_last_save": 0,
														"tallnewobj": 0,
														"boxanimatetime": 200,
														"enablehscroll": 1,
														"enablevscroll": 1,
														"devicewidth": 0.0,
														"description": "",
														"digest": "",
														"tags": "",
														"style": "",
														"subpatcher_template": "",
														"boxes": [
															{
																"box": {
																	"comment": "",
																	"id": "obj-2",
																	"maxclass": "outlet",
																	"numinlets": 1,
																	"numoutlets": 0,
																	"patching_rect": [
																		69.0,
																		365.8,
																		30.0,
																		30.0
																	],
																	"style": ""
																}
															},
															{
																"box": {
																	"comment": "",
																	"id": "obj-1",
																	"maxclass": "inlet",
																	"numinlets": 0,
																	"numoutlets": 1,
																	"outlettype": [
																		""
																	],
																	"patching_rect": [
																		69.0,
																		49.0,
																		30.0,
																		30.0
																	],
																	"style": ""
																}
															},
															{
																"box": {
																	"id": "obj-20",
																	"maxclass": "newobj",
																	"numinlets": 2,
																	"numoutlets": 1,
																	"outlettype": [
																		"int"
																	],
																	"patching_rect": [
																		69.0,
																		208.6,
																		31.0,
																		22.0
																	],
																	"style": "",
																	"text": "- 32"
																}
															},
															{
																"box": {
																	"id": "obj-19",
																	"maxclass": "newobj",
																	"numinlets": 2,
																	"numoutlets": 2,
																	"outlettype": [
																		"",
																		""
																	],
																	"patching_rect": [
																		69.0,
																		271.0,
																		57.0,
																		22.0
																	],
																	"style": "",
																	"text": "zl.join"
																}
															},
															{
																"box": {
																	"id": "obj-17",
																	"maxclass": "newobj",
																	"numinlets": 2,
																	"numoutlets": 2,
																	"outlettype": [
																		"",
																		""
																	],
																	"patching_rect": [
																		69.0,
																		167.8,
																		57.0,
																		22.0
																	],
																	"style": "",
																	"text": "zl.slice 1"
																}
															},
															{
																"box": {
																	"id": "obj-10",
																	"maxclass": "newobj",
																	"numinlets": 3,
																	"numoutlets": 1,
																	"outlettype": [
																		"int"
																	],
																	"patching_rect": [
																		69.0,
																		320.2,
																		40.0,
																		22.0
																	],
																	"style": "",
																	"text": "itoa"
																}
															},
															{
																"box": {
																	"id": "obj-4",
																	"maxclass": "newobj",
																	"numinlets": 3,
																	"numoutlets": 1,
																	"outlettype": [
																		"list"
																	],
																	"patching_rect": [
																		69.0,
																		117.4,
																		40.0,
																		22.0
																	],
																	"style": "",
																	"text": "atoi"
																}
															}
														],
														"lines": [
															{
																"patchline": {
																	"destination": [
																		"obj-4",
																		0
																	],
																	"disabled": 0,
																	"hidden": 0,
																	"source": [
																		"obj-1",
																		0
																	]
																}
															},
															{
																"patchline": {
																	"destination": [
																		"obj-2",
																		0
																	],
																	"disabled": 0,
																	"hidden": 0,
																	"source": [
																		"obj-10",
																		0
																	]
																}
															},
															{
																"patchline": {
																	"destination": [
																		"obj-19",
																		1
																	],
																	"disabled": 0,
																	"hidden": 0,
																	"source": [
																		"obj-17",
																		1
																	]
																}
															},
															{
																"patchline": {
																	"destination": [
																		"obj-20",
																		0
																	],
																	"disabled": 0,
																	"hidden": 0,
																	"source": [
																		"obj-17",
																		0
																	]
																}
															},
															{
																"patchline": {
																	"destination": [
																		"obj-10",
																		0
																	],
																	"disabled": 0,
																	"hidden": 0,
																	"source": [
																		"obj-19",
																		0
																	]
																}
															},
															{
																"patchline": {
																	"destination": [
																		"obj-19",
																		0
																	],
																	"disabled": 0,
																	"hidden": 0,
																	"source": [
																		"obj-20",
																		0
																	]
																}
															},
															{
																"patchline": {
																	"destination": [
																		"obj-17",
																		0
																	],
																	"disabled": 0,
																	"hidden": 0,
																	"source": [
																		"obj-4",
																		0
																	]
																}
															}
														]
													},
													"patching_rect": [
														74.0,
														184.2,
														93.0,
														22.0
													],
													"saved_object_attributes": {
														"description": "",
														"digest": "",
														"globalpatchername": "",
														"style": "",
														"tags": ""
													},
													"style": "",
													"text": "p Capitalization"
												}
											},
											{
												"box": {
													"id": "obj-71",
													"maxclass": "newobj",
													"numinlets": 2,
													"numoutlets": 2,
													"outlettype": [
														"",
														""
													],
													"patching_rect": [
														74.0,
														213.0,
														83.0,
														22.0
													],
													"style": "",
													"text": "combine arg :"
												}
											},
											{
												"box": {
													"comment": "",
													"id": "obj-1",
													"maxclass": "inlet",
													"numinlets": 0,
													"numoutlets": 1,
													"outlettype": [
														""
													],
													"patching_rect": [
														50.0,
														15.0,
														30.0,
														30.0
													],
													"style": ""
												}
											}
										],
										"lines": [
											{
												"patchline": {
													"destination": [
														"obj-4",
														0
													],
													"disabled": 0,
													"hidden": 0,
													"source": [
														"obj-1",
														0
													]
												}
											},
											{
												"patchline": {
													"destination": [
														"obj-3",
														0
													],
													"disabled": 0,
													"hidden": 0,
													"source": [
														"obj-10",
														1
													]
												}
											},
											{
												"patchline": {
													"destination": [
														"obj-71",
														0
													],
													"disabled": 0,
													"hidden": 0,
													"source": [
														"obj-3",
														0
													]
												}
											},
											{
												"patchline": {
													"destination": [
														"obj-10",
														0
													],
													"disabled": 0,
													"hidden": 0,
													"source": [
														"obj-4",
														0
													]
												}
											},
											{
												"patchline": {
													"destination": [
														"obj-6",
														0
													],
													"disabled": 0,
													"hidden": 0,
													"source": [
														"obj-5",
														0
													]
												}
											},
											{
												"patchline": {
													"destination": [
														"obj-5",
														0
													],
													"disabled": 0,
													"hidden": 0,
													"source": [
														"obj-71",
														0
													]
												}
											}
										]
									},
									"patching_rect": [
										877.0,
										30.4,
										113.0,
										35.0
									],
									"saved_object_attributes": {
										"description": "",
										"digest": "",
										"globalpatchername": "",
										"style": "",
										"tags": ""
									},
									"style": "",
									"text": "p GUI_update_script"
								}
							},
							{
								"box": {
									"id": "obj-13",
									"maxclass": "newobj",
									"numinlets": 1,
									"numoutlets": 0,
									"patching_rect": [
										767.0,
										605.2,
										127.0,
										22.0
									],
									"style": "",
									"text": "s #0.display.refresh"
								}
							},
							{
								"box": {
									"id": "obj-14",
									"maxclass": "newobj",
									"numinlets": 1,
									"numoutlets": 3,
									"outlettype": [
										"bang",
										"",
										""
									],
									"patching_rect": [
										767.0,
										403.6,
										103.0,
										22.0
									],
									"style": "",
									"text": "t b l l"
								}
							},
							{
								"box": {
									"id": "obj-7",
									"linecount": 2,
									"maxclass": "newobj",
									"numinlets": 1,
									"numoutlets": 0,
									"patcher": {
										"fileversion": 1,
										"appversion": {
											"major": 7,
											"minor": 0,
											"revision": 5,
											"architecture": "x86",
											"modernui": 1
										},
										"rect": [
											1246.0,
											134.0,
											640.0,
											508.6
										],
										"bglocked": 0,
										"openinpresentation": 0,
										"default_fontsize": 12.0,
										"default_fontface": 0,
										"default_fontname": "Arial",
										"gridonopen": 1,
										"gridsize": [
											15.0,
											15.0
										],
										"gridsnaponopen": 1,
										"objectsnaponopen": 1,
										"statusbarvisible": 2,
										"toolbarvisible": 1,
										"lefttoolbarpinned": 0,
										"toptoolbarpinned": 0,
										"righttoolbarpinned": 0,
										"bottomtoolbarpinned": 0,
										"toolbars_unpinned_last_save": 0,
										"tallnewobj": 0,
										"boxanimatetime": 200,
										"enablehscroll": 1,
										"enablevscroll": 1,
										"devicewidth": 0.0,
										"description": "",
										"digest": "",
										"tags": "",
										"style": "",
										"subpatcher_template": "",
										"boxes": [
											{
												"box": {
													"id": "obj-10",
													"maxclass": "newobj",
													"numinlets": 1,
													"numoutlets": 2,
													"outlettype": [
														"bang",
														"bang"
													],
													"patching_rect": [
														50.0,
														145.8,
														43.0,
														22.0
													],
													"style": "",
													"text": "b"
												}
											},
											{
												"box": {
													"id": "obj-9",
													"linecount": 3,
													"maxclass": "message",
													"numinlets": 2,
													"numoutlets": 1,
													"outlettype": [
														""
													],
													"patching_rect": [
														50.0,
														293.4,
														270.0,
														49.0
													],
													"style": "",
													"text": "script sendbox parameter[2]_label hidden 0, script sendbox parameter[2]_numbox hidden 0, script sendbox parameter[2]_panel hidden 0"
												}
											},
											{
												"box": {
													"id": "obj-6",
													"maxclass": "newobj",
													"numinlets": 1,
													"numoutlets": 0,
													"patching_rect": [
														50.0,
														426.6,
														109.0,
														22.0
													],
													"style": "",
													"text": "s #0.thispatcher"
												}
											},
											{
												"box": {
													"comment": "",
													"id": "obj-1",
													"maxclass": "inlet",
													"numinlets": 0,
													"numoutlets": 1,
													"outlettype": [
														""
													],
													"patching_rect": [
														50.0,
														15.0,
														30.0,
														30.0
													],
													"style": ""
												}
											}
										],
										"lines": [
											{
												"patchline": {
													"destination": [
														"obj-10",
														0
													],
													"disabled": 0,
													"hidden": 0,
													"source": [
														"obj-1",
														0
													]
												}
											},
											{
												"patchline": {
													"destination": [
														"obj-9",
														0
													],
													"disabled": 0,
													"hidden": 0,
													"source": [
														"obj-10",
														0
													]
												}
											},
											{
												"patchline": {
													"destination": [
														"obj-6",
														0
													],
													"disabled": 0,
													"hidden": 0,
													"source": [
														"obj-9",
														0
													]
												}
											}
										]
									},
									"patching_rect": [
										603.0,
										544.0,
										113.0,
										35.0
									],
									"saved_object_attributes": {
										"description": "",
										"digest": "",
										"globalpatchername": "",
										"style": "",
										"tags": ""
									},
									"style": "",
									"text": "p GUI_update_script"
								}
							},
							{
								"box": {
									"id": "obj-8",
									"maxclass": "newobj",
									"numinlets": 1,
									"numoutlets": 0,
									"patching_rect": [
										561.0,
										605.2,
										127.0,
										22.0
									],
									"style": "",
									"text": "s #0.display.refresh"
								}
							},
							{
								"box": {
									"id": "obj-9",
									"maxclass": "newobj",
									"numinlets": 1,
									"numoutlets": 3,
									"outlettype": [
										"bang",
										"",
										""
									],
									"patching_rect": [
										561.0,
										440.8,
										103.0,
										22.0
									],
									"style": "",
									"text": "t b l l"
								}
							},
							{
								"box": {
									"id": "obj-2",
									"linecount": 2,
									"maxclass": "newobj",
									"numinlets": 1,
									"numoutlets": 0,
									"patcher": {
										"fileversion": 1,
										"appversion": {
											"major": 7,
											"minor": 0,
											"revision": 5,
											"architecture": "x86",
											"modernui": 1
										},
										"rect": [
											1246.0,
											346.0,
											640.0,
											508.6
										],
										"bglocked": 0,
										"openinpresentation": 0,
										"default_fontsize": 12.0,
										"default_fontface": 0,
										"default_fontname": "Arial",
										"gridonopen": 1,
										"gridsize": [
											15.0,
											15.0
										],
										"gridsnaponopen": 1,
										"objectsnaponopen": 1,
										"statusbarvisible": 2,
										"toolbarvisible": 1,
										"lefttoolbarpinned": 0,
										"toptoolbarpinned": 0,
										"righttoolbarpinned": 0,
										"bottomtoolbarpinned": 0,
										"toolbars_unpinned_last_save": 0,
										"tallnewobj": 0,
										"boxanimatetime": 200,
										"enablehscroll": 1,
										"enablevscroll": 1,
										"devicewidth": 0.0,
										"description": "",
										"digest": "",
										"tags": "",
										"style": "",
										"subpatcher_template": "",
										"boxes": [
											{
												"box": {
													"id": "obj-4",
													"maxclass": "message",
													"numinlets": 2,
													"numoutlets": 1,
													"outlettype": [
														""
													],
													"patching_rect": [
														50.0,
														82.2,
														29.5,
														22.0
													],
													"style": "",
													"text": "$1"
												}
											},
											{
												"box": {
													"id": "obj-10",
													"maxclass": "newobj",
													"numinlets": 1,
													"numoutlets": 2,
													"outlettype": [
														"bang",
														""
													],
													"patching_rect": [
														50.0,
														145.8,
														43.0,
														22.0
													],
													"style": "",
													"text": "t b l"
												}
											},
											{
												"box": {
													"id": "obj-9",
													"linecount": 3,
													"maxclass": "message",
													"numinlets": 2,
													"numoutlets": 1,
													"outlettype": [
														""
													],
													"patching_rect": [
														50.0,
														293.4,
														264.0,
														49.0
													],
													"style": "",
													"text": "script sendbox parameter[1]_label hidden 0, script sendbox parameter[1]_numbox hidden 0, script sendbox parameter[1]_panel hidden 0"
												}
											},
											{
												"box": {
													"id": "obj-6",
													"maxclass": "newobj",
													"numinlets": 1,
													"numoutlets": 0,
													"patching_rect": [
														50.0,
														426.6,
														109.0,
														22.0
													],
													"style": "",
													"text": "s #0.thispatcher"
												}
											},
											{
												"box": {
													"id": "obj-5",
													"maxclass": "message",
													"numinlets": 2,
													"numoutlets": 1,
													"outlettype": [
														""
													],
													"patching_rect": [
														74.0,
														246.6,
														227.0,
														22.0
													],
													"style": "",
													"text": "script sendbox parameter[1]_label set $1"
												}
											},
											{
												"box": {
													"id": "obj-3",
													"maxclass": "newobj",
													"numinlets": 1,
													"numoutlets": 1,
													"outlettype": [
														"int"
													],
													"patcher": {
														"fileversion": 1,
														"appversion": {
															"major": 7,
															"minor": 0,
															"revision": 5,
															"architecture": "x86",
															"modernui": 1
														},
														"rect": [
															1246.0,
															307.0,
															640.0,
															480.0
														],
														"bglocked": 0,
														"openinpresentation": 0,
														"default_fontsize": 12.0,
														"default_fontface": 0,
														"default_fontname": "Arial",
														"gridonopen": 1,
														"gridsize": [
															15.0,
															15.0
														],
														"gridsnaponopen": 1,
														"objectsnaponopen": 1,
														"statusbarvisible": 2,
														"toolbarvisible": 1,
														"lefttoolbarpinned": 0,
														"toptoolbarpinned": 0,
														"righttoolbarpinned": 0,
														"bottomtoolbarpinned": 0,
														"toolbars_unpinned_last_save": 0,
														"tallnewobj": 0,
														"boxanimatetime": 200,
														"enablehscroll": 1,
														"enablevscroll": 1,
														"devicewidth": 0.0,
														"description": "",
														"digest": "",
														"tags": "",
														"style": "",
														"subpatcher_template": "",
														"boxes": [
															{
																"box": {
																	"comment": "",
																	"id": "obj-2",
																	"maxclass": "outlet",
																	"numinlets": 1,
																	"numoutlets": 0,
																	"patching_rect": [
																		69.0,
																		365.8,
																		30.0,
																		30.0
																	],
																	"style": ""
																}
															},
															{
																"box": {
																	"comment": "",
																	"id": "obj-1",
																	"maxclass": "inlet",
																	"numinlets": 0,
																	"numoutlets": 1,
																	"outlettype": [
																		""
																	],
																	"patching_rect": [
																		69.0,
																		49.0,
																		30.0,
																		30.0
																	],
																	"style": ""
																}
															},
															{
																"box": {
																	"id": "obj-20",
																	"maxclass": "newobj",
																	"numinlets": 2,
																	"numoutlets": 1,
																	"outlettype": [
																		"int"
																	],
																	"patching_rect": [
																		69.0,
																		208.6,
																		31.0,
																		22.0
																	],
																	"style": "",
																	"text": "- 32"
																}
															},
															{
																"box": {
																	"id": "obj-19",
																	"maxclass": "newobj",
																	"numinlets": 2,
																	"numoutlets": 2,
																	"outlettype": [
																		"",
																		""
																	],
																	"patching_rect": [
																		69.0,
																		271.0,
																		57.0,
																		22.0
																	],
																	"style": "",
																	"text": "zl.join"
																}
															},
															{
																"box": {
																	"id": "obj-17",
																	"maxclass": "newobj",
																	"numinlets": 2,
																	"numoutlets": 2,
																	"outlettype": [
																		"",
																		""
																	],
																	"patching_rect": [
																		69.0,
																		167.8,
																		57.0,
																		22.0
																	],
																	"style": "",
																	"text": "zl.slice 1"
																}
															},
															{
																"box": {
																	"id": "obj-10",
																	"maxclass": "newobj",
																	"numinlets": 3,
																	"numoutlets": 1,
																	"outlettype": [
																		"int"
																	],
																	"patching_rect": [
																		69.0,
																		320.2,
																		40.0,
																		22.0
																	],
																	"style": "",
																	"text": "itoa"
																}
															},
															{
																"box": {
																	"id": "obj-4",
																	"maxclass": "newobj",
																	"numinlets": 3,
																	"numoutlets": 1,
																	"outlettype": [
																		"list"
																	],
																	"patching_rect": [
																		69.0,
																		117.4,
																		40.0,
																		22.0
																	],
																	"style": "",
																	"text": "atoi"
																}
															}
														],
														"lines": [
															{
																"patchline": {
																	"destination": [
																		"obj-4",
																		0
																	],
																	"disabled": 0,
																	"hidden": 0,
																	"source": [
																		"obj-1",
																		0
																	]
																}
															},
															{
																"patchline": {
																	"destination": [
																		"obj-2",
																		0
																	],
																	"disabled": 0,
																	"hidden": 0,
																	"source": [
																		"obj-10",
																		0
																	]
																}
															},
															{
																"patchline": {
																	"destination": [
																		"obj-19",
																		1
																	],
																	"disabled": 0,
																	"hidden": 0,
																	"source": [
																		"obj-17",
																		1
																	]
																}
															},
															{
																"patchline": {
																	"destination": [
																		"obj-20",
																		0
																	],
																	"disabled": 0,
																	"hidden": 0,
																	"source": [
																		"obj-17",
																		0
																	]
																}
															},
															{
																"patchline": {
																	"destination": [
																		"obj-10",
																		0
																	],
																	"disabled": 0,
																	"hidden": 0,
																	"source": [
																		"obj-19",
																		0
																	]
																}
															},
															{
																"patchline": {
																	"destination": [
																		"obj-19",
																		0
																	],
																	"disabled": 0,
																	"hidden": 0,
																	"source": [
																		"obj-20",
																		0
																	]
																}
															},
															{
																"patchline": {
																	"destination": [
																		"obj-17",
																		0
																	],
																	"disabled": 0,
																	"hidden": 0,
																	"source": [
																		"obj-4",
																		0
																	]
																}
															}
														]
													},
													"patching_rect": [
														74.0,
														184.2,
														93.0,
														22.0
													],
													"saved_object_attributes": {
														"description": "",
														"digest": "",
														"globalpatchername": "",
														"style": "",
														"tags": ""
													},
													"style": "",
													"text": "p Capitalization"
												}
											},
											{
												"box": {
													"id": "obj-71",
													"maxclass": "newobj",
													"numinlets": 2,
													"numoutlets": 2,
													"outlettype": [
														"",
														""
													],
													"patching_rect": [
														74.0,
														213.0,
														83.0,
														22.0
													],
													"style": "",
													"text": "combine arg :"
												}
											},
											{
												"box": {
													"comment": "",
													"id": "obj-1",
													"maxclass": "inlet",
													"numinlets": 0,
													"numoutlets": 1,
													"outlettype": [
														""
													],
													"patching_rect": [
														50.0,
														15.0,
														30.0,
														30.0
													],
													"style": ""
												}
											}
										],
										"lines": [
											{
												"patchline": {
													"destination": [
														"obj-4",
														0
													],
													"disabled": 0,
													"hidden": 0,
													"source": [
														"obj-1",
														0
													]
												}
											},
											{
												"patchline": {
													"destination": [
														"obj-3",
														0
													],
													"disabled": 0,
													"hidden": 0,
													"source": [
														"obj-10",
														1
													]
												}
											},
											{
												"patchline": {
													"destination": [
														"obj-9",
														0
													],
													"disabled": 0,
													"hidden": 0,
													"source": [
														"obj-10",
														0
													]
												}
											},
											{
												"patchline": {
													"destination": [
														"obj-71",
														0
													],
													"disabled": 0,
													"hidden": 0,
													"source": [
														"obj-3",
														0
													]
												}
											},
											{
												"patchline": {
													"destination": [
														"obj-10",
														0
													],
													"disabled": 0,
													"hidden": 0,
													"source": [
														"obj-4",
														0
													]
												}
											},
											{
												"patchline": {
													"destination": [
														"obj-6",
														0
													],
													"disabled": 0,
													"hidden": 0,
													"source": [
														"obj-5",
														0
													]
												}
											},
											{
												"patchline": {
													"destination": [
														"obj-5",
														0
													],
													"disabled": 0,
													"hidden": 0,
													"source": [
														"obj-71",
														0
													]
												}
											},
											{
												"patchline": {
													"destination": [
														"obj-6",
														0
													],
													"disabled": 0,
													"hidden": 0,
													"source": [
														"obj-9",
														0
													]
												}
											}
										]
									},
									"patching_rect": [
										611.0,
										30.4,
										113.0,
										35.0
									],
									"saved_object_attributes": {
										"description": "",
										"digest": "",
										"globalpatchername": "",
										"style": "",
										"tags": ""
									},
									"style": "",
									"text": "p GUI_update_script"
								}
							},
							{
								"box": {
									"id": "obj-72",
									"maxclass": "newobj",
									"numinlets": 1,
									"numoutlets": 0,
									"patching_rect": [
										124.5,
										614.8,
										127.0,
										22.0
									],
									"style": "",
									"text": "s #0.display.refresh"
								}
							},
							{
								"box": {
									"id": "obj-1",
									"maxclass": "newobj",
									"numinlets": 1,
									"numoutlets": 3,
									"outlettype": [
										"bang",
										"",
										""
									],
									"patching_rect": [
										124.5,
										403.6,
										103.0,
										22.0
									],
									"style": "",
									"text": "t b l l"
								}
							},
							{
								"box": {
									"id": "obj-46",
									"maxclass": "newobj",
									"numinlets": 5,
									"numoutlets": 5,
									"outlettype": [
										"",
										"",
										"",
										"",
										""
									],
									"patching_rect": [
										305.000031,
										88.0,
										1043.0,
										22.0
									],
									"style": "",
									"text": "route parameter.1 parameter.2 curveList push"
								}
							},
							{
								"box": {
									"id": "obj-213",
									"maxclass": "newobj",
									"numinlets": 1,
									"numoutlets": 1,
									"outlettype": [
										""
									],
									"patching_rect": [
										889.0,
										811.0,
										112.0,
										22.0
									],
									"style": "",
									"text": "prepend setsymbol"
								}
							},
							{
								"box": {
									"id": "obj-214",
									"maxclass": "newobj",
									"numinlets": 1,
									"numoutlets": 1,
									"outlettype": [
										""
									],
									"patching_rect": [
										683.0,
										672.4,
										74.0,
										22.0
									],
									"style": "",
									"text": "prepend set"
								}
							},
							{
								"box": {
									"id": "obj-94",
									"maxclass": "newobj",
									"numinlets": 1,
									"numoutlets": 1,
									"outlettype": [
										""
									],
									"patching_rect": [
										246.5,
										672.4,
										74.0,
										22.0
									],
									"style": "",
									"text": "prepend set"
								}
							},
							{
								"box": {
									"id": "obj-228",
									"maxclass": "newobj",
									"numinlets": 3,
									"numoutlets": 3,
									"outlettype": [
										"",
										"",
										""
									],
									"patching_rect": [
										561.0,
										329.2,
										168.0,
										22.0
									],
									"style": "",
									"text": "route float int"
								}
							},
							{
								"box": {
									"comment": "",
									"id": "obj-231",
									"maxclass": "inlet",
									"numinlets": 0,
									"numoutlets": 1,
									"outlettype": [
										""
									],
									"patching_rect": [
										305.0,
										36.4,
										30.0,
										30.0
									],
									"presentation": 1,
									"presentation_rect": [
										1819.333252,
										451.0,
										30.0,
										30.0
									],
									"style": ""
								}
							},
							{
								"box": {
									"comment": "",
									"id": "obj-232",
									"maxclass": "inlet",
									"numinlets": 0,
									"numoutlets": 1,
									"outlettype": [
										""
									],
									"patching_rect": [
										561.0,
										16.0,
										30.0,
										30.0
									],
									"presentation": 1,
									"presentation_rect": [
										1884.333252,
										451.0,
										30.0,
										30.0
									],
									"style": ""
								}
							},
							{
								"box": {
									"comment": "",
									"id": "obj-233",
									"maxclass": "inlet",
									"numinlets": 0,
									"numoutlets": 1,
									"outlettype": [
										""
									],
									"patching_rect": [
										817.0,
										16.0,
										30.0,
										30.0
									],
									"presentation": 1,
									"presentation_rect": [
										1949.333252,
										451.0,
										30.0,
										30.0
									],
									"style": ""
								}
							},
							{
								"box": {
									"comment": "",
									"id": "obj-234",
									"maxclass": "outlet",
									"numinlets": 1,
									"numoutlets": 0,
									"patching_rect": [
										246.5,
										885.4,
										30.0,
										30.0
									],
									"presentation": 1,
									"presentation_rect": [
										1941.333252,
										1030.5,
										30.0,
										30.0
									],
									"style": ""
								}
							},
							{
								"box": {
									"comment": "",
									"id": "obj-235",
									"maxclass": "outlet",
									"numinlets": 1,
									"numoutlets": 0,
									"patching_rect": [
										681.0,
										875.8,
										30.0,
										30.0
									],
									"presentation": 1,
									"presentation_rect": [
										2270.833252,
										1030.5,
										30.0,
										30.0
									],
									"style": ""
								}
							},
							{
								"box": {
									"comment": "",
									"id": "obj-236",
									"maxclass": "outlet",
									"numinlets": 1,
									"numoutlets": 0,
									"patching_rect": [
										889.0,
										875.8,
										30.0,
										30.0
									],
									"presentation": 1,
									"presentation_rect": [
										2730.833252,
										1030.5,
										30.0,
										30.0
									],
									"style": ""
								}
							}
						],
						"lines": [
							{
								"patchline": {
									"destination": [
										"obj-72",
										0
									],
									"disabled": 0,
									"hidden": 0,
									"source": [
										"obj-1",
										0
									]
								}
							},
							{
								"patchline": {
									"destination": [
										"obj-94",
										0
									],
									"disabled": 0,
									"hidden": 0,
									"source": [
										"obj-1",
										2
									]
								}
							},
							{
								"patchline": {
									"destination": [
										"obj-13",
										0
									],
									"disabled": 0,
									"hidden": 0,
									"source": [
										"obj-14",
										0
									]
								}
							},
							{
								"patchline": {
									"destination": [
										"obj-213",
										0
									],
									"disabled": 0,
									"hidden": 0,
									"source": [
										"obj-14",
										2
									]
								}
							},
							{
								"patchline": {
									"destination": [
										"obj-27",
										0
									],
									"disabled": 0,
									"hidden": 0,
									"source": [
										"obj-14",
										1
									]
								}
							},
							{
								"patchline": {
									"destination": [
										"obj-17",
										0
									],
									"disabled": 0,
									"hidden": 0,
									"source": [
										"obj-16",
										0
									]
								}
							},
							{
								"patchline": {
									"destination": [
										"obj-41",
										0
									],
									"disabled": 0,
									"hidden": 0,
									"source": [
										"obj-16",
										1
									]
								}
							},
							{
								"patchline": {
									"destination": [
										"obj-236",
										0
									],
									"disabled": 0,
									"hidden": 0,
									"source": [
										"obj-213",
										0
									]
								}
							},
							{
								"patchline": {
									"destination": [
										"obj-235",
										0
									],
									"disabled": 0,
									"hidden": 0,
									"source": [
										"obj-214",
										0
									]
								}
							},
							{
								"patchline": {
									"destination": [
										"obj-14",
										0
									],
									"disabled": 0,
									"hidden": 0,
									"source": [
										"obj-228",
										2
									]
								}
							},
							{
								"patchline": {
									"destination": [
										"obj-9",
										0
									],
									"disabled": 0,
									"hidden": 0,
									"source": [
										"obj-228",
										1
									]
								}
							},
							{
								"patchline": {
									"destination": [
										"obj-9",
										0
									],
									"disabled": 0,
									"hidden": 0,
									"source": [
										"obj-228",
										0
									]
								}
							},
							{
								"patchline": {
									"destination": [
										"obj-46",
										0
									],
									"disabled": 0,
									"hidden": 0,
									"source": [
										"obj-231",
										0
									]
								}
							},
							{
								"patchline": {
									"destination": [
										"obj-2",
										0
									],
									"disabled": 0,
									"hidden": 0,
									"source": [
										"obj-232",
										0
									]
								}
							},
							{
								"patchline": {
									"destination": [
										"obj-33",
										1
									],
									"disabled": 0,
									"hidden": 0,
									"source": [
										"obj-232",
										0
									]
								}
							},
							{
								"patchline": {
									"destination": [
										"obj-46",
										1
									],
									"disabled": 0,
									"hidden": 0,
									"source": [
										"obj-232",
										0
									]
								}
							},
							{
								"patchline": {
									"destination": [
										"obj-12",
										0
									],
									"disabled": 0,
									"hidden": 0,
									"source": [
										"obj-233",
										0
									]
								}
							},
							{
								"patchline": {
									"destination": [
										"obj-33",
										2
									],
									"disabled": 0,
									"hidden": 0,
									"source": [
										"obj-233",
										0
									]
								}
							},
							{
								"patchline": {
									"destination": [
										"obj-46",
										2
									],
									"disabled": 0,
									"hidden": 0,
									"source": [
										"obj-233",
										0
									]
								}
							},
							{
								"patchline": {
									"destination": [
										"obj-16",
										0
									],
									"disabled": 0,
									"hidden": 0,
									"source": [
										"obj-28",
										1
									]
								}
							},
							{
								"patchline": {
									"destination": [
										"obj-18",
										0
									],
									"disabled": 0,
									"hidden": 0,
									"midpoints": [
										1021.166748,
										759.7,
										1093.166748,
										759.7
									],
									"source": [
										"obj-28",
										0
									]
								}
							},
							{
								"patchline": {
									"destination": [
										"obj-1",
										0
									],
									"disabled": 0,
									"hidden": 0,
									"source": [
										"obj-30",
										1
									]
								}
							},
							{
								"patchline": {
									"destination": [
										"obj-234",
										0
									],
									"disabled": 0,
									"hidden": 0,
									"midpoints": [
										116.0,
										758.5,
										256.0,
										758.5
									],
									"source": [
										"obj-30",
										0
									]
								}
							},
							{
								"patchline": {
									"destination": [
										"obj-235",
										0
									],
									"disabled": 0,
									"hidden": 0,
									"midpoints": [
										429.333344,
										758.5,
										690.5,
										758.5
									],
									"source": [
										"obj-31",
										0
									]
								}
							},
							{
								"patchline": {
									"destination": [
										"obj-9",
										0
									],
									"disabled": 0,
									"hidden": 0,
									"source": [
										"obj-31",
										1
									]
								}
							},
							{
								"patchline": {
									"destination": [
										"obj-28",
										0
									],
									"disabled": 0,
									"hidden": 0,
									"source": [
										"obj-33",
										2
									]
								}
							},
							{
								"patchline": {
									"destination": [
										"obj-30",
										0
									],
									"disabled": 0,
									"hidden": 0,
									"source": [
										"obj-33",
										0
									]
								}
							},
							{
								"patchline": {
									"destination": [
										"obj-34",
										0
									],
									"disabled": 0,
									"hidden": 0,
									"source": [
										"obj-33",
										1
									]
								}
							},
							{
								"patchline": {
									"destination": [
										"obj-23",
										1
									],
									"disabled": 0,
									"hidden": 0,
									"source": [
										"obj-34",
										2
									]
								}
							},
							{
								"patchline": {
									"destination": [
										"obj-31",
										0
									],
									"disabled": 0,
									"hidden": 0,
									"source": [
										"obj-34",
										1
									]
								}
							},
							{
								"patchline": {
									"destination": [
										"obj-31",
										0
									],
									"disabled": 0,
									"hidden": 0,
									"source": [
										"obj-34",
										0
									]
								}
							},
							{
								"patchline": {
									"destination": [
										"obj-35",
										0
									],
									"disabled": 0,
									"hidden": 0,
									"source": [
										"obj-34",
										2
									]
								}
							},
							{
								"patchline": {
									"destination": [
										"obj-14",
										0
									],
									"disabled": 0,
									"hidden": 0,
									"source": [
										"obj-35",
										1
									]
								}
							},
							{
								"patchline": {
									"destination": [
										"obj-236",
										0
									],
									"disabled": 0,
									"hidden": 0,
									"midpoints": [
										758.5,
										854.5,
										898.5,
										854.5
									],
									"source": [
										"obj-35",
										0
									]
								}
							},
							{
								"patchline": {
									"destination": [
										"obj-18",
										0
									],
									"disabled": 0,
									"hidden": 0,
									"source": [
										"obj-41",
										0
									]
								}
							},
							{
								"patchline": {
									"destination": [
										"obj-1",
										0
									],
									"disabled": 0,
									"hidden": 0,
									"source": [
										"obj-46",
										0
									]
								}
							},
							{
								"patchline": {
									"destination": [
										"obj-16",
										0
									],
									"disabled": 0,
									"hidden": 0,
									"source": [
										"obj-46",
										2
									]
								}
							},
							{
								"patchline": {
									"destination": [
										"obj-228",
										0
									],
									"disabled": 0,
									"hidden": 0,
									"source": [
										"obj-46",
										1
									]
								}
							},
							{
								"patchline": {
									"destination": [
										"obj-33",
										0
									],
									"disabled": 0,
									"hidden": 0,
									"source": [
										"obj-46",
										3
									]
								}
							},
							{
								"patchline": {
									"destination": [
										"obj-214",
										0
									],
									"disabled": 0,
									"hidden": 0,
									"source": [
										"obj-9",
										2
									]
								}
							},
							{
								"patchline": {
									"destination": [
										"obj-7",
										0
									],
									"disabled": 0,
									"hidden": 0,
									"source": [
										"obj-9",
										1
									]
								}
							},
							{
								"patchline": {
									"destination": [
										"obj-8",
										0
									],
									"disabled": 0,
									"hidden": 0,
									"source": [
										"obj-9",
										0
									]
								}
							},
							{
								"patchline": {
									"destination": [
										"obj-234",
										0
									],
									"disabled": 0,
									"hidden": 0,
									"source": [
										"obj-94",
										0
									]
								}
							}
						],
						"styles": [
							{
								"name": "Jamoma_highlighted_orange",
								"default": {
									"accentcolor": [
										1.0,
										0.5,
										0.0,
										1.0
									]
								},
								"parentstyle": "",
								"multi": 0
							}
						]
					},
					"patching_rect": [
						1881.0,
						620.2,
						448.75,
						22.0
					],
					"saved_object_attributes": {
						"description": "",
						"digest": "",
						"globalpatchername": "",
						"style": "",
						"tags": ""
					},
					"style": "",
					"text": "p parameters_dispatch"
				}
			},
			{
				"box": {
					"id": "obj-125",
					"maxclass": "newobj",
					"numinlets": 1,
					"numoutlets": 0,
					"patcher": {
						"fileversion": 1,
						"appversion": {
							"major": 7,
							"minor": 0,
							"revision": 5,
							"architecture": "x86",
							"modernui": 1
						},
						"rect": [
							1149.0,
							419.0,
							737.0,
							550.0
						],
						"bglocked": 0,
						"openinpresentation": 0,
						"default_fontsize": 12.0,
						"default_fontface": 0,
						"default_fontname": "Arial",
						"gridonopen": 1,
						"gridsize": [
							15.0,
							15.0
						],
						"gridsnaponopen": 1,
						"objectsnaponopen": 1,
						"statusbarvisible": 2,
						"toolbarvisible": 1,
						"lefttoolbarpinned": 0,
						"toptoolbarpinned": 0,
						"righttoolbarpinned": 0,
						"bottomtoolbarpinned": 0,
						"toolbars_unpinned_last_save": 0,
						"tallnewobj": 0,
						"boxanimatetime": 200,
						"enablehscroll": 1,
						"enablevscroll": 1,
						"devicewidth": 0.0,
						"description": "",
						"digest": "",
						"tags": "",
						"style": "",
						"subpatcher_template": "",
						"boxes": [
							{
								"box": {
									"id": "obj-4",
									"maxclass": "newobj",
									"numinlets": 1,
									"numoutlets": 2,
									"outlettype": [
										"bang",
										"bang"
									],
									"patching_rect": [
										102.0,
										78.2,
										100.0,
										22.0
									],
									"style": "",
									"text": "b"
								}
							},
							{
								"box": {
									"id": "obj-8",
									"maxclass": "comment",
									"numinlets": 1,
									"numoutlets": 0,
									"patching_rect": [
										388.0,
										357.8,
										198.0,
										20.0
									],
									"style": "",
									"text": "linear and freehand gui elements"
								}
							},
							{
								"box": {
									"id": "obj-7",
									"linecount": 3,
									"maxclass": "message",
									"numinlets": 2,
									"numoutlets": 1,
									"outlettype": [
										""
									],
									"patching_rect": [
										102.0,
										284.6,
										582.0,
										49.0
									],
									"style": "",
									"text": "script sendbox no_parameter_label hidden 1, script sendbox no_parameter_panel hidden 1, script sendbox no_parameter_plot hidden 1, script sendbox function_parameter_label hidden 1, script sendbox function_parameter_panel hidden 1, script sendbox function_parameter_bpf hidden 1"
								}
							},
							{
								"box": {
									"id": "obj-6",
									"maxclass": "comment",
									"numinlets": 1,
									"numoutlets": 0,
									"patching_rect": [
										376.0,
										214.4,
										198.0,
										20.0
									],
									"style": "",
									"text": "function parameters.2 gui elements"
								}
							},
							{
								"box": {
									"id": "obj-5",
									"maxclass": "comment",
									"numinlets": 1,
									"numoutlets": 0,
									"patching_rect": [
										376.0,
										137.6,
										198.0,
										20.0
									],
									"style": "",
									"text": "function parameters.1 gui elements"
								}
							},
							{
								"box": {
									"id": "obj-3",
									"linecount": 4,
									"maxclass": "message",
									"numinlets": 2,
									"numoutlets": 1,
									"outlettype": [
										""
									],
									"patching_rect": [
										102.0,
										193.4,
										263.0,
										62.0
									],
									"style": "",
									"text": "script sendbox parameter[2]_label hidden 1, script sendbox parameter[2]_numbox hidden 1, script sendbox parameter[2]_umenu hidden 1, script sendbox parameter[2]_panel hidden 1"
								}
							},
							{
								"box": {
									"id": "obj-2",
									"maxclass": "newobj",
									"numinlets": 1,
									"numoutlets": 0,
									"patching_rect": [
										102.0,
										462.2,
										107.0,
										22.0
									],
									"style": "",
									"text": "s #0.thispatcher"
								}
							},
							{
								"box": {
									"id": "obj-9",
									"linecount": 3,
									"maxclass": "message",
									"numinlets": 2,
									"numoutlets": 1,
									"outlettype": [
										""
									],
									"patching_rect": [
										102.0,
										120.2,
										267.0,
										49.0
									],
									"style": "",
									"text": "script sendbox parameter[1]_label hidden 1, script sendbox parameter[1]_numbox hidden 1, script sendbox parameter[1]_panel hidden 1"
								}
							},
							{
								"box": {
									"comment": "",
									"id": "obj-1",
									"maxclass": "inlet",
									"numinlets": 0,
									"numoutlets": 1,
									"outlettype": [
										""
									],
									"patching_rect": [
										102.0,
										23.0,
										30.0,
										30.0
									],
									"style": ""
								}
							}
						],
						"lines": [
							{
								"patchline": {
									"destination": [
										"obj-4",
										0
									],
									"disabled": 0,
									"hidden": 0,
									"source": [
										"obj-1",
										0
									]
								}
							},
							{
								"patchline": {
									"destination": [
										"obj-2",
										0
									],
									"disabled": 0,
									"hidden": 0,
									"source": [
										"obj-3",
										0
									]
								}
							},
							{
								"patchline": {
									"destination": [
										"obj-3",
										0
									],
									"disabled": 0,
									"hidden": 0,
									"source": [
										"obj-4",
										0
									]
								}
							},
							{
								"patchline": {
									"destination": [
										"obj-7",
										0
									],
									"disabled": 0,
									"hidden": 0,
									"source": [
										"obj-4",
										0
									]
								}
							},
							{
								"patchline": {
									"destination": [
										"obj-9",
										0
									],
									"disabled": 0,
									"hidden": 0,
									"source": [
										"obj-4",
										0
									]
								}
							},
							{
								"patchline": {
									"destination": [
										"obj-2",
										0
									],
									"disabled": 0,
									"hidden": 0,
									"source": [
										"obj-7",
										0
									]
								}
							},
							{
								"patchline": {
									"destination": [
										"obj-2",
										0
									],
									"disabled": 0,
									"hidden": 0,
									"source": [
										"obj-9",
										0
									]
								}
							}
						]
					},
					"patching_rect": [
						3028.5,
						716.8,
						112.5,
						22.0
					],
					"saved_object_attributes": {
						"description": "",
						"digest": "",
						"globalpatchername": "",
						"style": "",
						"tags": ""
					},
					"style": "",
					"text": "p GUI_init_script"
				}
			},
			{
				"box": {
					"id": "obj-124",
					"maxclass": "newobj",
					"numinlets": 0,
					"numoutlets": 1,
					"outlettype": [
						""
					],
					"patching_rect": [
						3522.041748,
						988.6,
						107.0,
						22.0
					],
					"style": "",
					"text": "r #0.thispatcher"
				}
			},
			{
				"box": {
					"id": "obj-48",
					"maxclass": "newobj",
					"numinlets": 1,
					"numoutlets": 5,
					"outlettype": [
						"bang",
						"",
						"function/parameters",
						"",
						"bang"
					],
					"patching_rect": [
						2963.0,
						751.6,
						208.666748,
						22.0
					],
					"style": "",
					"text": "t b l function/parameters l b"
				}
			},
			{
				"box": {
					"id": "obj-163",
					"maxclass": "newobj",
					"numinlets": 1,
					"numoutlets": 2,
					"outlettype": [
						"",
						"int"
					],
					"patching_rect": [
						2747.25,
						751.6,
						30.0,
						22.0
					],
					"style": "",
					"text": "t l 1"
				}
			},
			{
				"box": {
					"id": "obj-32",
					"linecount": 2,
					"maxclass": "newobj",
					"numinlets": 1,
					"numoutlets": 1,
					"outlettype": [
						""
					],
					"patcher": {
						"fileversion": 1,
						"appversion": {
							"major": 7,
							"minor": 0,
							"revision": 5,
							"architecture": "x86",
							"modernui": 1
						},
						"rect": [
							1096.0,
							320.0,
							790.0,
							552.0
						],
						"bglocked": 0,
						"openinpresentation": 0,
						"default_fontsize": 12.0,
						"default_fontface": 0,
						"default_fontname": "Arial",
						"gridonopen": 1,
						"gridsize": [
							15.0,
							15.0
						],
						"gridsnaponopen": 1,
						"objectsnaponopen": 1,
						"statusbarvisible": 2,
						"toolbarvisible": 1,
						"lefttoolbarpinned": 0,
						"toptoolbarpinned": 0,
						"righttoolbarpinned": 0,
						"bottomtoolbarpinned": 0,
						"toolbars_unpinned_last_save": 0,
						"tallnewobj": 0,
						"boxanimatetime": 200,
						"enablehscroll": 1,
						"enablevscroll": 1,
						"devicewidth": 0.0,
						"description": "",
						"digest": "",
						"tags": "",
						"style": "",
						"subpatcher_template": "",
						"boxes": [
							{
								"box": {
									"id": "obj-150",
									"linecount": 2,
									"maxclass": "newobj",
									"numinlets": 23,
									"numoutlets": 23,
									"outlettype": [
										"",
										"",
										"",
										"",
										"",
										"",
										"",
										"",
										"",
										"",
										"",
										"",
										"",
										"",
										"",
										"",
										"",
										"",
										"",
										"",
										"",
										"",
										""
									],
									"patching_rect": [
										50.0,
										110.8,
										730.0,
										35.0
									],
									"style": "",
									"text": "routepass float int list function inverse output/threshold/up output/threshold/down active input/threshold/down ramp function/parameters output/max output/min input/index clipmode input/min output input/threshold/up 1. input/max input function/parameter/value"
								}
							},
							{
								"box": {
									"comment": "",
									"id": "obj-28",
									"maxclass": "inlet",
									"numinlets": 0,
									"numoutlets": 1,
									"outlettype": [
										""
									],
									"patching_rect": [
										50.0,
										40.0,
										30.0,
										30.0
									],
									"presentation": 1,
									"presentation_rect": [
										1300.5,
										54.5,
										30.0,
										30.0
									],
									"style": ""
								}
							},
							{
								"box": {
									"comment": "",
									"id": "obj-29",
									"maxclass": "outlet",
									"numinlets": 1,
									"numoutlets": 0,
									"patching_rect": [
										50.0,
										442.0,
										30.0,
										30.0
									],
									"presentation": 1,
									"presentation_rect": [
										1294.5,
										223.5,
										30.0,
										30.0
									],
									"style": ""
								}
							}
						],
						"lines": [
							{
								"patchline": {
									"destination": [
										"obj-29",
										0
									],
									"disabled": 0,
									"hidden": 0,
									"source": [
										"obj-150",
										22
									]
								}
							},
							{
								"patchline": {
									"destination": [
										"obj-29",
										0
									],
									"disabled": 0,
									"hidden": 0,
									"source": [
										"obj-150",
										2
									]
								}
							},
							{
								"patchline": {
									"destination": [
										"obj-29",
										0
									],
									"disabled": 0,
									"hidden": 0,
									"source": [
										"obj-150",
										1
									]
								}
							},
							{
								"patchline": {
									"destination": [
										"obj-29",
										0
									],
									"disabled": 0,
									"hidden": 0,
									"source": [
										"obj-150",
										0
									]
								}
							},
							{
								"patchline": {
									"destination": [
										"obj-150",
										0
									],
									"disabled": 0,
									"hidden": 0,
									"source": [
										"obj-28",
										0
									]
								}
							}
						]
					},
					"patching_rect": [
						1881.0,
						215.2,
						81.833252,
						35.0
					],
					"saved_object_attributes": {
						"description": "",
						"digest": "",
						"globalpatchername": "",
						"style": "",
						"tags": ""
					},
					"style": "",
					"text": "p route_symbol"
				}
			},
			{
				"box": {
					"id": "obj-75",
					"maxclass": "newobj",
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [
						2963.0,
						853.0,
						127.0,
						22.0
					],
					"style": "",
					"text": "s #0.display.refresh"
				}
			},
			{
				"box": {
					"id": "obj-71",
					"maxclass": "newobj",
					"numinlets": 2,
					"numoutlets": 2,
					"outlettype": [
						"",
						""
					],
					"patching_rect": [
						1881.0,
						992.2,
						57.0,
						22.0
					],
					"style": "",
					"text": "route set"
				}
			},
			{
				"box": {
					"id": "obj-10",
					"maxclass": "newobj",
					"numinlets": 1,
					"numoutlets": 1,
					"outlettype": [
						""
					],
					"patching_rect": [
						3026.222168,
						810.4,
						112.0,
						22.0
					],
					"style": "",
					"text": "prepend setsymbol"
				}
			},
			{
				"box": {
					"id": "obj-201",
					"maxclass": "newobj",
					"numinlets": 2,
					"numoutlets": 4,
					"outlettype": [
						"",
						"",
						"",
						""
					],
					"patching_rect": [
						1881.0,
						955.0,
						214.0,
						22.0
					],
					"style": "",
					"text": "j.remote_array function/parameters.[2]"
				}
			},
			{
				"box": {
					"hidden": 1,
					"id": "obj-200",
					"maxclass": "newobj",
					"numinlets": 0,
					"numoutlets": 1,
					"outlettype": [
						""
					],
					"patching_rect": [
						2112.5,
						955.0,
						141.0,
						22.0
					],
					"style": "",
					"text": "r #0.parameterslength"
				}
			},
			{
				"box": {
					"id": "obj-191",
					"maxclass": "newobj",
					"numinlets": 1,
					"numoutlets": 1,
					"outlettype": [
						""
					],
					"patching_rect": [
						1778.5,
						1123.0,
						31.0,
						22.0
					],
					"style": "",
					"text": "thru"
				}
			},
			{
				"box": {
					"id": "obj-185",
					"maxclass": "newobj",
					"numinlets": 1,
					"numoutlets": 2,
					"outlettype": [
						"",
						""
					],
					"patching_rect": [
						1454.5,
						130.0,
						51.0,
						22.0
					],
					"style": "Jamoma_highlighted_orange",
					"text": "j.map"
				}
			},
			{
				"box": {
					"id": "obj-181",
					"maxclass": "newobj",
					"numinlets": 1,
					"numoutlets": 4,
					"outlettype": [
						"",
						"",
						"",
						""
					],
					"patching_rect": [
						2963.0,
						680.8,
						215.5,
						22.0
					],
					"style": "Jamoma_highlighted_orange",
					"text": "j.remote function"
				}
			},
			{
				"box": {
					"id": "obj-66",
					"maxclass": "message",
					"numinlets": 2,
					"numoutlets": 1,
					"outlettype": [
						""
					],
					"patching_rect": [
						290.833374,
						123.4,
						137.0,
						22.0
					],
					"style": "",
					"text": "model:address /mapper"
				}
			},
			{
				"box": {
					"id": "obj-187",
					"linecount": 2,
					"maxclass": "newobj",
					"numinlets": 3,
					"numoutlets": 1,
					"outlettype": [
						""
					],
					"patcher": {
						"fileversion": 1,
						"appversion": {
							"major": 7,
							"minor": 0,
							"revision": 5,
							"architecture": "x86",
							"modernui": 1
						},
						"rect": [
							770.0,
							341.0,
							1116.0,
							528
						],
						"bglocked": 0,
						"openinpresentation": 0,
						"default_fontsize": 12.0,
						"default_fontface": 0,
						"default_fontname": "Arial",
						"gridonopen": 1,
						"gridsize": [
							15.0,
							15.0
						],
						"gridsnaponopen": 1,
						"objectsnaponopen": 1,
						"statusbarvisible": 2,
						"toolbarvisible": 1,
						"lefttoolbarpinned": 0,
						"toptoolbarpinned": 0,
						"righttoolbarpinned": 0,
						"bottomtoolbarpinned": 0,
						"toolbars_unpinned_last_save": 0,
						"tallnewobj": 0,
						"boxanimatetime": 200,
						"enablehscroll": 1,
						"enablevscroll": 1,
						"devicewidth": 0.0,
						"description": "",
						"digest": "",
						"tags": "",
						"style": "",
						"subpatcher_template": "",
						"boxes": [
							{
								"box": {
									"id": "obj-154",
									"maxclass": "message",
									"numinlets": 2,
									"numoutlets": 1,
									"outlettype": [
										""
									],
									"patching_rect": [
										640.166687,
										302.6,
										189.0,
										22.0
									],
									"style": "",
									"text": "script sendbox inputval hidden $1"
								}
							},
							{
								"box": {
									"id": "obj-142",
									"maxclass": "message",
									"numinlets": 2,
									"numoutlets": 1,
									"outlettype": [
										""
									],
									"patching_rect": [
										835.166687,
										302.6,
										196.0,
										22.0
									],
									"style": "",
									"text": "script sendbox outputval hidden $1"
								}
							},
							{
								"box": {
									"id": "obj-141",
									"maxclass": "message",
									"numinlets": 2,
									"numoutlets": 1,
									"outlettype": [
										""
									],
									"patching_rect": [
										326.5,
										302.6,
										291.0,
										22.0
									],
									"style": "",
									"text": "script sendbox outputval presentation_position $1 $2"
								}
							},
							{
								"box": {
									"id": "obj-134",
									"maxclass": "newobj",
									"numinlets": 2,
									"numoutlets": 1,
									"outlettype": [
										"int"
									],
									"patching_rect": [
										326.5,
										116.0,
										34.0,
										22.0
									],
									"style": "",
									"text": "+ 15"
								}
							},
							{
								"box": {
									"id": "obj-135",
									"maxclass": "newobj",
									"numinlets": 2,
									"numoutlets": 1,
									"outlettype": [
										""
									],
									"patching_rect": [
										326.5,
										176.0,
										81.0,
										22.0
									],
									"style": "",
									"text": "pack f f"
								}
							},
							{
								"box": {
									"id": "obj-136",
									"maxclass": "newobj",
									"numinlets": 2,
									"numoutlets": 1,
									"outlettype": [
										"int"
									],
									"patching_rect": [
										388.5,
										116.0,
										29.5,
										22.0
									],
									"style": "",
									"text": "- 8"
								}
							},
							{
								"box": {
									"id": "obj-132",
									"maxclass": "newobj",
									"numinlets": 2,
									"numoutlets": 1,
									"outlettype": [
										"int"
									],
									"patching_rect": [
										39.083374,
										116.0,
										29.5,
										22.0
									],
									"style": "",
									"text": "- 5"
								}
							},
							{
								"box": {
									"id": "obj-107",
									"maxclass": "newobj",
									"numinlets": 2,
									"numoutlets": 1,
									"outlettype": [
										""
									],
									"patching_rect": [
										39.083374,
										176.0,
										60.5,
										22.0
									],
									"style": "",
									"text": "pack i i"
								}
							},
							{
								"box": {
									"id": "obj-106",
									"maxclass": "message",
									"numinlets": 2,
									"numoutlets": 1,
									"outlettype": [
										""
									],
									"patching_rect": [
										39.083374,
										302.6,
										283.0,
										22.0
									],
									"style": "",
									"text": "script sendbox inputval presentation_position $1 $2"
								}
							},
							{
								"box": {
									"id": "obj-104",
									"maxclass": "newobj",
									"numinlets": 2,
									"numoutlets": 1,
									"outlettype": [
										"int"
									],
									"patching_rect": [
										80.583374,
										116.0,
										34.0,
										22.0
									],
									"style": "",
									"text": "+ 20"
								}
							},
							{
								"box": {
									"comment": "",
									"id": "obj-181",
									"maxclass": "inlet",
									"numinlets": 0,
									"numoutlets": 1,
									"outlettype": [
										"int"
									],
									"patching_rect": [
										39.083374,
										20.0,
										30.0,
										30.0
									],
									"style": ""
								}
							},
							{
								"box": {
									"comment": "",
									"id": "obj-184",
									"maxclass": "inlet",
									"numinlets": 0,
									"numoutlets": 1,
									"outlettype": [
										"int"
									],
									"patching_rect": [
										388.5,
										20.0,
										30.0,
										30.0
									],
									"style": ""
								}
							},
							{
								"box": {
									"comment": "",
									"id": "obj-185",
									"maxclass": "inlet",
									"numinlets": 0,
									"numoutlets": 1,
									"outlettype": [
										"int"
									],
									"patching_rect": [
										640.166687,
										20.0,
										30.0,
										30.0
									],
									"style": ""
								}
							},
							{
								"box": {
									"comment": "",
									"id": "obj-186",
									"maxclass": "outlet",
									"numinlets": 1,
									"numoutlets": 0,
									"patching_rect": [
										326.5,
										446.6,
										30.0,
										30.0
									],
									"style": ""
								}
							}
						],
						"lines": [
							{
								"patchline": {
									"destination": [
										"obj-107",
										1
									],
									"disabled": 0,
									"hidden": 0,
									"source": [
										"obj-104",
										0
									]
								}
							},
							{
								"patchline": {
									"destination": [
										"obj-186",
										0
									],
									"disabled": 0,
									"hidden": 0,
									"source": [
										"obj-106",
										0
									]
								}
							},
							{
								"patchline": {
									"destination": [
										"obj-106",
										0
									],
									"disabled": 0,
									"hidden": 0,
									"source": [
										"obj-107",
										0
									]
								}
							},
							{
								"patchline": {
									"destination": [
										"obj-107",
										0
									],
									"disabled": 0,
									"hidden": 0,
									"source": [
										"obj-132",
										0
									]
								}
							},
							{
								"patchline": {
									"destination": [
										"obj-135",
										0
									],
									"disabled": 0,
									"hidden": 0,
									"source": [
										"obj-134",
										0
									]
								}
							},
							{
								"patchline": {
									"destination": [
										"obj-141",
										0
									],
									"disabled": 0,
									"hidden": 0,
									"source": [
										"obj-135",
										0
									]
								}
							},
							{
								"patchline": {
									"destination": [
										"obj-135",
										1
									],
									"disabled": 0,
									"hidden": 0,
									"source": [
										"obj-136",
										0
									]
								}
							},
							{
								"patchline": {
									"destination": [
										"obj-186",
										0
									],
									"disabled": 0,
									"hidden": 0,
									"source": [
										"obj-141",
										0
									]
								}
							},
							{
								"patchline": {
									"destination": [
										"obj-186",
										0
									],
									"disabled": 0,
									"hidden": 0,
									"source": [
										"obj-142",
										0
									]
								}
							},
							{
								"patchline": {
									"destination": [
										"obj-186",
										0
									],
									"disabled": 0,
									"hidden": 0,
									"source": [
										"obj-154",
										0
									]
								}
							},
							{
								"patchline": {
									"destination": [
										"obj-132",
										0
									],
									"disabled": 0,
									"hidden": 0,
									"source": [
										"obj-181",
										0
									]
								}
							},
							{
								"patchline": {
									"destination": [
										"obj-134",
										0
									],
									"disabled": 0,
									"hidden": 0,
									"source": [
										"obj-181",
										0
									]
								}
							},
							{
								"patchline": {
									"destination": [
										"obj-104",
										0
									],
									"disabled": 0,
									"hidden": 0,
									"source": [
										"obj-184",
										0
									]
								}
							},
							{
								"patchline": {
									"destination": [
										"obj-136",
										0
									],
									"disabled": 0,
									"hidden": 0,
									"source": [
										"obj-184",
										0
									]
								}
							},
							{
								"patchline": {
									"destination": [
										"obj-142",
										0
									],
									"disabled": 0,
									"hidden": 0,
									"source": [
										"obj-185",
										0
									]
								}
							},
							{
								"patchline": {
									"destination": [
										"obj-154",
										0
									],
									"disabled": 0,
									"hidden": 0,
									"source": [
										"obj-185",
										0
									]
								}
							}
						]
					},
					"patching_rect": [
						3498.875,
						845.2,
						135.166687,
						35.0
					],
					"saved_object_attributes": {
						"description": "",
						"digest": "",
						"globalpatchername": "",
						"style": "",
						"tags": ""
					},
					"style": "",
					"text": "p mousetooltips_scripting"
				}
			},
			{
				"box": {
					"id": "obj-13",
					"maxclass": "newobj",
					"numinlets": 1,
					"numoutlets": 2,
					"outlettype": [
						"",
						""
					],
					"patching_rect": [
						3498.875,
						1055.8,
						69.0,
						22.0
					],
					"save": [
						"#N",
						"thispatcher",
						";",
						"#Q",
						"savewindow",
						1,
						";",
						"#Q",
						"end",
						";"
					],
					"style": "",
					"text": "thispatcher"
				}
			},
			{
				"box": {
					"id": "obj-4",
					"maxclass": "newobj",
					"numinlets": 1,
					"numoutlets": 4,
					"outlettype": [
						"",
						"",
						"",
						""
					],
					"patching_rect": [
						3485.375,
						584.2,
						153.5,
						22.0
					],
					"saved_object_attributes": {
						"mode": 0
					},
					"style": "",
					"text": "hover"
				}
			},
			{
				"box": {
					"id": "obj-41",
					"maxclass": "newobj",
					"numinlets": 2,
					"numoutlets": 2,
					"outlettype": [
						"",
						""
					],
					"patching_rect": [
						318.666626,
						329.2,
						57.0,
						22.0
					],
					"style": "",
					"text": "route set"
				}
			},
			{
				"box": {
					"id": "obj-37",
					"maxclass": "newobj",
					"numinlets": 2,
					"numoutlets": 2,
					"outlettype": [
						"",
						""
					],
					"patching_rect": [
						891.300049,
						329.2,
						57.0,
						22.0
					],
					"style": "",
					"text": "route set"
				}
			},
			{
				"box": {
					"id": "obj-17",
					"justification": 1,
					"maxclass": "live.line",
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [
						174.833374,
						942.4,
						15.0,
						100.0
					],
					"presentation": 1,
					"presentation_rect": [
						19.333344,
						368.292969,
						478.0,
						33.5
					]
				}
			},
			{
				"box": {
					"id": "obj-16",
					"maxclass": "live.line",
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [
						150.0,
						942.4,
						15.0,
						100.0
					],
					"presentation": 1,
					"presentation_rect": [
						260.333344,
						147.0,
						46.0,
						475.0
					]
				}
			},
			{
				"box": {
					"id": "obj-221",
					"maxclass": "newobj",
					"numinlets": 1,
					"numoutlets": 1,
					"outlettype": [
						""
					],
					"patcher": {
						"fileversion": 1,
						"appversion": {
							"major": 7,
							"minor": 0,
							"revision": 5,
							"architecture": "x86",
							"modernui": 1
						},
						"rect": [
							63.0,
							104.0,
							640.0,
							480.0
						],
						"bglocked": 0,
						"openinpresentation": 0,
						"default_fontsize": 12.0,
						"default_fontface": 0,
						"default_fontname": "Arial",
						"gridonopen": 1,
						"gridsize": [
							15.0,
							15.0
						],
						"gridsnaponopen": 1,
						"objectsnaponopen": 1,
						"statusbarvisible": 2,
						"toolbarvisible": 1,
						"lefttoolbarpinned": 0,
						"toptoolbarpinned": 0,
						"righttoolbarpinned": 0,
						"bottomtoolbarpinned": 0,
						"toolbars_unpinned_last_save": 0,
						"tallnewobj": 0,
						"boxanimatetime": 200,
						"enablehscroll": 1,
						"enablevscroll": 1,
						"devicewidth": 0.0,
						"description": "",
						"digest": "",
						"tags": "",
						"style": "",
						"subpatcher_template": "",
						"boxes": [
							{
								"box": {
									"fontname": "Arial",
									"fontsize": 12.0,
									"id": "obj-25",
									"maxclass": "message",
									"numinlets": 2,
									"numoutlets": 1,
									"outlettype": [
										""
									],
									"patching_rect": [
										50.0,
										152.2,
										64.0,
										22.0
									],
									"style": "",
									"text": "data/out.1"
								}
							},
							{
								"box": {
									"fontname": "Arial",
									"fontsize": 12.0,
									"id": "obj-17",
									"maxclass": "newobj",
									"numinlets": 2,
									"numoutlets": 2,
									"outlettype": [
										"bang",
										""
									],
									"patching_rect": [
										50.0,
										112.0,
										87.700012,
										22.0
									],
									"style": "",
									"text": "sel none"
								}
							},
							{
								"box": {
									"comment": "",
									"id": "obj-218",
									"maxclass": "inlet",
									"numinlets": 0,
									"numoutlets": 1,
									"outlettype": [
										""
									],
									"patching_rect": [
										50.0,
										40.0,
										30.0,
										30.0
									],
									"presentation": 1,
									"presentation_rect": [
										23.299988,
										559.5,
										30.0,
										30.0
									],
									"style": ""
								}
							},
							{
								"box": {
									"comment": "",
									"id": "obj-219",
									"maxclass": "outlet",
									"numinlets": 1,
									"numoutlets": 0,
									"patching_rect": [
										44.0,
										250.6,
										30.0,
										30.0
									],
									"presentation": 1,
									"presentation_rect": [
										17.299988,
										735.0,
										30.0,
										30.0
									],
									"style": ""
								}
							}
						],
						"lines": [
							{
								"patchline": {
									"destination": [
										"obj-219",
										0
									],
									"disabled": 0,
									"hidden": 0,
									"source": [
										"obj-17",
										1
									]
								}
							},
							{
								"patchline": {
									"destination": [
										"obj-25",
										0
									],
									"disabled": 0,
									"hidden": 0,
									"source": [
										"obj-17",
										0
									]
								}
							},
							{
								"patchline": {
									"destination": [
										"obj-17",
										0
									],
									"disabled": 0,
									"hidden": 0,
									"source": [
										"obj-218",
										0
									]
								}
							},
							{
								"patchline": {
									"destination": [
										"obj-219",
										0
									],
									"disabled": 0,
									"hidden": 0,
									"source": [
										"obj-25",
										0
									]
								}
							}
						]
					},
					"patching_rect": [
						891.300049,
						357.4,
						57.0,
						22.0
					],
					"saved_object_attributes": {
						"description": "",
						"digest": "",
						"globalpatchername": "",
						"style": "",
						"tags": ""
					},
					"style": "",
					"text": "p default"
				}
			},
			{
				"box": {
					"id": "obj-220",
					"maxclass": "newobj",
					"numinlets": 1,
					"numoutlets": 1,
					"outlettype": [
						""
					],
					"patcher": {
						"fileversion": 1,
						"appversion": {
							"major": 7,
							"minor": 0,
							"revision": 5,
							"architecture": "x86",
							"modernui": 1
						},
						"rect": [
							63.0,
							104.0,
							640.0,
							480.0
						],
						"bglocked": 0,
						"openinpresentation": 0,
						"default_fontsize": 12.0,
						"default_fontface": 0,
						"default_fontname": "Arial",
						"gridonopen": 1,
						"gridsize": [
							15.0,
							15.0
						],
						"gridsnaponopen": 1,
						"objectsnaponopen": 1,
						"statusbarvisible": 2,
						"toolbarvisible": 1,
						"lefttoolbarpinned": 0,
						"toptoolbarpinned": 0,
						"righttoolbarpinned": 0,
						"bottomtoolbarpinned": 0,
						"toolbars_unpinned_last_save": 0,
						"tallnewobj": 0,
						"boxanimatetime": 200,
						"enablehscroll": 1,
						"enablevscroll": 1,
						"devicewidth": 0.0,
						"description": "",
						"digest": "",
						"tags": "",
						"style": "",
						"subpatcher_template": "",
						"boxes": [
							{
								"box": {
									"fontname": "Arial",
									"fontsize": 12.0,
									"id": "obj-25",
									"maxclass": "message",
									"numinlets": 2,
									"numoutlets": 1,
									"outlettype": [
										""
									],
									"patching_rect": [
										50.0,
										152.2,
										57.0,
										22.0
									],
									"style": "",
									"text": "data/in.1"
								}
							},
							{
								"box": {
									"fontname": "Arial",
									"fontsize": 12.0,
									"id": "obj-17",
									"maxclass": "newobj",
									"numinlets": 2,
									"numoutlets": 2,
									"outlettype": [
										"bang",
										""
									],
									"patching_rect": [
										50.0,
										112.0,
										87.700012,
										22.0
									],
									"style": "",
									"text": "sel none"
								}
							},
							{
								"box": {
									"comment": "",
									"id": "obj-218",
									"maxclass": "inlet",
									"numinlets": 0,
									"numoutlets": 1,
									"outlettype": [
										""
									],
									"patching_rect": [
										50.0,
										40.0,
										30.0,
										30.0
									],
									"presentation": 1,
									"presentation_rect": [
										23.299988,
										559.5,
										30.0,
										30.0
									],
									"style": ""
								}
							},
							{
								"box": {
									"comment": "",
									"id": "obj-219",
									"maxclass": "outlet",
									"numinlets": 1,
									"numoutlets": 0,
									"patching_rect": [
										44.0,
										250.6,
										30.0,
										30.0
									],
									"presentation": 1,
									"presentation_rect": [
										17.299988,
										735.0,
										30.0,
										30.0
									],
									"style": ""
								}
							}
						],
						"lines": [
							{
								"patchline": {
									"destination": [
										"obj-219",
										0
									],
									"disabled": 0,
									"hidden": 0,
									"source": [
										"obj-17",
										1
									]
								}
							},
							{
								"patchline": {
									"destination": [
										"obj-25",
										0
									],
									"disabled": 0,
									"hidden": 0,
									"source": [
										"obj-17",
										0
									]
								}
							},
							{
								"patchline": {
									"destination": [
										"obj-17",
										0
									],
									"disabled": 0,
									"hidden": 0,
									"source": [
										"obj-218",
										0
									]
								}
							},
							{
								"patchline": {
									"destination": [
										"obj-219",
										0
									],
									"disabled": 0,
									"hidden": 0,
									"source": [
										"obj-25",
										0
									]
								}
							}
						]
					},
					"patching_rect": [
						318.666626,
						357.4,
						57.0,
						22.0
					],
					"saved_object_attributes": {
						"description": "",
						"digest": "",
						"globalpatchername": "",
						"style": "",
						"tags": ""
					},
					"style": "",
					"text": "p default"
				}
			},
			{
				"box": {
					"id": "obj-206",
					"linecount": 2,
					"maxclass": "newobj",
					"numinlets": 2,
					"numoutlets": 1,
					"outlettype": [
						""
					],
					"patcher": {
						"fileversion": 1,
						"appversion": {
							"major": 7,
							"minor": 0,
							"revision": 5,
							"architecture": "x86",
							"modernui": 1
						},
						"rect": [
							487.0,
							161.0,
							640.0,
							480.0
						],
						"bglocked": 0,
						"openinpresentation": 0,
						"default_fontsize": 12.0,
						"default_fontface": 0,
						"default_fontname": "Arial",
						"gridonopen": 1,
						"gridsize": [
							15.0,
							15.0
						],
						"gridsnaponopen": 1,
						"objectsnaponopen": 1,
						"statusbarvisible": 2,
						"toolbarvisible": 1,
						"lefttoolbarpinned": 0,
						"toptoolbarpinned": 0,
						"righttoolbarpinned": 0,
						"bottomtoolbarpinned": 0,
						"toolbars_unpinned_last_save": 0,
						"tallnewobj": 0,
						"boxanimatetime": 200,
						"enablehscroll": 1,
						"enablevscroll": 1,
						"devicewidth": 0.0,
						"description": "",
						"digest": "",
						"tags": "",
						"style": "",
						"subpatcher_template": "",
						"boxes": [
							{
								"box": {
									"fontname": "Arial",
									"fontsize": 12.0,
									"id": "obj-170",
									"maxclass": "newobj",
									"numinlets": 2,
									"numoutlets": 2,
									"outlettype": [
										"",
										""
									],
									"patching_rect": [
										50.0,
										112.0,
										57.0,
										22.0
									],
									"style": "",
									"text": "route set"
								}
							},
							{
								"box": {
									"id": "obj-175",
									"maxclass": "newobj",
									"numinlets": 2,
									"numoutlets": 1,
									"outlettype": [
										"int"
									],
									"patching_rect": [
										50.0,
										184.6,
										29.5,
										22.0
									],
									"style": "",
									"text": "!- 2"
								}
							},
							{
								"box": {
									"id": "obj-176",
									"maxclass": "newobj",
									"numinlets": 2,
									"numoutlets": 1,
									"outlettype": [
										"int"
									],
									"patching_rect": [
										50.0,
										145.0,
										35.0,
										22.0
									],
									"style": "",
									"text": "== 0"
								}
							},
							{
								"box": {
									"id": "obj-177",
									"maxclass": "newobj",
									"numinlets": 2,
									"numoutlets": 2,
									"outlettype": [
										"",
										""
									],
									"patching_rect": [
										50.0,
										223.0,
										54.0,
										22.0
									],
									"style": "",
									"text": "gate 2 0"
								}
							},
							{
								"box": {
									"id": "obj-178",
									"maxclass": "newobj",
									"numinlets": 2,
									"numoutlets": 2,
									"outlettype": [
										"",
										""
									],
									"patching_rect": [
										85.0,
										268.6,
										39.0,
										22.0
									],
									"style": "",
									"text": "zl.nth"
								}
							},
							{
								"box": {
									"comment": "",
									"id": "obj-179",
									"maxclass": "inlet",
									"numinlets": 0,
									"numoutlets": 1,
									"outlettype": [
										""
									],
									"patching_rect": [
										50.0,
										40.0,
										30.0,
										30.0
									],
									"presentation": 1,
									"presentation_rect": [
										572.700012,
										587.5,
										30.0,
										30.0
									],
									"style": ""
								}
							},
							{
								"box": {
									"comment": "",
									"id": "obj-180",
									"maxclass": "inlet",
									"numinlets": 0,
									"numoutlets": 1,
									"outlettype": [
										""
									],
									"patching_rect": [
										7.0,
										40.0,
										30.0,
										30.0
									],
									"presentation": 1,
									"presentation_rect": [
										607.700012,
										587.5,
										30.0,
										30.0
									],
									"style": ""
								}
							},
							{
								"box": {
									"comment": "",
									"id": "obj-181",
									"maxclass": "outlet",
									"numinlets": 1,
									"numoutlets": 0,
									"patching_rect": [
										61.5,
										367.0,
										30.0,
										30.0
									],
									"presentation": 1,
									"presentation_rect": [
										584.200012,
										860.0,
										30.0,
										30.0
									],
									"style": ""
								}
							}
						],
						"lines": [
							{
								"patchline": {
									"destination": [
										"obj-176",
										0
									],
									"disabled": 0,
									"hidden": 0,
									"source": [
										"obj-170",
										0
									]
								}
							},
							{
								"patchline": {
									"destination": [
										"obj-178",
										1
									],
									"disabled": 0,
									"hidden": 0,
									"source": [
										"obj-170",
										0
									]
								}
							},
							{
								"patchline": {
									"destination": [
										"obj-177",
										0
									],
									"disabled": 0,
									"hidden": 0,
									"source": [
										"obj-175",
										0
									]
								}
							},
							{
								"patchline": {
									"destination": [
										"obj-175",
										0
									],
									"disabled": 0,
									"hidden": 0,
									"source": [
										"obj-176",
										0
									]
								}
							},
							{
								"patchline": {
									"destination": [
										"obj-178",
										0
									],
									"disabled": 0,
									"hidden": 0,
									"source": [
										"obj-177",
										1
									]
								}
							},
							{
								"patchline": {
									"destination": [
										"obj-181",
										0
									],
									"disabled": 0,
									"hidden": 0,
									"source": [
										"obj-177",
										0
									]
								}
							},
							{
								"patchline": {
									"destination": [
										"obj-181",
										0
									],
									"disabled": 0,
									"hidden": 0,
									"source": [
										"obj-178",
										0
									]
								}
							},
							{
								"patchline": {
									"destination": [
										"obj-170",
										0
									],
									"disabled": 0,
									"hidden": 0,
									"source": [
										"obj-179",
										0
									]
								}
							},
							{
								"patchline": {
									"destination": [
										"obj-177",
										1
									],
									"disabled": 0,
									"hidden": 0,
									"source": [
										"obj-180",
										0
									]
								}
							}
						]
					},
					"patching_rect": [
						147.0,
						751.0,
						67.0,
						35.0
					],
					"saved_object_attributes": {
						"description": "",
						"digest": "",
						"globalpatchername": "",
						"style": "",
						"tags": ""
					},
					"style": "",
					"text": "p fromArray"
				}
			},
			{
				"box": {
					"fontface": 0,
					"fontname": "Arial",
					"fontsize": 12.0,
					"id": "obj-207",
					"maxclass": "newobj",
					"numinlets": 1,
					"numoutlets": 4,
					"outlettype": [
						"",
						"",
						"",
						""
					],
					"patching_rect": [
						195.0,
						714.4,
						115.0,
						22.0
					],
					"style": "",
					"text": "j.remote input/index"
				}
			},
			{
				"box": {
					"fontname": "Arial",
					"fontsize": 12.0,
					"id": "obj-208",
					"maxclass": "newobj",
					"numinlets": 2,
					"numoutlets": 2,
					"outlettype": [
						"",
						""
					],
					"patching_rect": [
						476.166626,
						639.4,
						57.0,
						22.0
					],
					"style": "",
					"text": "route set"
				}
			},
			{
				"box": {
					"fontname": "Arial",
					"fontsize": 12.0,
					"id": "obj-209",
					"maxclass": "newobj",
					"numinlets": 2,
					"numoutlets": 2,
					"outlettype": [
						"",
						""
					],
					"patching_rect": [
						265.166626,
						639.4,
						57.0,
						22.0
					],
					"style": "",
					"text": "route set"
				}
			},
			{
				"box": {
					"fontname": "Arial",
					"fontsize": 12.0,
					"id": "obj-210",
					"linecount": 2,
					"maxclass": "newobj",
					"numinlets": 1,
					"numoutlets": 1,
					"outlettype": [
						""
					],
					"patching_rect": [
						147.0,
						618.4,
						72.0,
						35.0
					],
					"style": "",
					"text": "prepend address"
				}
			},
			{
				"box": {
					"fontface": 0,
					"fontname": "Arial",
					"fontsize": 12.0,
					"id": "obj-211",
					"maxclass": "newobj",
					"numinlets": 1,
					"numoutlets": 3,
					"outlettype": [
						"",
						"",
						""
					],
					"patching_rect": [
						147.0,
						674.8,
						55.0,
						22.0
					],
					"style": "",
					"text": "j.receive"
				}
			},
			{
				"box": {
					"fontname": "Arial",
					"fontsize": 12.0,
					"id": "obj-212",
					"maxclass": "newobj",
					"numinlets": 6,
					"numoutlets": 1,
					"outlettype": [
						""
					],
					"patching_rect": [
						248.966614,
						833.2,
						100.0,
						22.0
					],
					"style": "",
					"text": "scale 0. 1. 0. 1."
				}
			},
			{
				"box": {
					"fontname": "Arial",
					"fontsize": 12.0,
					"id": "obj-195",
					"maxclass": "newobj",
					"numinlets": 2,
					"numoutlets": 2,
					"outlettype": [
						"",
						""
					],
					"patching_rect": [
						265.166626,
						415.0,
						72.5,
						22.0
					],
					"style": "",
					"text": "zl.reg"
				}
			},
			{
				"box": {
					"fontname": "Arial",
					"fontsize": 12.0,
					"id": "obj-198",
					"maxclass": "newobj",
					"numinlets": 1,
					"numoutlets": 1,
					"outlettype": [
						""
					],
					"patching_rect": [
						265.166626,
						472.6,
						101.0,
						22.0
					],
					"style": "",
					"text": "prepend address"
				}
			},
			{
				"box": {
					"fontface": 0,
					"fontname": "Arial",
					"fontsize": 12.0,
					"id": "obj-203",
					"maxclass": "newobj",
					"numinlets": 1,
					"numoutlets": 3,
					"outlettype": [
						"",
						"",
						""
					],
					"patching_rect": [
						265.166626,
						512.8,
						55.0,
						22.0
					],
					"style": "",
					"text": "j.receive"
				}
			},
			{
				"box": {
					"fontname": "Arial",
					"fontsize": 12.0,
					"id": "obj-204",
					"maxclass": "newobj",
					"numinlets": 1,
					"numoutlets": 3,
					"outlettype": [
						"",
						"",
						""
					],
					"patching_rect": [
						265.166626,
						545.8,
						441.0,
						22.0
					],
					"style": "",
					"text": "unjoin 2"
				}
			},
			{
				"box": {
					"fontname": "Arial",
					"fontsize": 12.0,
					"id": "obj-205",
					"maxclass": "newobj",
					"numinlets": 2,
					"numoutlets": 2,
					"outlettype": [
						"",
						""
					],
					"patching_rect": [
						265.166626,
						443.8,
						143.0,
						22.0
					],
					"style": "",
					"text": "combine /address :range"
				}
			},
			{
				"box": {
					"id": "obj-192",
					"ignoreclick": 1,
					"maxclass": "multislider",
					"numinlets": 1,
					"numoutlets": 2,
					"orientation": 0,
					"outlettype": [
						"",
						""
					],
					"parameter_enable": 0,
					"patching_rect": [
						248.966614,
						877.6,
						100.0,
						16.0
					],
					"presentation": 1,
					"presentation_rect": [
						19.333344,
						145.0,
						478.0,
						478.085938
					],
					"setminmax": [
						0.0,
						1.0
					],
					"size": 3,
					"style": "",
					"thickness": 1
				}
			},
			{
				"box": {
					"id": "obj-64",
					"maxclass": "message",
					"numinlets": 2,
					"numoutlets": 1,
					"outlettype": [
						""
					],
					"patching_rect": [
						827.833374,
						1032.4,
						37.0,
						22.0
					],
					"style": "",
					"text": "none"
				}
			},
			{
				"box": {
					"id": "obj-65",
					"maxclass": "newobj",
					"numinlets": 2,
					"numoutlets": 2,
					"outlettype": [
						"bang",
						""
					],
					"patching_rect": [
						827.833374,
						991.6,
						56.0,
						22.0
					],
					"style": "",
					"text": "sel bang"
				}
			},
			{
				"box": {
					"id": "obj-85",
					"maxclass": "newobj",
					"numinlets": 2,
					"numoutlets": 2,
					"outlettype": [
						"",
						""
					],
					"patching_rect": [
						827.833374,
						947.2,
						61.0,
						22.0
					],
					"style": "",
					"text": "route text"
				}
			},
			{
				"box": {
					"annotation": "none",
					"border": 1.0,
					"id": "obj-86",
					"keymode": 1,
					"lines": 1,
					"maxclass": "textedit",
					"numinlets": 1,
					"numoutlets": 4,
					"outlettype": [
						"",
						"int",
						"",
						""
					],
					"parameter_enable": 0,
					"patching_rect": [
						827.833374,
						1103.2,
						100.0,
						26.0
					],
					"presentation": 1,
					"presentation_rect": [
						796.0,
						28.0,
						57.0,
						20.0
					],
					"rounded": 0.0,
					"style": "",
					"text": "none"
				}
			},
			{
				"box": {
					"id": "obj-87",
					"maxclass": "newobj",
					"numinlets": 1,
					"numoutlets": 4,
					"outlettype": [
						"",
						"",
						"",
						""
					],
					"patching_rect": [
						827.833374,
						1066.0,
						113.0,
						22.0
					],
					"style": "",
					"text": "j.remote output/unit"
				}
			},
			{
				"box": {
					"annotation": "output/index : Pick an item from destination parameter, if it is of type array (default 0 = all)",
					"fontname": "Arial",
					"hint": "output/index : Pick an item from destination parameter, if it is of type array (default 0 = all)",
					"id": "obj-88",
					"maxclass": "number",
					"numinlets": 1,
					"numoutlets": 2,
					"outlettype": [
						"",
						"bang"
					],
					"parameter_enable": 0,
					"patching_rect": [
						734.000122,
						714.4,
						50.0,
						23.0
					],
					"presentation": 1,
					"presentation_rect": [
						499.333374,
						50.0,
						28.0,
						23.0
					],
					"style": ""
				}
			},
			{
				"box": {
					"annotation": "none",
					"bgmode": 0,
					"border": 0,
					"clickthrough": 0,
					"enablehscroll": 0,
					"enablevscroll": 0,
					"id": "obj-90",
					"lockeddragscroll": 0,
					"maxclass": "bpatcher",
					"name": "j.namespacebrowser.view.maxpat",
					"numinlets": 1,
					"numoutlets": 2,
					"offset": [
						1.0,
						2.0
					],
					"outlettype": [
						"",
						"bang"
					],
					"patching_rect": [
						891.300049,
						248.2,
						174.666626,
						20.0
					],
					"presentation": 1,
					"presentation_rect": [
						80.333344,
						50.0,
						358.0,
						26.0
					],
					"viewvisibility": 1
				}
			},
			{
				"box": {
					"annotation": "none",
					"bgmode": 0,
					"border": 0,
					"clickthrough": 0,
					"enablehscroll": 0,
					"enablevscroll": 0,
					"id": "obj-91",
					"lockeddragscroll": 0,
					"maxclass": "bpatcher",
					"name": "j.namespacebrowser.view.maxpat",
					"numinlets": 1,
					"numoutlets": 2,
					"offset": [
						2.0,
						2.0
					],
					"outlettype": [
						"",
						"bang"
					],
					"patching_rect": [
						318.666626,
						248.2,
						185.666718,
						21.0
					],
					"presentation": 1,
					"presentation_rect": [
						80.333344,
						26.0,
						358.0,
						26.0
					],
					"viewvisibility": 1
				}
			},
			{
				"box": {
					"fontname": "Arial",
					"fontsize": 12.0,
					"id": "obj-93",
					"maxclass": "newobj",
					"numinlets": 2,
					"numoutlets": 2,
					"outlettype": [
						"",
						""
					],
					"patching_rect": [
						833.833374,
						415.0,
						76.466675,
						22.0
					],
					"style": "",
					"text": "zl.reg"
				}
			},
			{
				"box": {
					"annotation": "none",
					"fontname": "Arial",
					"hint": "input/index : Pick an item from source parameter, if it is of type array (default 0 = all)",
					"id": "obj-96",
					"maxclass": "number",
					"numinlets": 1,
					"numoutlets": 2,
					"outlettype": [
						"",
						"bang"
					],
					"parameter_enable": 0,
					"patching_rect": [
						139.833374,
						714.4,
						50.0,
						23.0
					],
					"presentation": 1,
					"presentation_rect": [
						499.333374,
						26.0,
						28.0,
						23.0
					],
					"style": ""
				}
			},
			{
				"box": {
					"annotation": "none",
					"fontname": "Arial",
					"fontsize": 12.0,
					"format": 6,
					"id": "obj-109",
					"maxclass": "flonum",
					"numinlets": 1,
					"numoutlets": 2,
					"outlettype": [
						"",
						"bang"
					],
					"parameter_enable": 0,
					"patching_rect": [
						207.166626,
						581.8,
						49.0,
						23.0
					],
					"presentation": 1,
					"presentation_rect": [
						19.333344,
						628.085938,
						69.0,
						23.0
					],
					"style": ""
				}
			},
			{
				"box": {
					"annotation": "none",
					"fontname": "Arial",
					"fontsize": 12.0,
					"format": 6,
					"id": "obj-110",
					"maxclass": "flonum",
					"numinlets": 1,
					"numoutlets": 2,
					"outlettype": [
						"",
						"bang"
					],
					"parameter_enable": 0,
					"patching_rect": [
						418.166626,
						581.8,
						49.0,
						23.0
					],
					"presentation": 1,
					"presentation_rect": [
						429.416687,
						628.085938,
						69.0,
						23.0
					],
					"style": ""
				}
			},
			{
				"box": {
					"annotation": "none",
					"fontname": "Arial",
					"fontsize": 12.0,
					"format": 6,
					"id": "obj-111",
					"maxclass": "flonum",
					"numinlets": 1,
					"numoutlets": 2,
					"outlettype": [
						"",
						"bang"
					],
					"parameter_enable": 0,
					"patching_rect": [
						769.666748,
						581.8,
						49.0,
						23.0
					],
					"presentation": 1,
					"presentation_rect": [
						499.333374,
						603.5,
						69.0,
						23.0
					],
					"style": ""
				}
			},
			{
				"box": {
					"annotation": "none",
					"fontname": "Arial",
					"fontsize": 12.0,
					"format": 6,
					"id": "obj-112",
					"maxclass": "flonum",
					"numinlets": 1,
					"numoutlets": 2,
					"outlettype": [
						"",
						"bang"
					],
					"parameter_enable": 0,
					"patching_rect": [
						989.666748,
						581.8,
						50.0,
						23.0
					],
					"presentation": 1,
					"presentation_rect": [
						499.333374,
						147.0,
						69.0,
						23.0
					],
					"style": ""
				}
			},
			{
				"box": {
					"fontname": "Arial",
					"fontsize": 12.0,
					"id": "obj-113",
					"maxclass": "newobj",
					"numinlets": 1,
					"numoutlets": 4,
					"outlettype": [
						"",
						"",
						"",
						""
					],
					"patching_rect": [
						1053.833374,
						581.8,
						117.0,
						22.0
					],
					"style": "",
					"text": "j.remote output/max"
				}
			},
			{
				"box": {
					"fontname": "Arial",
					"fontsize": 12.0,
					"id": "obj-114",
					"maxclass": "newobj",
					"numinlets": 1,
					"numoutlets": 4,
					"outlettype": [
						"",
						"",
						"",
						""
					],
					"patching_rect": [
						833.833374,
						581.8,
						113.0,
						22.0
					],
					"style": "",
					"text": "j.remote output/min"
				}
			},
			{
				"box": {
					"fontname": "Arial",
					"fontsize": 12.0,
					"id": "obj-115",
					"maxclass": "newobj",
					"numinlets": 1,
					"numoutlets": 4,
					"outlettype": [
						"",
						"",
						"",
						""
					],
					"patching_rect": [
						476.166626,
						581.8,
						109.0,
						22.0
					],
					"style": "",
					"text": "j.remote input/max"
				}
			},
			{
				"box": {
					"fontname": "Arial",
					"fontsize": 12.0,
					"id": "obj-116",
					"maxclass": "newobj",
					"numinlets": 1,
					"numoutlets": 4,
					"outlettype": [
						"",
						"",
						"",
						""
					],
					"patching_rect": [
						265.166626,
						581.8,
						106.0,
						22.0
					],
					"style": "",
					"text": "j.remote input/min"
				}
			},
			{
				"box": {
					"fontname": "Arial",
					"fontsize": 12.0,
					"id": "obj-118",
					"maxclass": "newobj",
					"numinlets": 1,
					"numoutlets": 1,
					"outlettype": [
						""
					],
					"patching_rect": [
						833.833374,
						472.6,
						101.0,
						22.0
					],
					"style": "",
					"text": "prepend address"
				}
			},
			{
				"box": {
					"fontface": 0,
					"fontname": "Arial",
					"fontsize": 12.0,
					"id": "obj-120",
					"maxclass": "newobj",
					"numinlets": 1,
					"numoutlets": 3,
					"outlettype": [
						"",
						"",
						""
					],
					"patching_rect": [
						833.833374,
						517.0,
						55.0,
						22.0
					],
					"style": "",
					"text": "j.receive"
				}
			},
			{
				"box": {
					"fontname": "Arial",
					"fontsize": 12.0,
					"id": "obj-121",
					"maxclass": "newobj",
					"numinlets": 1,
					"numoutlets": 3,
					"outlettype": [
						"",
						"",
						""
					],
					"patching_rect": [
						833.833374,
						545.8,
						459.0,
						22.0
					],
					"style": "",
					"text": "unjoin 2"
				}
			},
			{
				"box": {
					"fontname": "Arial",
					"fontsize": 12.0,
					"id": "obj-122",
					"maxclass": "newobj",
					"numinlets": 2,
					"numoutlets": 2,
					"outlettype": [
						"",
						""
					],
					"patching_rect": [
						833.833374,
						443.8,
						143.0,
						22.0
					],
					"style": "",
					"text": "combine /address :range"
				}
			},
			{
				"box": {
					"fontface": 1,
					"fontname": "Arial",
					"fontsize": 12.0,
					"id": "obj-165",
					"maxclass": "comment",
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [
						405.666626,
						174.4,
						40.0,
						21.0
					],
					"presentation": 1,
					"presentation_rect": [
						36.333344,
						26.0,
						42.0,
						21.0
					],
					"style": "",
					"text": "Input:"
				}
			},
			{
				"box": {
					"fontname": "Arial",
					"fontsize": 12.0,
					"id": "obj-167",
					"maxclass": "newobj",
					"numinlets": 1,
					"numoutlets": 4,
					"outlettype": [
						"",
						"",
						"",
						""
					],
					"patching_rect": [
						891.300049,
						283.0,
						123.0,
						22.0
					],
					"style": "",
					"text": "j.remote output"
				}
			},
			{
				"box": {
					"fontname": "Arial",
					"fontsize": 12.0,
					"id": "obj-169",
					"maxclass": "newobj",
					"numinlets": 1,
					"numoutlets": 4,
					"outlettype": [
						"",
						"",
						"",
						""
					],
					"patching_rect": [
						318.666626,
						283.0,
						123.0,
						22.0
					],
					"style": "",
					"text": "j.remote input"
				}
			},
			{
				"box": {
					"comment": "",
					"id": "obj-18",
					"maxclass": "outlet",
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [
						160.0,
						448.6,
						30.0,
						30.0
					],
					"style": ""
				}
			},
			{
				"box": {
					"id": "obj-138",
					"maxclass": "newobj",
					"numinlets": 1,
					"numoutlets": 2,
					"outlettype": [
						"",
						""
					],
					"patching_rect": [
						160.0,
						409.0,
						41.0,
						22.0
					],
					"style": "",
					"text": "j.view"
				}
			},
			{
				"box": {
					"fontname": "Arial",
					"fontsize": 12.0,
					"id": "obj-148",
					"maxclass": "newobj",
					"numinlets": 2,
					"numoutlets": 2,
					"outlettype": [
						"",
						""
					],
					"patching_rect": [
						1053.833374,
						633.4,
						57.0,
						22.0
					],
					"style": "",
					"text": "route set"
				}
			},
			{
				"box": {
					"fontname": "Arial",
					"fontsize": 12.0,
					"id": "obj-152",
					"maxclass": "newobj",
					"numinlets": 2,
					"numoutlets": 2,
					"outlettype": [
						"",
						""
					],
					"patching_rect": [
						833.833374,
						639.4,
						57.0,
						22.0
					],
					"style": "",
					"text": "route set"
				}
			},
			{
				"box": {
					"fontname": "Arial",
					"fontsize": 12.0,
					"id": "obj-68",
					"linecount": 2,
					"maxclass": "newobj",
					"numinlets": 1,
					"numoutlets": 1,
					"outlettype": [
						""
					],
					"patching_rect": [
						736.666748,
						625.6,
						72.0,
						35.0
					],
					"style": "",
					"text": "prepend address"
				}
			},
			{
				"box": {
					"fontface": 0,
					"fontname": "Arial",
					"fontsize": 12.0,
					"id": "obj-82",
					"maxclass": "newobj",
					"numinlets": 1,
					"numoutlets": 3,
					"outlettype": [
						"",
						"",
						""
					],
					"patching_rect": [
						736.666748,
						674.8,
						55.0,
						22.0
					],
					"style": "",
					"text": "j.receive"
				}
			},
			{
				"box": {
					"fontname": "Arial",
					"fontsize": 12.0,
					"id": "obj-173",
					"maxclass": "newobj",
					"numinlets": 1,
					"numoutlets": 1,
					"outlettype": [
						""
					],
					"patching_rect": [
						2379.611084,
						841.0,
						106.0,
						22.0
					],
					"style": "",
					"text": "prepend curveList"
				}
			},
			{
				"box": {
					"fontname": "Arial",
					"fontsize": 12.0,
					"id": "obj-139",
					"maxclass": "newobj",
					"numinlets": 1,
					"numoutlets": 2,
					"outlettype": [
						"",
						""
					],
					"patcher": {
						"fileversion": 1,
						"appversion": {
							"major": 7,
							"minor": 0,
							"revision": 5,
							"architecture": "x86",
							"modernui": 1
						},
						"rect": [
							2426.0,
							360.0,
							640.0,
							480.0
						],
						"bglocked": 0,
						"openinpresentation": 0,
						"default_fontsize": 12.0,
						"default_fontface": 0,
						"default_fontname": "Arial",
						"gridonopen": 1,
						"gridsize": [
							15.0,
							15.0
						],
						"gridsnaponopen": 1,
						"objectsnaponopen": 1,
						"statusbarvisible": 2,
						"toolbarvisible": 1,
						"lefttoolbarpinned": 0,
						"toptoolbarpinned": 0,
						"righttoolbarpinned": 0,
						"bottomtoolbarpinned": 0,
						"toolbars_unpinned_last_save": 0,
						"tallnewobj": 0,
						"boxanimatetime": 200,
						"enablehscroll": 1,
						"enablevscroll": 1,
						"devicewidth": 0.0,
						"description": "",
						"digest": "",
						"tags": "",
						"style": "",
						"subpatcher_template": "",
						"boxes": [
							{
								"box": {
									"id": "obj-3",
									"maxclass": "newobj",
									"numinlets": 2,
									"numoutlets": 2,
									"outlettype": [
										"",
										""
									],
									"patching_rect": [
										151.166687,
										169.6,
										57.0,
										22.0
									],
									"style": "",
									"text": "route set"
								}
							},
							{
								"box": {
									"id": "obj-4",
									"maxclass": "newobj",
									"numinlets": 2,
									"numoutlets": 2,
									"outlettype": [
										"",
										""
									],
									"patching_rect": [
										127.166687,
										94.0,
										57.0,
										22.0
									],
									"style": "",
									"text": "route set"
								}
							},
							{
								"box": {
									"fontface": 0,
									"fontname": "Arial",
									"fontsize": 12.0,
									"id": "obj-5",
									"maxclass": "newobj",
									"numinlets": 1,
									"numoutlets": 4,
									"outlettype": [
										"",
										"",
										"",
										""
									],
									"patching_rect": [
										151.166687,
										134.5,
										109.0,
										22.0
									],
									"style": "",
									"text": "j.remote input/max"
								}
							},
							{
								"box": {
									"fontface": 0,
									"fontname": "Arial",
									"fontsize": 12.0,
									"id": "obj-6",
									"maxclass": "newobj",
									"numinlets": 1,
									"numoutlets": 4,
									"outlettype": [
										"",
										"",
										"",
										""
									],
									"patching_rect": [
										127.166687,
										58.9,
										106.0,
										22.0
									],
									"style": "",
									"text": "j.remote input/min"
								}
							},
							{
								"box": {
									"id": "obj-2",
									"maxclass": "newobj",
									"numinlets": 2,
									"numoutlets": 2,
									"outlettype": [
										"",
										""
									],
									"patching_rect": [
										396.166687,
										193.6,
										57.0,
										22.0
									],
									"style": "",
									"text": "route set"
								}
							},
							{
								"box": {
									"id": "obj-1",
									"maxclass": "newobj",
									"numinlets": 2,
									"numoutlets": 2,
									"outlettype": [
										"",
										""
									],
									"patching_rect": [
										372.166687,
										118.0,
										57.0,
										22.0
									],
									"style": "",
									"text": "route set"
								}
							},
							{
								"box": {
									"fontname": "Arial",
									"fontsize": 12.0,
									"id": "obj-113",
									"maxclass": "newobj",
									"numinlets": 1,
									"numoutlets": 4,
									"outlettype": [
										"",
										"",
										"",
										""
									],
									"patching_rect": [
										396.166687,
										158.5,
										117.0,
										22.0
									],
									"style": "",
									"text": "j.remote output/max"
								}
							},
							{
								"box": {
									"fontname": "Arial",
									"fontsize": 12.0,
									"id": "obj-114",
									"maxclass": "newobj",
									"numinlets": 1,
									"numoutlets": 4,
									"outlettype": [
										"",
										"",
										"",
										""
									],
									"patching_rect": [
										372.166687,
										82.9,
										113.0,
										22.0
									],
									"style": "",
									"text": "j.remote output/min"
								}
							},
							{
								"box": {
									"fontname": "Arial",
									"fontsize": 12.0,
									"id": "obj-132",
									"maxclass": "newobj",
									"numinlets": 1,
									"numoutlets": 1,
									"outlettype": [
										""
									],
									"patching_rect": [
										302.0,
										298.6,
										74.0,
										22.0
									],
									"style": "",
									"text": "prepend set"
								}
							},
							{
								"box": {
									"fontname": "Arial",
									"fontsize": 12.0,
									"id": "obj-131",
									"maxclass": "newobj",
									"numinlets": 1,
									"numoutlets": 1,
									"outlettype": [
										""
									],
									"patching_rect": [
										50.0,
										281.2,
										74.0,
										22.0
									],
									"style": "",
									"text": "prepend set"
								}
							},
							{
								"box": {
									"fontname": "Arial",
									"fontsize": 12.0,
									"id": "obj-128",
									"maxclass": "newobj",
									"numinlets": 6,
									"numoutlets": 1,
									"outlettype": [
										""
									],
									"patching_rect": [
										50.0,
										246.4,
										100.0,
										22.0
									],
									"style": "",
									"text": "scale 0. 1. 0. 1."
								}
							},
							{
								"box": {
									"fontname": "Arial",
									"fontsize": 12.0,
									"id": "obj-127",
									"maxclass": "newobj",
									"numinlets": 6,
									"numoutlets": 1,
									"outlettype": [
										""
									],
									"patching_rect": [
										302.0,
										246.4,
										135.999969,
										22.0
									],
									"style": "",
									"text": "scale 0. 1. 0. 1."
								}
							},
							{
								"box": {
									"fontname": "Arial",
									"fontsize": 12.0,
									"id": "obj-71",
									"maxclass": "newobj",
									"numinlets": 1,
									"numoutlets": 3,
									"outlettype": [
										"",
										"",
										""
									],
									"patching_rect": [
										50.0,
										112.0,
										53.0,
										22.0
									],
									"style": "",
									"text": "unjoin 2"
								}
							},
							{
								"box": {
									"comment": "",
									"id": "obj-134",
									"maxclass": "inlet",
									"numinlets": 0,
									"numoutlets": 1,
									"outlettype": [
										""
									],
									"patching_rect": [
										50.0,
										40.0,
										25.0,
										25.0
									],
									"style": ""
								}
							},
							{
								"box": {
									"comment": "",
									"id": "obj-137",
									"maxclass": "outlet",
									"numinlets": 1,
									"numoutlets": 0,
									"patching_rect": [
										50.0,
										377.2,
										25.0,
										25.0
									],
									"style": ""
								}
							},
							{
								"box": {
									"comment": "",
									"id": "obj-138",
									"maxclass": "outlet",
									"numinlets": 1,
									"numoutlets": 0,
									"patching_rect": [
										302.0,
										377.2,
										25.0,
										25.0
									],
									"style": ""
								}
							}
						],
						"lines": [
							{
								"patchline": {
									"destination": [
										"obj-127",
										3
									],
									"disabled": 0,
									"hidden": 0,
									"source": [
										"obj-1",
										0
									]
								}
							},
							{
								"patchline": {
									"destination": [
										"obj-2",
										0
									],
									"disabled": 0,
									"hidden": 0,
									"source": [
										"obj-113",
										0
									]
								}
							},
							{
								"patchline": {
									"destination": [
										"obj-1",
										0
									],
									"disabled": 0,
									"hidden": 0,
									"source": [
										"obj-114",
										0
									]
								}
							},
							{
								"patchline": {
									"destination": [
										"obj-132",
										0
									],
									"disabled": 0,
									"hidden": 0,
									"source": [
										"obj-127",
										0
									]
								}
							},
							{
								"patchline": {
									"destination": [
										"obj-131",
										0
									],
									"disabled": 0,
									"hidden": 0,
									"source": [
										"obj-128",
										0
									]
								}
							},
							{
								"patchline": {
									"destination": [
										"obj-137",
										0
									],
									"disabled": 0,
									"hidden": 0,
									"source": [
										"obj-131",
										0
									]
								}
							},
							{
								"patchline": {
									"destination": [
										"obj-138",
										0
									],
									"disabled": 0,
									"hidden": 0,
									"source": [
										"obj-132",
										0
									]
								}
							},
							{
								"patchline": {
									"destination": [
										"obj-71",
										0
									],
									"disabled": 0,
									"hidden": 0,
									"source": [
										"obj-134",
										0
									]
								}
							},
							{
								"patchline": {
									"destination": [
										"obj-127",
										4
									],
									"disabled": 0,
									"hidden": 0,
									"source": [
										"obj-2",
										0
									]
								}
							},
							{
								"patchline": {
									"destination": [
										"obj-128",
										4
									],
									"disabled": 0,
									"hidden": 0,
									"source": [
										"obj-3",
										0
									]
								}
							},
							{
								"patchline": {
									"destination": [
										"obj-128",
										3
									],
									"disabled": 0,
									"hidden": 0,
									"source": [
										"obj-4",
										0
									]
								}
							},
							{
								"patchline": {
									"destination": [
										"obj-3",
										0
									],
									"disabled": 0,
									"hidden": 0,
									"source": [
										"obj-5",
										0
									]
								}
							},
							{
								"patchline": {
									"destination": [
										"obj-4",
										0
									],
									"disabled": 0,
									"hidden": 0,
									"source": [
										"obj-6",
										0
									]
								}
							},
							{
								"patchline": {
									"destination": [
										"obj-127",
										0
									],
									"disabled": 0,
									"hidden": 0,
									"source": [
										"obj-71",
										1
									]
								}
							},
							{
								"patchline": {
									"destination": [
										"obj-128",
										0
									],
									"disabled": 0,
									"hidden": 0,
									"source": [
										"obj-71",
										0
									]
								}
							}
						]
					},
					"patching_rect": [
						2449.111084,
						875.2,
						93.0,
						22.0
					],
					"saved_object_attributes": {
						"description": "",
						"digest": "",
						"globalpatchername": "",
						"style": "",
						"tags": ""
					},
					"style": "",
					"text": "p cursor_tooltip"
				}
			},
			{
				"box": {
					"fontname": "Arial",
					"fontsize": 12.0,
					"hidden": 1,
					"id": "obj-133",
					"maxclass": "comment",
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [
						2523.111084,
						907.6,
						48.0,
						21.0
					],
					"presentation": 1,
					"presentation_rect": [
						129.0,
						126.0,
						48.0,
						21.0
					],
					"style": "",
					"text": "1.00",
					"varname": "outputval"
				}
			},
			{
				"box": {
					"fontname": "Arial",
					"fontsize": 12.0,
					"hidden": 1,
					"id": "obj-83",
					"maxclass": "comment",
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [
						2449.111084,
						907.6,
						58.0,
						21.0
					],
					"presentation": 1,
					"presentation_rect": [
						109.0,
						154.0,
						58.0,
						21.0
					],
					"style": "",
					"text": "0.21",
					"varname": "inputval"
				}
			},
			{
				"box": {
					"fontname": "Arial",
					"fontsize": 12.0,
					"id": "obj-51",
					"maxclass": "newobj",
					"numinlets": 6,
					"numoutlets": 1,
					"outlettype": [
						""
					],
					"patching_rect": [
						819.233398,
						833.2,
						92.0,
						22.0
					],
					"style": "",
					"text": "scale 0. 1. 0. 1."
				}
			},
			{
				"box": {
					"id": "obj-26",
					"linecount": 2,
					"maxclass": "newobj",
					"numinlets": 2,
					"numoutlets": 3,
					"outlettype": [
						"",
						"",
						"listdump"
					],
					"patcher": {
						"fileversion": 1,
						"appversion": {
							"major": 7,
							"minor": 0,
							"revision": 5,
							"architecture": "x86",
							"modernui": 1
						},
						"rect": [
							991.0,
							220.0,
							871.0,
							720.0
						],
						"bglocked": 0,
						"openinpresentation": 0,
						"default_fontsize": 12.0,
						"default_fontface": 0,
						"default_fontname": "Arial",
						"gridonopen": 1,
						"gridsize": [
							15.0,
							15.0
						],
						"gridsnaponopen": 1,
						"objectsnaponopen": 1,
						"statusbarvisible": 2,
						"toolbarvisible": 1,
						"lefttoolbarpinned": 0,
						"toptoolbarpinned": 0,
						"righttoolbarpinned": 0,
						"bottomtoolbarpinned": 0,
						"toolbars_unpinned_last_save": 0,
						"tallnewobj": 0,
						"boxanimatetime": 200,
						"enablehscroll": 1,
						"enablevscroll": 1,
						"devicewidth": 0.0,
						"description": "",
						"digest": "",
						"tags": "",
						"style": "",
						"subpatcher_template": "",
						"boxes": [
							{
								"box": {
									"id": "obj-25",
									"maxclass": "newobj",
									"numinlets": 1,
									"numoutlets": 2,
									"outlettype": [
										"bang",
										""
									],
									"patching_rect": [
										18.666687,
										224.6,
										30.0,
										22.0
									],
									"style": "",
									"text": "t b l"
								}
							},
							{
								"box": {
									"id": "obj-21",
									"maxclass": "newobj",
									"numinlets": 2,
									"numoutlets": 2,
									"outlettype": [
										"",
										""
									],
									"patching_rect": [
										29.666687,
										257.0,
										49.0,
										22.0
									],
									"style": "",
									"text": "zl.iter 3"
								}
							},
							{
								"box": {
									"fontname": "Arial",
									"fontsize": 12.0,
									"id": "obj-18",
									"maxclass": "comment",
									"numinlets": 1,
									"numoutlets": 0,
									"patching_rect": [
										135.666687,
										481.4,
										104.0,
										20.0
									],
									"style": "",
									"text": "report mouse info"
								}
							},
							{
								"box": {
									"comment": "",
									"id": "obj-16",
									"maxclass": "outlet",
									"numinlets": 1,
									"numoutlets": 0,
									"patching_rect": [
										103.666687,
										481.4,
										25.0,
										25.0
									],
									"style": ""
								}
							},
							{
								"box": {
									"fontname": "Arial",
									"fontsize": 12.0,
									"id": "obj-15",
									"maxclass": "newobj",
									"numinlets": 2,
									"numoutlets": 2,
									"outlettype": [
										"",
										""
									],
									"patching_rect": [
										18.666687,
										191.0,
										104.0,
										22.0
									],
									"style": "",
									"text": "gate 2 1"
								}
							},
							{
								"box": {
									"fontname": "Arial",
									"fontsize": 12.0,
									"id": "obj-14",
									"maxclass": "newobj",
									"numinlets": 1,
									"numoutlets": 1,
									"outlettype": [
										"int"
									],
									"patching_rect": [
										135.666687,
										146.6,
										24.0,
										22.0
									],
									"style": "",
									"text": "t 1"
								}
							},
							{
								"box": {
									"fontname": "Arial",
									"fontsize": 12.0,
									"id": "obj-13",
									"maxclass": "newobj",
									"numinlets": 1,
									"numoutlets": 1,
									"outlettype": [
										"int"
									],
									"patching_rect": [
										166.166687,
										146.6,
										24.0,
										22.0
									],
									"style": "",
									"text": "t 2"
								}
							},
							{
								"box": {
									"fontname": "Arial",
									"fontsize": 12.0,
									"id": "obj-10",
									"maxclass": "newobj",
									"numinlets": 2,
									"numoutlets": 2,
									"outlettype": [
										"",
										""
									],
									"patching_rect": [
										135.666687,
										81.8,
										49.0,
										22.0
									],
									"style": "",
									"text": "zl.nth 3"
								}
							},
							{
								"box": {
									"fontname": "Arial",
									"fontsize": 12.0,
									"id": "obj-6",
									"maxclass": "newobj",
									"numinlets": 3,
									"numoutlets": 3,
									"outlettype": [
										"",
										"",
										""
									],
									"patching_rect": [
										135.666687,
										114.2,
										80.0,
										22.0
									],
									"style": "",
									"text": "route float int"
								}
							},
							{
								"box": {
									"fontname": "Arial",
									"fontsize": 12.0,
									"id": "obj-1",
									"maxclass": "newobj",
									"numinlets": 1,
									"numoutlets": 2,
									"outlettype": [
										"",
										""
									],
									"patching_rect": [
										103.666687,
										51.8,
										51.5,
										22.0
									],
									"style": "",
									"text": "t l l"
								}
							},
							{
								"box": {
									"fontname": "Arial",
									"fontsize": 12.0,
									"id": "obj-2",
									"maxclass": "message",
									"numinlets": 2,
									"numoutlets": 1,
									"outlettype": [
										""
									],
									"patching_rect": [
										336.0,
										340.4,
										63.0,
										22.0
									],
									"style": "",
									"text": "domain 1."
								}
							},
							{
								"box": {
									"fontname": "Arial",
									"fontsize": 12.0,
									"id": "obj-86",
									"maxclass": "newobj",
									"numinlets": 2,
									"numoutlets": 2,
									"outlettype": [
										"",
										""
									],
									"patching_rect": [
										29.666687,
										347.0,
										57.0,
										22.0
									],
									"style": "",
									"text": "zl join"
								}
							},
							{
								"box": {
									"fontname": "Arial",
									"fontsize": 12.0,
									"id": "obj-85",
									"maxclass": "newobj",
									"numinlets": 1,
									"numoutlets": 1,
									"outlettype": [
										""
									],
									"patcher": {
										"fileversion": 1,
										"appversion": {
											"major": 7,
											"minor": 0,
											"revision": 5,
											"architecture": "x86",
											"modernui": 1
										},
										"rect": [
											916.0,
											566.0,
											246.0,
											286
										],
										"bglocked": 0,
										"openinpresentation": 0,
										"default_fontsize": 12.0,
										"default_fontface": 0,
										"default_fontname": "Arial",
										"gridonopen": 1,
										"gridsize": [
											15.0,
											15.0
										],
										"gridsnaponopen": 1,
										"objectsnaponopen": 1,
										"statusbarvisible": 2,
										"toolbarvisible": 1,
										"lefttoolbarpinned": 0,
										"toptoolbarpinned": 0,
										"righttoolbarpinned": 0,
										"bottomtoolbarpinned": 0,
										"toolbars_unpinned_last_save": 0,
										"tallnewobj": 0,
										"boxanimatetime": 200,
										"enablehscroll": 1,
										"enablevscroll": 1,
										"devicewidth": 0.0,
										"description": "",
										"digest": "",
										"tags": "",
										"style": "",
										"subpatcher_template": "",
										"boxes": [
											{
												"box": {
													"fontname": "Arial",
													"fontsize": 12.0,
													"id": "obj-14",
													"maxclass": "newobj",
													"numinlets": 1,
													"numoutlets": 1,
													"outlettype": [
														""
													],
													"patching_rect": [
														139.0,
														145.6,
														102.0,
														22.0
													],
													"style": "",
													"text": "expr log(1. + $f1)"
												}
											},
											{
												"box": {
													"fontname": "Arial",
													"fontsize": 12.0,
													"id": "obj-8",
													"maxclass": "newobj",
													"numinlets": 1,
													"numoutlets": 1,
													"outlettype": [
														""
													],
													"patching_rect": [
														22.0,
														200.8,
														143.0,
														22.0
													],
													"style": "",
													"text": "expr exp($f1 * 2.718282)"
												}
											},
											{
												"box": {
													"fontname": "Arial",
													"fontsize": 12.0,
													"id": "obj-81",
													"maxclass": "newobj",
													"numinlets": 1,
													"numoutlets": 1,
													"outlettype": [
														""
													],
													"patching_rect": [
														22.0,
														145.6,
														103.0,
														22.0
													],
													"style": "",
													"text": "expr -log(1. - $f1)"
												}
											},
											{
												"box": {
													"fontname": "Arial",
													"fontsize": 12.0,
													"id": "obj-76",
													"maxclass": "newobj",
													"numinlets": 3,
													"numoutlets": 2,
													"outlettype": [
														"float",
														"float"
													],
													"patching_rect": [
														22.0,
														76.0,
														136.0,
														22.0
													],
													"style": "",
													"text": "split 0. 1."
												}
											},
											{
												"box": {
													"fontname": "Arial",
													"fontsize": 12.0,
													"id": "obj-75",
													"maxclass": "newobj",
													"numinlets": 3,
													"numoutlets": 2,
													"outlettype": [
														"float",
														"float"
													],
													"patching_rect": [
														139.0,
														112.0,
														70.0,
														22.0
													],
													"style": "",
													"text": "split -1. 0."
												}
											},
											{
												"box": {
													"comment": "",
													"id": "obj-83",
													"maxclass": "inlet",
													"numinlets": 0,
													"numoutlets": 1,
													"outlettype": [
														""
													],
													"patching_rect": [
														22.0,
														16.0,
														25.0,
														25.0
													],
													"style": ""
												}
											},
											{
												"box": {
													"comment": "",
													"id": "obj-84",
													"maxclass": "outlet",
													"numinlets": 1,
													"numoutlets": 0,
													"patching_rect": [
														22.0,
														246.4,
														25.0,
														25.0
													],
													"style": ""
												}
											}
										],
										"lines": [
											{
												"patchline": {
													"destination": [
														"obj-8",
														0
													],
													"disabled": 0,
													"hidden": 0,
													"midpoints": [
														148.5,
														184.6,
														31.5,
														184.6
													],
													"source": [
														"obj-14",
														0
													]
												}
											},
											{
												"patchline": {
													"destination": [
														"obj-14",
														0
													],
													"disabled": 0,
													"hidden": 0,
													"source": [
														"obj-75",
														0
													]
												}
											},
											{
												"patchline": {
													"destination": [
														"obj-75",
														0
													],
													"disabled": 0,
													"hidden": 0,
													"source": [
														"obj-76",
														1
													]
												}
											},
											{
												"patchline": {
													"destination": [
														"obj-81",
														0
													],
													"disabled": 0,
													"hidden": 0,
													"source": [
														"obj-76",
														0
													]
												}
											},
											{
												"patchline": {
													"destination": [
														"obj-84",
														0
													],
													"disabled": 0,
													"hidden": 0,
													"source": [
														"obj-8",
														0
													]
												}
											},
											{
												"patchline": {
													"destination": [
														"obj-8",
														0
													],
													"disabled": 0,
													"hidden": 0,
													"source": [
														"obj-81",
														0
													]
												}
											},
											{
												"patchline": {
													"destination": [
														"obj-76",
														0
													],
													"disabled": 0,
													"hidden": 0,
													"source": [
														"obj-83",
														0
													]
												}
											}
										]
									},
									"patching_rect": [
										67.666687,
										320.6,
										83.0,
										22.0
									],
									"saved_object_attributes": {
										"description": "",
										"digest": "",
										"globalpatchername": "",
										"style": "",
										"tags": ""
									},
									"style": "",
									"text": "p factor2base"
								}
							},
							{
								"box": {
									"fontname": "Arial",
									"fontsize": 12.0,
									"id": "obj-7",
									"maxclass": "newobj",
									"numinlets": 2,
									"numoutlets": 2,
									"outlettype": [
										"",
										""
									],
									"patching_rect": [
										29.666687,
										294.2,
										57.0,
										22.0
									],
									"style": "",
									"text": "zl slice 2"
								}
							},
							{
								"box": {
									"fontname": "Arial",
									"fontsize": 12.0,
									"id": "obj-5",
									"maxclass": "newobj",
									"numinlets": 1,
									"numoutlets": 1,
									"outlettype": [
										"bang"
									],
									"patching_rect": [
										336.0,
										307.4,
										60.0,
										22.0
									],
									"style": "",
									"text": "loadbang"
								}
							},
							{
								"box": {
									"fontname": "Arial",
									"fontsize": 12.0,
									"id": "obj-43",
									"maxclass": "message",
									"numinlets": 2,
									"numoutlets": 1,
									"outlettype": [
										""
									],
									"patching_rect": [
										29.666687,
										383.0,
										151.0,
										22.0
									],
									"style": "",
									"text": "$1 $2 exponential base $3"
								}
							},
							{
								"box": {
									"fontname": "Arial",
									"fontsize": 12.0,
									"id": "obj-41",
									"maxclass": "newobj",
									"numinlets": 2,
									"numoutlets": 2,
									"outlettype": [
										"",
										""
									],
									"patching_rect": [
										29.666687,
										430.4,
										181.0,
										22.0
									],
									"style": "",
									"text": "zl group 1024 @zlmaxsize 1024"
								}
							},
							{
								"box": {
									"fontface": 0,
									"fontname": "Arial",
									"fontsize": 12.0,
									"id": "obj-40",
									"maxclass": "newobj",
									"numinlets": 1,
									"numoutlets": 2,
									"outlettype": [
										"bang",
										"listdump"
									],
									"patching_rect": [
										242.0,
										307.4,
										72.0,
										22.0
									],
									"style": "",
									"text": "t b listdump"
								}
							},
							{
								"box": {
									"comment": "",
									"id": "obj-8",
									"maxclass": "inlet",
									"numinlets": 0,
									"numoutlets": 1,
									"outlettype": [
										"bang"
									],
									"patching_rect": [
										242.0,
										17.0,
										25.0,
										25.0
									],
									"style": ""
								}
							},
							{
								"box": {
									"comment": "",
									"id": "obj-9",
									"maxclass": "inlet",
									"numinlets": 0,
									"numoutlets": 1,
									"outlettype": [
										""
									],
									"patching_rect": [
										103.666687,
										17.0,
										25.0,
										25.0
									],
									"style": ""
								}
							},
							{
								"box": {
									"comment": "",
									"id": "obj-11",
									"maxclass": "outlet",
									"numinlets": 1,
									"numoutlets": 0,
									"patching_rect": [
										295.0,
										481.4,
										25.0,
										25.0
									],
									"style": ""
								}
							},
							{
								"box": {
									"comment": "",
									"id": "obj-12",
									"maxclass": "outlet",
									"numinlets": 1,
									"numoutlets": 0,
									"patching_rect": [
										29.666687,
										481.4,
										25.0,
										25.0
									],
									"style": ""
								}
							}
						],
						"lines": [
							{
								"patchline": {
									"destination": [
										"obj-10",
										0
									],
									"disabled": 0,
									"hidden": 0,
									"source": [
										"obj-1",
										1
									]
								}
							},
							{
								"patchline": {
									"destination": [
										"obj-15",
										1
									],
									"disabled": 0,
									"hidden": 0,
									"source": [
										"obj-1",
										0
									]
								}
							},
							{
								"patchline": {
									"destination": [
										"obj-6",
										0
									],
									"disabled": 0,
									"hidden": 0,
									"source": [
										"obj-10",
										0
									]
								}
							},
							{
								"patchline": {
									"destination": [
										"obj-15",
										0
									],
									"disabled": 0,
									"hidden": 0,
									"source": [
										"obj-13",
										0
									]
								}
							},
							{
								"patchline": {
									"destination": [
										"obj-15",
										0
									],
									"disabled": 0,
									"hidden": 0,
									"source": [
										"obj-14",
										0
									]
								}
							},
							{
								"patchline": {
									"destination": [
										"obj-16",
										0
									],
									"disabled": 0,
									"hidden": 0,
									"source": [
										"obj-15",
										1
									]
								}
							},
							{
								"patchline": {
									"destination": [
										"obj-25",
										0
									],
									"disabled": 0,
									"hidden": 0,
									"source": [
										"obj-15",
										0
									]
								}
							},
							{
								"patchline": {
									"destination": [
										"obj-11",
										0
									],
									"disabled": 0,
									"hidden": 0,
									"midpoints": [
										345.5,
										405.8,
										304.5,
										405.8
									],
									"source": [
										"obj-2",
										0
									]
								}
							},
							{
								"patchline": {
									"destination": [
										"obj-7",
										0
									],
									"disabled": 0,
									"hidden": 0,
									"source": [
										"obj-21",
										0
									]
								}
							},
							{
								"patchline": {
									"destination": [
										"obj-21",
										0
									],
									"disabled": 0,
									"hidden": 0,
									"source": [
										"obj-25",
										1
									]
								}
							},
							{
								"patchline": {
									"destination": [
										"obj-41",
										0
									],
									"disabled": 0,
									"hidden": 0,
									"midpoints": [
										28.166687,
										428.9,
										39.166687,
										428.9
									],
									"source": [
										"obj-25",
										0
									]
								}
							},
							{
								"patchline": {
									"destination": [
										"obj-11",
										0
									],
									"disabled": 0,
									"hidden": 0,
									"source": [
										"obj-40",
										1
									]
								}
							},
							{
								"patchline": {
									"destination": [
										"obj-41",
										0
									],
									"disabled": 0,
									"hidden": 0,
									"midpoints": [
										251.5,
										417.8,
										39.166687,
										417.8
									],
									"source": [
										"obj-40",
										0
									]
								}
							},
							{
								"patchline": {
									"destination": [
										"obj-12",
										0
									],
									"disabled": 0,
									"hidden": 0,
									"source": [
										"obj-41",
										0
									]
								}
							},
							{
								"patchline": {
									"destination": [
										"obj-41",
										0
									],
									"disabled": 0,
									"hidden": 0,
									"source": [
										"obj-43",
										0
									]
								}
							},
							{
								"patchline": {
									"destination": [
										"obj-2",
										0
									],
									"disabled": 0,
									"hidden": 0,
									"source": [
										"obj-5",
										0
									]
								}
							},
							{
								"patchline": {
									"destination": [
										"obj-13",
										0
									],
									"disabled": 0,
									"hidden": 0,
									"source": [
										"obj-6",
										1
									]
								}
							},
							{
								"patchline": {
									"destination": [
										"obj-14",
										0
									],
									"disabled": 0,
									"hidden": 0,
									"source": [
										"obj-6",
										0
									]
								}
							},
							{
								"patchline": {
									"destination": [
										"obj-85",
										0
									],
									"disabled": 0,
									"hidden": 0,
									"source": [
										"obj-7",
										1
									]
								}
							},
							{
								"patchline": {
									"destination": [
										"obj-86",
										0
									],
									"disabled": 0,
									"hidden": 0,
									"source": [
										"obj-7",
										0
									]
								}
							},
							{
								"patchline": {
									"destination": [
										"obj-40",
										0
									],
									"disabled": 0,
									"hidden": 0,
									"source": [
										"obj-8",
										0
									]
								}
							},
							{
								"patchline": {
									"destination": [
										"obj-86",
										1
									],
									"disabled": 0,
									"hidden": 0,
									"source": [
										"obj-85",
										0
									]
								}
							},
							{
								"patchline": {
									"destination": [
										"obj-43",
										0
									],
									"disabled": 0,
									"hidden": 0,
									"source": [
										"obj-86",
										0
									]
								}
							},
							{
								"patchline": {
									"destination": [
										"obj-1",
										0
									],
									"disabled": 0,
									"hidden": 0,
									"source": [
										"obj-9",
										0
									]
								}
							}
						]
					},
					"patching_rect": [
						2379.611084,
						785.8,
						158.0,
						35.0
					],
					"saved_object_attributes": {
						"description": "",
						"digest": "",
						"globalpatchername": "",
						"style": "",
						"tags": ""
					},
					"style": "",
					"text": "p function2freehand_reformat"
				}
			},
			{
				"box": {
					"id": "obj-56",
					"ignoreclick": 1,
					"maxclass": "multislider",
					"numinlets": 1,
					"numoutlets": 2,
					"outlettype": [
						"",
						""
					],
					"parameter_enable": 0,
					"patching_rect": [
						819.233398,
						877.6,
						100.0,
						16.0
					],
					"presentation": 1,
					"presentation_rect": [
						19.333344,
						147.0,
						478.0,
						479.085938
					],
					"setminmax": [
						0.0,
						1.0
					],
					"size": 3,
					"style": "",
					"thickness": 1
				}
			},
			{
				"box": {
					"comment": "",
					"id": "obj-80",
					"maxclass": "inlet",
					"numinlets": 0,
					"numoutlets": 1,
					"outlettype": [
						""
					],
					"patching_rect": [
						88.0,
						202.0,
						25.0,
						25.0
					],
					"style": ""
				}
			},
			{
				"box": {
					"background": 1,
					"domain": 1.0,
					"grid": 3,
					"gridstep_x": 1.0,
					"gridstep_y": 1.0,
					"hidden": 1,
					"id": "obj-29",
					"legend": 0,
					"linethickness": 0.96,
					"maxclass": "function",
					"mode": 1,
					"mousereport": 1,
					"numinlets": 1,
					"numoutlets": 4,
					"outlettype": [
						"float",
						"",
						"",
						"bang"
					],
					"parameter_enable": 0,
					"patching_rect": [
						2310.833252,
						692.8,
						122.166687,
						54.5
					],
					"presentation": 1,
					"presentation_rect": [
						22.333344,
						147.0,
						474.0,
						474.0
					],
					"style": "",
					"varname": "function_parameter_bpf"
				}
			},
			{
				"box": {
					"id": "obj-160",
					"maxclass": "newobj",
					"numinlets": 1,
					"numoutlets": 2,
					"outlettype": [
						"nopoll",
						"int"
					],
					"patching_rect": [
						3575.041748,
						671.8,
						59.0,
						22.0
					],
					"style": "",
					"text": "t nopoll 1"
				}
			},
			{
				"box": {
					"id": "obj-159",
					"maxclass": "newobj",
					"numinlets": 1,
					"numoutlets": 2,
					"outlettype": [
						"poll",
						"int"
					],
					"patching_rect": [
						3485.375,
						671.8,
						46.0,
						22.0
					],
					"style": "",
					"text": "t poll 0"
				}
			},
			{
				"box": {
					"hidden": 1,
					"id": "obj-157",
					"maxclass": "newobj",
					"numinlets": 1,
					"numoutlets": 1,
					"outlettype": [
						""
					],
					"patching_rect": [
						3375.208496,
						797.2,
						105.0,
						22.0
					],
					"style": "",
					"text": "loadmess mode 1"
				}
			},
			{
				"box": {
					"id": "obj-63",
					"maxclass": "newobj",
					"numinlets": 2,
					"numoutlets": 2,
					"outlettype": [
						"",
						""
					],
					"patching_rect": [
						3485.375,
						620.2,
						168.0,
						22.0
					],
					"style": "",
					"text": "route function_parameter_bpf"
				}
			},
			{
				"box": {
					"id": "obj-23",
					"maxclass": "newobj",
					"numinlets": 1,
					"numoutlets": 5,
					"outlettype": [
						"int",
						"int",
						"int",
						"int",
						"int"
					],
					"patching_rect": [
						3485.375,
						797.2,
						73.0,
						22.0
					],
					"style": "",
					"text": "mousestate"
				}
			},
			{
				"box": {
					"fontface": 1,
					"fontname": "Arial",
					"id": "obj-76",
					"maxclass": "comment",
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [
						2641.75,
						680.8,
						61.0,
						21.0
					],
					"presentation": 1,
					"presentation_rect": [
						19.333344,
						98.0,
						61.0,
						21.0
					],
					"style": "",
					"text": "Function:",
					"textjustification": 2
				}
			},
			{
				"box": {
					"angle": 270.0,
					"border": 1,
					"id": "obj-79",
					"maxclass": "panel",
					"mode": 0,
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [
						2641.75,
						712.0,
						61.0,
						21.0
					],
					"presentation": 1,
					"presentation_rect": [
						19.333344,
						98.0,
						59.0,
						22.0
					],
					"proportion": 0.39,
					"rounded": 0,
					"style": ""
				}
			},
			{
				"box": {
					"fontface": 1,
					"fontname": "Arial",
					"fontsize": 12.0,
					"hidden": 1,
					"id": "obj-81",
					"maxclass": "comment",
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [
						1953.5,
						731.8,
						67.0,
						21.0
					],
					"presentation": 1,
					"presentation_rect": [
						351.333344,
						98.0,
						87.0,
						21.0
					],
					"style": "",
					"text": "Symmetry:",
					"textjustification": 2,
					"varname": "parameter[2]_label"
				}
			},
			{
				"box": {
					"fontface": 1,
					"fontname": "Arial",
					"hidden": 1,
					"id": "obj-84",
					"maxclass": "comment",
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [
						1790.800049,
						731.8,
						78.0,
						21.0
					],
					"presentation": 1,
					"presentation_rect": [
						219.333344,
						98.0,
						78.0,
						21.0
					],
					"style": "",
					"text": "PowerValue:",
					"textjustification": 2,
					"varname": "parameter[1]_label"
				}
			},
			{
				"box": {
					"id": "obj-99",
					"maxclass": "newobj",
					"numinlets": 1,
					"numoutlets": 2,
					"outlettype": [
						"",
						"int"
					],
					"patching_rect": [
						1881.0,
						884.8,
						30.0,
						22.0
					],
					"style": "",
					"text": "t l 1"
				}
			},
			{
				"box": {
					"id": "obj-100",
					"maxclass": "newobj",
					"numinlets": 1,
					"numoutlets": 2,
					"outlettype": [
						"",
						"int"
					],
					"patching_rect": [
						2024.25,
						883.6,
						30.0,
						22.0
					],
					"style": "",
					"text": "t l 2"
				}
			},
			{
				"box": {
					"id": "obj-107",
					"maxclass": "newobj",
					"numinlets": 0,
					"numoutlets": 1,
					"outlettype": [
						""
					],
					"patching_rect": [
						1454.5,
						21.4,
						125.0,
						22.0
					],
					"style": "",
					"text": "r #0.display.refresh"
				}
			},
			{
				"box": {
					"id": "obj-126",
					"maxclass": "comment",
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [
						1987.5,
						469.6,
						280.0,
						20.0
					],
					"style": "",
					"text": "to make sure symmetry is sent to right... not sexy..."
				}
			},
			{
				"box": {
					"id": "obj-127",
					"maxclass": "newobj",
					"numinlets": 2,
					"numoutlets": 2,
					"outlettype": [
						"",
						""
					],
					"patching_rect": [
						1943.833252,
						469.6,
						43.0,
						22.0
					],
					"style": "",
					"text": "zl.sort"
				}
			},
			{
				"box": {
					"id": "obj-53",
					"maxclass": "newobj",
					"numinlets": 1,
					"numoutlets": 1,
					"outlettype": [
						""
					],
					"patcher": {
						"fileversion": 1,
						"appversion": {
							"major": 7,
							"minor": 0,
							"revision": 5,
							"architecture": "x86",
							"modernui": 1
						},
						"rect": [
							1133.0,
							230.0,
							640.0,
							560.0
						],
						"bglocked": 0,
						"openinpresentation": 0,
						"default_fontsize": 12.0,
						"default_fontface": 0,
						"default_fontname": "Arial",
						"gridonopen": 1,
						"gridsize": [
							15.0,
							15.0
						],
						"gridsnaponopen": 1,
						"objectsnaponopen": 1,
						"statusbarvisible": 2,
						"toolbarvisible": 1,
						"lefttoolbarpinned": 0,
						"toptoolbarpinned": 0,
						"righttoolbarpinned": 0,
						"bottomtoolbarpinned": 0,
						"toolbars_unpinned_last_save": 0,
						"tallnewobj": 0,
						"boxanimatetime": 200,
						"enablehscroll": 1,
						"enablevscroll": 1,
						"devicewidth": 0.0,
						"description": "",
						"digest": "",
						"tags": "",
						"style": "",
						"subpatcher_template": "",
						"boxes": [
							{
								"box": {
									"id": "obj-50",
									"maxclass": "newobj",
									"numinlets": 2,
									"numoutlets": 1,
									"outlettype": [
										"float"
									],
									"patching_rect": [
										363.5,
										325.4,
										31.0,
										22.0
									],
									"style": "",
									"text": "+ 0."
								}
							},
							{
								"box": {
									"id": "obj-49",
									"maxclass": "newobj",
									"numinlets": 2,
									"numoutlets": 1,
									"outlettype": [
										"float"
									],
									"patching_rect": [
										379.5,
										290.6,
										35.0,
										22.0
									],
									"style": "",
									"text": "* 0.5"
								}
							},
							{
								"box": {
									"id": "obj-38",
									"maxclass": "message",
									"numinlets": 2,
									"numoutlets": 1,
									"outlettype": [
										""
									],
									"patching_rect": [
										379.5,
										371.6,
										86.0,
										22.0
									],
									"style": "",
									"text": "defineygrid $1"
								}
							},
							{
								"box": {
									"id": "obj-34",
									"maxclass": "newobj",
									"numinlets": 2,
									"numoutlets": 1,
									"outlettype": [
										"int"
									],
									"patching_rect": [
										381.5,
										225.8,
										29.5,
										22.0
									],
									"style": "",
									"text": "!-"
								}
							},
							{
								"box": {
									"id": "obj-15",
									"maxclass": "newobj",
									"numinlets": 2,
									"numoutlets": 1,
									"outlettype": [
										""
									],
									"patching_rect": [
										208.5,
										210.2,
										93.416748,
										22.0
									],
									"style": "",
									"text": "join 2"
								}
							},
							{
								"box": {
									"id": "obj-12",
									"maxclass": "newobj",
									"numinlets": 2,
									"numoutlets": 2,
									"outlettype": [
										"float",
										"int"
									],
									"patching_rect": [
										282.916748,
										165.2,
										76.0,
										22.0
									],
									"style": "",
									"text": "maximum 0."
								}
							},
							{
								"box": {
									"id": "obj-9",
									"maxclass": "newobj",
									"numinlets": 2,
									"numoutlets": 2,
									"outlettype": [
										"float",
										"int"
									],
									"patching_rect": [
										208.5,
										165.2,
										73.0,
										22.0
									],
									"style": "",
									"text": "minimum 0."
								}
							},
							{
								"box": {
									"id": "obj-14",
									"maxclass": "message",
									"numinlets": 2,
									"numoutlets": 1,
									"outlettype": [
										""
									],
									"patching_rect": [
										208.5,
										246.8,
										107.0,
										22.0
									],
									"style": "",
									"text": "definerange $1 $2"
								}
							},
							{
								"box": {
									"comment": "",
									"id": "obj-51",
									"maxclass": "inlet",
									"numinlets": 0,
									"numoutlets": 1,
									"outlettype": [
										""
									],
									"patching_rect": [
										46.5,
										11.0,
										30.0,
										30.0
									],
									"presentation": 1,
									"presentation_rect": [
										1104.208374,
										36.0,
										30.0,
										30.0
									],
									"style": ""
								}
							},
							{
								"box": {
									"comment": "",
									"id": "obj-52",
									"maxclass": "outlet",
									"numinlets": 1,
									"numoutlets": 0,
									"patching_rect": [
										206.666626,
										470.0,
										30.0,
										30.0
									],
									"presentation": 1,
									"presentation_rect": [
										1071.166626,
										389.5,
										30.0,
										30.0
									],
									"style": ""
								}
							}
						],
						"lines": [
							{
								"patchline": {
									"destination": [
										"obj-15",
										1
									],
									"disabled": 0,
									"hidden": 0,
									"source": [
										"obj-12",
										0
									]
								}
							},
							{
								"patchline": {
									"destination": [
										"obj-34",
										1
									],
									"disabled": 0,
									"hidden": 0,
									"source": [
										"obj-12",
										0
									]
								}
							},
							{
								"patchline": {
									"destination": [
										"obj-52",
										0
									],
									"disabled": 0,
									"hidden": 0,
									"source": [
										"obj-14",
										0
									]
								}
							},
							{
								"patchline": {
									"destination": [
										"obj-14",
										0
									],
									"disabled": 0,
									"hidden": 0,
									"source": [
										"obj-15",
										0
									]
								}
							},
							{
								"patchline": {
									"destination": [
										"obj-49",
										0
									],
									"disabled": 0,
									"hidden": 0,
									"source": [
										"obj-34",
										0
									]
								}
							},
							{
								"patchline": {
									"destination": [
										"obj-52",
										0
									],
									"disabled": 0,
									"hidden": 0,
									"source": [
										"obj-38",
										0
									]
								}
							},
							{
								"patchline": {
									"destination": [
										"obj-50",
										1
									],
									"disabled": 0,
									"hidden": 0,
									"source": [
										"obj-49",
										0
									]
								}
							},
							{
								"patchline": {
									"destination": [
										"obj-38",
										0
									],
									"disabled": 0,
									"hidden": 0,
									"source": [
										"obj-50",
										0
									]
								}
							},
							{
								"patchline": {
									"destination": [
										"obj-12",
										0
									],
									"disabled": 0,
									"hidden": 0,
									"source": [
										"obj-51",
										0
									]
								}
							},
							{
								"patchline": {
									"destination": [
										"obj-52",
										0
									],
									"disabled": 0,
									"hidden": 0,
									"source": [
										"obj-51",
										0
									]
								}
							},
							{
								"patchline": {
									"destination": [
										"obj-9",
										0
									],
									"disabled": 0,
									"hidden": 0,
									"source": [
										"obj-51",
										0
									]
								}
							},
							{
								"patchline": {
									"destination": [
										"obj-15",
										0
									],
									"disabled": 0,
									"hidden": 0,
									"source": [
										"obj-9",
										0
									]
								}
							},
							{
								"patchline": {
									"destination": [
										"obj-34",
										0
									],
									"disabled": 0,
									"hidden": 0,
									"source": [
										"obj-9",
										0
									]
								}
							},
							{
								"patchline": {
									"destination": [
										"obj-50",
										0
									],
									"disabled": 0,
									"hidden": 0,
									"source": [
										"obj-9",
										0
									]
								}
							}
						]
					},
					"patching_rect": [
						1683.75,
						215.2,
						73.0,
						22.0
					],
					"saved_object_attributes": {
						"description": "",
						"digest": "",
						"globalpatchername": "",
						"style": "",
						"tags": ""
					},
					"style": "",
					"text": "p setranges"
				}
			},
			{
				"box": {
					"id": "obj-1",
					"maxclass": "newobj",
					"numinlets": 1,
					"numoutlets": 1,
					"outlettype": [
						""
					],
					"patching_rect": [
						3152.666748,
						810.4,
						100.0,
						22.0
					],
					"style": "",
					"text": "prepend function"
				}
			},
			{
				"box": {
					"hidden": 1,
					"id": "obj-130",
					"maxclass": "message",
					"numinlets": 2,
					"numoutlets": 1,
					"outlettype": [
						""
					],
					"patching_rect": [
						1599.5,
						50.2,
						262.0,
						22.0
					],
					"style": "",
					"text": "function/samples, function, function/parameters"
				}
			},
			{
				"box": {
					"hidden": 1,
					"id": "obj-158",
					"maxclass": "newobj",
					"numinlets": 1,
					"numoutlets": 1,
					"outlettype": [
						"bang"
					],
					"patching_rect": [
						1599.5,
						21.4,
						60.0,
						22.0
					],
					"style": "",
					"text": "loadbang"
				}
			},
			{
				"box": {
					"id": "obj-147",
					"maxclass": "newobj",
					"numinlets": 1,
					"numoutlets": 1,
					"outlettype": [
						""
					],
					"patching_rect": [
						2073.5,
						681.4,
						74.0,
						22.0
					],
					"style": "",
					"text": "prepend set"
				}
			},
			{
				"box": {
					"id": "obj-146",
					"maxclass": "newobj",
					"numinlets": 1,
					"numoutlets": 1,
					"outlettype": [
						""
					],
					"patching_rect": [
						1943.833252,
						679.0,
						74.0,
						22.0
					],
					"style": "",
					"text": "prepend set"
				}
			},
			{
				"box": {
					"id": "obj-131",
					"maxclass": "newobj",
					"numinlets": 1,
					"numoutlets": 1,
					"outlettype": [
						""
					],
					"patching_rect": [
						1454.5,
						50.2,
						56.0,
						22.0
					],
					"style": "",
					"text": "deferlow"
				}
			},
			{
				"box": {
					"id": "obj-132",
					"maxclass": "message",
					"numinlets": 2,
					"numoutlets": 1,
					"outlettype": [
						""
					],
					"patching_rect": [
						1454.5,
						79.0,
						101.0,
						22.0
					],
					"style": "default",
					"text": "function/samples"
				}
			},
			{
				"box": {
					"id": "obj-134",
					"maxclass": "message",
					"numinlets": 2,
					"numoutlets": 1,
					"outlettype": [
						""
					],
					"patching_rect": [
						2819.75,
						601.0,
						63.0,
						22.0
					],
					"style": "",
					"text": "hidden $1"
				}
			},
			{
				"box": {
					"id": "obj-135",
					"maxclass": "newobj",
					"numinlets": 2,
					"numoutlets": 1,
					"outlettype": [
						"int"
					],
					"patching_rect": [
						2819.75,
						569.8,
						29.5,
						22.0
					],
					"style": "",
					"text": "!- 1"
				}
			},
			{
				"box": {
					"id": "obj-136",
					"maxclass": "message",
					"numinlets": 2,
					"numoutlets": 1,
					"outlettype": [
						""
					],
					"patching_rect": [
						2707.0,
						724.0,
						43.0,
						22.0
					],
					"style": "",
					"text": "set $1"
				}
			},
			{
				"box": {
					"id": "obj-137",
					"maxclass": "message",
					"numinlets": 2,
					"numoutlets": 1,
					"outlettype": [
						""
					],
					"patching_rect": [
						2707.0,
						601.0,
						63.0,
						22.0
					],
					"style": "",
					"text": "hidden $1"
				}
			},
			{
				"box": {
					"fontname": "Arial",
					"id": "obj-141",
					"maxclass": "textbutton",
					"mode": 1,
					"numinlets": 1,
					"numoutlets": 3,
					"outlettype": [
						"",
						"",
						"int"
					],
					"parameter_enable": 0,
					"patching_rect": [
						2707.0,
						520.0,
						29.5,
						22.0
					],
					"presentation": 1,
					"presentation_rect": [
						80.333344,
						98.0,
						20.0,
						22.0
					],
					"style": "",
					"text": "T",
					"texton": "T",
					"fontface": 1
				}
			},
			{
				"box": {
					"allowdrag": 0,
					"id": "obj-142",
					"items": [
						"linear",
						",",
						"easeInBack",
						",",
						"easeInOutBack",
						",",
						"easeOutBack",
						",",
						"easeInBounce",
						",",
						"easeInOutBounce",
						",",
						"easeOutBounce",
						",",
						"easeInCircular",
						",",
						"easeInOutCircular",
						",",
						"easeOutCircular",
						",",
						"easeInCubic",
						",",
						"easeInOutCubic",
						",",
						"easeOutCubic",
						",",
						"easeInElastic",
						",",
						"easeInOutElastic",
						",",
						"easeOutElastic",
						",",
						"easeInExponential",
						",",
						"easeInOutExponential",
						",",
						"easeOutExponential",
						",",
						"easeInQuadratic",
						",",
						"easeInOutQuadratic",
						",",
						"easeOutQuadratic",
						",",
						"easeInQuartic",
						",",
						"easeInOutQuartic",
						",",
						"easeOutQuartic",
						",",
						"easeInQuintic",
						",",
						"easeInOutQuintic",
						",",
						"easeOutQuintic",
						",",
						"easeInSine",
						",",
						"easeInOutSine",
						",",
						"easeOutSine",
						",",
						"exponential",
						",",
						"freehand",
						",",
						"logarithm",
						",",
						"lowpass",
						",",
						"power",
						",",
						"smoothPolynomial",
						",",
						"tanh",
						",",
						"bartlett",
						",",
						"blackman",
						",",
						"blackmanHarris",
						",",
						"expodec",
						",",
						"gauss",
						",",
						"hamming",
						",",
						"hanning",
						",",
						"kaiser",
						",",
						"nuttall",
						",",
						"rectangular",
						",",
						"rosenbergGlottalPulse",
						",",
						"trapezoid",
						",",
						"tukey",
						",",
						"welch"
					],
					"labelclick": 1,
					"maxclass": "umenu",
					"numinlets": 1,
					"numoutlets": 3,
					"outlettype": [
						"int",
						"",
						""
					],
					"parameter_enable": 0,
					"patching_rect": [
						2819.75,
						680.8,
						100.0,
						22.0
					],
					"presentation": 1,
					"presentation_rect": [
						101.333344,
						98.0,
						108.0,
						22.0
					],
					"style": ""
				}
			},
			{
				"box": {
					"id": "obj-143",
					"maxclass": "newobj",
					"numinlets": 1,
					"numoutlets": 1,
					"outlettype": [
						""
					],
					"patching_rect": [
						2024.25,
						801.4,
						55.0,
						22.0
					],
					"style": "",
					"text": "prepend"
				}
			},
			{
				"box": {
					"id": "obj-144",
					"maxclass": "newobj",
					"numinlets": 1,
					"numoutlets": 1,
					"outlettype": [
						""
					],
					"patching_rect": [
						1881.0,
						801.4,
						55.0,
						22.0
					],
					"style": "",
					"text": "prepend"
				}
			},
			{
				"box": {
					"fontface": 0,
					"fontname": "Arial",
					"fontsize": 15.1,
					"hidden": 1,
					"id": "obj-145",
					"maxclass": "live.menu",
					"numinlets": 1,
					"numoutlets": 3,
					"outlettype": [
						"",
						"",
						"float"
					],
					"parameter_enable": 1,
					"patching_rect": [
						2707.0,
						680.8,
						99.5,
						22.0
					],
					"pictures": [
						"linear.svg",
						"easeInBack.svg",
						"easeInOutBack.svg",
						"easeOutBack.svg",
						"easeInBounce.svg",
						"easeInOutBounce.svg",
						"easeOutBounce.svg",
						"easeInCircular.svg",
						"easeInOutCircular.svg",
						"easeOutCircular.svg",
						"easeInCubic.svg",
						"easeInOutCubic.svg",
						"easeOutCubic.svg",
						"easeInElastic.svg",
						"easeInOutElastic.svg",
						"easeOutElastic.svg",
						"easeInExponential.svg",
						"easeInOutExponential.svg",
						"easeOutExponential.svg",
						"easeInQuadratic.svg",
						"easeInOutQuadratic.svg",
						"easeOutQuadratic.svg",
						"easeInQuartic.svg",
						"easeInOutQuartic.svg",
						"easeOutQuartic.svg",
						"easeInQuintic.svg",
						"easeInOutQuintic.svg",
						"easeOutQuintic.svg",
						"easeInSine.svg",
						"easeInOutSine.svg",
						"easeOutSine.svg",
						"exponential.svg",
						"freehand.svg",
						"logarithm.svg",
						"lowpass.svg",
						"power.svg",
						"smoothPolynomial.svg",
						"tanh.svg",
						"bartlett.svg",
						"blackman.svg",
						"blackmanHarris.svg",
						"expodec.svg",
						"gauss.svg",
						"hamming.svg",
						"hanning.svg",
						"kaiser.svg",
						"nuttall.svg",
						"rectangular.svg",
						"rosenbergGlottalPulse.svg",
						"trapezoid.svg",
						"tukey.svg",
						"welch.svg"
					],
					"presentation": 1,
					"presentation_rect": [
						101.333344,
						98.0,
						108.0,
						22.0
					],
					"saved_attribute_attributes": {
						"valueof": {
							"parameter_longname": "live.menu[1]",
							"parameter_shortname": "live.menu",
							"parameter_type": 2,
							"parameter_enum": [
								"linear",
								"easeInBack",
								"easeInOutBack",
								"easeOutBack",
								"easeInBounce",
								"easeInOutBounce",
								"easeOutBounce",
								"easeInCircular",
								"easeInOutCircular",
								"easeOutCircular",
								"easeInCubic",
								"easeInOutCubic",
								"easeOutCubic",
								"easeInElastic",
								"easeInOutElastic",
								"easeOutElastic",
								"easeInExponential",
								"easeInOutExponential",
								"easeOutExponential",
								"easeInQuadratic",
								"easeInOutQuadratic",
								"easeOutQuadratic",
								"easeInQuartic",
								"easeInOutQuartic",
								"easeOutQuartic",
								"easeInQuintic",
								"easeInOutQuintic",
								"easeOutQuintic",
								"easeInSine",
								"easeInOutSine",
								"easeOutSine",
								"exponential",
								"freehand",
								"logarithm",
								"lowpass",
								"power",
								"smoothPolynomial",
								"tanh",
								"bartlett",
								"blackman",
								"blackmanHarris",
								"expodec",
								"gauss",
								"hamming",
								"hanning",
								"kaiser",
								"nuttall",
								"rectangular",
								"rosenbergGlottalPulse",
								"trapezoid",
								"tukey",
								"welch"
							]
						}
					},
					"usepicture": 1,
					"varname": "live.menu[4]"
				}
			},
			{
				"box": {
					"angle": 270.0,
					"border": 1,
					"hidden": 1,
					"id": "obj-149",
					"maxclass": "panel",
					"mode": 0,
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [
						1790.800049,
						731.8,
						78.0,
						21.0
					],
					"presentation": 1,
					"presentation_rect": [
						210.333344,
						98.0,
						87.0,
						22.0
					],
					"proportion": 0.39,
					"rounded": 0,
					"style": "",
					"varname": "parameter[1]_panel"
				}
			},
			{
				"box": {
					"id": "obj-150",
					"maxclass": "newobj",
					"numinlets": 1,
					"numoutlets": 1,
					"outlettype": [
						"int"
					],
					"patching_rect": [
						1486.5,
						663.4,
						24.0,
						22.0
					],
					"style": "",
					"text": "t 0"
				}
			},
			{
				"box": {
					"id": "obj-151",
					"maxclass": "newobj",
					"numinlets": 1,
					"numoutlets": 2,
					"outlettype": [
						"int",
						"curveList"
					],
					"patching_rect": [
						1636.5,
						663.4,
						75.0,
						22.0
					],
					"style": "",
					"text": "t 0 curveList"
				}
			},
			{
				"box": {
					"id": "obj-153",
					"maxclass": "message",
					"numinlets": 2,
					"numoutlets": 1,
					"outlettype": [
						""
					],
					"patching_rect": [
						1636.5,
						695.8,
						63.0,
						22.0
					],
					"style": "",
					"text": "hidden $1"
				}
			},
			{
				"box": {
					"id": "obj-154",
					"maxclass": "message",
					"numinlets": 2,
					"numoutlets": 1,
					"outlettype": [
						""
					],
					"patching_rect": [
						1486.5,
						695.8,
						63.0,
						22.0
					],
					"style": "",
					"text": "hidden $1"
				}
			},
			{
				"box": {
					"allowdrag": 0,
					"hidden": 1,
					"id": "obj-156",
					"items": [
						"none",
						",",
						"axis",
						",",
						"point"
					],
					"labelclick": 1,
					"maxclass": "umenu",
					"numinlets": 1,
					"numoutlets": 3,
					"outlettype": [
						"int",
						"",
						""
					],
					"parameter_enable": 0,
					"patching_rect": [
						2167.5,
						731.8,
						100.0,
						22.0
					],
					"presentation": 1,
					"presentation_rect": [
						440.333344,
						98.0,
						57.0,
						22.0
					],
					"style": "",
					"varname": "parameter[2]_umenu"
				}
			},
			{
				"box": {
					"id": "obj-166",
					"maxclass": "newobj",
					"numinlets": 1,
					"numoutlets": 4,
					"outlettype": [
						"",
						"int",
						"",
						"bang"
					],
					"patching_rect": [
						1486.5,
						215.2,
						55.0,
						22.0
					],
					"style": "",
					"text": "t l 1 l b"
				}
			},
			{
				"box": {
					"format": 6,
					"hidden": 1,
					"id": "obj-168",
					"maxclass": "flonum",
					"numinlets": 1,
					"numoutlets": 2,
					"outlettype": [
						"",
						"bang"
					],
					"parameter_enable": 0,
					"patching_rect": [
						2024.25,
						731.8,
						50.0,
						22.0
					],
					"presentation": 1,
					"presentation_rect": [
						440.333344,
						98.0,
						57.0,
						22.0
					],
					"style": "",
					"varname": "parameter[2]_numbox"
				}
			},
			{
				"box": {
					"format": 6,
					"hidden": 1,
					"id": "obj-170",
					"maxclass": "flonum",
					"numinlets": 1,
					"numoutlets": 2,
					"outlettype": [
						"",
						"bang"
					],
					"parameter_enable": 0,
					"patching_rect": [
						1881.0,
						731.8,
						50.0,
						22.0
					],
					"presentation": 1,
					"presentation_rect": [
						299.333344,
						98.0,
						50.0,
						22.0
					],
					"style": "",
					"varname": "parameter[1]_numbox"
				}
			},
			{
				"box": {
					"id": "obj-62",
					"maxclass": "newobj",
					"numinlets": 3,
					"numoutlets": 3,
					"outlettype": [
						"",
						"",
						""
					],
					"patching_rect": [
						1486.5,
						409.6,
						319.0,
						22.0
					],
					"style": "",
					"text": "route bang curveList"
				}
			},
			{
				"box": {
					"id": "obj-55",
					"maxclass": "newobj",
					"numinlets": 1,
					"numoutlets": 1,
					"outlettype": [
						""
					],
					"patching_rect": [
						1778.5,
						1076.2,
						27.0,
						22.0
					],
					"style": "",
					"text": "iter"
				}
			},
			{
				"box": {
					"id": "obj-171",
					"maxclass": "newobj",
					"numinlets": 1,
					"numoutlets": 2,
					"outlettype": [
						"",
						""
					],
					"patching_rect": [
						1786.5,
						440.8,
						176.333252,
						22.0
					],
					"style": "",
					"text": "t l l"
				}
			},
			{
				"box": {
					"id": "obj-47",
					"maxclass": "newobj",
					"numinlets": 1,
					"numoutlets": 3,
					"outlettype": [
						"",
						"",
						""
					],
					"patching_rect": [
						1943.833252,
						519.4,
						278.333496,
						22.0
					],
					"style": "",
					"text": "unjoin 2"
				}
			},
			{
				"box": {
					"id": "obj-43",
					"maxclass": "newobj",
					"numinlets": 3,
					"numoutlets": 3,
					"outlettype": [
						"",
						"",
						""
					],
					"patching_rect": [
						1486.5,
						165.4,
						413.5,
						22.0
					],
					"style": "",
					"text": "route function/parameters function/samples"
				}
			},
			{
				"box": {
					"angle": 270.0,
					"border": 1,
					"id": "obj-215",
					"maxclass": "panel",
					"mode": 0,
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [
						28.333374,
						887.2,
						78.0,
						21.0
					],
					"presentation": 1,
					"presentation_rect": [
						2.0,
						20.0,
						900.0,
						61.0
					],
					"proportion": 0.39,
					"rounded": 0,
					"style": "",
					"varname": "parameter[1]_panel[2]"
				}
			},
			{
				"box": {
					"angle": 270.0,
					"background": 1,
					"border": 1,
					"id": "obj-179",
					"maxclass": "panel",
					"mode": 0,
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [
						1486.5,
						771.4,
						138.0,
						21.0
					],
					"presentation": 1,
					"presentation_rect": [
						210.333344,
						98.0,
						287.0,
						22.0
					],
					"proportion": 0.39,
					"rounded": 0,
					"style": "",
					"varname": "no_parameter_panel"
				}
			},
			{
				"box": {
					"angle": 270.0,
					"background": 1,
					"border": 1,
					"hidden": 1,
					"id": "obj-178",
					"maxclass": "panel",
					"mode": 0,
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [
						1636.5,
						771.4,
						138.0,
						21.0
					],
					"presentation": 1,
					"presentation_rect": [
						210.333344,
						98.0,
						287.0,
						22.0
					],
					"proportion": 0.39,
					"rounded": 0,
					"style": "",
					"varname": "function_parameter_panel"
				}
			},
			{
				"box": {
					"background": 1,
					"fontname": "Arial",
					"id": "obj-177",
					"ignoreclick": 1,
					"margins": [
						0.0,
						0.0,
						0.0,
						0.0
					],
					"maxclass": "plot~",
					"numinlets": 1,
					"numoutlets": 1,
					"numpoints": 100,
					"outlettype": [
						""
					],
					"patching_rect": [
						1683.75,
						252.4,
						78.499878,
						50.0
					],
					"presentation": 1,
					"presentation_rect": [
						19.333344,
						147.0,
						478.0,
						478.5
					],
					"subplots": [
						{
							"color": [
								0.0,
								0.0,
								0.0,
								1.0
							],
							"thickness": 0.3,
							"point_style": "dot",
							"line_style": "lines",
							"number_style": "none",
							"filter": "none",
							"domain_start": 0.0,
							"domain_end": 1.0,
							"domain_style": "linear",
							"domain_markers": [
								0.5
							],
							"domain_labels": [],
							"range_start": 0.0,
							"range_end": 0.99,
							"range_style": "linear",
							"range_markers": [
								0.0
							],
							"range_labels": [],
							"origin_x": 0.0,
							"origin_y": 0.0
						}
					],
					"thinmode": "none",
					"thinto": 0.13,
					"varname": "plot"
				}
			},
			{
				"box": {
					"angle": 270.0,
					"background": 1,
					"border": 1,
					"hidden": 1,
					"id": "obj-180",
					"maxclass": "panel",
					"mode": 0,
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [
						1953.5,
						731.8,
						67.0,
						21.0
					],
					"presentation": 1,
					"presentation_rect": [
						351.333344,
						98.0,
						87.0,
						22.0
					],
					"proportion": 0.39,
					"rounded": 0,
					"style": "",
					"varname": "parameter[2]_panel"
				}
			},
			{
				"box": {
					"angle": 270.0,
					"background": 1,
					"border": 1,
					"id": "obj-8",
					"maxclass": "panel",
					"mode": 0,
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [
						1683.75,
						320.2,
						81.666687,
						50.0
					],
					"presentation": 1,
					"presentation_rect": [
						19.333344,
						147.0,
						478.0,
						478.5
					],
					"proportion": 0.39,
					"rounded": 0,
					"style": ""
				}
			},
			{
				"box": {
					"hidden": 1,
					"id": "obj-202",
					"maxclass": "message",
					"numinlets": 2,
					"numoutlets": 1,
					"outlettype": [
						""
					],
					"patching_rect": [
						2112.5,
						985.6,
						88.0,
						22.0
					],
					"style": "",
					"text": "array/resize $1"
				}
			},
			{
				"box": {
					"background": 1,
					"fontface": 0,
					"id": "obj-19",
					"maxclass": "j.ui",
					"numinlets": 1,
					"numoutlets": 1,
					"outlettype": [
						""
					],
					"patching_rect": [
						2.0,
						1.0,
						150.0,
						70.0
					],
					"presentation": 1,
					"presentation_rect": [
						2.0,
						1.0,
						900.0,
						665.0
					],
					"text": "/mapper"
				}
			}
		],
		"lines": [
			{
				"patchline": {
					"destination": [
						"obj-191",
						0
					],
					"disabled": 0,
					"hidden": 0,
					"midpoints": [
						3162.166748,
						1112.8,
						1788.0,
						1112.8
					],
					"source": [
						"obj-1",
						0
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-142",
						0
					],
					"disabled": 0,
					"hidden": 0,
					"midpoints": [
						3035.722168,
						848.8,
						3276.486084,
						848.8,
						3276.486084,
						667.6,
						2829.25,
						667.6
					],
					"source": [
						"obj-10",
						0
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-145",
						0
					],
					"disabled": 0,
					"hidden": 0,
					"midpoints": [
						3035.722168,
						848.8,
						3289.111084,
						848.8,
						3289.111084,
						659.2,
						2716.5,
						659.2
					],
					"source": [
						"obj-10",
						0
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-201",
						1
					],
					"disabled": 0,
					"hidden": 0,
					"source": [
						"obj-100",
						1
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-201",
						0
					],
					"disabled": 0,
					"hidden": 0,
					"source": [
						"obj-100",
						0
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-102",
						0
					],
					"disabled": 0,
					"hidden": 0,
					"source": [
						"obj-101",
						0
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-103",
						0
					],
					"disabled": 0,
					"hidden": 0,
					"source": [
						"obj-104",
						0
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-108",
						0
					],
					"disabled": 0,
					"hidden": 0,
					"midpoints": [
						4357.333008,
						922.0,
						4342.333008,
						922.0,
						4342.333008,
						823.0,
						4357.333008,
						823.0
					],
					"source": [
						"obj-106",
						0
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-131",
						0
					],
					"disabled": 0,
					"hidden": 0,
					"source": [
						"obj-107",
						0
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-27",
						0
					],
					"disabled": 0,
					"hidden": 0,
					"source": [
						"obj-108",
						0
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-116",
						0
					],
					"disabled": 0,
					"hidden": 0,
					"source": [
						"obj-109",
						0
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-51",
						0
					],
					"disabled": 0,
					"hidden": 0,
					"source": [
						"obj-11",
						0
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-115",
						0
					],
					"disabled": 0,
					"hidden": 0,
					"source": [
						"obj-110",
						0
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-114",
						0
					],
					"disabled": 0,
					"hidden": 0,
					"source": [
						"obj-111",
						0
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-113",
						0
					],
					"disabled": 0,
					"hidden": 0,
					"source": [
						"obj-112",
						0
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-112",
						0
					],
					"disabled": 0,
					"hidden": 0,
					"source": [
						"obj-113",
						0
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-148",
						0
					],
					"disabled": 0,
					"hidden": 0,
					"source": [
						"obj-113",
						0
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-111",
						0
					],
					"disabled": 0,
					"hidden": 0,
					"source": [
						"obj-114",
						0
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-152",
						0
					],
					"disabled": 0,
					"hidden": 0,
					"source": [
						"obj-114",
						0
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-110",
						0
					],
					"disabled": 0,
					"hidden": 0,
					"source": [
						"obj-115",
						0
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-208",
						0
					],
					"disabled": 0,
					"hidden": 0,
					"source": [
						"obj-115",
						0
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-109",
						0
					],
					"disabled": 0,
					"hidden": 0,
					"source": [
						"obj-116",
						0
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-209",
						0
					],
					"disabled": 0,
					"hidden": 0,
					"source": [
						"obj-116",
						0
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-234",
						1
					],
					"disabled": 0,
					"hidden": 0,
					"source": [
						"obj-117",
						1
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-120",
						0
					],
					"disabled": 0,
					"hidden": 0,
					"source": [
						"obj-118",
						0
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-250",
						0
					],
					"disabled": 0,
					"hidden": 0,
					"source": [
						"obj-119",
						0
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-255",
						0
					],
					"disabled": 0,
					"hidden": 0,
					"source": [
						"obj-119",
						1
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-11",
						1
					],
					"disabled": 0,
					"hidden": 0,
					"source": [
						"obj-12",
						0
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-88",
						0
					],
					"disabled": 0,
					"hidden": 0,
					"source": [
						"obj-12",
						0
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-121",
						0
					],
					"disabled": 0,
					"hidden": 0,
					"source": [
						"obj-120",
						0
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-113",
						0
					],
					"disabled": 0,
					"hidden": 0,
					"source": [
						"obj-121",
						1
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-114",
						0
					],
					"disabled": 0,
					"hidden": 0,
					"source": [
						"obj-121",
						0
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-118",
						0
					],
					"disabled": 0,
					"hidden": 0,
					"source": [
						"obj-122",
						0
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-46",
						0
					],
					"disabled": 0,
					"hidden": 0,
					"midpoints": [
						4035.333252,
						799.0,
						4020.333252,
						799.0,
						4020.333252,
						703.6,
						4035.333252,
						703.6
					],
					"source": [
						"obj-123",
						0
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-13",
						0
					],
					"disabled": 0,
					"hidden": 0,
					"source": [
						"obj-124",
						0
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-47",
						0
					],
					"disabled": 0,
					"hidden": 0,
					"source": [
						"obj-127",
						0
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-74",
						0
					],
					"disabled": 0,
					"hidden": 0,
					"source": [
						"obj-128",
						0
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-155",
						0
					],
					"disabled": 0,
					"hidden": 0,
					"midpoints": [
						4196.333008,
						541.0,
						4181.333008,
						541.0,
						4181.333008,
						445.6,
						4196.333008,
						445.6
					],
					"source": [
						"obj-129",
						0
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-185",
						0
					],
					"disabled": 0,
					"hidden": 1,
					"midpoints": [
						1609.0,
						123.1,
						1464.0,
						123.1
					],
					"source": [
						"obj-130",
						0
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-132",
						0
					],
					"disabled": 0,
					"hidden": 0,
					"source": [
						"obj-131",
						0
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-185",
						0
					],
					"disabled": 0,
					"hidden": 0,
					"source": [
						"obj-132",
						0
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-142",
						0
					],
					"disabled": 0,
					"hidden": 0,
					"source": [
						"obj-134",
						0
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-134",
						0
					],
					"disabled": 0,
					"hidden": 0,
					"source": [
						"obj-135",
						0
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-142",
						0
					],
					"disabled": 0,
					"hidden": 0,
					"source": [
						"obj-136",
						0
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-145",
						0
					],
					"disabled": 0,
					"hidden": 0,
					"source": [
						"obj-137",
						0
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-18",
						0
					],
					"disabled": 0,
					"hidden": 0,
					"source": [
						"obj-138",
						0
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-133",
						0
					],
					"disabled": 0,
					"hidden": 0,
					"source": [
						"obj-139",
						1
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-83",
						0
					],
					"disabled": 0,
					"hidden": 0,
					"source": [
						"obj-139",
						0
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-129",
						0
					],
					"disabled": 0,
					"hidden": 0,
					"source": [
						"obj-140",
						0
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-135",
						0
					],
					"disabled": 0,
					"hidden": 0,
					"midpoints": [
						2716.5,
						559.6,
						2829.25,
						559.6
					],
					"source": [
						"obj-141",
						0
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-137",
						0
					],
					"disabled": 0,
					"hidden": 0,
					"source": [
						"obj-141",
						0
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-145",
						0
					],
					"disabled": 0,
					"hidden": 0,
					"source": [
						"obj-142",
						0
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-100",
						0
					],
					"disabled": 0,
					"hidden": 0,
					"source": [
						"obj-143",
						0
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-99",
						0
					],
					"disabled": 0,
					"hidden": 0,
					"source": [
						"obj-144",
						0
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-136",
						0
					],
					"disabled": 0,
					"hidden": 0,
					"source": [
						"obj-145",
						0
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-163",
						0
					],
					"disabled": 0,
					"hidden": 0,
					"source": [
						"obj-145",
						1
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-144",
						0
					],
					"disabled": 0,
					"hidden": 0,
					"source": [
						"obj-146",
						0
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-143",
						0
					],
					"disabled": 0,
					"hidden": 0,
					"source": [
						"obj-147",
						0
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-51",
						2
					],
					"disabled": 0,
					"hidden": 0,
					"midpoints": [
						1063.333374,
						715.9,
						857.933411,
						715.9
					],
					"source": [
						"obj-148",
						0
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-154",
						0
					],
					"disabled": 0,
					"hidden": 0,
					"source": [
						"obj-150",
						0
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-153",
						0
					],
					"disabled": 0,
					"hidden": 0,
					"source": [
						"obj-151",
						0
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-51",
						1
					],
					"disabled": 0,
					"hidden": 0,
					"source": [
						"obj-152",
						0
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-178",
						0
					],
					"disabled": 0,
					"hidden": 0,
					"source": [
						"obj-153",
						0
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-77",
						0
					],
					"disabled": 0,
					"hidden": 0,
					"source": [
						"obj-153",
						0
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-179",
						0
					],
					"disabled": 0,
					"hidden": 0,
					"source": [
						"obj-154",
						0
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-78",
						0
					],
					"disabled": 0,
					"hidden": 0,
					"source": [
						"obj-154",
						0
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-140",
						0
					],
					"disabled": 0,
					"hidden": 0,
					"source": [
						"obj-155",
						0
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-143",
						0
					],
					"disabled": 0,
					"hidden": 0,
					"source": [
						"obj-156",
						1
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-23",
						0
					],
					"disabled": 0,
					"hidden": 1,
					"source": [
						"obj-157",
						0
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-130",
						0
					],
					"disabled": 0,
					"hidden": 1,
					"source": [
						"obj-158",
						0
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-187",
						2
					],
					"disabled": 0,
					"hidden": 0,
					"source": [
						"obj-159",
						1
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-23",
						0
					],
					"disabled": 0,
					"hidden": 0,
					"source": [
						"obj-159",
						0
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-187",
						2
					],
					"disabled": 0,
					"hidden": 0,
					"source": [
						"obj-160",
						1
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-23",
						0
					],
					"disabled": 0,
					"hidden": 0,
					"source": [
						"obj-160",
						0
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-164",
						0
					],
					"disabled": 0,
					"hidden": 0,
					"midpoints": [
						4035.333252,
						541.0,
						4020.333252,
						541.0,
						4020.333252,
						445.6,
						4035.333252,
						445.6
					],
					"source": [
						"obj-161",
						0
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-161",
						0
					],
					"disabled": 0,
					"hidden": 0,
					"source": [
						"obj-162",
						0
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-181",
						0
					],
					"disabled": 0,
					"hidden": 0,
					"source": [
						"obj-163",
						0
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-234",
						0
					],
					"disabled": 0,
					"hidden": 0,
					"midpoints": [
						2767.75,
						939.1,
						1761.0,
						939.1
					],
					"source": [
						"obj-163",
						1
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-162",
						0
					],
					"disabled": 0,
					"hidden": 0,
					"source": [
						"obj-164",
						0
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-117",
						0
					],
					"disabled": 0,
					"hidden": 0,
					"source": [
						"obj-166",
						2
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-5",
						0
					],
					"disabled": 0,
					"hidden": 0,
					"source": [
						"obj-166",
						2
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-62",
						0
					],
					"disabled": 0,
					"hidden": 0,
					"source": [
						"obj-166",
						0
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-37",
						0
					],
					"disabled": 0,
					"hidden": 0,
					"source": [
						"obj-167",
						0
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-90",
						0
					],
					"disabled": 0,
					"hidden": 0,
					"midpoints": [
						900.800049,
						316.0,
						876.800049,
						316.0,
						876.800049,
						239.2,
						900.800049,
						239.2
					],
					"source": [
						"obj-167",
						0
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-143",
						0
					],
					"disabled": 0,
					"hidden": 0,
					"source": [
						"obj-168",
						0
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-41",
						0
					],
					"disabled": 0,
					"hidden": 0,
					"source": [
						"obj-169",
						0
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-91",
						0
					],
					"disabled": 0,
					"hidden": 0,
					"midpoints": [
						328.166626,
						321.4,
						302.166626,
						321.4,
						302.166626,
						235.0,
						328.166626,
						235.0
					],
					"source": [
						"obj-169",
						0
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-144",
						0
					],
					"disabled": 0,
					"hidden": 0,
					"source": [
						"obj-170",
						0
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-127",
						0
					],
					"disabled": 0,
					"hidden": 0,
					"source": [
						"obj-171",
						1
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-176",
						0
					],
					"disabled": 0,
					"hidden": 0,
					"midpoints": [
						656.0,
						113.8,
						565.5,
						113.8
					],
					"source": [
						"obj-172",
						1
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-3",
						0
					],
					"disabled": 0,
					"hidden": 0,
					"source": [
						"obj-173",
						0
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-186",
						0
					],
					"disabled": 0,
					"hidden": 0,
					"midpoints": [
						4035.333252,
						414.4,
						4020.833252,
						414.4,
						4020.833252,
						347.2,
						4035.333252,
						347.2
					],
					"source": [
						"obj-174",
						0
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-13",
						0
					],
					"disabled": 0,
					"hidden": 0,
					"source": [
						"obj-175",
						0
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-216",
						0
					],
					"disabled": 0,
					"hidden": 0,
					"source": [
						"obj-176",
						0
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-125",
						0
					],
					"disabled": 0,
					"hidden": 0,
					"source": [
						"obj-181",
						1
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-48",
						0
					],
					"disabled": 0,
					"hidden": 0,
					"source": [
						"obj-181",
						1
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-55",
						0
					],
					"disabled": 0,
					"hidden": 0,
					"source": [
						"obj-184",
						0
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-43",
						0
					],
					"disabled": 0,
					"hidden": 0,
					"source": [
						"obj-185",
						1
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-174",
						0
					],
					"disabled": 0,
					"hidden": 0,
					"source": [
						"obj-186",
						0
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-13",
						0
					],
					"disabled": 0,
					"hidden": 0,
					"source": [
						"obj-187",
						0
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-189",
						0
					],
					"disabled": 0,
					"hidden": 0,
					"midpoints": [
						4035.333252,
						338.8,
						4020.833252,
						338.8,
						4020.833252,
						271.6,
						4035.333252,
						271.6
					],
					"source": [
						"obj-188",
						0
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-188",
						0
					],
					"disabled": 0,
					"hidden": 0,
					"source": [
						"obj-189",
						0
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-252",
						1
					],
					"disabled": 0,
					"hidden": 0,
					"source": [
						"obj-190",
						0
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-256",
						0
					],
					"disabled": 0,
					"hidden": 0,
					"source": [
						"obj-190",
						0
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-185",
						0
					],
					"disabled": 0,
					"hidden": 0,
					"midpoints": [
						1788.0,
						1159.0,
						1446.5,
						1159.0,
						1446.5,
						122.8,
						1464.0,
						122.8
					],
					"source": [
						"obj-191",
						0
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-205",
						0
					],
					"disabled": 0,
					"hidden": 0,
					"source": [
						"obj-195",
						0
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-195",
						0
					],
					"disabled": 0,
					"hidden": 0,
					"source": [
						"obj-196",
						0
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-203",
						0
					],
					"disabled": 0,
					"hidden": 0,
					"source": [
						"obj-198",
						0
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-202",
						0
					],
					"disabled": 0,
					"hidden": 1,
					"source": [
						"obj-200",
						0
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-71",
						0
					],
					"disabled": 0,
					"hidden": 0,
					"source": [
						"obj-201",
						0
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-204",
						0
					],
					"disabled": 0,
					"hidden": 0,
					"source": [
						"obj-203",
						0
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-115",
						0
					],
					"disabled": 0,
					"hidden": 0,
					"source": [
						"obj-204",
						1
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-116",
						0
					],
					"disabled": 0,
					"hidden": 0,
					"source": [
						"obj-204",
						0
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-198",
						0
					],
					"disabled": 0,
					"hidden": 0,
					"source": [
						"obj-205",
						0
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-212",
						0
					],
					"disabled": 0,
					"hidden": 0,
					"midpoints": [
						156.5,
						817.3,
						258.466614,
						817.3
					],
					"source": [
						"obj-206",
						0
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-206",
						1
					],
					"disabled": 0,
					"hidden": 0,
					"source": [
						"obj-207",
						0
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-96",
						0
					],
					"disabled": 0,
					"hidden": 0,
					"source": [
						"obj-207",
						0
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-212",
						2
					],
					"disabled": 0,
					"hidden": 0,
					"source": [
						"obj-208",
						0
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-58",
						4
					],
					"disabled": 0,
					"hidden": 0,
					"source": [
						"obj-208",
						0
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-212",
						1
					],
					"disabled": 0,
					"hidden": 0,
					"source": [
						"obj-209",
						0
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-58",
						3
					],
					"disabled": 0,
					"hidden": 0,
					"source": [
						"obj-209",
						0
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-20",
						0
					],
					"disabled": 0,
					"hidden": 0,
					"source": [
						"obj-21",
						0
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-211",
						0
					],
					"disabled": 0,
					"hidden": 0,
					"source": [
						"obj-210",
						0
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-206",
						0
					],
					"disabled": 0,
					"hidden": 0,
					"source": [
						"obj-211",
						0
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-192",
						0
					],
					"disabled": 0,
					"hidden": 0,
					"source": [
						"obj-212",
						0
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-185",
						0
					],
					"disabled": 0,
					"hidden": 0,
					"source": [
						"obj-214",
						0
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-172",
						0
					],
					"disabled": 0,
					"hidden": 0,
					"midpoints": [
						565.5,
						194.2,
						546.0,
						194.2,
						546.0,
						64.6,
						565.5,
						64.6
					],
					"source": [
						"obj-216",
						0
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-13",
						0
					],
					"disabled": 0,
					"hidden": 0,
					"source": [
						"obj-217",
						0
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-195",
						1
					],
					"disabled": 0,
					"hidden": 0,
					"source": [
						"obj-220",
						0
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-210",
						0
					],
					"disabled": 0,
					"hidden": 0,
					"source": [
						"obj-220",
						0
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-68",
						0
					],
					"disabled": 0,
					"hidden": 0,
					"midpoints": [
						900.800049,
						403.3,
						746.166748,
						403.3
					],
					"source": [
						"obj-221",
						0
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-93",
						1
					],
					"disabled": 0,
					"hidden": 0,
					"source": [
						"obj-221",
						0
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-238",
						0
					],
					"disabled": 0,
					"hidden": 0,
					"source": [
						"obj-227",
						1
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-237",
						0
					],
					"disabled": 0,
					"hidden": 0,
					"source": [
						"obj-229",
						0
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-187",
						1
					],
					"disabled": 0,
					"hidden": 0,
					"source": [
						"obj-23",
						2
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-187",
						0
					],
					"disabled": 0,
					"hidden": 0,
					"source": [
						"obj-23",
						1
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-239",
						0
					],
					"disabled": 0,
					"hidden": 0,
					"source": [
						"obj-231",
						0
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-235",
						0
					],
					"disabled": 0,
					"hidden": 0,
					"source": [
						"obj-234",
						0
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-184",
						0
					],
					"disabled": 0,
					"hidden": 0,
					"source": [
						"obj-235",
						1
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-234",
						0
					],
					"disabled": 0,
					"hidden": 0,
					"midpoints": [
						1761.0,
						1059.4,
						1739.0,
						1059.4,
						1739.0,
						941.8,
						1761.0,
						941.8
					],
					"source": [
						"obj-235",
						0
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-156",
						0
					],
					"disabled": 0,
					"hidden": 0,
					"source": [
						"obj-237",
						2
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-168",
						0
					],
					"disabled": 0,
					"hidden": 0,
					"source": [
						"obj-237",
						1
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-170",
						0
					],
					"disabled": 0,
					"hidden": 0,
					"source": [
						"obj-237",
						0
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-224",
						0
					],
					"disabled": 0,
					"hidden": 0,
					"source": [
						"obj-237",
						1
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-29",
						0
					],
					"disabled": 0,
					"hidden": 0,
					"source": [
						"obj-237",
						3
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-191",
						0
					],
					"disabled": 0,
					"hidden": 0,
					"midpoints": [
						1894.5,
						1112.2,
						1788.0,
						1112.2
					],
					"source": [
						"obj-238",
						0
					]
				}
			},
			{
				"patchline": {
					"color": [
						1.0,
						0.0,
						0.022667,
						1.0
					],
					"destination": [
						"obj-237",
						0
					],
					"disabled": 0,
					"hidden": 0,
					"midpoints": [
						1905.0,
						1105.0,
						2568.0,
						1105.0,
						2568.0,
						416.2,
						1890.5,
						416.2
					],
					"source": [
						"obj-238",
						1
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-211",
						0
					],
					"disabled": 0,
					"hidden": 0,
					"midpoints": [
						41.666748,
						670.9,
						156.5,
						670.9
					],
					"source": [
						"obj-239",
						0
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-22",
						0
					],
					"disabled": 0,
					"hidden": 0,
					"source": [
						"obj-24",
						0
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-251",
						0
					],
					"disabled": 0,
					"hidden": 0,
					"source": [
						"obj-245",
						0
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-138",
						0
					],
					"disabled": 0,
					"hidden": 0,
					"source": [
						"obj-249",
						1
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-250",
						0
					],
					"disabled": 0,
					"hidden": 0,
					"source": [
						"obj-249",
						0
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-253",
						1
					],
					"disabled": 0,
					"hidden": 0,
					"source": [
						"obj-250",
						0
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-252",
						0
					],
					"disabled": 0,
					"hidden": 0,
					"source": [
						"obj-251",
						0
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-119",
						0
					],
					"disabled": 0,
					"hidden": 0,
					"source": [
						"obj-252",
						0
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-138",
						0
					],
					"disabled": 0,
					"hidden": 0,
					"source": [
						"obj-253",
						0
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-253",
						0
					],
					"disabled": 0,
					"hidden": 0,
					"source": [
						"obj-255",
						0
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-138",
						0
					],
					"disabled": 0,
					"hidden": 0,
					"source": [
						"obj-256",
						1
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-255",
						0
					],
					"disabled": 0,
					"hidden": 0,
					"source": [
						"obj-256",
						0
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-138",
						0
					],
					"disabled": 0,
					"hidden": 0,
					"source": [
						"obj-257",
						0
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-139",
						0
					],
					"disabled": 0,
					"hidden": 0,
					"source": [
						"obj-26",
						1
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-173",
						0
					],
					"disabled": 0,
					"hidden": 0,
					"source": [
						"obj-26",
						0
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-29",
						0
					],
					"disabled": 0,
					"hidden": 0,
					"midpoints": [
						2528.111084,
						839.8,
						2543.0,
						839.8,
						2543.0,
						674.2,
						2320.333252,
						674.2
					],
					"source": [
						"obj-26",
						2
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-106",
						0
					],
					"disabled": 0,
					"hidden": 0,
					"source": [
						"obj-27",
						0
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-31",
						0
					],
					"disabled": 0,
					"hidden": 0,
					"midpoints": [
						4196.333008,
						922.0,
						4181.333008,
						922.0,
						4181.333008,
						823.0,
						4196.333008,
						823.0
					],
					"source": [
						"obj-28",
						0
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-26",
						1
					],
					"disabled": 0,
					"hidden": 0,
					"source": [
						"obj-29",
						3
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-26",
						0
					],
					"disabled": 0,
					"hidden": 0,
					"source": [
						"obj-29",
						2
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-201",
						1
					],
					"disabled": 0,
					"hidden": 0,
					"source": [
						"obj-3",
						1
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-201",
						0
					],
					"disabled": 0,
					"hidden": 0,
					"source": [
						"obj-3",
						0
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-28",
						0
					],
					"disabled": 0,
					"hidden": 0,
					"source": [
						"obj-30",
						0
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-30",
						0
					],
					"disabled": 0,
					"hidden": 0,
					"source": [
						"obj-31",
						0
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-229",
						0
					],
					"disabled": 0,
					"hidden": 0,
					"source": [
						"obj-32",
						0
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-35",
						0
					],
					"disabled": 0,
					"hidden": 0,
					"midpoints": [
						4035.333252,
						922.0,
						4020.333252,
						922.0,
						4020.333252,
						823.0,
						4035.333252,
						823.0
					],
					"source": [
						"obj-33",
						0
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-33",
						0
					],
					"disabled": 0,
					"hidden": 0,
					"source": [
						"obj-34",
						0
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-34",
						0
					],
					"disabled": 0,
					"hidden": 0,
					"source": [
						"obj-35",
						0
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-39",
						0
					],
					"disabled": 0,
					"hidden": 0,
					"midpoints": [
						4357.333008,
						799.0,
						4342.333008,
						799.0,
						4342.333008,
						703.6,
						4357.333008,
						703.6
					],
					"source": [
						"obj-36",
						0
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-221",
						0
					],
					"disabled": 0,
					"hidden": 0,
					"source": [
						"obj-37",
						0
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-36",
						0
					],
					"disabled": 0,
					"hidden": 0,
					"source": [
						"obj-38",
						0
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-38",
						0
					],
					"disabled": 0,
					"hidden": 0,
					"source": [
						"obj-39",
						0
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-160",
						0
					],
					"disabled": 0,
					"hidden": 0,
					"source": [
						"obj-4",
						2
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-63",
						0
					],
					"disabled": 0,
					"hidden": 0,
					"source": [
						"obj-4",
						0
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-44",
						0
					],
					"disabled": 0,
					"hidden": 0,
					"midpoints": [
						4196.333008,
						799.0,
						4181.333008,
						799.0,
						4181.333008,
						703.6,
						4196.333008,
						703.6
					],
					"source": [
						"obj-40",
						0
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-220",
						0
					],
					"disabled": 0,
					"hidden": 0,
					"source": [
						"obj-41",
						0
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-40",
						0
					],
					"disabled": 0,
					"hidden": 0,
					"source": [
						"obj-42",
						0
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-166",
						0
					],
					"disabled": 0,
					"hidden": 0,
					"source": [
						"obj-43",
						0
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-32",
						0
					],
					"disabled": 0,
					"hidden": 0,
					"source": [
						"obj-43",
						2
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-53",
						0
					],
					"disabled": 0,
					"hidden": 0,
					"source": [
						"obj-43",
						1
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-42",
						0
					],
					"disabled": 0,
					"hidden": 0,
					"source": [
						"obj-44",
						0
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-123",
						0
					],
					"disabled": 0,
					"hidden": 0,
					"source": [
						"obj-45",
						0
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-45",
						0
					],
					"disabled": 0,
					"hidden": 0,
					"source": [
						"obj-46",
						0
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-146",
						0
					],
					"disabled": 0,
					"hidden": 0,
					"source": [
						"obj-47",
						0
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-147",
						0
					],
					"disabled": 0,
					"hidden": 0,
					"source": [
						"obj-47",
						1
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-237",
						2
					],
					"disabled": 0,
					"hidden": 0,
					"source": [
						"obj-47",
						1
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-237",
						1
					],
					"disabled": 0,
					"hidden": 0,
					"source": [
						"obj-47",
						0
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-1",
						0
					],
					"disabled": 0,
					"hidden": 0,
					"source": [
						"obj-48",
						3
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-10",
						0
					],
					"disabled": 0,
					"hidden": 0,
					"source": [
						"obj-48",
						1
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-191",
						0
					],
					"disabled": 0,
					"hidden": 0,
					"midpoints": [
						3067.333496,
						1113.1,
						1788.0,
						1113.1
					],
					"source": [
						"obj-48",
						2
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-75",
						0
					],
					"disabled": 0,
					"hidden": 0,
					"source": [
						"obj-48",
						0
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-56",
						0
					],
					"disabled": 0,
					"hidden": 0,
					"source": [
						"obj-51",
						0
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-177",
						0
					],
					"disabled": 0,
					"hidden": 0,
					"source": [
						"obj-53",
						0
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-59",
						0
					],
					"disabled": 0,
					"hidden": 0,
					"midpoints": [
						4357.333008,
						664.0,
						4342.333008,
						664.0,
						4342.333008,
						565.0,
						4357.333008,
						565.0
					],
					"source": [
						"obj-54",
						0
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-191",
						0
					],
					"disabled": 0,
					"hidden": 0,
					"source": [
						"obj-55",
						0
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-54",
						0
					],
					"disabled": 0,
					"hidden": 0,
					"source": [
						"obj-57",
						0
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-212",
						0
					],
					"disabled": 0,
					"hidden": 0,
					"midpoints": [
						425.666626,
						816.1,
						258.466614,
						816.1
					],
					"source": [
						"obj-58",
						0
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-49",
						0
					],
					"disabled": 0,
					"hidden": 0,
					"source": [
						"obj-58",
						0
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-57",
						0
					],
					"disabled": 0,
					"hidden": 0,
					"source": [
						"obj-59",
						0
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-92",
						0
					],
					"disabled": 0,
					"hidden": 0,
					"source": [
						"obj-60",
						0
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-72",
						0
					],
					"disabled": 0,
					"hidden": 0,
					"midpoints": [
						4035.333252,
						664.0,
						4020.333252,
						664.0,
						4020.333252,
						565.0,
						4035.333252,
						565.0
					],
					"source": [
						"obj-61",
						0
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-150",
						0
					],
					"disabled": 0,
					"hidden": 0,
					"source": [
						"obj-62",
						0
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-151",
						0
					],
					"disabled": 0,
					"hidden": 0,
					"source": [
						"obj-62",
						1
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-171",
						0
					],
					"disabled": 0,
					"hidden": 0,
					"source": [
						"obj-62",
						2
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-159",
						0
					],
					"disabled": 0,
					"hidden": 0,
					"source": [
						"obj-63",
						0
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-87",
						0
					],
					"disabled": 0,
					"hidden": 0,
					"source": [
						"obj-64",
						0
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-64",
						0
					],
					"disabled": 0,
					"hidden": 0,
					"source": [
						"obj-65",
						0
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-87",
						0
					],
					"disabled": 0,
					"hidden": 0,
					"source": [
						"obj-65",
						1
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-138",
						0
					],
					"disabled": 0,
					"hidden": 0,
					"source": [
						"obj-66",
						0
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-82",
						0
					],
					"disabled": 0,
					"hidden": 0,
					"source": [
						"obj-68",
						0
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-61",
						0
					],
					"disabled": 0,
					"hidden": 0,
					"source": [
						"obj-69",
						0
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-9",
						0
					],
					"disabled": 0,
					"hidden": 0,
					"source": [
						"obj-7",
						0
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-58",
						0
					],
					"disabled": 0,
					"hidden": 0,
					"source": [
						"obj-70",
						0
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-227",
						0
					],
					"disabled": 0,
					"hidden": 0,
					"source": [
						"obj-71",
						0
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-69",
						0
					],
					"disabled": 0,
					"hidden": 0,
					"source": [
						"obj-72",
						0
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-128",
						0
					],
					"disabled": 0,
					"hidden": 0,
					"midpoints": [
						4357.333008,
						541.0,
						4342.333008,
						541.0,
						4342.333008,
						445.6,
						4357.333008,
						445.6
					],
					"source": [
						"obj-73",
						0
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-73",
						0
					],
					"disabled": 0,
					"hidden": 0,
					"source": [
						"obj-74",
						0
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-249",
						0
					],
					"disabled": 0,
					"hidden": 0,
					"source": [
						"obj-80",
						0
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-11",
						0
					],
					"disabled": 0,
					"hidden": 0,
					"midpoints": [
						746.166748,
						716.2,
						748.666748,
						716.2
					],
					"source": [
						"obj-82",
						0
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-65",
						0
					],
					"disabled": 0,
					"hidden": 0,
					"source": [
						"obj-85",
						0
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-85",
						0
					],
					"disabled": 0,
					"hidden": 0,
					"midpoints": [
						837.333374,
						1136.8,
						812.833313,
						1136.8,
						812.833313,
						942.4,
						837.333374,
						942.4
					],
					"source": [
						"obj-86",
						0
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-86",
						0
					],
					"disabled": 0,
					"hidden": 0,
					"source": [
						"obj-87",
						0
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-12",
						0
					],
					"disabled": 0,
					"hidden": 0,
					"source": [
						"obj-88",
						0
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-7",
						0
					],
					"disabled": 0,
					"hidden": 0,
					"source": [
						"obj-9",
						0
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-167",
						0
					],
					"disabled": 0,
					"hidden": 0,
					"source": [
						"obj-90",
						0
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-169",
						0
					],
					"disabled": 0,
					"hidden": 0,
					"source": [
						"obj-91",
						0
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-94",
						0
					],
					"disabled": 0,
					"hidden": 0,
					"midpoints": [
						4196.333008,
						664.0,
						4181.333008,
						664.0,
						4181.333008,
						565.0,
						4196.333008,
						565.0
					],
					"source": [
						"obj-92",
						0
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-122",
						0
					],
					"disabled": 0,
					"hidden": 0,
					"source": [
						"obj-93",
						0
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-60",
						0
					],
					"disabled": 0,
					"hidden": 0,
					"source": [
						"obj-94",
						0
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-93",
						0
					],
					"disabled": 0,
					"hidden": 0,
					"source": [
						"obj-95",
						0
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-207",
						0
					],
					"disabled": 0,
					"hidden": 0,
					"source": [
						"obj-96",
						0
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-201",
						1
					],
					"disabled": 0,
					"hidden": 0,
					"source": [
						"obj-99",
						1
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-201",
						0
					],
					"disabled": 0,
					"hidden": 0,
					"source": [
						"obj-99",
						0
					]
				}
			}
		],
		"styles": [
			{
				"name": "Jamoma_highlighted_orange",
				"default": {
					"accentcolor": [
						1.0,
						0.5,
						0.0,
						1.0
					]
				},
				"parentstyle": "",
				"multi": 0
			}
		]
	}
}
