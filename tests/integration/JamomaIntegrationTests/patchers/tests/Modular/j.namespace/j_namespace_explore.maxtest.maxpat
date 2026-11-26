{
 "patcher": {
  "fileversion": 1,
  "appversion": {
   "major": 9,
   "minor": 2,
   "revision": 2,
   "architecture": "x64",
   "modernui": 1
  },
  "classnamespace": "box",
  "rect": [
   34.0,
   96.0,
   2945.2,
   658.0
  ],
  "boxes": [
   {
    "box": {
     "id": "m",
     "maxclass": "newobj",
     "numinlets": 1,
     "numoutlets": 2,
     "outlettype": [
      "",
      ""
     ],
     "patching_rect": [
      30.0,
      30.0,
      88.0,
      22.0
     ],
     "text": "j.model pm"
    }
   },
   {
    "box": {
     "id": "pa",
     "maxclass": "newobj",
     "numinlets": 1,
     "numoutlets": 2,
     "outlettype": [
      "",
      ""
     ],
     "patching_rect": [
      142.0,
      30.0,
      299.2,
      22.0
     ],
     "text": "j.parameter alpha @type integer @default 1"
    }
   },
   {
    "box": {
     "id": "pb",
     "maxclass": "newobj",
     "numinlets": 1,
     "numoutlets": 2,
     "outlettype": [
      "",
      ""
     ],
     "patching_rect": [
      465.2,
      30.0,
      292.6,
      22.0
     ],
     "text": "j.parameter beta @type integer @default 2"
    }
   },
   {
    "box": {
     "id": "ji",
     "maxclass": "newobj",
     "numinlets": 1,
     "numoutlets": 2,
     "outlettype": [
      "",
      ""
     ],
     "patching_rect": [
      781.8,
      30.0,
      61.6,
      22.0
     ],
     "text": "j.init"
    }
   },
   {
    "box": {
     "id": "nc",
     "maxclass": "newobj",
     "numinlets": 1,
     "numoutlets": 3,
     "outlettype": [
      "",
      "",
      ""
     ],
     "patching_rect": [
      781.8,
      158.0,
      292.6,
      22.0
     ],
     "text": "j.namespace @address /pm @output children"
    }
   },
   {
    "box": {
     "id": "na",
     "maxclass": "newobj",
     "numinlets": 1,
     "numoutlets": 3,
     "outlettype": [
      "",
      "",
      ""
     ],
     "patching_rect": [
      1098.4,
      158.0,
      345.4,
      22.0
     ],
     "text": "j.namespace @address /pm/alpha @output attributes"
    }
   },
   {
    "box": {
     "id": "nm",
     "maxclass": "newobj",
     "numinlets": 1,
     "numoutlets": 3,
     "outlettype": [
      "",
      "",
      ""
     ],
     "patching_rect": [
      1467.8,
      286.0,
      206.8,
      22.0
     ],
     "text": "j.namespace @output children"
    }
   },
   {
    "box": {
     "id": "nc_sz",
     "maxclass": "newobj",
     "numinlets": 2,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      1240.2,
      414.0,
      41.8,
      22.0
     ],
     "text": "int"
    }
   },
   {
    "box": {
     "id": "na_sz",
     "maxclass": "newobj",
     "numinlets": 2,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      1398.5,
      414.0,
      41.8,
      22.0
     ],
     "text": "int"
    }
   },
   {
    "box": {
     "id": "nm_sz",
     "maxclass": "newobj",
     "numinlets": 2,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      1583.2,
      414.0,
      41.8,
      22.0
     ],
     "text": "int"
    }
   },
   {
    "box": {
     "id": "ra",
     "maxclass": "newobj",
     "numinlets": 1,
     "numoutlets": 2,
     "outlettype": [
      "",
      ""
     ],
     "patching_rect": [
      781.8,
      222.0,
      94.6,
      22.0
     ],
     "text": "route alpha"
    }
   },
   {
    "box": {
     "id": "sb",
     "maxclass": "newobj",
     "numinlets": 1,
     "numoutlets": 2,
     "outlettype": [
      "",
      ""
     ],
     "patching_rect": [
      781.8,
      286.0,
      74.8,
      22.0
     ],
     "text": "sel beta"
    }
   },
   {
    "box": {
     "id": "one",
     "maxclass": "message",
     "numinlets": 2,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      781.8,
      350.0,
      40.0,
      22.0
     ],
     "text": "1"
    }
   },
   {
    "box": {
     "id": "e2",
     "maxclass": "newobj",
     "numinlets": 2,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      1382.2,
      478.0,
      48.4,
      22.0
     ],
     "text": "== 2"
    }
   },
   {
    "box": {
     "id": "g10",
     "maxclass": "newobj",
     "numinlets": 2,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      1454.6,
      478.0,
      48.4,
      22.0
     ],
     "text": "> 10"
    }
   },
   {
    "box": {
     "id": "e2m",
     "maxclass": "newobj",
     "numinlets": 2,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      1583.2,
      478.0,
      48.4,
      22.0
     ],
     "text": "== 2"
    }
   },
   {
    "box": {
     "id": "a_list",
     "maxclass": "newobj",
     "numinlets": 1,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      781.8,
      478.0,
      576.4,
      22.0
     ],
     "text": "test.assert Jamoma/Modular/j.namespace/explore/children_list_the_parameters_in_order"
    }
   },
   {
    "box": {
     "id": "a_size",
     "maxclass": "newobj",
     "numinlets": 1,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      1382.2,
      606.0,
      510.4,
      22.0
     ],
     "text": "test.assert Jamoma/Modular/j.namespace/explore/size_is_the_number_of_items"
    }
   },
   {
    "box": {
     "id": "a_attr",
     "maxclass": "newobj",
     "numinlets": 1,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      1916.6,
      606.0,
      464.2,
      22.0
     ],
     "text": "test.assert Jamoma/Modular/j.namespace/explore/attributes_of_a_node"
    }
   },
   {
    "box": {
     "id": "a_msg",
     "maxclass": "newobj",
     "numinlets": 1,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      2404.8,
      606.0,
      510.4,
      22.0
     ],
     "text": "test.assert Jamoma/Modular/j.namespace/explore/an_address_message_explores"
    }
   },
   {
    "box": {
     "id": "s0",
     "maxclass": "message",
     "numinlets": 2,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      781.8,
      94.0,
      48.4,
      22.0
     ],
     "text": "bang"
    }
   },
   {
    "box": {
     "id": "sd0",
     "maxclass": "newobj",
     "numinlets": 2,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      1467.8,
      158.0,
      74.8,
      22.0
     ],
     "text": "delay 60"
    }
   },
   {
    "box": {
     "id": "s1",
     "maxclass": "message",
     "numinlets": 2,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      1467.8,
      222.0,
      41.8,
      22.0
     ],
     "text": "/pm"
    }
   },
   {
    "box": {
     "id": "sd1",
     "maxclass": "newobj",
     "numinlets": 2,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      1698.6,
      286.0,
      74.8,
      22.0
     ],
     "text": "delay 60"
    }
   },
   {
    "box": {
     "id": "s2",
     "maxclass": "message",
     "numinlets": 2,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      1698.6,
      350.0,
      48.4,
      22.0
     ],
     "text": "bang"
    }
   },
   {
    "box": {
     "id": "sd2",
     "maxclass": "newobj",
     "numinlets": 2,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      1698.6,
      414.0,
      74.8,
      22.0
     ],
     "text": "delay 60"
    }
   },
   {
    "box": {
     "id": "send",
     "maxclass": "newobj",
     "numinlets": 2,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      1698.6,
      478.0,
      81.4,
      22.0
     ],
     "text": "delay 300"
    }
   },
   {
    "box": {
     "id": "sterm",
     "maxclass": "newobj",
     "numinlets": 1,
     "numoutlets": 0,
     "outlettype": [],
     "patching_rect": [
      1698.6,
      542.0,
      114.4,
      22.0
     ],
     "text": "test.terminate"
    }
   },
   {
    "box": {
     "id": "tg_a_list",
     "maxclass": "toggle",
     "numinlets": 1,
     "numoutlets": 1,
     "outlettype": [
      "int"
     ],
     "parameter_enable": 0,
     "patching_rect": [
      781.8,
      414.0,
      24.0,
      24.0
     ]
    }
   },
   {
    "box": {
     "id": "tg_a_size",
     "maxclass": "toggle",
     "numinlets": 1,
     "numoutlets": 1,
     "outlettype": [
      "int"
     ],
     "parameter_enable": 0,
     "patching_rect": [
      1382.2,
      542.0,
      24.0,
      24.0
     ]
    }
   },
   {
    "box": {
     "id": "tg_a_attr",
     "maxclass": "toggle",
     "numinlets": 1,
     "numoutlets": 1,
     "outlettype": [
      "int"
     ],
     "parameter_enable": 0,
     "patching_rect": [
      1916.6,
      542.0,
      24.0,
      24.0
     ]
    }
   },
   {
    "box": {
     "id": "tg_a_msg",
     "maxclass": "toggle",
     "numinlets": 1,
     "numoutlets": 1,
     "outlettype": [
      "int"
     ],
     "parameter_enable": 0,
     "patching_rect": [
      2404.8,
      542.0,
      24.0,
      24.0
     ]
    }
   }
  ],
  "lines": [
   {
    "patchline": {
     "source": [
      "nc",
      1
     ],
     "destination": [
      "nc_sz",
      1
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "na",
      1
     ],
     "destination": [
      "na_sz",
      1
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "nm",
      1
     ],
     "destination": [
      "nm_sz",
      1
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "nc",
      0
     ],
     "destination": [
      "ra",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "ra",
      0
     ],
     "destination": [
      "sb",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "sb",
      0
     ],
     "destination": [
      "one",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "nc_sz",
      0
     ],
     "destination": [
      "e2",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "na_sz",
      0
     ],
     "destination": [
      "g10",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "nm_sz",
      0
     ],
     "destination": [
      "e2m",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "one",
      0
     ],
     "destination": [
      "tg_a_list",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "e2",
      0
     ],
     "destination": [
      "tg_a_size",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "g10",
      0
     ],
     "destination": [
      "tg_a_attr",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "e2m",
      0
     ],
     "destination": [
      "tg_a_msg",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "ji",
      1
     ],
     "destination": [
      "s0",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "s0",
      0
     ],
     "destination": [
      "nc",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "s0",
      0
     ],
     "destination": [
      "na",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "s0",
      0
     ],
     "destination": [
      "sd0",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "sd0",
      0
     ],
     "destination": [
      "s1",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "s1",
      0
     ],
     "destination": [
      "nm",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "s1",
      0
     ],
     "destination": [
      "sd1",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "sd1",
      0
     ],
     "destination": [
      "s2",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "s2",
      0
     ],
     "destination": [
      "nc_sz",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "s2",
      0
     ],
     "destination": [
      "na_sz",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "s2",
      0
     ],
     "destination": [
      "nm_sz",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "s2",
      0
     ],
     "destination": [
      "sd2",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "sd2",
      0
     ],
     "destination": [
      "send",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "send",
      0
     ],
     "destination": [
      "sterm",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "tg_a_list",
      0
     ],
     "destination": [
      "a_list",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "tg_a_size",
      0
     ],
     "destination": [
      "a_size",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "tg_a_attr",
      0
     ],
     "destination": [
      "a_attr",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "tg_a_msg",
      0
     ],
     "destination": [
      "a_msg",
      0
     ]
    }
   }
  ]
 }
}
