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
   1509.1,
   786.0
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
     "id": "ns",
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
      414.0,
      180.4,
      22.0
     ],
     "text": "j.namespace @address /pm"
    }
   },
   {
    "box": {
     "id": "sz",
     "maxclass": "newobj",
     "numinlets": 2,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      849.9,
      542.0,
      41.8,
      22.0
     ],
     "text": "int"
    }
   },
   {
    "box": {
     "id": "z",
     "maxclass": "newobj",
     "numinlets": 2,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      849.9,
      606.0,
      48.4,
      22.0
     ],
     "text": "== 0"
    }
   },
   {
    "box": {
     "id": "two",
     "maxclass": "newobj",
     "numinlets": 2,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      922.3,
      606.0,
      48.4,
      22.0
     ],
     "text": "== 2"
    }
   },
   {
    "box": {
     "id": "e_attr",
     "maxclass": "newobj",
     "numinlets": 1,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      849.9,
      734.0,
      629.2,
      22.0
     ],
     "text": "test.assert Jamoma/Modular/j.namespace/attribute_messages/an_attribute_can_be_set_by_message"
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
      40.0,
      22.0
     ],
     "text": "99"
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
      781.8,
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
      781.8,
      222.0,
      134.2,
      22.0
     ],
     "text": "output attributes"
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
      781.8,
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
      781.8,
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
      986.2,
      414.0,
      74.8,
      22.0
     ],
     "text": "delay 60"
    }
   },
   {
    "box": {
     "id": "s3",
     "maxclass": "message",
     "numinlets": 2,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      986.2,
      478.0,
      48.4,
      22.0
     ],
     "text": "bang"
    }
   },
   {
    "box": {
     "id": "sd3",
     "maxclass": "newobj",
     "numinlets": 2,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      986.2,
      542.0,
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
      994.7,
      606.0,
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
      994.7,
      670.0,
      114.4,
      22.0
     ],
     "text": "test.terminate"
    }
   },
   {
    "box": {
     "id": "tg_e_attr",
     "maxclass": "toggle",
     "numinlets": 1,
     "numoutlets": 1,
     "outlettype": [
      "int"
     ],
     "parameter_enable": 0,
     "patching_rect": [
      849.9,
      670.0,
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
      "ns",
      1
     ],
     "destination": [
      "sz",
      1
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "sz",
      0
     ],
     "destination": [
      "z",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "sz",
      0
     ],
     "destination": [
      "two",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "z",
      0
     ],
     "destination": [
      "tg_e_attr",
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
      "sz",
      1
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
      "ns",
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
      "ns",
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
      "sz",
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
      "sd3",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "sd3",
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
      "tg_e_attr",
      0
     ],
     "destination": [
      "e_attr",
      0
     ]
    }
   }
  ]
 }
}
