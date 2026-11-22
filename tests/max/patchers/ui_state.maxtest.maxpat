{
 "patcher": {
  "fileversion": 1,
  "appversion": {
   "major": 9,
   "minor": 0,
   "revision": 0,
   "architecture": "x64",
   "modernui": 1
  },
  "classnamespace": "box",
  "rect": [
   60.0,
   60.0,
   1613.5,
   1106.0
  ],
  "boxes": [
   {
    "box": {
     "id": "vw",
     "maxclass": "newobj",
     "text": "vu.view",
     "numinlets": 1,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      756.7,
      734.0,
      68.2,
      22.0
     ]
    }
   },
   {
    "box": {
     "id": "tp",
     "maxclass": "newobj",
     "text": "thispatcher",
     "numinlets": 1,
     "numoutlets": 2,
     "outlettype": [
      "",
      ""
     ],
     "patching_rect": [
      557.2,
      670.0,
      94.6,
      22.0
     ]
    }
   },
   {
    "box": {
     "id": "lb",
     "maxclass": "newobj",
     "text": "loadbang",
     "numinlets": 1,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      30.0,
      30.0,
      74.8,
      22.0
     ]
    }
   },
   {
    "box": {
     "id": "d1",
     "maxclass": "newobj",
     "text": "delay 200",
     "numinlets": 2,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      30.0,
      94.0,
      81.4,
      22.0
     ]
    }
   },
   {
    "box": {
     "id": "mk",
     "maxclass": "message",
     "text": "script newdefault m1 30 500 vu.model",
     "numinlets": 2,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      30.0,
      158.0,
      259.6,
      22.0
     ]
    }
   },
   {
    "box": {
     "id": "d2",
     "maxclass": "newobj",
     "text": "delay 400",
     "numinlets": 2,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      313.6,
      158.0,
      81.4,
      22.0
     ]
    }
   },
   {
    "box": {
     "id": "dump1",
     "maxclass": "message",
     "text": "dump",
     "numinlets": 2,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      313.6,
      222.0,
      48.4,
      22.0
     ]
    }
   },
   {
    "box": {
     "id": "d3",
     "maxclass": "newobj",
     "text": "delay 200",
     "numinlets": 2,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      386.0,
      222.0,
      81.4,
      22.0
     ]
    }
   },
   {
    "box": {
     "id": "n1",
     "maxclass": "message",
     "text": "preset:new x",
     "numinlets": 2,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      386.0,
      286.0,
      101.2,
      22.0
     ]
    }
   },
   {
    "box": {
     "id": "d3b",
     "maxclass": "newobj",
     "text": "delay 100",
     "numinlets": 2,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      511.2,
      286.0,
      81.4,
      22.0
     ]
    }
   },
   {
    "box": {
     "id": "n2",
     "maxclass": "message",
     "text": "preset:new y",
     "numinlets": 2,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      511.2,
      350.0,
      101.2,
      22.0
     ]
    }
   },
   {
    "box": {
     "id": "d4",
     "maxclass": "newobj",
     "text": "delay 200",
     "numinlets": 2,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      636.4,
      350.0,
      81.4,
      22.0
     ]
    }
   },
   {
    "box": {
     "id": "dump2",
     "maxclass": "message",
     "text": "dump",
     "numinlets": 2,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      636.4,
      414.0,
      48.4,
      22.0
     ]
    }
   },
   {
    "box": {
     "id": "d5",
     "maxclass": "newobj",
     "text": "delay 200",
     "numinlets": 2,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      708.8,
      414.0,
      81.4,
      22.0
     ]
    }
   },
   {
    "box": {
     "id": "rm",
     "maxclass": "message",
     "text": "script delete m1",
     "numinlets": 2,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      708.8,
      478.0,
      127.6,
      22.0
     ]
    }
   },
   {
    "box": {
     "id": "d6",
     "maxclass": "newobj",
     "text": "delay 300",
     "numinlets": 2,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      860.4,
      478.0,
      81.4,
      22.0
     ]
    }
   },
   {
    "box": {
     "id": "dump3",
     "maxclass": "message",
     "text": "dump",
     "numinlets": 2,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      860.4,
      542.0,
      48.4,
      22.0
     ]
    }
   },
   {
    "box": {
     "id": "d7",
     "maxclass": "newobj",
     "text": "delay 200",
     "numinlets": 2,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      932.8,
      542.0,
      81.4,
      22.0
     ]
    }
   },
   {
    "box": {
     "id": "mk2",
     "maxclass": "message",
     "text": "script newdefault m2 30 600 vu.model",
     "numinlets": 2,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      932.8,
      606.0,
      259.6,
      22.0
     ]
    }
   },
   {
    "box": {
     "id": "d8",
     "maxclass": "newobj",
     "text": "delay 400",
     "numinlets": 2,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      1216.4,
      606.0,
      81.4,
      22.0
     ]
    }
   },
   {
    "box": {
     "id": "dump4",
     "maxclass": "message",
     "text": "dump",
     "numinlets": 2,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      1216.4,
      670.0,
      48.4,
      22.0
     ]
    }
   },
   {
    "box": {
     "id": "d9",
     "maxclass": "newobj",
     "text": "delay 300",
     "numinlets": 2,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      1288.8,
      670.0,
      81.4,
      22.0
     ]
    }
   },
   {
    "box": {
     "id": "term",
     "maxclass": "newobj",
     "text": "test.terminate",
     "numinlets": 1,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      1288.8,
      734.0,
      114.4,
      22.0
     ]
    }
   },
   {
    "box": {
     "id": "rt",
     "maxclass": "newobj",
     "text": "route model:address model:waiting preset:count",
     "numinlets": 4,
     "numoutlets": 4,
     "outlettype": [
      "",
      "",
      "",
      ""
     ],
     "patching_rect": [
      756.7,
      798.0,
      325.6,
      22.0
     ]
    }
   },
   {
    "box": {
     "id": "sa",
     "maxclass": "newobj",
     "text": "sel /vu",
     "numinlets": 2,
     "numoutlets": 2,
     "outlettype": [
      "",
      ""
     ],
     "patching_rect": [
      756.7,
      862.0,
      68.2,
      22.0
     ]
    }
   },
   {
    "box": {
     "id": "one",
     "maxclass": "message",
     "text": "1",
     "numinlets": 2,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      756.7,
      926.0,
      40.0,
      22.0
     ]
    }
   },
   {
    "box": {
     "id": "as1",
     "maxclass": "newobj",
     "text": "test.assert JamomaMax3/ui_state/reports_its_model",
     "numinlets": 1,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      756.7,
      1054.0,
      345.4,
      22.0
     ]
    }
   },
   {
    "box": {
     "id": "bg",
     "maxclass": "message",
     "text": "1",
     "numinlets": 2,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      848.9,
      862.0,
      40.0,
      22.0
     ]
    }
   },
   {
    "box": {
     "id": "as2",
     "maxclass": "newobj",
     "text": "test.assert JamomaMax3/ui_state/reports_waiting",
     "numinlets": 1,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      848.9,
      990.0,
      332.2,
      22.0
     ]
    }
   },
   {
    "box": {
     "id": "zl",
     "maxclass": "newobj",
     "text": "sel 2",
     "numinlets": 2,
     "numoutlets": 2,
     "outlettype": [
      "",
      ""
     ],
     "patching_rect": [
      912.9,
      862.0,
      55.0,
      22.0
     ]
    }
   },
   {
    "box": {
     "id": "e2",
     "maxclass": "message",
     "text": "1",
     "numinlets": 2,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      912.9,
      926.0,
      40.0,
      22.0
     ]
    }
   },
   {
    "box": {
     "id": "as3",
     "maxclass": "newobj",
     "text": "test.assert JamomaMax3/ui_state/lists_the_preset_names",
     "numinlets": 1,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      1205.1,
      1054.0,
      378.4,
      22.0
     ]
    }
   },
   {
    "box": {
     "id": "vm",
     "maxclass": "newobj",
     "text": "s vu_model_in",
     "numinlets": 1,
     "numoutlets": 0,
     "outlettype": [],
     "patching_rect": [
      448.6,
      414.0,
      107.8,
      22.0
     ]
    }
   },
   {
    "box": {
     "id": "tg_as1",
     "maxclass": "toggle",
     "numinlets": 1,
     "numoutlets": 1,
     "outlettype": [
      "int"
     ],
     "parameter_enable": 0,
     "patching_rect": [
      756.7,
      990.0,
      24.0,
      24.0
     ]
    }
   },
   {
    "box": {
     "id": "tg_as2",
     "maxclass": "toggle",
     "numinlets": 1,
     "numoutlets": 1,
     "outlettype": [
      "int"
     ],
     "parameter_enable": 0,
     "patching_rect": [
      848.9,
      926.0,
      24.0,
      24.0
     ]
    }
   },
   {
    "box": {
     "id": "tg_as3",
     "maxclass": "toggle",
     "numinlets": 1,
     "numoutlets": 1,
     "outlettype": [
      "int"
     ],
     "parameter_enable": 0,
     "patching_rect": [
      1205.1,
      990.0,
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
      "lb",
      0
     ],
     "destination": [
      "d1",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "d1",
      0
     ],
     "destination": [
      "mk",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "mk",
      0
     ],
     "destination": [
      "tp",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "d1",
      0
     ],
     "destination": [
      "d2",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "d2",
      0
     ],
     "destination": [
      "dump1",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "dump1",
      0
     ],
     "destination": [
      "vw",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "d2",
      0
     ],
     "destination": [
      "d3",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "d3",
      0
     ],
     "destination": [
      "n1",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "n1",
      0
     ],
     "destination": [
      "vm",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "n2",
      0
     ],
     "destination": [
      "vm",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "d3",
      0
     ],
     "destination": [
      "d3b",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "d3b",
      0
     ],
     "destination": [
      "n2",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "d3b",
      0
     ],
     "destination": [
      "d4",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "d4",
      0
     ],
     "destination": [
      "dump2",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "dump2",
      0
     ],
     "destination": [
      "vw",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "d4",
      0
     ],
     "destination": [
      "d5",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "d5",
      0
     ],
     "destination": [
      "rm",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "rm",
      0
     ],
     "destination": [
      "tp",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "d5",
      0
     ],
     "destination": [
      "d6",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "d6",
      0
     ],
     "destination": [
      "dump3",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "dump3",
      0
     ],
     "destination": [
      "vw",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "d6",
      0
     ],
     "destination": [
      "d7",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "d7",
      0
     ],
     "destination": [
      "mk2",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "mk2",
      0
     ],
     "destination": [
      "tp",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "d7",
      0
     ],
     "destination": [
      "d8",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "d8",
      0
     ],
     "destination": [
      "dump4",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "dump4",
      0
     ],
     "destination": [
      "vw",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "d8",
      0
     ],
     "destination": [
      "d9",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "d9",
      0
     ],
     "destination": [
      "term",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "vw",
      0
     ],
     "destination": [
      "rt",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "rt",
      0
     ],
     "destination": [
      "sa",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "sa",
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
      "one",
      0
     ],
     "destination": [
      "tg_as1",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "rt",
      1
     ],
     "destination": [
      "bg",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "bg",
      0
     ],
     "destination": [
      "tg_as2",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "rt",
      2
     ],
     "destination": [
      "zl",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "zl",
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
      "e2",
      0
     ],
     "destination": [
      "tg_as3",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "tg_as1",
      0
     ],
     "destination": [
      "as1",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "tg_as2",
      0
     ],
     "destination": [
      "as2",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "tg_as3",
      0
     ],
     "destination": [
      "as3",
      0
     ]
    }
   }
  ]
 }
}
