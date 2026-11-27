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
   3909.6,
   338.0
  ],
  "boxes": [
   {
    "box": {
     "id": "about",
     "maxclass": "comment",
     "numinlets": 1,
     "numoutlets": 0,
     "outlettype": [],
     "patching_rect": [
      30.0,
      30.0,
      410.6,
      20.0
     ],
     "text": "A model outputs the changes of the parameters of a model inside it."
    }
   },
   {
    "box": {
     "id": "obj-1",
     "maxclass": "newobj",
     "numinlets": 1,
     "numoutlets": 2,
     "outlettype": [
      "",
      ""
     ],
     "patching_rect": [
      3655.0,
      30.0,
      62.6,
      22.0
     ],
     "text": "j.model"
    }
   },
   {
    "box": {
     "id": "obj-1_s0",
     "maxclass": "newobj",
     "numinlets": 1,
     "numoutlets": 0,
     "outlettype": [],
     "patching_rect": [
      3655.0,
      94.0,
      138.0,
      22.0
     ],
     "text": "s mod_chi_from_model"
    }
   },
   {
    "box": {
     "annotation": "none",
     "id": "obj-4",
     "maxclass": "newobj",
     "numinlets": 1,
     "numoutlets": 0,
     "patcher": {
      "fileversion": 1,
      "appversion": {
       "major": 8,
       "minor": 5,
       "revision": 7,
       "architecture": "x64",
       "modernui": 1
      },
      "classnamespace": "box",
      "rect": [
       59.0,
       115.0,
       1390.4,
       274.0
      ],
      "bglocked": 0,
      "openinpresentation": 0,
      "default_fontsize": 12.0,
      "default_fontface": 0,
      "default_fontname": "Arial",
      "gridonopen": 1,
      "gridsize": [
       15.0,
       15.0
      ],
      "gridsnaponopen": 1,
      "objectsnaponopen": 1,
      "statusbarvisible": 2,
      "toolbarvisible": 1,
      "lefttoolbarpinned": 0,
      "toptoolbarpinned": 0,
      "righttoolbarpinned": 0,
      "bottomtoolbarpinned": 0,
      "toolbars_unpinned_last_save": 0,
      "tallnewobj": 0,
      "boxanimatetime": 200,
      "enablehscroll": 1,
      "enablevscroll": 1,
      "devicewidth": 0.0,
      "description": "",
      "digest": "",
      "tags": "",
      "style": "",
      "subpatcher_template": "",
      "assistshowspatchername": 0,
      "boxes": [
       {
        "box": {
         "id": "obj-1",
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
          62.6,
          22.0
         ],
         "text": "j.model"
        }
       },
       {
        "box": {
         "id": "obj-12",
         "maxclass": "message",
         "numinlets": 2,
         "numoutlets": 1,
         "outlettype": [
          ""
         ],
         "patching_rect": [
          1077.4,
          158.0,
          80.0,
          22.0
         ],
         "text": "5.67 foo 2"
        }
       },
       {
        "box": {
         "id": "obj-4",
         "maxclass": "message",
         "numinlets": 2,
         "numoutlets": 1,
         "outlettype": [
          ""
         ],
         "patching_rect": [
          967.6,
          158.0,
          85.8,
          22.0
         ],
         "text": "1.1 2.2 3.3"
        }
       },
       {
        "box": {
         "id": "obj-27",
         "maxclass": "newobj",
         "numinlets": 1,
         "numoutlets": 2,
         "outlettype": [
          "",
          ""
         ],
         "patching_rect": [
          1170.2,
          222.0,
          190.2,
          22.0
         ],
         "text": "j.parameter fff @type generic"
        }
       },
       {
        "box": {
         "id": "obj-26",
         "maxclass": "newobj",
         "numinlets": 1,
         "numoutlets": 2,
         "outlettype": [
          "",
          ""
         ],
         "patching_rect": [
          967.6,
          222.0,
          178.6,
          22.0
         ],
         "text": "j.parameter eee @type array"
        }
       },
       {
        "box": {
         "id": "obj-25",
         "maxclass": "newobj",
         "numinlets": 1,
         "numoutlets": 2,
         "outlettype": [
          "",
          ""
         ],
         "patching_rect": [
          753.4,
          158.0,
          190.2,
          22.0
         ],
         "text": "j.parameter ddd @type boolean"
        }
       },
       {
        "box": {
         "id": "obj-24",
         "maxclass": "newobj",
         "numinlets": 1,
         "numoutlets": 2,
         "outlettype": [
          "",
          ""
         ],
         "patching_rect": [
          545.0,
          158.0,
          184.4,
          22.0
         ],
         "text": "j.parameter ccc @type string"
        }
       },
       {
        "box": {
         "id": "obj-23",
         "maxclass": "newobj",
         "numinlets": 1,
         "numoutlets": 2,
         "outlettype": [
          "",
          ""
         ],
         "patching_rect": [
          330.8,
          158.0,
          190.2,
          22.0
         ],
         "text": "j.parameter bbb @type integer"
        }
       },
       {
        "box": {
         "id": "obj-22",
         "maxclass": "newobj",
         "numinlets": 1,
         "numoutlets": 6,
         "outlettype": [
          "float",
          "int",
          "hello",
          "int",
          "bang",
          "bang"
         ],
         "patching_rect": [
          116.6,
          94.0,
          143.8,
          22.0
         ],
         "text": "t 3.14 54 hello 1 b b"
        }
       },
       {
        "box": {
         "id": "obj-2",
         "maxclass": "newobj",
         "numinlets": 1,
         "numoutlets": 2,
         "outlettype": [
          "",
          ""
         ],
         "patching_rect": [
          116.6,
          158.0,
          190.2,
          22.0
         ],
         "text": "j.parameter aaa @type decimal"
        }
       },
       {
        "box": {
         "comment": "",
         "id": "obj-3",
         "index": 1,
         "maxclass": "inlet",
         "numinlets": 0,
         "numoutlets": 1,
         "outlettype": [
          "bang"
         ],
         "patching_rect": [
          116.6,
          30.0,
          40.0,
          22.0
         ]
        }
       }
      ],
      "lines": [
       {
        "patchline": {
         "destination": [
          "obj-27",
          0
         ],
         "source": [
          "obj-12",
          0
         ]
        }
       },
       {
        "patchline": {
         "destination": [
          "obj-12",
          0
         ],
         "source": [
          "obj-22",
          5
         ]
        }
       },
       {
        "patchline": {
         "destination": [
          "obj-2",
          0
         ],
         "source": [
          "obj-22",
          0
         ]
        }
       },
       {
        "patchline": {
         "destination": [
          "obj-23",
          0
         ],
         "source": [
          "obj-22",
          1
         ]
        }
       },
       {
        "patchline": {
         "destination": [
          "obj-24",
          0
         ],
         "source": [
          "obj-22",
          2
         ]
        }
       },
       {
        "patchline": {
         "destination": [
          "obj-25",
          0
         ],
         "source": [
          "obj-22",
          3
         ]
        }
       },
       {
        "patchline": {
         "destination": [
          "obj-4",
          0
         ],
         "source": [
          "obj-22",
          4
         ]
        }
       },
       {
        "patchline": {
         "destination": [
          "obj-22",
          0
         ],
         "source": [
          "obj-3",
          0
         ]
        }
       },
       {
        "patchline": {
         "destination": [
          "obj-26",
          0
         ],
         "source": [
          "obj-4",
          0
         ]
        }
       }
      ]
     },
     "patching_rect": [
      3817.0,
      94.0,
      62.6,
      22.0
     ],
     "saved_object_attributes": {
      "description": "",
      "digest": "",
      "globalpatchername": "",
      "tags": ""
     },
     "text": "p child"
    }
   },
   {
    "box": {
     "id": "obj-4_r0",
     "maxclass": "newobj",
     "numinlets": 0,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      3741.6,
      30.0,
      126.4,
      22.0
     ],
     "text": "r mod_chi_to_child"
    }
   },
   {
    "box": {
     "id": "obj-11",
     "maxclass": "newobj",
     "numinlets": 1,
     "numoutlets": 2,
     "outlettype": [
      "bang",
      "bang"
     ],
     "patching_rect": [
      30.0,
      60.0,
      56.8,
      22.0
     ],
     "text": "j.init"
    }
   },
   {
    "box": {
     "id": "step0",
     "maxclass": "newobj",
     "numinlets": 1,
     "numoutlets": 7,
     "outlettype": [
      "",
      "",
      "",
      "",
      "",
      "",
      ""
     ],
     "patching_rect": [
      30.0,
      124.0,
      3080.0,
      22.0
     ],
     "text": "p change_the_child",
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
       1072.0,
       410.0
      ],
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
         ]
        }
       },
       {
        "box": {
         "id": "r0_0",
         "maxclass": "newobj",
         "numinlets": 0,
         "numoutlets": 1,
         "outlettype": [
          ""
         ],
         "patching_rect": [
          94.0,
          30.0,
          138.0,
          22.0
         ],
         "text": "r mod_chi_from_model"
        }
       },
       {
        "box": {
         "id": "o0_0_0",
         "maxclass": "newobj",
         "numinlets": 2,
         "numoutlets": 2,
         "outlettype": [
          "",
          ""
         ],
         "patching_rect": [
          267.4,
          94.0,
          109.0,
          22.0
         ],
         "text": "route child/aaa"
        }
       },
       {
        "box": {
         "id": "h0_0",
         "maxclass": "newobj",
         "numinlets": 2,
         "numoutlets": 1,
         "outlettype": [
          ""
         ],
         "patching_rect": [
          452.0,
          158.0,
          74.2,
          22.0
         ],
         "text": "float -1."
        }
       },
       {
        "box": {
         "id": "c0_0",
         "maxclass": "newobj",
         "numinlets": 2,
         "numoutlets": 1,
         "outlettype": [
          ""
         ],
         "patching_rect": [
          644.8,
          222.0,
          62.6,
          22.0
         ],
         "text": "== 3.14"
        }
       },
       {
        "box": {
         "id": "r1_0",
         "maxclass": "newobj",
         "numinlets": 0,
         "numoutlets": 1,
         "outlettype": [
          ""
         ],
         "patching_rect": [
          256.0,
          30.0,
          138.0,
          22.0
         ],
         "text": "r mod_chi_from_model"
        }
       },
       {
        "box": {
         "id": "o1_0_0",
         "maxclass": "newobj",
         "numinlets": 2,
         "numoutlets": 2,
         "outlettype": [
          "",
          ""
         ],
         "patching_rect": [
          400.4,
          94.0,
          109.0,
          22.0
         ],
         "text": "route child/bbb"
        }
       },
       {
        "box": {
         "id": "h1_0",
         "maxclass": "newobj",
         "numinlets": 2,
         "numoutlets": 1,
         "outlettype": [
          ""
         ],
         "patching_rect": [
          550.2,
          158.0,
          56.8,
          22.0
         ],
         "text": "int -1"
        }
       },
       {
        "box": {
         "id": "c1_0",
         "maxclass": "newobj",
         "numinlets": 2,
         "numoutlets": 1,
         "outlettype": [
          ""
         ],
         "patching_rect": [
          731.4,
          222.0,
          51.0,
          22.0
         ],
         "text": "== 54"
        }
       },
       {
        "box": {
         "id": "r2_0",
         "maxclass": "newobj",
         "numinlets": 0,
         "numoutlets": 1,
         "outlettype": [
          ""
         ],
         "patching_rect": [
          418.0,
          30.0,
          138.0,
          22.0
         ],
         "text": "r mod_chi_from_model"
        }
       },
       {
        "box": {
         "id": "o2_0_0",
         "maxclass": "newobj",
         "numinlets": 2,
         "numoutlets": 2,
         "outlettype": [
          "",
          ""
         ],
         "patching_rect": [
          533.4,
          94.0,
          109.0,
          22.0
         ],
         "text": "route child/ccc"
        }
       },
       {
        "box": {
         "id": "h2_0",
         "maxclass": "newobj",
         "numinlets": 2,
         "numoutlets": 2,
         "outlettype": [
          "",
          ""
         ],
         "patching_rect": [
          315.4,
          222.0,
          85.8,
          22.0
         ],
         "text": "zl reg none"
        }
       },
       {
        "box": {
         "id": "c2_0",
         "maxclass": "newobj",
         "numinlets": 2,
         "numoutlets": 2,
         "outlettype": [
          "",
          ""
         ],
         "patching_rect": [
          315.4,
          286.0,
          114.8,
          22.0
         ],
         "text": "zl compare hello"
        }
       },
       {
        "box": {
         "id": "r3_0",
         "maxclass": "newobj",
         "numinlets": 0,
         "numoutlets": 1,
         "outlettype": [
          ""
         ],
         "patching_rect": [
          580.0,
          30.0,
          138.0,
          22.0
         ],
         "text": "r mod_chi_from_model"
        }
       },
       {
        "box": {
         "id": "o3_0_0",
         "maxclass": "newobj",
         "numinlets": 2,
         "numoutlets": 2,
         "outlettype": [
          "",
          ""
         ],
         "patching_rect": [
          666.4,
          94.0,
          109.0,
          22.0
         ],
         "text": "route child/ddd"
        }
       },
       {
        "box": {
         "id": "h3_0",
         "maxclass": "newobj",
         "numinlets": 2,
         "numoutlets": 1,
         "outlettype": [
          ""
         ],
         "patching_rect": [
          631.0,
          158.0,
          56.8,
          22.0
         ],
         "text": "int -1"
        }
       },
       {
        "box": {
         "id": "c3_0",
         "maxclass": "newobj",
         "numinlets": 2,
         "numoutlets": 1,
         "outlettype": [
          ""
         ],
         "patching_rect": [
          806.4,
          222.0,
          45.2,
          22.0
         ],
         "text": "== 1"
        }
       },
       {
        "box": {
         "id": "r4_0",
         "maxclass": "newobj",
         "numinlets": 0,
         "numoutlets": 1,
         "outlettype": [
          ""
         ],
         "patching_rect": [
          742.0,
          30.0,
          138.0,
          22.0
         ],
         "text": "r mod_chi_from_model"
        }
       },
       {
        "box": {
         "id": "o4_0_0",
         "maxclass": "newobj",
         "numinlets": 2,
         "numoutlets": 2,
         "outlettype": [
          "",
          ""
         ],
         "patching_rect": [
          799.4,
          94.0,
          109.0,
          22.0
         ],
         "text": "route child/eee"
        }
       },
       {
        "box": {
         "id": "h4_0",
         "maxclass": "newobj",
         "numinlets": 2,
         "numoutlets": 2,
         "outlettype": [
          "",
          ""
         ],
         "patching_rect": [
          425.2,
          222.0,
          85.8,
          22.0
         ],
         "text": "zl reg none"
        }
       },
       {
        "box": {
         "id": "c4_0",
         "maxclass": "newobj",
         "numinlets": 2,
         "numoutlets": 2,
         "outlettype": [
          "",
          ""
         ],
         "patching_rect": [
          454.2,
          286.0,
          149.6,
          22.0
         ],
         "text": "zl compare 1.1 2.2 3.3"
        }
       },
       {
        "box": {
         "id": "r5_0",
         "maxclass": "newobj",
         "numinlets": 0,
         "numoutlets": 1,
         "outlettype": [
          ""
         ],
         "patching_rect": [
          904.0,
          30.0,
          138.0,
          22.0
         ],
         "text": "r mod_chi_from_model"
        }
       },
       {
        "box": {
         "id": "o5_0_0",
         "maxclass": "newobj",
         "numinlets": 2,
         "numoutlets": 2,
         "outlettype": [
          "",
          ""
         ],
         "patching_rect": [
          932.4,
          94.0,
          109.0,
          22.0
         ],
         "text": "route child/fff"
        }
       },
       {
        "box": {
         "id": "h5_0",
         "maxclass": "newobj",
         "numinlets": 2,
         "numoutlets": 2,
         "outlettype": [
          "",
          ""
         ],
         "patching_rect": [
          535.0,
          222.0,
          85.8,
          22.0
         ],
         "text": "zl reg none"
        }
       },
       {
        "box": {
         "id": "c5_0",
         "maxclass": "newobj",
         "numinlets": 2,
         "numoutlets": 2,
         "outlettype": [
          "",
          ""
         ],
         "patching_rect": [
          627.8,
          286.0,
          143.8,
          22.0
         ],
         "text": "zl compare 5.67 foo 2"
        }
       },
       {
        "box": {
         "id": "done",
         "maxclass": "outlet",
         "numinlets": 1,
         "numoutlets": 0,
         "outlettype": [],
         "patching_rect": [
          30.0,
          350.0,
          30.0,
          30.0
         ]
        }
       },
       {
        "box": {
         "id": "out0",
         "maxclass": "outlet",
         "numinlets": 1,
         "numoutlets": 0,
         "outlettype": [],
         "patching_rect": [
          120.0,
          350.0,
          30.0,
          30.0
         ]
        }
       },
       {
        "box": {
         "id": "out1",
         "maxclass": "outlet",
         "numinlets": 1,
         "numoutlets": 0,
         "outlettype": [],
         "patching_rect": [
          210.0,
          350.0,
          30.0,
          30.0
         ]
        }
       },
       {
        "box": {
         "id": "out2",
         "maxclass": "outlet",
         "numinlets": 1,
         "numoutlets": 0,
         "outlettype": [],
         "patching_rect": [
          300.0,
          350.0,
          30.0,
          30.0
         ]
        }
       },
       {
        "box": {
         "id": "out3",
         "maxclass": "outlet",
         "numinlets": 1,
         "numoutlets": 0,
         "outlettype": [],
         "patching_rect": [
          390.0,
          350.0,
          30.0,
          30.0
         ]
        }
       },
       {
        "box": {
         "id": "out4",
         "maxclass": "outlet",
         "numinlets": 1,
         "numoutlets": 0,
         "outlettype": [],
         "patching_rect": [
          480.0,
          350.0,
          30.0,
          30.0
         ]
        }
       },
       {
        "box": {
         "id": "out5",
         "maxclass": "outlet",
         "numinlets": 1,
         "numoutlets": 0,
         "outlettype": [],
         "patching_rect": [
          570.0,
          350.0,
          30.0,
          30.0
         ]
        }
       },
       {
        "box": {
         "id": "t0",
         "maxclass": "newobj",
         "numinlets": 1,
         "numoutlets": 14,
         "outlettype": [
          "",
          "",
          "",
          "",
          "",
          "",
          "",
          "",
          "",
          "",
          "",
          "",
          "",
          ""
         ],
         "patching_rect": [
          30.0,
          94.0,
          213.4,
          22.0
         ],
         "text": "t b b b b b b b b b b -1 b -1 -1."
        }
       },
       {
        "box": {
         "id": "z0_2",
         "maxclass": "message",
         "numinlets": 2,
         "numoutlets": 1,
         "outlettype": [
          ""
         ],
         "patching_rect": [
          382.8,
          158.0,
          45.2,
          22.0
         ],
         "text": "none"
        }
       },
       {
        "box": {
         "id": "z0_4",
         "maxclass": "message",
         "numinlets": 2,
         "numoutlets": 1,
         "outlettype": [
          ""
         ],
         "patching_rect": [
          313.6,
          158.0,
          45.2,
          22.0
         ],
         "text": "none"
        }
       },
       {
        "box": {
         "id": "z0_5",
         "maxclass": "message",
         "numinlets": 2,
         "numoutlets": 1,
         "outlettype": [
          ""
         ],
         "patching_rect": [
          244.4,
          158.0,
          45.2,
          22.0
         ],
         "text": "none"
        }
       },
       {
        "box": {
         "id": "s0_6",
         "maxclass": "newobj",
         "numinlets": 1,
         "numoutlets": 0,
         "outlettype": [],
         "patching_rect": [
          94.0,
          158.0,
          126.4,
          22.0
         ],
         "text": "s mod_chi_to_child"
        }
       }
      ],
      "lines": [
       {
        "patchline": {
         "source": [
          "r0_0",
          0
         ],
         "destination": [
          "o0_0_0",
          0
         ]
        }
       },
       {
        "patchline": {
         "source": [
          "o0_0_0",
          0
         ],
         "destination": [
          "h0_0",
          1
         ]
        }
       },
       {
        "patchline": {
         "source": [
          "h0_0",
          0
         ],
         "destination": [
          "c0_0",
          0
         ]
        }
       },
       {
        "patchline": {
         "source": [
          "r1_0",
          0
         ],
         "destination": [
          "o1_0_0",
          0
         ]
        }
       },
       {
        "patchline": {
         "source": [
          "o1_0_0",
          0
         ],
         "destination": [
          "h1_0",
          1
         ]
        }
       },
       {
        "patchline": {
         "source": [
          "h1_0",
          0
         ],
         "destination": [
          "c1_0",
          0
         ]
        }
       },
       {
        "patchline": {
         "source": [
          "r2_0",
          0
         ],
         "destination": [
          "o2_0_0",
          0
         ]
        }
       },
       {
        "patchline": {
         "source": [
          "o2_0_0",
          0
         ],
         "destination": [
          "h2_0",
          1
         ]
        }
       },
       {
        "patchline": {
         "source": [
          "h2_0",
          0
         ],
         "destination": [
          "c2_0",
          0
         ]
        }
       },
       {
        "patchline": {
         "source": [
          "r3_0",
          0
         ],
         "destination": [
          "o3_0_0",
          0
         ]
        }
       },
       {
        "patchline": {
         "source": [
          "o3_0_0",
          0
         ],
         "destination": [
          "h3_0",
          1
         ]
        }
       },
       {
        "patchline": {
         "source": [
          "h3_0",
          0
         ],
         "destination": [
          "c3_0",
          0
         ]
        }
       },
       {
        "patchline": {
         "source": [
          "r4_0",
          0
         ],
         "destination": [
          "o4_0_0",
          0
         ]
        }
       },
       {
        "patchline": {
         "source": [
          "o4_0_0",
          0
         ],
         "destination": [
          "h4_0",
          1
         ]
        }
       },
       {
        "patchline": {
         "source": [
          "h4_0",
          0
         ],
         "destination": [
          "c4_0",
          0
         ]
        }
       },
       {
        "patchline": {
         "source": [
          "r5_0",
          0
         ],
         "destination": [
          "o5_0_0",
          0
         ]
        }
       },
       {
        "patchline": {
         "source": [
          "o5_0_0",
          0
         ],
         "destination": [
          "h5_0",
          1
         ]
        }
       },
       {
        "patchline": {
         "source": [
          "h5_0",
          0
         ],
         "destination": [
          "c5_0",
          0
         ]
        }
       },
       {
        "patchline": {
         "source": [
          "c0_0",
          0
         ],
         "destination": [
          "out0",
          0
         ]
        }
       },
       {
        "patchline": {
         "source": [
          "c1_0",
          0
         ],
         "destination": [
          "out1",
          0
         ]
        }
       },
       {
        "patchline": {
         "source": [
          "c2_0",
          0
         ],
         "destination": [
          "out2",
          0
         ]
        }
       },
       {
        "patchline": {
         "source": [
          "c3_0",
          0
         ],
         "destination": [
          "out3",
          0
         ]
        }
       },
       {
        "patchline": {
         "source": [
          "c4_0",
          0
         ],
         "destination": [
          "out4",
          0
         ]
        }
       },
       {
        "patchline": {
         "source": [
          "c5_0",
          0
         ],
         "destination": [
          "out5",
          0
         ]
        }
       },
       {
        "patchline": {
         "source": [
          "in",
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
          "t0",
          13
         ],
         "destination": [
          "h0_0",
          1
         ]
        }
       },
       {
        "patchline": {
         "source": [
          "t0",
          12
         ],
         "destination": [
          "h1_0",
          1
         ]
        }
       },
       {
        "patchline": {
         "source": [
          "t0",
          11
         ],
         "destination": [
          "z0_2",
          0
         ]
        }
       },
       {
        "patchline": {
         "source": [
          "z0_2",
          0
         ],
         "destination": [
          "h2_0",
          1
         ]
        }
       },
       {
        "patchline": {
         "source": [
          "t0",
          10
         ],
         "destination": [
          "h3_0",
          1
         ]
        }
       },
       {
        "patchline": {
         "source": [
          "t0",
          9
         ],
         "destination": [
          "z0_4",
          0
         ]
        }
       },
       {
        "patchline": {
         "source": [
          "z0_4",
          0
         ],
         "destination": [
          "h4_0",
          1
         ]
        }
       },
       {
        "patchline": {
         "source": [
          "t0",
          8
         ],
         "destination": [
          "z0_5",
          0
         ]
        }
       },
       {
        "patchline": {
         "source": [
          "z0_5",
          0
         ],
         "destination": [
          "h5_0",
          1
         ]
        }
       },
       {
        "patchline": {
         "source": [
          "t0",
          7
         ],
         "destination": [
          "s0_6",
          0
         ]
        }
       },
       {
        "patchline": {
         "source": [
          "t0",
          6
         ],
         "destination": [
          "h0_0",
          0
         ]
        }
       },
       {
        "patchline": {
         "source": [
          "t0",
          5
         ],
         "destination": [
          "h1_0",
          0
         ]
        }
       },
       {
        "patchline": {
         "source": [
          "t0",
          4
         ],
         "destination": [
          "h2_0",
          0
         ]
        }
       },
       {
        "patchline": {
         "source": [
          "t0",
          3
         ],
         "destination": [
          "h3_0",
          0
         ]
        }
       },
       {
        "patchline": {
         "source": [
          "t0",
          2
         ],
         "destination": [
          "h4_0",
          0
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
          "h5_0",
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
          "done",
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
     "id": "step0_a0",
     "maxclass": "newobj",
     "numinlets": 1,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      540.2,
      194.0,
      486.0,
      22.0
     ],
     "text": "test.assert Jamoma/Modular/j.model/outputs_nested_model_parameter_change/decimal"
    }
   },
   {
    "box": {
     "id": "step0_a1",
     "maxclass": "newobj",
     "numinlets": 1,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      1050.3,
      194.0,
      486.0,
      22.0
     ],
     "text": "test.assert Jamoma/Modular/j.model/outputs_nested_model_parameter_change/integer"
    }
   },
   {
    "box": {
     "id": "step0_a2",
     "maxclass": "newobj",
     "numinlets": 1,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      1560.5,
      194.0,
      480.2,
      22.0
     ],
     "text": "test.assert Jamoma/Modular/j.model/outputs_nested_model_parameter_change/string"
    }
   },
   {
    "box": {
     "id": "step0_a3",
     "maxclass": "newobj",
     "numinlets": 1,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      2070.7,
      194.0,
      486.0,
      22.0
     ],
     "text": "test.assert Jamoma/Modular/j.model/outputs_nested_model_parameter_change/boolean"
    }
   },
   {
    "box": {
     "id": "step0_a4",
     "maxclass": "newobj",
     "numinlets": 1,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      2580.8,
      194.0,
      474.4,
      22.0
     ],
     "text": "test.assert Jamoma/Modular/j.model/outputs_nested_model_parameter_change/array"
    }
   },
   {
    "box": {
     "id": "step0_a5",
     "maxclass": "newobj",
     "numinlets": 1,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      3091.0,
      194.0,
      486.0,
      22.0
     ],
     "text": "test.assert Jamoma/Modular/j.model/outputs_nested_model_parameter_change/generic"
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
      244.0,
      103.2,
      22.0
     ],
     "text": "test.terminate"
    }
   },
   {
    "box": {
     "id": "tg_step0_a0",
     "maxclass": "toggle",
     "numinlets": 1,
     "numoutlets": 1,
     "outlettype": [
      "int"
     ],
     "parameter_enable": 0,
     "patching_rect": [
      540.2,
      160.0,
      24.0,
      24.0
     ]
    }
   },
   {
    "box": {
     "id": "tg_step0_a1",
     "maxclass": "toggle",
     "numinlets": 1,
     "numoutlets": 1,
     "outlettype": [
      "int"
     ],
     "parameter_enable": 0,
     "patching_rect": [
      1050.3,
      160.0,
      24.0,
      24.0
     ]
    }
   },
   {
    "box": {
     "id": "tg_step0_a2",
     "maxclass": "toggle",
     "numinlets": 1,
     "numoutlets": 1,
     "outlettype": [
      "int"
     ],
     "parameter_enable": 0,
     "patching_rect": [
      1560.5,
      160.0,
      24.0,
      24.0
     ]
    }
   },
   {
    "box": {
     "id": "tg_step0_a3",
     "maxclass": "toggle",
     "numinlets": 1,
     "numoutlets": 1,
     "outlettype": [
      "int"
     ],
     "parameter_enable": 0,
     "patching_rect": [
      2070.7,
      160.0,
      24.0,
      24.0
     ]
    }
   },
   {
    "box": {
     "id": "tg_step0_a4",
     "maxclass": "toggle",
     "numinlets": 1,
     "numoutlets": 1,
     "outlettype": [
      "int"
     ],
     "parameter_enable": 0,
     "patching_rect": [
      2580.8,
      160.0,
      24.0,
      24.0
     ]
    }
   },
   {
    "box": {
     "id": "tg_step0_a5",
     "maxclass": "toggle",
     "numinlets": 1,
     "numoutlets": 1,
     "outlettype": [
      "int"
     ],
     "parameter_enable": 0,
     "patching_rect": [
      3091.0,
      160.0,
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
      "obj-1",
      0
     ],
     "destination": [
      "obj-1_s0",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "obj-4_r0",
      0
     ],
     "destination": [
      "obj-4",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "obj-11",
      1
     ],
     "destination": [
      "step0",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "step0",
      1
     ],
     "destination": [
      "tg_step0_a0",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "step0",
      2
     ],
     "destination": [
      "tg_step0_a1",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "step0",
      3
     ],
     "destination": [
      "tg_step0_a2",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "step0",
      4
     ],
     "destination": [
      "tg_step0_a3",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "step0",
      5
     ],
     "destination": [
      "tg_step0_a4",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "step0",
      6
     ],
     "destination": [
      "tg_step0_a5",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "step0",
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
      "tg_step0_a0",
      0
     ],
     "destination": [
      "step0_a0",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "tg_step0_a1",
      0
     ],
     "destination": [
      "step0_a1",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "tg_step0_a2",
      0
     ],
     "destination": [
      "step0_a2",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "tg_step0_a3",
      0
     ],
     "destination": [
      "step0_a3",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "tg_step0_a4",
      0
     ],
     "destination": [
      "step0_a4",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "tg_step0_a5",
      0
     ],
     "destination": [
      "step0_a5",
      0
     ]
    }
   }
  ]
 }
}
