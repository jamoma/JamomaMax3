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
   80.0,
   96.0,
   3017.6,
   722.0
  ],
  "boxes": [
   {
    "box": {
     "id": "lb",
     "maxclass": "newobj",
     "numinlets": 1,
     "numoutlets": 1,
     "outlettype": [
      "bang"
     ],
     "patching_rect": [
      30.0,
      30.0,
      74.8,
      22.0
     ],
     "text": "loadbang"
    }
   },
   {
    "box": {
     "id": "d1",
     "maxclass": "newobj",
     "numinlets": 2,
     "numoutlets": 1,
     "outlettype": [
      "bang"
     ],
     "patching_rect": [
      30.0,
      94.0,
      81.4,
      22.0
     ],
     "text": "delay 200"
    }
   },
   {
    "box": {
     "id": "t1",
     "maxclass": "newobj",
     "numinlets": 1,
     "numoutlets": 4,
     "outlettype": [
      "bang",
      "bang",
      "bang",
      "bang"
     ],
     "patching_rect": [
      30.0,
      158.0,
      81.4,
      22.0
     ],
     "text": "t b b b b"
    }
   },
   {
    "box": {
     "id": "tp",
     "maxclass": "newobj",
     "numinlets": 1,
     "numoutlets": 2,
     "outlettype": [
      "",
      ""
     ],
     "patching_rect": [
      924.6,
      350.0,
      94.6,
      22.0
     ],
     "text": "thispatcher"
    }
   },
   {
    "box": {
     "id": "mk1",
     "maxclass": "message",
     "numinlets": 1,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      30.0,
      222.0,
      431.2,
      22.0
     ],
     "text": "script newobject j.ui @varname u1 @patching_rect 30 500 320 52"
    }
   },
   {
    "box": {
     "id": "mk2",
     "maxclass": "message",
     "numinlets": 1,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      485.2,
      222.0,
      490.6,
      22.0
     ],
     "text": "script newobject j.ui @varname u2 @snap 0 @patching_rect 400 500 233 52"
    }
   },
   {
    "box": {
     "id": "mk3",
     "maxclass": "message",
     "numinlets": 1,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      999.8,
      222.0,
      437.8,
      22.0
     ],
     "text": "script newobject j.ui @varname u3 @patching_rect 700 500 300 70"
    }
   },
   {
    "box": {
     "id": "d2",
     "maxclass": "newobj",
     "numinlets": 2,
     "numoutlets": 1,
     "outlettype": [
      "bang"
     ],
     "patching_rect": [
      1461.6,
      222.0,
      81.4,
      22.0
     ],
     "text": "delay 200"
    }
   },
   {
    "box": {
     "id": "rs",
     "maxclass": "message",
     "numinlets": 1,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      1461.6,
      286.0,
      160.6,
      22.0
     ],
     "text": "script size u3 410 80"
    }
   },
   {
    "box": {
     "id": "rs0",
     "maxclass": "message",
     "numinlets": 1,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      1646.2,
      286.0,
      160.6,
      22.0
     ],
     "text": "script size u2 410 80"
    }
   },
   {
    "box": {
     "id": "d3",
     "maxclass": "newobj",
     "numinlets": 2,
     "numoutlets": 1,
     "outlettype": [
      "bang"
     ],
     "patching_rect": [
      1830.8,
      286.0,
      81.4,
      22.0
     ],
     "text": "delay 300"
    }
   },
   {
    "box": {
     "id": "t2",
     "maxclass": "newobj",
     "numinlets": 1,
     "numoutlets": 3,
     "outlettype": [
      "bang",
      "bang",
      "bang"
     ],
     "patching_rect": [
      1830.8,
      350.0,
      68.2,
      22.0
     ],
     "text": "t b b b"
    }
   },
   {
    "box": {
     "id": "m0",
     "maxclass": "message",
     "numinlets": 1,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      1830.8,
      414.0,
      88.0,
      22.0
     ],
     "text": "measure u1"
    }
   },
   {
    "box": {
     "id": "js0",
     "maxclass": "newobj",
     "numinlets": 1,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      1830.8,
      478.0,
      107.8,
      22.0
     ],
     "text": "js ui_size.js"
    }
   },
   {
    "box": {
     "id": "cmp0",
     "maxclass": "newobj",
     "numinlets": 2,
     "numoutlets": 2,
     "outlettype": [
      "",
      ""
     ],
     "patching_rect": [
      1830.8,
      542.0,
      134.2,
      22.0
     ],
     "text": "zl compare 300 35"
    }
   },
   {
    "box": {
     "id": "tg0",
     "maxclass": "toggle",
     "numinlets": 1,
     "numoutlets": 1,
     "outlettype": [
      "int"
     ],
     "patching_rect": [
      1830.8,
      606.0,
      24.0,
      24.0
     ],
     "parameter_enable": 0
    }
   },
   {
    "box": {
     "id": "as0",
     "maxclass": "newobj",
     "numinlets": 1,
     "numoutlets": 0,
     "outlettype": [],
     "patching_rect": [
      1830.8,
      670.0,
      358.6,
      22.0
     ],
     "text": "test.assert JamomaMax3/ui_grid/snaps_a_created_size"
    }
   },
   {
    "box": {
     "id": "m1",
     "maxclass": "message",
     "numinlets": 1,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      1942.8,
      414.0,
      88.0,
      22.0
     ],
     "text": "measure u2"
    }
   },
   {
    "box": {
     "id": "js1",
     "maxclass": "newobj",
     "numinlets": 1,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      1962.6,
      478.0,
      107.8,
      22.0
     ],
     "text": "js ui_size.js"
    }
   },
   {
    "box": {
     "id": "cmp1",
     "maxclass": "newobj",
     "numinlets": 2,
     "numoutlets": 2,
     "outlettype": [
      "",
      ""
     ],
     "patching_rect": [
      1989.0,
      542.0,
      134.2,
      22.0
     ],
     "text": "zl compare 410 80"
    }
   },
   {
    "box": {
     "id": "tg1",
     "maxclass": "toggle",
     "numinlets": 1,
     "numoutlets": 1,
     "outlettype": [
      "int"
     ],
     "patching_rect": [
      2213.4,
      606.0,
      24.0,
      24.0
     ],
     "parameter_enable": 0
    }
   },
   {
    "box": {
     "id": "as1",
     "maxclass": "newobj",
     "numinlets": 1,
     "numoutlets": 0,
     "outlettype": [],
     "patching_rect": [
      2213.4,
      670.0,
      431.2,
      22.0
     ],
     "text": "test.assert JamomaMax3/ui_grid/keeps_the_size_when_snap_is_off"
    }
   },
   {
    "box": {
     "id": "m2",
     "maxclass": "message",
     "numinlets": 1,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      2054.8,
      414.0,
      88.0,
      22.0
     ],
     "text": "measure u3"
    }
   },
   {
    "box": {
     "id": "js2",
     "maxclass": "newobj",
     "numinlets": 1,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      2094.4,
      478.0,
      107.8,
      22.0
     ],
     "text": "js ui_size.js"
    }
   },
   {
    "box": {
     "id": "cmp2",
     "maxclass": "newobj",
     "numinlets": 2,
     "numoutlets": 2,
     "outlettype": [
      "",
      ""
     ],
     "patching_rect": [
      2147.2,
      542.0,
      134.2,
      22.0
     ],
     "text": "zl compare 450 70"
    }
   },
   {
    "box": {
     "id": "tg2",
     "maxclass": "toggle",
     "numinlets": 1,
     "numoutlets": 1,
     "outlettype": [
      "int"
     ],
     "patching_rect": [
      2668.6,
      606.0,
      24.0,
      24.0
     ],
     "parameter_enable": 0
    }
   },
   {
    "box": {
     "id": "as2",
     "maxclass": "newobj",
     "numinlets": 1,
     "numoutlets": 0,
     "outlettype": [],
     "patching_rect": [
      2668.6,
      670.0,
      319.0,
      22.0
     ],
     "text": "test.assert JamomaMax3/ui_grid/snaps_a_resize"
    }
   },
   {
    "box": {
     "id": "d4",
     "maxclass": "newobj",
     "numinlets": 2,
     "numoutlets": 1,
     "outlettype": [
      "bang"
     ],
     "patching_rect": [
      1923.0,
      350.0,
      81.4,
      22.0
     ],
     "text": "delay 300"
    }
   },
   {
    "box": {
     "id": "term",
     "maxclass": "newobj",
     "numinlets": 1,
     "numoutlets": 0,
     "outlettype": [],
     "patching_rect": [
      2166.8,
      414.0,
      114.4,
      22.0
     ],
     "text": "test.terminate"
    }
   }
  ],
  "lines": [
   {
    "patchline": {
     "destination": [
      "d1",
      0
     ],
     "source": [
      "lb",
      0
     ]
    }
   },
   {
    "patchline": {
     "destination": [
      "t1",
      0
     ],
     "source": [
      "d1",
      0
     ]
    }
   },
   {
    "patchline": {
     "destination": [
      "mk1",
      0
     ],
     "source": [
      "t1",
      0
     ]
    }
   },
   {
    "patchline": {
     "destination": [
      "mk2",
      0
     ],
     "source": [
      "t1",
      1
     ]
    }
   },
   {
    "patchline": {
     "destination": [
      "mk3",
      0
     ],
     "source": [
      "t1",
      2
     ]
    }
   },
   {
    "patchline": {
     "destination": [
      "d2",
      0
     ],
     "source": [
      "t1",
      3
     ]
    }
   },
   {
    "patchline": {
     "destination": [
      "tp",
      0
     ],
     "source": [
      "mk1",
      0
     ]
    }
   },
   {
    "patchline": {
     "destination": [
      "tp",
      0
     ],
     "source": [
      "mk2",
      0
     ]
    }
   },
   {
    "patchline": {
     "destination": [
      "tp",
      0
     ],
     "source": [
      "mk3",
      0
     ]
    }
   },
   {
    "patchline": {
     "destination": [
      "rs",
      0
     ],
     "source": [
      "d2",
      0
     ]
    }
   },
   {
    "patchline": {
     "destination": [
      "rs0",
      0
     ],
     "source": [
      "d2",
      0
     ]
    }
   },
   {
    "patchline": {
     "destination": [
      "tp",
      0
     ],
     "source": [
      "rs",
      0
     ]
    }
   },
   {
    "patchline": {
     "destination": [
      "tp",
      0
     ],
     "source": [
      "rs0",
      0
     ]
    }
   },
   {
    "patchline": {
     "destination": [
      "d3",
      0
     ],
     "source": [
      "d2",
      0
     ]
    }
   },
   {
    "patchline": {
     "destination": [
      "t2",
      0
     ],
     "source": [
      "d3",
      0
     ]
    }
   },
   {
    "patchline": {
     "destination": [
      "d4",
      0
     ],
     "source": [
      "d3",
      0
     ]
    }
   },
   {
    "patchline": {
     "destination": [
      "term",
      0
     ],
     "source": [
      "d4",
      0
     ]
    }
   },
   {
    "patchline": {
     "destination": [
      "m0",
      0
     ],
     "source": [
      "t2",
      0
     ]
    }
   },
   {
    "patchline": {
     "destination": [
      "js0",
      0
     ],
     "source": [
      "m0",
      0
     ]
    }
   },
   {
    "patchline": {
     "destination": [
      "cmp0",
      0
     ],
     "source": [
      "js0",
      0
     ]
    }
   },
   {
    "patchline": {
     "destination": [
      "tg0",
      0
     ],
     "source": [
      "cmp0",
      0
     ]
    }
   },
   {
    "patchline": {
     "destination": [
      "as0",
      0
     ],
     "source": [
      "tg0",
      0
     ]
    }
   },
   {
    "patchline": {
     "destination": [
      "m1",
      0
     ],
     "source": [
      "t2",
      1
     ]
    }
   },
   {
    "patchline": {
     "destination": [
      "js1",
      0
     ],
     "source": [
      "m1",
      0
     ]
    }
   },
   {
    "patchline": {
     "destination": [
      "cmp1",
      0
     ],
     "source": [
      "js1",
      0
     ]
    }
   },
   {
    "patchline": {
     "destination": [
      "tg1",
      0
     ],
     "source": [
      "cmp1",
      0
     ]
    }
   },
   {
    "patchline": {
     "destination": [
      "as1",
      0
     ],
     "source": [
      "tg1",
      0
     ]
    }
   },
   {
    "patchline": {
     "destination": [
      "m2",
      0
     ],
     "source": [
      "t2",
      2
     ]
    }
   },
   {
    "patchline": {
     "destination": [
      "js2",
      0
     ],
     "source": [
      "m2",
      0
     ]
    }
   },
   {
    "patchline": {
     "destination": [
      "cmp2",
      0
     ],
     "source": [
      "js2",
      0
     ]
    }
   },
   {
    "patchline": {
     "destination": [
      "tg2",
      0
     ],
     "source": [
      "cmp2",
      0
     ]
    }
   },
   {
    "patchline": {
     "destination": [
      "as2",
      0
     ],
     "source": [
      "tg2",
      0
     ]
    }
   }
  ],
  "autosave": 0,
  "dependency_cache": []
 }
}
