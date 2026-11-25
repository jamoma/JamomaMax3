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
   1872.8,
   1234.0
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
      30.0,
      30.0,
      68.2,
      22.0
     ],
     "text": "j.model"
    }
   },
   {
    "box": {
     "id": "init",
     "maxclass": "newobj",
     "numinlets": 1,
     "numoutlets": 2,
     "outlettype": [
      "bang",
      "bang"
     ],
     "patching_rect": [
      122.2,
      30.0,
      61.6,
      22.0
     ],
     "text": "j.init"
    }
   },
   {
    "box": {
     "id": "ui",
     "maxclass": "j.ui",
     "numinlets": 1,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      676.2,
      606.0,
      40.0,
      22.0
     ]
    }
   },
   {
    "box": {
     "id": "rt",
     "maxclass": "newobj",
     "numinlets": 1,
     "numoutlets": 2,
     "outlettype": [
      "",
      ""
     ],
     "patching_rect": [
      676.2,
      670.0,
      101.2,
      22.0
     ],
     "text": "route active"
    }
   },
   {
    "box": {
     "id": "rcv",
     "maxclass": "newobj",
     "numinlets": 1,
     "numoutlets": 3,
     "outlettype": [
      "",
      "",
      ""
     ],
     "patching_rect": [
      207.8,
      30.0,
      160.6,
      22.0
     ],
     "text": "j.receive data/active"
    }
   },
   {
    "box": {
     "id": "A1",
     "maxclass": "newobj",
     "numinlets": 2,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      399.2,
      734.0,
      41.8,
      22.0
     ],
     "text": "int"
    }
   },
   {
    "box": {
     "id": "A2",
     "maxclass": "newobj",
     "numinlets": 2,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      465.0,
      734.0,
      41.8,
      22.0
     ],
     "text": "int"
    }
   },
   {
    "box": {
     "id": "A3",
     "maxclass": "newobj",
     "numinlets": 2,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      530.8,
      734.0,
      41.8,
      22.0
     ],
     "text": "int"
    }
   },
   {
    "box": {
     "id": "R1",
     "maxclass": "newobj",
     "numinlets": 2,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      214.4,
      414.0,
      41.8,
      22.0
     ],
     "text": "int"
    }
   },
   {
    "box": {
     "id": "R2",
     "maxclass": "newobj",
     "numinlets": 2,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      740.2,
      606.0,
      41.8,
      22.0
     ],
     "text": "int"
    }
   },
   {
    "box": {
     "id": "F",
     "maxclass": "newobj",
     "numinlets": 2,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      1332.4,
      990.0,
      55.0,
      22.0
     ],
     "text": "int 1"
    }
   },
   {
    "box": {
     "id": "nodata",
     "maxclass": "newobj",
     "numinlets": 1,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      873.8,
      734.0,
      74.8,
      22.0
     ],
     "text": "p nodata",
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
       400.0,
       240.0
      ],
      "autosave": 0,
      "boxes": [
       {
        "box": {
         "id": "in",
         "maxclass": "inlet",
         "numinlets": 0,
         "numoutlets": 1,
         "outlettype": [
          ""
         ],
         "patching_rect": [
          30.0,
          30.0,
          40.0,
          22.0
         ],
         "comment": ""
        }
       },
       {
        "box": {
         "id": "m2",
         "maxclass": "newobj",
         "numinlets": 1,
         "numoutlets": 2,
         "outlettype": [
          "",
          ""
         ],
         "patching_rect": [
          94.0,
          30.0,
          173.8,
          22.0
         ],
         "text": "j.model @amenities none"
        }
       },
       {
        "box": {
         "id": "u2",
         "maxclass": "j.ui",
         "numinlets": 1,
         "numoutlets": 1,
         "outlettype": [
          ""
         ],
         "patching_rect": [
          30.0,
          94.0,
          40.0,
          22.0
         ]
        }
       },
       {
        "box": {
         "id": "o",
         "maxclass": "outlet",
         "numinlets": 1,
         "numoutlets": 0,
         "outlettype": [],
         "patching_rect": [
          30.0,
          158.0,
          40.0,
          22.0
         ],
         "comment": ""
        }
       }
      ],
      "lines": [
       {
        "patchline": {
         "destination": [
          "u2",
          0
         ],
         "source": [
          "in",
          0
         ]
        }
       },
       {
        "patchline": {
         "destination": [
          "o",
          0
         ],
         "source": [
          "u2",
          0
         ]
        }
       }
      ]
     }
    }
   },
   {
    "box": {
     "id": "rt2",
     "maxclass": "newobj",
     "numinlets": 1,
     "numoutlets": 2,
     "outlettype": [
      "",
      ""
     ],
     "patching_rect": [
      1362.2,
      798.0,
      101.2,
      22.0
     ],
     "text": "route active"
    }
   },
   {
    "box": {
     "id": "tb",
     "maxclass": "newobj",
     "numinlets": 1,
     "numoutlets": 1,
     "outlettype": [
      "bang"
     ],
     "patching_rect": [
      1362.2,
      862.0,
      41.8,
      22.0
     ],
     "text": "t b"
    }
   },
   {
    "box": {
     "id": "zero",
     "maxclass": "message",
     "numinlets": 1,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      1718.6,
      926.0,
      40.0,
      22.0
     ],
     "text": "0"
    }
   },
   {
    "box": {
     "id": "dump",
     "maxclass": "message",
     "numinlets": 1,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      262.4,
      542.0,
      48.4,
      22.0
     ],
     "text": "dump"
    }
   },
   {
    "box": {
     "id": "dump2",
     "maxclass": "message",
     "numinlets": 1,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      873.8,
      670.0,
      48.4,
      22.0
     ],
     "text": "dump"
    }
   },
   {
    "box": {
     "id": "off",
     "maxclass": "message",
     "numinlets": 1,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      122.2,
      286.0,
      74.8,
      22.0
     ],
     "text": "active 0"
    }
   },
   {
    "box": {
     "id": "tog",
     "maxclass": "message",
     "numinlets": 1,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      286.8,
      478.0,
      61.6,
      22.0
     ],
     "text": "active"
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
      1487.4,
      798.0,
      114.4,
      22.0
     ],
     "text": "test.terminate"
    }
   },
   {
    "box": {
     "id": "dl0",
     "maxclass": "newobj",
     "numinlets": 2,
     "numoutlets": 1,
     "outlettype": [
      "bang"
     ],
     "patching_rect": [
      122.2,
      94.0,
      74.8,
      22.0
     ],
     "text": "delay 80"
    }
   },
   {
    "box": {
     "id": "dl1",
     "maxclass": "newobj",
     "numinlets": 2,
     "numoutlets": 1,
     "outlettype": [
      "bang"
     ],
     "patching_rect": [
      122.2,
      158.0,
      74.8,
      22.0
     ],
     "text": "delay 80"
    }
   },
   {
    "box": {
     "id": "dl2",
     "maxclass": "newobj",
     "numinlets": 2,
     "numoutlets": 1,
     "outlettype": [
      "bang"
     ],
     "patching_rect": [
      122.2,
      222.0,
      74.8,
      22.0
     ],
     "text": "delay 80"
    }
   },
   {
    "box": {
     "id": "dl3",
     "maxclass": "newobj",
     "numinlets": 2,
     "numoutlets": 1,
     "outlettype": [
      "bang"
     ],
     "patching_rect": [
      221.0,
      286.0,
      74.8,
      22.0
     ],
     "text": "delay 80"
    }
   },
   {
    "box": {
     "id": "dl4",
     "maxclass": "newobj",
     "numinlets": 2,
     "numoutlets": 1,
     "outlettype": [
      "bang"
     ],
     "patching_rect": [
      221.0,
      350.0,
      74.8,
      22.0
     ],
     "text": "delay 80"
    }
   },
   {
    "box": {
     "id": "dl5",
     "maxclass": "newobj",
     "numinlets": 2,
     "numoutlets": 1,
     "outlettype": [
      "bang"
     ],
     "patching_rect": [
      280.2,
      414.0,
      74.8,
      22.0
     ],
     "text": "delay 80"
    }
   },
   {
    "box": {
     "id": "dl6",
     "maxclass": "newobj",
     "numinlets": 2,
     "numoutlets": 1,
     "outlettype": [
      "bang"
     ],
     "patching_rect": [
      372.4,
      478.0,
      74.8,
      22.0
     ],
     "text": "delay 80"
    }
   },
   {
    "box": {
     "id": "dl7",
     "maxclass": "newobj",
     "numinlets": 2,
     "numoutlets": 1,
     "outlettype": [
      "bang"
     ],
     "patching_rect": [
      372.4,
      542.0,
      74.8,
      22.0
     ],
     "text": "delay 80"
    }
   },
   {
    "box": {
     "id": "dl8",
     "maxclass": "newobj",
     "numinlets": 2,
     "numoutlets": 1,
     "outlettype": [
      "bang"
     ],
     "patching_rect": [
      806.0,
      606.0,
      74.8,
      22.0
     ],
     "text": "delay 80"
    }
   },
   {
    "box": {
     "id": "dl9",
     "maxclass": "newobj",
     "numinlets": 2,
     "numoutlets": 1,
     "outlettype": [
      "bang"
     ],
     "patching_rect": [
      946.2,
      670.0,
      74.8,
      22.0
     ],
     "text": "delay 80"
    }
   },
   {
    "box": {
     "id": "dl10",
     "maxclass": "newobj",
     "numinlets": 2,
     "numoutlets": 1,
     "outlettype": [
      "bang"
     ],
     "patching_rect": [
      972.6,
      734.0,
      74.8,
      22.0
     ],
     "text": "delay 80"
    }
   },
   {
    "box": {
     "id": "c1eq",
     "maxclass": "newobj",
     "numinlets": 2,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      399.2,
      798.0,
      48.4,
      22.0
     ],
     "text": "== 1"
    }
   },
   {
    "box": {
     "id": "c1tg",
     "maxclass": "toggle",
     "numinlets": 1,
     "numoutlets": 1,
     "outlettype": [
      "int"
     ],
     "patching_rect": [
      399.2,
      862.0,
      24.0,
      24.0
     ],
     "parameter_enable": 0
    }
   },
   {
    "box": {
     "id": "c1as",
     "maxclass": "newobj",
     "numinlets": 1,
     "numoutlets": 0,
     "outlettype": [],
     "patching_rect": [
      399.2,
      926.0,
      404.8,
      22.0
     ],
     "text": "test.assert JamomaMax3/ui_active/reports_active_by_default"
    }
   },
   {
    "box": {
     "id": "c2eq",
     "maxclass": "newobj",
     "numinlets": 2,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      471.6,
      798.0,
      48.4,
      22.0
     ],
     "text": "== 0"
    }
   },
   {
    "box": {
     "id": "c2tg",
     "maxclass": "toggle",
     "numinlets": 1,
     "numoutlets": 1,
     "outlettype": [
      "int"
     ],
     "patching_rect": [
      828.0,
      862.0,
      24.0,
      24.0
     ],
     "parameter_enable": 0
    }
   },
   {
    "box": {
     "id": "c2as",
     "maxclass": "newobj",
     "numinlets": 1,
     "numoutlets": 0,
     "outlettype": [],
     "patching_rect": [
      828.0,
      926.0,
      398.2,
      22.0
     ],
     "text": "test.assert JamomaMax3/ui_active/active_0_switches_it_off"
    }
   },
   {
    "box": {
     "id": "c3eq",
     "maxclass": "newobj",
     "numinlets": 2,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      214.4,
      478.0,
      48.4,
      22.0
     ],
     "text": "== 0"
    }
   },
   {
    "box": {
     "id": "c3tg",
     "maxclass": "toggle",
     "numinlets": 1,
     "numoutlets": 1,
     "outlettype": [
      "int"
     ],
     "patching_rect": [
      214.4,
      542.0,
      24.0,
      24.0
     ],
     "parameter_enable": 0
    }
   },
   {
    "box": {
     "id": "c3as",
     "maxclass": "newobj",
     "numinlets": 1,
     "numoutlets": 0,
     "outlettype": [],
     "patching_rect": [
      214.4,
      606.0,
      437.8,
      22.0
     ],
     "text": "test.assert JamomaMax3/ui_active/active_0_changes_the_parameter"
    }
   },
   {
    "box": {
     "id": "c4eq",
     "maxclass": "newobj",
     "numinlets": 2,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      544.0,
      798.0,
      48.4,
      22.0
     ],
     "text": "== 1"
    }
   },
   {
    "box": {
     "id": "c4tg",
     "maxclass": "toggle",
     "numinlets": 1,
     "numoutlets": 1,
     "outlettype": [
      "int"
     ],
     "patching_rect": [
      1250.2,
      862.0,
      24.0,
      24.0
     ],
     "parameter_enable": 0
    }
   },
   {
    "box": {
     "id": "c4as",
     "maxclass": "newobj",
     "numinlets": 1,
     "numoutlets": 0,
     "outlettype": [],
     "patching_rect": [
      1250.2,
      926.0,
      444.4,
      22.0
     ],
     "text": "test.assert JamomaMax3/ui_active/active_without_argument_toggles"
    }
   },
   {
    "box": {
     "id": "c5eq",
     "maxclass": "newobj",
     "numinlets": 2,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      801.4,
      670.0,
      48.4,
      22.0
     ],
     "text": "== 1"
    }
   },
   {
    "box": {
     "id": "c5tg",
     "maxclass": "toggle",
     "numinlets": 1,
     "numoutlets": 1,
     "outlettype": [
      "int"
     ],
     "patching_rect": [
      801.4,
      734.0,
      24.0,
      24.0
     ],
     "parameter_enable": 0
    }
   },
   {
    "box": {
     "id": "c5as",
     "maxclass": "newobj",
     "numinlets": 1,
     "numoutlets": 0,
     "outlettype": [],
     "patching_rect": [
      801.4,
      798.0,
      536.8,
      22.0
     ],
     "text": "test.assert JamomaMax3/ui_active/active_without_argument_toggles_the_parameter"
    }
   },
   {
    "box": {
     "id": "c6eq",
     "maxclass": "newobj",
     "numinlets": 2,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      1332.4,
      1054.0,
      48.4,
      22.0
     ],
     "text": "== 1"
    }
   },
   {
    "box": {
     "id": "c6tg",
     "maxclass": "toggle",
     "numinlets": 1,
     "numoutlets": 1,
     "outlettype": [
      "int"
     ],
     "patching_rect": [
      1332.4,
      1118.0,
      24.0,
      24.0
     ],
     "parameter_enable": 0
    }
   },
   {
    "box": {
     "id": "c6as",
     "maxclass": "newobj",
     "numinlets": 1,
     "numoutlets": 0,
     "outlettype": [],
     "patching_rect": [
      1332.4,
      1182.0,
      510.4,
      22.0
     ],
     "text": "test.assert JamomaMax3/ui_active/no_active_button_without_the_data_amenity"
    }
   }
  ],
  "lines": [
   {
    "patchline": {
     "destination": [
      "dl0",
      0
     ],
     "source": [
      "init",
      1
     ]
    }
   },
   {
    "patchline": {
     "destination": [
      "dl1",
      0
     ],
     "source": [
      "dl0",
      0
     ]
    }
   },
   {
    "patchline": {
     "destination": [
      "dl2",
      0
     ],
     "source": [
      "dl1",
      0
     ]
    }
   },
   {
    "patchline": {
     "destination": [
      "dl3",
      0
     ],
     "source": [
      "dl2",
      0
     ]
    }
   },
   {
    "patchline": {
     "destination": [
      "dl4",
      0
     ],
     "source": [
      "dl3",
      0
     ]
    }
   },
   {
    "patchline": {
     "destination": [
      "dl5",
      0
     ],
     "source": [
      "dl4",
      0
     ]
    }
   },
   {
    "patchline": {
     "destination": [
      "dl6",
      0
     ],
     "source": [
      "dl5",
      0
     ]
    }
   },
   {
    "patchline": {
     "destination": [
      "dl7",
      0
     ],
     "source": [
      "dl6",
      0
     ]
    }
   },
   {
    "patchline": {
     "destination": [
      "dl8",
      0
     ],
     "source": [
      "dl7",
      0
     ]
    }
   },
   {
    "patchline": {
     "destination": [
      "dl9",
      0
     ],
     "source": [
      "dl8",
      0
     ]
    }
   },
   {
    "patchline": {
     "destination": [
      "dl10",
      0
     ],
     "source": [
      "dl9",
      0
     ]
    }
   },
   {
    "patchline": {
     "destination": [
      "c1eq",
      0
     ],
     "source": [
      "A1",
      0
     ]
    }
   },
   {
    "patchline": {
     "destination": [
      "c1tg",
      0
     ],
     "source": [
      "c1eq",
      0
     ]
    }
   },
   {
    "patchline": {
     "destination": [
      "c1as",
      0
     ],
     "source": [
      "c1tg",
      0
     ]
    }
   },
   {
    "patchline": {
     "destination": [
      "c2eq",
      0
     ],
     "source": [
      "A2",
      0
     ]
    }
   },
   {
    "patchline": {
     "destination": [
      "c2tg",
      0
     ],
     "source": [
      "c2eq",
      0
     ]
    }
   },
   {
    "patchline": {
     "destination": [
      "c2as",
      0
     ],
     "source": [
      "c2tg",
      0
     ]
    }
   },
   {
    "patchline": {
     "destination": [
      "c3eq",
      0
     ],
     "source": [
      "R1",
      0
     ]
    }
   },
   {
    "patchline": {
     "destination": [
      "c3tg",
      0
     ],
     "source": [
      "c3eq",
      0
     ]
    }
   },
   {
    "patchline": {
     "destination": [
      "c3as",
      0
     ],
     "source": [
      "c3tg",
      0
     ]
    }
   },
   {
    "patchline": {
     "destination": [
      "c4eq",
      0
     ],
     "source": [
      "A3",
      0
     ]
    }
   },
   {
    "patchline": {
     "destination": [
      "c4tg",
      0
     ],
     "source": [
      "c4eq",
      0
     ]
    }
   },
   {
    "patchline": {
     "destination": [
      "c4as",
      0
     ],
     "source": [
      "c4tg",
      0
     ]
    }
   },
   {
    "patchline": {
     "destination": [
      "c5eq",
      0
     ],
     "source": [
      "R2",
      0
     ]
    }
   },
   {
    "patchline": {
     "destination": [
      "c5tg",
      0
     ],
     "source": [
      "c5eq",
      0
     ]
    }
   },
   {
    "patchline": {
     "destination": [
      "c5as",
      0
     ],
     "source": [
      "c5tg",
      0
     ]
    }
   },
   {
    "patchline": {
     "destination": [
      "c6eq",
      0
     ],
     "source": [
      "F",
      0
     ]
    }
   },
   {
    "patchline": {
     "destination": [
      "c6tg",
      0
     ],
     "source": [
      "c6eq",
      0
     ]
    }
   },
   {
    "patchline": {
     "destination": [
      "c6as",
      0
     ],
     "source": [
      "c6tg",
      0
     ]
    }
   },
   {
    "patchline": {
     "destination": [
      "dump",
      0
     ],
     "source": [
      "dl0",
      0
     ]
    }
   },
   {
    "patchline": {
     "destination": [
      "ui",
      0
     ],
     "source": [
      "dump",
      0
     ]
    }
   },
   {
    "patchline": {
     "destination": [
      "A1",
      0
     ],
     "source": [
      "dl1",
      0
     ]
    }
   },
   {
    "patchline": {
     "destination": [
      "off",
      0
     ],
     "source": [
      "dl2",
      0
     ]
    }
   },
   {
    "patchline": {
     "destination": [
      "ui",
      0
     ],
     "source": [
      "off",
      0
     ]
    }
   },
   {
    "patchline": {
     "destination": [
      "dump",
      0
     ],
     "source": [
      "dl3",
      0
     ]
    }
   },
   {
    "patchline": {
     "destination": [
      "A2",
      0
     ],
     "source": [
      "dl4",
      0
     ]
    }
   },
   {
    "patchline": {
     "destination": [
      "R1",
      0
     ],
     "source": [
      "dl4",
      0
     ]
    }
   },
   {
    "patchline": {
     "destination": [
      "tog",
      0
     ],
     "source": [
      "dl5",
      0
     ]
    }
   },
   {
    "patchline": {
     "destination": [
      "ui",
      0
     ],
     "source": [
      "tog",
      0
     ]
    }
   },
   {
    "patchline": {
     "destination": [
      "dump",
      0
     ],
     "source": [
      "dl6",
      0
     ]
    }
   },
   {
    "patchline": {
     "destination": [
      "A3",
      0
     ],
     "source": [
      "dl7",
      0
     ]
    }
   },
   {
    "patchline": {
     "destination": [
      "R2",
      0
     ],
     "source": [
      "dl7",
      0
     ]
    }
   },
   {
    "patchline": {
     "destination": [
      "dump2",
      0
     ],
     "source": [
      "dl8",
      0
     ]
    }
   },
   {
    "patchline": {
     "destination": [
      "nodata",
      0
     ],
     "source": [
      "dump2",
      0
     ]
    }
   },
   {
    "patchline": {
     "destination": [
      "F",
      0
     ],
     "source": [
      "dl9",
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
      "dl10",
      0
     ]
    }
   },
   {
    "patchline": {
     "destination": [
      "rt",
      0
     ],
     "source": [
      "ui",
      0
     ]
    }
   },
   {
    "patchline": {
     "destination": [
      "A1",
      1
     ],
     "source": [
      "rt",
      0
     ]
    }
   },
   {
    "patchline": {
     "destination": [
      "A2",
      1
     ],
     "source": [
      "rt",
      0
     ]
    }
   },
   {
    "patchline": {
     "destination": [
      "A3",
      1
     ],
     "source": [
      "rt",
      0
     ]
    }
   },
   {
    "patchline": {
     "destination": [
      "R1",
      1
     ],
     "source": [
      "rcv",
      0
     ]
    }
   },
   {
    "patchline": {
     "destination": [
      "R2",
      1
     ],
     "source": [
      "rcv",
      0
     ]
    }
   },
   {
    "patchline": {
     "destination": [
      "rt2",
      0
     ],
     "source": [
      "nodata",
      0
     ]
    }
   },
   {
    "patchline": {
     "destination": [
      "tb",
      0
     ],
     "source": [
      "rt2",
      0
     ]
    }
   },
   {
    "patchline": {
     "destination": [
      "zero",
      0
     ],
     "source": [
      "tb",
      0
     ]
    }
   },
   {
    "patchline": {
     "destination": [
      "F",
      1
     ],
     "source": [
      "zero",
      0
     ]
    }
   }
  ],
  "autosave": 0,
  "dependency_cache": []
 }
}
