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
   1156.9,
   1554.0
  ],
  "boxes": [
   {
    "box": {
     "id": "m",
     "maxclass": "newobj",
     "text": "j.model pm",
     "numinlets": 1,
     "numoutlets": 2,
     "outlettype": [
      "",
      ""
     ],
     "patching_rect": [
      570.5,
      1182.0,
      88.0,
      22.0
     ]
    }
   },
   {
    "box": {
     "id": "pa",
     "maxclass": "newobj",
     "text": "j.parameter a @type integer @default 1",
     "numinlets": 1,
     "numoutlets": 2,
     "outlettype": [
      "",
      ""
     ],
     "patching_rect": [
      30.0,
      286.0,
      272.8,
      22.0
     ]
    }
   },
   {
    "box": {
     "id": "pb",
     "maxclass": "newobj",
     "text": "j.parameter b @type integer @default 2",
     "numinlets": 1,
     "numoutlets": 2,
     "outlettype": [
      "",
      ""
     ],
     "patching_rect": [
      326.8,
      414.0,
      272.8,
      22.0
     ]
    }
   },
   {
    "box": {
     "id": "ji",
     "maxclass": "newobj",
     "text": "j.init",
     "numinlets": 1,
     "numoutlets": 2,
     "outlettype": [
      "",
      ""
     ],
     "patching_rect": [
      30.0,
      30.0,
      61.6,
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
      951.6,
      1310.0,
      114.4,
      22.0
     ]
    }
   },
   {
    "box": {
     "id": "s0",
     "maxclass": "message",
     "text": "preset:new one",
     "numinlets": 2,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      30.0,
      94.0,
      114.4,
      22.0
     ]
    }
   },
   {
    "box": {
     "id": "d0",
     "maxclass": "newobj",
     "text": "delay 60",
     "numinlets": 2,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      30.0,
      158.0,
      74.8,
      22.0
     ]
    }
   },
   {
    "box": {
     "id": "s1",
     "maxclass": "message",
     "text": "11",
     "numinlets": 2,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      30.0,
      222.0,
      40.0,
      22.0
     ]
    }
   },
   {
    "box": {
     "id": "d1",
     "maxclass": "newobj",
     "text": "delay 60",
     "numinlets": 2,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      326.8,
      286.0,
      74.8,
      22.0
     ]
    }
   },
   {
    "box": {
     "id": "s2",
     "maxclass": "message",
     "text": "22",
     "numinlets": 2,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      326.8,
      350.0,
      40.0,
      22.0
     ]
    }
   },
   {
    "box": {
     "id": "d2",
     "maxclass": "newobj",
     "text": "delay 60",
     "numinlets": 2,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      623.6,
      414.0,
      74.8,
      22.0
     ]
    }
   },
   {
    "box": {
     "id": "s3",
     "maxclass": "message",
     "text": "preset:new two",
     "numinlets": 2,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      623.6,
      478.0,
      114.4,
      22.0
     ]
    }
   },
   {
    "box": {
     "id": "d3",
     "maxclass": "newobj",
     "text": "delay 60",
     "numinlets": 2,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      623.6,
      542.0,
      74.8,
      22.0
     ]
    }
   },
   {
    "box": {
     "id": "s4",
     "maxclass": "message",
     "text": "preset one",
     "numinlets": 2,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      623.6,
      606.0,
      88.0,
      22.0
     ]
    }
   },
   {
    "box": {
     "id": "d4",
     "maxclass": "newobj",
     "text": "delay 60",
     "numinlets": 2,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      623.6,
      670.0,
      74.8,
      22.0
     ]
    }
   },
   {
    "box": {
     "id": "s5",
     "maxclass": "message",
     "text": "bang",
     "numinlets": 2,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      623.6,
      734.0,
      48.4,
      22.0
     ]
    }
   },
   {
    "box": {
     "id": "d5",
     "maxclass": "newobj",
     "text": "delay 60",
     "numinlets": 2,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      623.6,
      798.0,
      74.8,
      22.0
     ]
    }
   },
   {
    "box": {
     "id": "s6",
     "maxclass": "message",
     "text": "preset:interpolate one two 0.5",
     "numinlets": 2,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      623.6,
      862.0,
      220.0,
      22.0
     ]
    }
   },
   {
    "box": {
     "id": "d6",
     "maxclass": "newobj",
     "text": "delay 60",
     "numinlets": 2,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      623.6,
      926.0,
      74.8,
      22.0
     ]
    }
   },
   {
    "box": {
     "id": "s7",
     "maxclass": "message",
     "text": "bang",
     "numinlets": 2,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      623.6,
      990.0,
      48.4,
      22.0
     ]
    }
   },
   {
    "box": {
     "id": "d7",
     "maxclass": "newobj",
     "text": "delay 60",
     "numinlets": 2,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      623.6,
      1054.0,
      74.8,
      22.0
     ]
    }
   },
   {
    "box": {
     "id": "s8",
     "maxclass": "message",
     "text": "preset:names",
     "numinlets": 2,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      951.6,
      1118.0,
      101.2,
      22.0
     ]
    }
   },
   {
    "box": {
     "id": "d8",
     "maxclass": "newobj",
     "text": "delay 60",
     "numinlets": 2,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      951.6,
      1182.0,
      74.8,
      22.0
     ]
    }
   },
   {
    "box": {
     "id": "ia0",
     "maxclass": "newobj",
     "text": "int",
     "numinlets": 2,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      376.2,
      862.0,
      41.8,
      22.0
     ]
    }
   },
   {
    "box": {
     "id": "ib0",
     "maxclass": "newobj",
     "text": "int",
     "numinlets": 2,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      524.6,
      862.0,
      41.8,
      22.0
     ]
    }
   },
   {
    "box": {
     "id": "t0",
     "maxclass": "newobj",
     "text": "t b b",
     "numinlets": 1,
     "numoutlets": 2,
     "outlettype": [
      "",
      ""
     ],
     "patching_rect": [
      722.4,
      798.0,
      55.0,
      22.0
     ]
    }
   },
   {
    "box": {
     "id": "ex0",
     "maxclass": "newobj",
     "text": "expr $i1*10+$i2",
     "numinlets": 2,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      450.4,
      926.0,
      121.0,
      22.0
     ]
    }
   },
   {
    "box": {
     "id": "eq0",
     "maxclass": "newobj",
     "text": "== 12",
     "numinlets": 1,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      450.4,
      990.0,
      55.0,
      22.0
     ]
    }
   },
   {
    "box": {
     "id": "x0",
     "maxclass": "newobj",
     "text": "test.assert JamomaMax3/model_presets/recall_restores_values",
     "numinlets": 1,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      450.4,
      1118.0,
      411.4,
      22.0
     ]
    }
   },
   {
    "box": {
     "id": "ia1",
     "maxclass": "newobj",
     "text": "int",
     "numinlets": 2,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      376.2,
      1118.0,
      41.8,
      22.0
     ]
    }
   },
   {
    "box": {
     "id": "ib1",
     "maxclass": "newobj",
     "text": "int",
     "numinlets": 2,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      885.8,
      1118.0,
      41.8,
      22.0
     ]
    }
   },
   {
    "box": {
     "id": "t1",
     "maxclass": "newobj",
     "text": "t b b",
     "numinlets": 1,
     "numoutlets": 2,
     "outlettype": [
      "",
      ""
     ],
     "patching_rect": [
      722.4,
      1054.0,
      55.0,
      22.0
     ]
    }
   },
   {
    "box": {
     "id": "ex1",
     "maxclass": "newobj",
     "text": "expr $i1*10+$i2",
     "numinlets": 2,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      682.5,
      1182.0,
      121.0,
      22.0
     ]
    }
   },
   {
    "box": {
     "id": "eq1",
     "maxclass": "newobj",
     "text": "== 72",
     "numinlets": 1,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      735.3,
      1246.0,
      55.0,
      22.0
     ]
    }
   },
   {
    "box": {
     "id": "x1",
     "maxclass": "newobj",
     "text": "test.assert JamomaMax3/model_presets/interpolate_halfway",
     "numinlets": 1,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      735.3,
      1374.0,
      391.6,
      22.0
     ]
    }
   },
   {
    "box": {
     "id": "rt",
     "maxclass": "newobj",
     "text": "route preset:names",
     "numinlets": 2,
     "numoutlets": 2,
     "outlettype": [
      "",
      ""
     ],
     "patching_rect": [
      570.5,
      1246.0,
      140.8,
      22.0
     ]
    }
   },
   {
    "box": {
     "id": "zn",
     "maxclass": "newobj",
     "text": "zl len",
     "numinlets": 2,
     "numoutlets": 2,
     "outlettype": [
      "",
      ""
     ],
     "patching_rect": [
      570.5,
      1310.0,
      61.6,
      22.0
     ]
    }
   },
   {
    "box": {
     "id": "e2",
     "maxclass": "newobj",
     "text": "== 2",
     "numinlets": 1,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      570.5,
      1374.0,
      48.4,
      22.0
     ]
    }
   },
   {
    "box": {
     "id": "asn",
     "maxclass": "newobj",
     "text": "test.assert JamomaMax3/model_presets/names_listed",
     "numinlets": 1,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      570.5,
      1502.0,
      345.4,
      22.0
     ]
    }
   },
   {
    "box": {
     "id": "dend",
     "maxclass": "newobj",
     "text": "delay 300",
     "numinlets": 2,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      951.6,
      1246.0,
      81.4,
      22.0
     ]
    }
   },
   {
    "box": {
     "id": "tg_x0",
     "maxclass": "toggle",
     "numinlets": 1,
     "numoutlets": 1,
     "outlettype": [
      "int"
     ],
     "parameter_enable": 0,
     "patching_rect": [
      450.4,
      1054.0,
      24.0,
      24.0
     ]
    }
   },
   {
    "box": {
     "id": "tg_x1",
     "maxclass": "toggle",
     "numinlets": 1,
     "numoutlets": 1,
     "outlettype": [
      "int"
     ],
     "parameter_enable": 0,
     "patching_rect": [
      735.3,
      1310.0,
      24.0,
      24.0
     ]
    }
   },
   {
    "box": {
     "id": "tg_asn",
     "maxclass": "toggle",
     "numinlets": 1,
     "numoutlets": 1,
     "outlettype": [
      "int"
     ],
     "parameter_enable": 0,
     "patching_rect": [
      570.5,
      1438.0,
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
      "m",
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
      "d0",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "d0",
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
      "pa",
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
      "pb",
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
      "s3",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "s3",
      0
     ],
     "destination": [
      "m",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "s3",
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
      "s4",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "s4",
      0
     ],
     "destination": [
      "m",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "s4",
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
      "s5",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "s5",
      0
     ],
     "destination": [
      "t0",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "s5",
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
      "s6",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "s6",
      0
     ],
     "destination": [
      "m",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "s6",
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
      "s7",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "s7",
      0
     ],
     "destination": [
      "t1",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "s7",
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
      "s8",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "s8",
      0
     ],
     "destination": [
      "m",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "s8",
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
      "pa",
      0
     ],
     "destination": [
      "ia0",
      1
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "pb",
      0
     ],
     "destination": [
      "ib0",
      1
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "t0",
      1
     ],
     "destination": [
      "ib0",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "t0",
      0
     ],
     "destination": [
      "ia0",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "ib0",
      0
     ],
     "destination": [
      "ex0",
      1
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "ia0",
      0
     ],
     "destination": [
      "ex0",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "ex0",
      0
     ],
     "destination": [
      "eq0",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "eq0",
      0
     ],
     "destination": [
      "tg_x0",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "pa",
      0
     ],
     "destination": [
      "ia1",
      1
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "pb",
      0
     ],
     "destination": [
      "ib1",
      1
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "t1",
      1
     ],
     "destination": [
      "ib1",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "t1",
      0
     ],
     "destination": [
      "ia1",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "ib1",
      0
     ],
     "destination": [
      "ex1",
      1
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "ia1",
      0
     ],
     "destination": [
      "ex1",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "ex1",
      0
     ],
     "destination": [
      "eq1",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "eq1",
      0
     ],
     "destination": [
      "tg_x1",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "m",
      1
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
      "zn",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "zn",
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
      "tg_asn",
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
      "dend",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "dend",
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
      "tg_x0",
      0
     ],
     "destination": [
      "x0",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "tg_x1",
      0
     ],
     "destination": [
      "x1",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "tg_asn",
      0
     ],
     "destination": [
      "asn",
      0
     ]
    }
   }
  ]
 }
}
