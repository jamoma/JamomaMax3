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
   1507.2,
   658.0
  ],
  "boxes": [
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
     "id": "d0",
     "maxclass": "newobj",
     "text": "delay 500",
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
     "id": "t",
     "maxclass": "newobj",
     "text": "t b b b",
     "numinlets": 1,
     "numoutlets": 3,
     "outlettype": [
      "",
      "",
      ""
     ],
     "patching_rect": [
      30.0,
      158.0,
      68.2,
      22.0
     ]
    }
   },
   {
    "box": {
     "id": "m1",
     "maxclass": "message",
     "text": "-6.",
     "numinlets": 2,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      214.4,
      222.0,
      41.8,
      22.0
     ]
    }
   },
   {
    "box": {
     "id": "u1",
     "maxclass": "newobj",
     "text": "j.unit @dataspace gain @input db @output linear",
     "numinlets": 1,
     "numoutlets": 2,
     "outlettype": [
      "",
      ""
     ],
     "patching_rect": [
      610.4,
      286.0,
      332.2,
      22.0
     ]
    }
   },
   {
    "box": {
     "id": "c1",
     "maxclass": "newobj",
     "text": "expr ($f1-0.501187)<0.000001 && ($f1-0.501187)>-0.000001",
     "numinlets": 1,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      762.2,
      350.0,
      391.6,
      22.0
     ]
    }
   },
   {
    "box": {
     "id": "a1",
     "maxclass": "newobj",
     "text": "test.assert JamomaMax3/unit_basic/gain_db_to_linear",
     "numinlets": 1,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      1118.6,
      478.0,
      358.6,
      22.0
     ]
    }
   },
   {
    "box": {
     "id": "m2",
     "maxclass": "message",
     "text": "100.",
     "numinlets": 2,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      142.0,
      222.0,
      48.4,
      22.0
     ]
    }
   },
   {
    "box": {
     "id": "u2",
     "maxclass": "newobj",
     "text": "j.unit @input C @output F",
     "numinlets": 1,
     "numoutlets": 2,
     "outlettype": [
      "",
      ""
     ],
     "patching_rect": [
      399.4,
      286.0,
      187.0,
      22.0
     ]
    }
   },
   {
    "box": {
     "id": "c2",
     "maxclass": "newobj",
     "text": "expr ($f1-212.)<0.000001 && ($f1-212.)>-0.000001",
     "numinlets": 1,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      399.4,
      350.0,
      338.8,
      22.0
     ]
    }
   },
   {
    "box": {
     "id": "a2",
     "maxclass": "newobj",
     "text": "test.assert JamomaMax3/unit_basic/default_dataspace_is_temperature",
     "numinlets": 1,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      637.0,
      478.0,
      457.6,
      22.0
     ]
    }
   },
   {
    "box": {
     "id": "m3",
     "maxclass": "message",
     "text": "45. 10. 2.",
     "numinlets": 2,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      30.0,
      222.0,
      88.0,
      22.0
     ]
    }
   },
   {
    "box": {
     "id": "u3",
     "maxclass": "newobj",
     "text": "j.unit @dataspace position @input aed @output xyz",
     "numinlets": 1,
     "numoutlets": 2,
     "outlettype": [
      "",
      ""
     ],
     "patching_rect": [
      30.0,
      286.0,
      345.4,
      22.0
     ]
    }
   },
   {
    "box": {
     "id": "u4",
     "maxclass": "newobj",
     "text": "j.unit @dataspace position @input xyz @output aed",
     "numinlets": 1,
     "numoutlets": 2,
     "outlettype": [
      "",
      ""
     ],
     "patching_rect": [
      30.0,
      350.0,
      345.4,
      22.0
     ]
    }
   },
   {
    "box": {
     "id": "p",
     "maxclass": "newobj",
     "text": "unpack 0. 0. 0.",
     "numinlets": 1,
     "numoutlets": 3,
     "outlettype": [
      "",
      "",
      ""
     ],
     "patching_rect": [
      30.0,
      414.0,
      121.0,
      22.0
     ]
    }
   },
   {
    "box": {
     "id": "c3",
     "maxclass": "newobj",
     "text": "expr ($f1-45.)<0.00001 && ($f1-45.)>-0.00001 && ($f2-2.)<0.00001 && ($f2-2.)>-0.00001",
     "numinlets": 2,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      30.0,
      478.0,
      583.0,
      22.0
     ]
    }
   },
   {
    "box": {
     "id": "a3",
     "maxclass": "newobj",
     "text": "test.assert JamomaMax3/unit_basic/position_round_trip",
     "numinlets": 1,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      30.0,
      606.0,
      371.8,
      22.0
     ]
    }
   },
   {
    "box": {
     "id": "d1",
     "maxclass": "newobj",
     "text": "delay 1500",
     "numinlets": 2,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      135.4,
      94.0,
      88.0,
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
      135.4,
      158.0,
      114.4,
      22.0
     ]
    }
   },
   {
    "box": {
     "id": "tg_a1",
     "maxclass": "toggle",
     "numinlets": 1,
     "numoutlets": 1,
     "outlettype": [
      "int"
     ],
     "parameter_enable": 0,
     "patching_rect": [
      1118.6,
      414.0,
      24.0,
      24.0
     ]
    }
   },
   {
    "box": {
     "id": "tg_a2",
     "maxclass": "toggle",
     "numinlets": 1,
     "numoutlets": 1,
     "outlettype": [
      "int"
     ],
     "parameter_enable": 0,
     "patching_rect": [
      637.0,
      414.0,
      24.0,
      24.0
     ]
    }
   },
   {
    "box": {
     "id": "tg_a3",
     "maxclass": "toggle",
     "numinlets": 1,
     "numoutlets": 1,
     "outlettype": [
      "int"
     ],
     "parameter_enable": 0,
     "patching_rect": [
      30.0,
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
      "lb",
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
      "t",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "t",
      2
     ],
     "destination": [
      "m1",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "t",
      1
     ],
     "destination": [
      "m2",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "t",
      0
     ],
     "destination": [
      "m3",
      0
     ]
    }
   },
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
      "term",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "m1",
      0
     ],
     "destination": [
      "u1",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "u1",
      0
     ],
     "destination": [
      "c1",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "c1",
      0
     ],
     "destination": [
      "tg_a1",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "m2",
      0
     ],
     "destination": [
      "u2",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "u2",
      0
     ],
     "destination": [
      "c2",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "c2",
      0
     ],
     "destination": [
      "tg_a2",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "m3",
      0
     ],
     "destination": [
      "u3",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "u3",
      0
     ],
     "destination": [
      "u4",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "u4",
      0
     ],
     "destination": [
      "p",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "p",
      0
     ],
     "destination": [
      "c3",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "p",
      2
     ],
     "destination": [
      "c3",
      1
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "c3",
      0
     ],
     "destination": [
      "tg_a3",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "tg_a1",
      0
     ],
     "destination": [
      "a1",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "tg_a2",
      0
     ],
     "destination": [
      "a2",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "tg_a3",
      0
     ],
     "destination": [
      "a3",
      0
     ]
    }
   }
  ]
 }
}
