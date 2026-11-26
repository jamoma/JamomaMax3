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
   3222.2,
   850.0
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
     "id": "um",
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
      286.0,
      385.0,
      22.0
     ],
     "text": "j.namespace @address /pm @output children @format umenu"
    }
   },
   {
    "box": {
     "id": "up",
     "maxclass": "newobj",
     "numinlets": 1,
     "numoutlets": 3,
     "outlettype": [
      "",
      "",
      ""
     ],
     "patching_rect": [
      1190.8,
      286.0,
      431.2,
      22.0
     ],
     "text": "j.namespace @address /pm @output children @format umenu_prefix"
    }
   },
   {
    "box": {
     "id": "cb",
     "maxclass": "newobj",
     "numinlets": 1,
     "numoutlets": 3,
     "outlettype": [
      "",
      "",
      ""
     ],
     "patching_rect": [
      1646.0,
      286.0,
      437.8,
      22.0
     ],
     "text": "j.namespace @address /pm @output children @format jit.cellblock"
    }
   },
   {
    "box": {
     "id": "co",
     "maxclass": "newobj",
     "numinlets": 1,
     "numoutlets": 3,
     "outlettype": [
      "",
      "",
      ""
     ],
     "patching_rect": [
      2107.8,
      286.0,
      378.4,
      22.0
     ],
     "text": "j.namespace @address /pm @output children @format coll"
    }
   },
   {
    "box": {
     "id": "cu_rt",
     "maxclass": "newobj",
     "numinlets": 1,
     "numoutlets": 2,
     "outlettype": [
      "",
      ""
     ],
     "patching_rect": [
      781.8,
      350.0,
      101.2,
      22.0
     ],
     "text": "route append"
    }
   },
   {
    "box": {
     "id": "cu_t",
     "maxclass": "newobj",
     "numinlets": 1,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      781.8,
      414.0,
      41.8,
      22.0
     ],
     "text": "t b"
    }
   },
   {
    "box": {
     "id": "cu_i",
     "maxclass": "newobj",
     "numinlets": 2,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      781.8,
      478.0,
      41.8,
      22.0
     ],
     "text": "int"
    }
   },
   {
    "box": {
     "id": "cu_p",
     "maxclass": "newobj",
     "numinlets": 2,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      781.8,
      542.0,
      41.8,
      22.0
     ],
     "text": "+ 1"
    }
   },
   {
    "box": {
     "id": "cu_n",
     "maxclass": "newobj",
     "numinlets": 2,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      1731.8,
      606.0,
      41.8,
      22.0
     ],
     "text": "int"
    }
   },
   {
    "box": {
     "id": "cc_rt",
     "maxclass": "newobj",
     "numinlets": 1,
     "numoutlets": 2,
     "outlettype": [
      "",
      ""
     ],
     "patching_rect": [
      907.0,
      350.0,
      94.6,
      22.0
     ],
     "text": "route clear"
    }
   },
   {
    "box": {
     "id": "cc_t",
     "maxclass": "newobj",
     "numinlets": 1,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      907.0,
      414.0,
      41.8,
      22.0
     ],
     "text": "t b"
    }
   },
   {
    "box": {
     "id": "cc_i",
     "maxclass": "newobj",
     "numinlets": 2,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      847.6,
      478.0,
      41.8,
      22.0
     ],
     "text": "int"
    }
   },
   {
    "box": {
     "id": "cc_p",
     "maxclass": "newobj",
     "numinlets": 2,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      847.6,
      542.0,
      41.8,
      22.0
     ],
     "text": "+ 1"
    }
   },
   {
    "box": {
     "id": "cc_n",
     "maxclass": "newobj",
     "numinlets": 2,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      1797.6,
      606.0,
      41.8,
      22.0
     ],
     "text": "int"
    }
   },
   {
    "box": {
     "id": "co_c_rt",
     "maxclass": "newobj",
     "numinlets": 1,
     "numoutlets": 2,
     "outlettype": [
      "",
      ""
     ],
     "patching_rect": [
      2107.8,
      350.0,
      94.6,
      22.0
     ],
     "text": "route store"
    }
   },
   {
    "box": {
     "id": "co_c_t",
     "maxclass": "newobj",
     "numinlets": 1,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      2107.8,
      414.0,
      41.8,
      22.0
     ],
     "text": "t b"
    }
   },
   {
    "box": {
     "id": "co_c_i",
     "maxclass": "newobj",
     "numinlets": 2,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      1444.8,
      478.0,
      41.8,
      22.0
     ],
     "text": "int"
    }
   },
   {
    "box": {
     "id": "co_c_p",
     "maxclass": "newobj",
     "numinlets": 2,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      1444.8,
      542.0,
      41.8,
      22.0
     ],
     "text": "+ 1"
    }
   },
   {
    "box": {
     "id": "co_c_n",
     "maxclass": "newobj",
     "numinlets": 2,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      1863.4,
      606.0,
      41.8,
      22.0
     ],
     "text": "int"
    }
   },
   {
    "box": {
     "id": "pf_rt",
     "maxclass": "newobj",
     "numinlets": 1,
     "numoutlets": 2,
     "outlettype": [
      "",
      ""
     ],
     "patching_rect": [
      1190.8,
      350.0,
      101.2,
      22.0
     ],
     "text": "route prefix"
    }
   },
   {
    "box": {
     "id": "pf_sel",
     "maxclass": "newobj",
     "numinlets": 1,
     "numoutlets": 2,
     "outlettype": [
      "",
      ""
     ],
     "patching_rect": [
      1190.8,
      414.0,
      74.8,
      22.0
     ],
     "text": "sel /pm/"
    }
   },
   {
    "box": {
     "id": "pf_one",
     "maxclass": "message",
     "numinlets": 2,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      1190.8,
      478.0,
      40.0,
      22.0
     ],
     "text": "1"
    }
   },
   {
    "box": {
     "id": "rw_rt",
     "maxclass": "newobj",
     "numinlets": 1,
     "numoutlets": 2,
     "outlettype": [
      "",
      ""
     ],
     "patching_rect": [
      1646.0,
      350.0,
      88.0,
      22.0
     ],
     "text": "route rows"
    }
   },
   {
    "box": {
     "id": "rw_eq",
     "maxclass": "newobj",
     "numinlets": 2,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      1646.0,
      414.0,
      48.4,
      22.0
     ],
     "text": "== 2"
    }
   },
   {
    "box": {
     "id": "ue",
     "maxclass": "newobj",
     "numinlets": 2,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      1731.8,
      670.0,
      48.4,
      22.0
     ],
     "text": "== 2"
    }
   },
   {
    "box": {
     "id": "ce",
     "maxclass": "newobj",
     "numinlets": 2,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      1804.2,
      670.0,
      48.4,
      22.0
     ],
     "text": "== 1"
    }
   },
   {
    "box": {
     "id": "coe",
     "maxclass": "newobj",
     "numinlets": 2,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      1876.6,
      670.0,
      48.4,
      22.0
     ],
     "text": "== 2"
    }
   },
   {
    "box": {
     "id": "c_um",
     "maxclass": "newobj",
     "numinlets": 1,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      1731.8,
      798.0,
      490.6,
      22.0
     ],
     "text": "test.assert Jamoma/Modular/j.namespace/formats/umenu_appends_every_item"
    }
   },
   {
    "box": {
     "id": "c_umc",
     "maxclass": "newobj",
     "numinlets": 1,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      2246.4,
      798.0,
      444.4,
      22.0
     ],
     "text": "test.assert Jamoma/Modular/j.namespace/formats/umenu_clears_once"
    }
   },
   {
    "box": {
     "id": "c_up",
     "maxclass": "newobj",
     "numinlets": 1,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      1190.8,
      606.0,
      517.0,
      22.0
     ],
     "text": "test.assert Jamoma/Modular/j.namespace/formats/umenu_prefix_sets_the_prefix"
    }
   },
   {
    "box": {
     "id": "c_cb",
     "maxclass": "newobj",
     "numinlets": 1,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      1646.0,
      542.0,
      510.4,
      22.0
     ],
     "text": "test.assert Jamoma/Modular/j.namespace/formats/jit_cellblock_sets_the_rows"
    }
   },
   {
    "box": {
     "id": "c_co",
     "maxclass": "newobj",
     "numinlets": 1,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      2714.8,
      798.0,
      477.4,
      22.0
     ],
     "text": "test.assert Jamoma/Modular/j.namespace/formats/coll_stores_every_item"
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
     "text": "0"
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
      2510.2,
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
      2510.2,
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
      2510.2,
      414.0,
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
      2510.2,
      478.0,
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
      2510.2,
      542.0,
      114.4,
      22.0
     ],
     "text": "test.terminate"
    }
   },
   {
    "box": {
     "id": "tg_c_um",
     "maxclass": "toggle",
     "numinlets": 1,
     "numoutlets": 1,
     "outlettype": [
      "int"
     ],
     "parameter_enable": 0,
     "patching_rect": [
      1731.8,
      734.0,
      24.0,
      24.0
     ]
    }
   },
   {
    "box": {
     "id": "tg_c_umc",
     "maxclass": "toggle",
     "numinlets": 1,
     "numoutlets": 1,
     "outlettype": [
      "int"
     ],
     "parameter_enable": 0,
     "patching_rect": [
      2246.4,
      734.0,
      24.0,
      24.0
     ]
    }
   },
   {
    "box": {
     "id": "tg_c_up",
     "maxclass": "toggle",
     "numinlets": 1,
     "numoutlets": 1,
     "outlettype": [
      "int"
     ],
     "parameter_enable": 0,
     "patching_rect": [
      1190.8,
      542.0,
      24.0,
      24.0
     ]
    }
   },
   {
    "box": {
     "id": "tg_c_cb",
     "maxclass": "toggle",
     "numinlets": 1,
     "numoutlets": 1,
     "outlettype": [
      "int"
     ],
     "parameter_enable": 0,
     "patching_rect": [
      1646.0,
      478.0,
      24.0,
      24.0
     ]
    }
   },
   {
    "box": {
     "id": "tg_c_co",
     "maxclass": "toggle",
     "numinlets": 1,
     "numoutlets": 1,
     "outlettype": [
      "int"
     ],
     "parameter_enable": 0,
     "patching_rect": [
      2714.8,
      734.0,
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
      "um",
      0
     ],
     "destination": [
      "cu_rt",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "cu_rt",
      0
     ],
     "destination": [
      "cu_t",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "cu_t",
      0
     ],
     "destination": [
      "cu_i",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "cu_i",
      0
     ],
     "destination": [
      "cu_p",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "cu_p",
      0
     ],
     "destination": [
      "cu_i",
      1
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "cu_p",
      0
     ],
     "destination": [
      "cu_n",
      1
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "um",
      0
     ],
     "destination": [
      "cc_rt",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "cc_rt",
      0
     ],
     "destination": [
      "cc_t",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "cc_t",
      0
     ],
     "destination": [
      "cc_i",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "cc_i",
      0
     ],
     "destination": [
      "cc_p",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "cc_p",
      0
     ],
     "destination": [
      "cc_i",
      1
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "cc_p",
      0
     ],
     "destination": [
      "cc_n",
      1
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "co",
      0
     ],
     "destination": [
      "co_c_rt",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "co_c_rt",
      0
     ],
     "destination": [
      "co_c_t",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "co_c_t",
      0
     ],
     "destination": [
      "co_c_i",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "co_c_i",
      0
     ],
     "destination": [
      "co_c_p",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "co_c_p",
      0
     ],
     "destination": [
      "co_c_i",
      1
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "co_c_p",
      0
     ],
     "destination": [
      "co_c_n",
      1
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "up",
      0
     ],
     "destination": [
      "pf_rt",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "pf_rt",
      0
     ],
     "destination": [
      "pf_sel",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "pf_sel",
      0
     ],
     "destination": [
      "pf_one",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "cb",
      0
     ],
     "destination": [
      "rw_rt",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "rw_rt",
      0
     ],
     "destination": [
      "rw_eq",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "cu_n",
      0
     ],
     "destination": [
      "ue",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "cc_n",
      0
     ],
     "destination": [
      "ce",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "co_c_n",
      0
     ],
     "destination": [
      "coe",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "ue",
      0
     ],
     "destination": [
      "tg_c_um",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "ce",
      0
     ],
     "destination": [
      "tg_c_umc",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "pf_one",
      0
     ],
     "destination": [
      "tg_c_up",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "rw_eq",
      0
     ],
     "destination": [
      "tg_c_cb",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "coe",
      0
     ],
     "destination": [
      "tg_c_co",
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
      "cu_i",
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
      "cu_n",
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
      "cc_i",
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
      "cc_n",
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
      "co_c_i",
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
      "co_c_n",
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
      "um",
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
      "up",
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
      "cb",
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
      "co",
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
      "cu_n",
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
      "cc_n",
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
      "co_c_n",
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
      "tg_c_um",
      0
     ],
     "destination": [
      "c_um",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "tg_c_umc",
      0
     ],
     "destination": [
      "c_umc",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "tg_c_up",
      0
     ],
     "destination": [
      "c_up",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "tg_c_cb",
      0
     ],
     "destination": [
      "c_cb",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "tg_c_co",
      0
     ],
     "destination": [
      "c_co",
      0
     ]
    }
   }
  ]
 }
}
