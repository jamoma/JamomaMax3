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
   992.2,
   530.0
  ],
  "boxes": [
   {
    "box": {
     "id": "a1",
     "maxclass": "newobj",
     "text": "dieze_abs one 5",
     "numinlets": 1,
     "numoutlets": 0,
     "outlettype": [],
     "patching_rect": [
      30.0,
      30.0,
      121.0,
      22.0
     ]
    }
   },
   {
    "box": {
     "id": "a2",
     "maxclass": "newobj",
     "text": "dieze_abs two 9",
     "numinlets": 1,
     "numoutlets": 0,
     "outlettype": [],
     "patching_rect": [
      175.0,
      30.0,
      121.0,
      22.0
     ]
    }
   },
   {
    "box": {
     "id": "r1",
     "maxclass": "newobj",
     "text": "j.receive /one/p",
     "numinlets": 1,
     "numoutlets": 3,
     "outlettype": [
      "",
      "",
      ""
     ],
     "patching_rect": [
      320.0,
      222.0,
      127.6,
      22.0
     ]
    }
   },
   {
    "box": {
     "id": "r2",
     "maxclass": "newobj",
     "text": "j.receive /two/p",
     "numinlets": 1,
     "numoutlets": 3,
     "outlettype": [
      "",
      "",
      ""
     ],
     "patching_rect": [
      471.6,
      222.0,
      127.6,
      22.0
     ]
    }
   },
   {
    "box": {
     "id": "s1",
     "maxclass": "newobj",
     "text": "sel 5",
     "numinlets": 2,
     "numoutlets": 2,
     "outlettype": [
      "",
      ""
     ],
     "patching_rect": [
      320.0,
      286.0,
      55.0,
      22.0
     ]
    }
   },
   {
    "box": {
     "id": "o1",
     "maxclass": "message",
     "text": "1",
     "numinlets": 2,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      320.0,
      350.0,
      40.0,
      22.0
     ]
    }
   },
   {
    "box": {
     "id": "as1",
     "maxclass": "newobj",
     "text": "test.assert JamomaMax3/dieze/first_instance",
     "numinlets": 1,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      320.0,
      478.0,
      305.8,
      22.0
     ]
    }
   },
   {
    "box": {
     "id": "s2",
     "maxclass": "newobj",
     "text": "sel 9",
     "numinlets": 2,
     "numoutlets": 2,
     "outlettype": [
      "",
      ""
     ],
     "patching_rect": [
      471.6,
      286.0,
      55.0,
      22.0
     ]
    }
   },
   {
    "box": {
     "id": "o2",
     "maxclass": "message",
     "text": "1",
     "numinlets": 2,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      471.6,
      350.0,
      40.0,
      22.0
     ]
    }
   },
   {
    "box": {
     "id": "as2",
     "maxclass": "newobj",
     "text": "test.assert JamomaMax3/dieze/second_instance",
     "numinlets": 1,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      649.8,
      478.0,
      312.4,
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
      320.0,
      30.0,
      74.8,
      22.0
     ]
    }
   },
   {
    "box": {
     "id": "d",
     "maxclass": "newobj",
     "text": "delay 500",
     "numinlets": 2,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      320.0,
      94.0,
      81.4,
      22.0
     ]
    }
   },
   {
    "box": {
     "id": "bg",
     "maxclass": "message",
     "text": "bang",
     "numinlets": 1,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      320.0,
      158.0,
      48.4,
      22.0
     ]
    }
   },
   {
    "box": {
     "id": "d4",
     "maxclass": "newobj",
     "text": "delay 300",
     "numinlets": 2,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      392.4,
      158.0,
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
      623.2,
      222.0,
      114.4,
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
      320.0,
      414.0,
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
      649.8,
      414.0,
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
      "r1",
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
      "o1",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "o1",
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
      "r2",
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
      "o2",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "o2",
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
      "lb",
      0
     ],
     "destination": [
      "d",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "d",
      0
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
      "r1",
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
      "r2",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "d",
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
      "term",
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
   }
  ]
 }
}
