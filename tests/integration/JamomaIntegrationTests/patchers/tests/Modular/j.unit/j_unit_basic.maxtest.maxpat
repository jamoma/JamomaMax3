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
   134.0,
   168.0,
   1586.4,
   658.0
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
     "id": "d0",
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
     "text": "delay 500"
    }
   },
   {
    "box": {
     "id": "t",
     "maxclass": "newobj",
     "numinlets": 1,
     "numoutlets": 3,
     "outlettype": [
      "bang",
      "bang",
      "bang"
     ],
     "patching_rect": [
      30.0,
      158.0,
      68.2,
      22.0
     ],
     "text": "t b b b"
    }
   },
   {
    "box": {
     "id": "m1",
     "maxclass": "message",
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
     ],
     "text": "-6."
    }
   },
   {
    "box": {
     "id": "u1",
     "maxclass": "newobj",
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
     ],
     "text": "j.unit @dataspace gain @input db @output linear"
    }
   },
   {
    "box": {
     "id": "c1",
     "maxclass": "newobj",
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
     ],
     "text": "expr ($f1-0.501187)<0.000001 && ($f1-0.501187)>-0.000001"
    }
   },
   {
    "box": {
     "color": [
      0.7,
      0.4,
      0.3,
      1.0
     ],
     "id": "a1",
     "maxclass": "newobj",
     "numinlets": 1,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      1158.2,
      478.0,
      398.2,
      22.0
     ],
     "text": "test.assert Jamoma/Modular/j.unit/basic/gain_db_to_linear"
    }
   },
   {
    "box": {
     "id": "m2",
     "maxclass": "message",
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
     ],
     "text": "100."
    }
   },
   {
    "box": {
     "id": "u2",
     "maxclass": "newobj",
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
     ],
     "text": "j.unit @input C @output F"
    }
   },
   {
    "box": {
     "id": "c2",
     "maxclass": "newobj",
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
     ],
     "text": "expr ($f1-212.)<0.000001 && ($f1-212.)>-0.000001"
    }
   },
   {
    "box": {
     "color": [
      0.7,
      0.4,
      0.3,
      1.0
     ],
     "id": "a2",
     "maxclass": "newobj",
     "numinlets": 1,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      637.0,
      478.0,
      497.2,
      22.0
     ],
     "text": "test.assert Jamoma/Modular/j.unit/basic/default_dataspace_is_temperature"
    }
   },
   {
    "box": {
     "id": "m3",
     "maxclass": "message",
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
     ],
     "text": "45. 10. 2."
    }
   },
   {
    "box": {
     "id": "u3",
     "maxclass": "newobj",
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
     ],
     "text": "j.unit @dataspace position @input aed @output xyz"
    }
   },
   {
    "box": {
     "id": "u4",
     "maxclass": "newobj",
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
     ],
     "text": "j.unit @dataspace position @input xyz @output aed"
    }
   },
   {
    "box": {
     "id": "p",
     "maxclass": "newobj",
     "numinlets": 1,
     "numoutlets": 3,
     "outlettype": [
      "float",
      "float",
      "float"
     ],
     "patching_rect": [
      30.0,
      414.0,
      121.0,
      22.0
     ],
     "text": "unpack 0. 0. 0."
    }
   },
   {
    "box": {
     "id": "c3",
     "maxclass": "newobj",
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
     ],
     "text": "expr ($f1-45.)<0.00001 && ($f1-45.)>-0.00001 && ($f2-2.)<0.00001 && ($f2-2.)>-0.00001"
    }
   },
   {
    "box": {
     "color": [
      0.7,
      0.4,
      0.3,
      1.0
     ],
     "id": "a3",
     "maxclass": "newobj",
     "numinlets": 1,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      30.0,
      606.0,
      411.4,
      22.0
     ],
     "text": "test.assert Jamoma/Modular/j.unit/basic/position_round_trip"
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
      135.4,
      94.0,
      88.0,
      22.0
     ],
     "text": "delay 1500"
    }
   },
   {
    "box": {
     "color": [
      0.7,
      0.4,
      0.3,
      1.0
     ],
     "id": "term",
     "maxclass": "newobj",
     "numinlets": 1,
     "numoutlets": 0,
     "patching_rect": [
      135.4,
      158.0,
      114.4,
      22.0
     ],
     "text": "test.terminate"
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
      1158.2,
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
     "destination": [
      "tg_a1",
      0
     ],
     "source": [
      "c1",
      0
     ]
    }
   },
   {
    "patchline": {
     "destination": [
      "tg_a2",
      0
     ],
     "source": [
      "c2",
      0
     ]
    }
   },
   {
    "patchline": {
     "destination": [
      "tg_a3",
      0
     ],
     "source": [
      "c3",
      0
     ]
    }
   },
   {
    "patchline": {
     "destination": [
      "t",
      0
     ],
     "source": [
      "d0",
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
      "d1",
      0
     ]
    }
   },
   {
    "patchline": {
     "destination": [
      "d0",
      0
     ],
     "order": 1,
     "source": [
      "lb",
      0
     ]
    }
   },
   {
    "patchline": {
     "destination": [
      "d1",
      0
     ],
     "order": 0,
     "source": [
      "lb",
      0
     ]
    }
   },
   {
    "patchline": {
     "destination": [
      "u1",
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
      "u2",
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
      "u3",
      0
     ],
     "source": [
      "m3",
      0
     ]
    }
   },
   {
    "patchline": {
     "destination": [
      "c3",
      1
     ],
     "source": [
      "p",
      2
     ]
    }
   },
   {
    "patchline": {
     "destination": [
      "c3",
      0
     ],
     "source": [
      "p",
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
      "t",
      2
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
      "t",
      1
     ]
    }
   },
   {
    "patchline": {
     "destination": [
      "m3",
      0
     ],
     "source": [
      "t",
      0
     ]
    }
   },
   {
    "patchline": {
     "destination": [
      "a1",
      0
     ],
     "source": [
      "tg_a1",
      0
     ]
    }
   },
   {
    "patchline": {
     "destination": [
      "a2",
      0
     ],
     "source": [
      "tg_a2",
      0
     ]
    }
   },
   {
    "patchline": {
     "destination": [
      "a3",
      0
     ],
     "source": [
      "tg_a3",
      0
     ]
    }
   },
   {
    "patchline": {
     "destination": [
      "c1",
      0
     ],
     "source": [
      "u1",
      0
     ]
    }
   },
   {
    "patchline": {
     "destination": [
      "c2",
      0
     ],
     "source": [
      "u2",
      0
     ]
    }
   },
   {
    "patchline": {
     "destination": [
      "u4",
      0
     ],
     "source": [
      "u3",
      0
     ]
    }
   },
   {
    "patchline": {
     "destination": [
      "p",
      0
     ],
     "source": [
      "u4",
      0
     ]
    }
   }
  ],
  "autosave": 0
 }
}
