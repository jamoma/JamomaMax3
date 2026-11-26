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
   1583.4,
   658.0
  ],
  "boxes": [
   {
    "box": {
     "id": "model",
     "maxclass": "newobj",
     "numinlets": 1,
     "numoutlets": 2,
     "outlettype": [
      "",
      ""
     ],
     "patching_rect": [
      685.8,
      158.0,
      80.0,
      22.0
     ],
     "text": "j.model pm"
    }
   },
   {
    "box": {
     "id": "src",
     "maxclass": "newobj",
     "numinlets": 1,
     "numoutlets": 2,
     "outlettype": [
      "",
      ""
     ],
     "patching_rect": [
      1287.8,
      222.0,
      265.6,
      22.0
     ],
     "text": "j.parameter src @type decimal @range 10 20"
    }
   },
   {
    "box": {
     "id": "dst",
     "maxclass": "newobj",
     "numinlets": 1,
     "numoutlets": 2,
     "outlettype": [
      "",
      ""
     ],
     "patching_rect": [
      789.8,
      158.0,
      265.6,
      22.0
     ],
     "text": "j.parameter dst @type decimal @range 0 100"
    }
   },
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
      1079.4,
      158.0,
      184.4,
      22.0
     ],
     "text": "j.map @input src @output dst"
    }
   },
   {
    "box": {
     "id": "r_to_src",
     "maxclass": "newobj",
     "numinlets": 0,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      1287.8,
      158.0,
      68.4,
      22.0
     ],
     "text": "r to_src"
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
      30.0,
      30.0,
      56.8,
      22.0
     ],
     "text": "j.init"
    }
   },
   {
    "box": {
     "id": "top",
     "maxclass": "newobj",
     "numinlets": 1,
     "numoutlets": 2,
     "outlettype": [
      "",
      ""
     ],
     "patching_rect": [
      30.0,
      94.0,
      51.0,
      22.0
     ],
     "text": "t b b"
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
      30.0,
      606.0,
      103.2,
      22.0
     ],
     "text": "test.terminate"
    }
   },
   {
    "box": {
     "id": "follow_t",
     "maxclass": "newobj",
     "numinlets": 1,
     "numoutlets": 2,
     "outlettype": [
      "",
      ""
     ],
     "patching_rect": [
      30.0,
      158.0,
      56.8,
      22.0
     ],
     "text": "t b 15"
    }
   },
   {
    "box": {
     "id": "follow_s0",
     "maxclass": "newobj",
     "numinlets": 1,
     "numoutlets": 0,
     "outlettype": [],
     "patching_rect": [
      30.0,
      222.0,
      68.4,
      22.0
     ],
     "text": "s to_src"
    }
   },
   {
    "box": {
     "id": "follow_h",
     "maxclass": "newobj",
     "numinlets": 2,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      30.0,
      286.0,
      68.4,
      22.0
     ],
     "text": "float 0."
    }
   },
   {
    "box": {
     "id": "follow_c",
     "maxclass": "newobj",
     "numinlets": 1,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      30.0,
      350.0,
      190.2,
      22.0
     ],
     "text": "expr abs($f1 - 50.) < 0.00001"
    }
   },
   {
    "box": {
     "id": "follow_a",
     "maxclass": "newobj",
     "numinlets": 1,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      30.0,
      478.0,
      607.8,
      22.0
     ],
     "text": "test.assert Jamoma/Modular/j.map/follows_parameters/maps_one_parameter_onto_another_with_their_ranges"
    }
   },
   {
    "box": {
     "id": "tg_follow_a",
     "maxclass": "toggle",
     "numinlets": 1,
     "numoutlets": 1,
     "outlettype": [
      "int"
     ],
     "parameter_enable": 0,
     "patching_rect": [
      30.0,
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
      "r_to_src",
      0
     ],
     "destination": [
      "src",
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
      "top",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "top",
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
      "top",
      1
     ],
     "destination": [
      "follow_t",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "follow_t",
      1
     ],
     "destination": [
      "follow_s0",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "follow_t",
      0
     ],
     "destination": [
      "follow_h",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "dst",
      0
     ],
     "destination": [
      "follow_h",
      1
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "follow_h",
      0
     ],
     "destination": [
      "follow_c",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "follow_c",
      0
     ],
     "destination": [
      "tg_follow_a",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "tg_follow_a",
      0
     ],
     "destination": [
      "follow_a",
      0
     ]
    }
   }
  ]
 }
}
