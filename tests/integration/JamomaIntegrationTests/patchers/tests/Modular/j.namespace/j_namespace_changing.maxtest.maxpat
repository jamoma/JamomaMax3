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
   2318.4,
   914.0
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
     "text": "j.parameter beta @type integer @default 2",
     "varname": "boxb"
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
     "id": "tp",
     "maxclass": "newobj",
     "numinlets": 1,
     "numoutlets": 2,
     "outlettype": [
      "",
      ""
     ],
     "patching_rect": [
      781.8,
      414.0,
      94.6,
      22.0
     ],
     "text": "thispatcher"
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
      841.1,
      542.0,
      292.6,
      22.0
     ],
     "text": "j.namespace @address /pm @output children"
    }
   },
   {
    "box": {
     "id": "nx",
     "maxclass": "newobj",
     "numinlets": 1,
     "numoutlets": 3,
     "outlettype": [
      "",
      "",
      ""
     ],
     "patching_rect": [
      1157.7,
      542.0,
      451.0,
      22.0
     ],
     "text": "j.namespace @address /nothing/here @output children @format umenu"
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
      1085.2,
      670.0,
      41.8,
      22.0
     ],
     "text": "int"
    }
   },
   {
    "box": {
     "id": "nx_sz",
     "maxclass": "newobj",
     "numinlets": 2,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      1190.7,
      670.0,
      41.8,
      22.0
     ],
     "text": "int"
    }
   },
   {
    "box": {
     "id": "e1",
     "maxclass": "newobj",
     "numinlets": 2,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      1085.2,
      734.0,
      48.4,
      22.0
     ],
     "text": "== 1"
    }
   },
   {
    "box": {
     "id": "z0",
     "maxclass": "newobj",
     "numinlets": 2,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      1190.7,
      734.0,
      48.4,
      22.0
     ],
     "text": "== 0"
    }
   },
   {
    "box": {
     "id": "d_del",
     "maxclass": "newobj",
     "numinlets": 1,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      1085.2,
      862.0,
      622.6,
      22.0
     ],
     "text": "test.assert Jamoma/Modular/j.namespace/changing/a_deleted_node_is_gone_from_the_next_result"
    }
   },
   {
    "box": {
     "id": "d_none",
     "maxclass": "newobj",
     "numinlets": 1,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      1731.8,
      862.0,
      556.6,
      22.0
     ],
     "text": "test.assert Jamoma/Modular/j.namespace/changing/a_missing_address_gives_size_zero"
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
      48.4,
      22.0
     ],
     "text": "bang"
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
      140.8,
      22.0
     ],
     "text": "script delete boxb"
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
      900.4,
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
      900.4,
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
      1632.7,
      542.0,
      74.8,
      22.0
     ],
     "text": "delay 60"
    }
   },
   {
    "box": {
     "id": "s4",
     "maxclass": "message",
     "numinlets": 2,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      1632.7,
      606.0,
      48.4,
      22.0
     ],
     "text": "bang"
    }
   },
   {
    "box": {
     "id": "sd4",
     "maxclass": "newobj",
     "numinlets": 2,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      1632.7,
      670.0,
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
      1632.7,
      734.0,
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
      1632.7,
      798.0,
      114.4,
      22.0
     ],
     "text": "test.terminate"
    }
   },
   {
    "box": {
     "id": "tg_d_del",
     "maxclass": "toggle",
     "numinlets": 1,
     "numoutlets": 1,
     "outlettype": [
      "int"
     ],
     "parameter_enable": 0,
     "patching_rect": [
      1085.2,
      798.0,
      24.0,
      24.0
     ]
    }
   },
   {
    "box": {
     "id": "tg_d_none",
     "maxclass": "toggle",
     "numinlets": 1,
     "numoutlets": 1,
     "outlettype": [
      "int"
     ],
     "parameter_enable": 0,
     "patching_rect": [
      1771.1,
      798.0,
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
      "nx",
      1
     ],
     "destination": [
      "nx_sz",
      1
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
      "e1",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "nx_sz",
      0
     ],
     "destination": [
      "z0",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "e1",
      0
     ],
     "destination": [
      "tg_d_del",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "z0",
      0
     ],
     "destination": [
      "tg_d_none",
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
      "nc_sz",
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
      "nx_sz",
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
      "nc",
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
      "tp",
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
      "nc",
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
      "nx",
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
      "nc_sz",
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
      "nx_sz",
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
      "sd4",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "sd4",
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
      "tg_d_del",
      0
     ],
     "destination": [
      "d_del",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "tg_d_none",
      0
     ],
     "destination": [
      "d_none",
      0
     ]
    }
   }
  ]
 }
}
