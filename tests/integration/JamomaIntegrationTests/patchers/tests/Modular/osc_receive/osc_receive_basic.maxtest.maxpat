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
   1745.4,
   1746.0
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
      91.6,
      22.0
     ],
     "text": "j.model osct"
    }
   },
   {
    "box": {
     "id": "value",
     "maxclass": "newobj",
     "numinlets": 1,
     "numoutlets": 2,
     "outlettype": [
      "",
      ""
     ],
     "patching_rect": [
      145.6,
      30.0,
      201.8,
      22.0
     ],
     "text": "j.parameter value @type decimal"
    }
   },
   {
    "box": {
     "id": "osc",
     "maxclass": "newobj",
     "numinlets": 1,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      371.4,
      30.0,
      149.6,
      22.0
     ],
     "text": "osc_receive.model oscr"
    }
   },
   {
    "box": {
     "id": "udp_default",
     "maxclass": "newobj",
     "numinlets": 1,
     "numoutlets": 0,
     "outlettype": [],
     "patching_rect": [
      712.8,
      94.0,
      155.4,
      22.0
     ],
     "text": "udpsend 127.0.0.1 11111"
    }
   },
   {
    "box": {
     "id": "udp_new",
     "maxclass": "newobj",
     "numinlets": 1,
     "numoutlets": 0,
     "outlettype": [],
     "patching_rect": [
      892.2,
      94.0,
      149.6,
      22.0
     ],
     "text": "udpsend 127.0.0.1 7413"
    }
   },
   {
    "box": {
     "id": "rv",
     "maxclass": "newobj",
     "numinlets": 1,
     "numoutlets": 2,
     "outlettype": [
      "",
      ""
     ],
     "patching_rect": [
      545.0,
      30.0,
      143.8,
      22.0
     ],
     "text": "j.receive /osct/value"
    }
   },
   {
    "box": {
     "id": "port",
     "maxclass": "newobj",
     "numinlets": 1,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      1065.8,
      94.0,
      149.6,
      22.0
     ],
     "text": "j.send /osct/oscr/port"
    }
   },
   {
    "box": {
     "id": "act",
     "maxclass": "newobj",
     "numinlets": 1,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      1239.4,
      94.0,
      190.2,
      22.0
     ],
     "text": "j.send /osct/oscr/data/active"
    }
   },
   {
    "box": {
     "id": "out_route",
     "maxclass": "newobj",
     "numinlets": 1,
     "numoutlets": 2,
     "outlettype": [
      "",
      ""
     ],
     "patching_rect": [
      371.4,
      94.0,
      120.6,
      22.0
     ],
     "text": "route /osct/value"
    }
   },
   {
    "box": {
     "id": "r_to_default",
     "maxclass": "newobj",
     "numinlets": 0,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      712.8,
      30.0,
      91.6,
      22.0
     ],
     "text": "r to_default"
    }
   },
   {
    "box": {
     "id": "r_to_new",
     "maxclass": "newobj",
     "numinlets": 0,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      828.4,
      30.0,
      68.4,
      22.0
     ],
     "text": "r to_new"
    }
   },
   {
    "box": {
     "id": "r_to_port",
     "maxclass": "newobj",
     "numinlets": 0,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      920.8,
      30.0,
      74.2,
      22.0
     ],
     "text": "r to_port"
    }
   },
   {
    "box": {
     "id": "r_to_act",
     "maxclass": "newobj",
     "numinlets": 0,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      1019.0,
      30.0,
      68.4,
      22.0
     ],
     "text": "r to_act"
    }
   },
   {
    "box": {
     "id": "a_h",
     "maxclass": "newobj",
     "numinlets": 2,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      999.3,
      350.0,
      74.2,
      22.0
     ],
     "text": "float -1."
    }
   },
   {
    "box": {
     "id": "b_h",
     "maxclass": "newobj",
     "numinlets": 2,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      912.5,
      542.0,
      74.2,
      22.0
     ],
     "text": "float -1."
    }
   },
   {
    "box": {
     "id": "d_h",
     "maxclass": "newobj",
     "numinlets": 2,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      999.3,
      862.0,
      74.2,
      22.0
     ],
     "text": "float -1."
    }
   },
   {
    "box": {
     "id": "f_h",
     "maxclass": "newobj",
     "numinlets": 2,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      1015.6,
      1182.0,
      74.2,
      22.0
     ],
     "text": "float -1."
    }
   },
   {
    "box": {
     "id": "h_h",
     "maxclass": "newobj",
     "numinlets": 2,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      1032.4,
      1502.0,
      74.2,
      22.0
     ],
     "text": "float -1."
    }
   },
   {
    "box": {
     "id": "lb",
     "maxclass": "newobj",
     "numinlets": 1,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      1111.4,
      30.0,
      68.4,
      22.0
     ],
     "text": "loadbang"
    }
   },
   {
    "box": {
     "id": "w0",
     "maxclass": "newobj",
     "numinlets": 2,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      1453.6,
      94.0,
      80.0,
      22.0
     ],
     "text": "delay 1000"
    }
   },
   {
    "box": {
     "id": "a_t",
     "maxclass": "newobj",
     "numinlets": 1,
     "numoutlets": 2,
     "outlettype": [
      "",
      ""
     ],
     "patching_rect": [
      1453.6,
      158.0,
      51.0,
      22.0
     ],
     "text": "t b b"
    }
   },
   {
    "box": {
     "id": "a_s0",
     "maxclass": "newobj",
     "numinlets": 1,
     "numoutlets": 0,
     "outlettype": [],
     "patching_rect": [
      1551.8,
      286.0,
      91.6,
      22.0
     ],
     "text": "s to_default"
    }
   },
   {
    "box": {
     "id": "a_m0",
     "maxclass": "message",
     "numinlets": 2,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      1551.8,
      222.0,
      97.4,
      22.0
     ],
     "text": "/osct/value 5"
    }
   },
   {
    "box": {
     "id": "a_d",
     "maxclass": "newobj",
     "numinlets": 2,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      1453.6,
      222.0,
      74.2,
      22.0
     ],
     "text": "delay 400"
    }
   },
   {
    "box": {
     "id": "a_o",
     "maxclass": "newobj",
     "numinlets": 1,
     "numoutlets": 2,
     "outlettype": [
      "",
      ""
     ],
     "patching_rect": [
      1453.6,
      286.0,
      51.0,
      22.0
     ],
     "text": "t b b"
    }
   },
   {
    "box": {
     "id": "a_c",
     "maxclass": "newobj",
     "numinlets": 2,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      999.3,
      414.0,
      51.0,
      22.0
     ],
     "text": "== 5."
    }
   },
   {
    "box": {
     "id": "a_a",
     "maxclass": "newobj",
     "numinlets": 1,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      1010.7,
      542.0,
      404.8,
      22.0
     ],
     "text": "test.assert Jamoma/Modular/osc_receive/basic/listens_on_port_11111"
    }
   },
   {
    "box": {
     "id": "b_t",
     "maxclass": "newobj",
     "numinlets": 1,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      1453.6,
      350.0,
      40.0,
      22.0
     ],
     "text": "t b"
    }
   },
   {
    "box": {
     "id": "b_d",
     "maxclass": "newobj",
     "numinlets": 2,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      1453.6,
      414.0,
      74.2,
      22.0
     ],
     "text": "delay 400"
    }
   },
   {
    "box": {
     "id": "b_o",
     "maxclass": "newobj",
     "numinlets": 1,
     "numoutlets": 2,
     "outlettype": [
      "",
      ""
     ],
     "patching_rect": [
      1453.6,
      478.0,
      51.0,
      22.0
     ],
     "text": "t b b"
    }
   },
   {
    "box": {
     "id": "b_c",
     "maxclass": "newobj",
     "numinlets": 2,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      912.5,
      606.0,
      51.0,
      22.0
     ],
     "text": "== 5."
    }
   },
   {
    "box": {
     "id": "b_a",
     "maxclass": "newobj",
     "numinlets": 1,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      912.5,
      734.0,
      486.0,
      22.0
     ],
     "text": "test.assert Jamoma/Modular/osc_receive/basic/passes_the_message_out_of_the_model"
    }
   },
   {
    "box": {
     "id": "c_t",
     "maxclass": "newobj",
     "numinlets": 1,
     "numoutlets": 2,
     "outlettype": [
      "",
      ""
     ],
     "patching_rect": [
      1453.6,
      542.0,
      68.4,
      22.0
     ],
     "text": "t b 7413"
    }
   },
   {
    "box": {
     "id": "c_s0",
     "maxclass": "newobj",
     "numinlets": 1,
     "numoutlets": 0,
     "outlettype": [],
     "patching_rect": [
      1551.8,
      606.0,
      74.2,
      22.0
     ],
     "text": "s to_port"
    }
   },
   {
    "box": {
     "id": "c_d",
     "maxclass": "newobj",
     "numinlets": 2,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      1453.6,
      606.0,
      74.2,
      22.0
     ],
     "text": "delay 400"
    }
   },
   {
    "box": {
     "id": "d_t",
     "maxclass": "newobj",
     "numinlets": 1,
     "numoutlets": 2,
     "outlettype": [
      "",
      ""
     ],
     "patching_rect": [
      1453.6,
      670.0,
      51.0,
      22.0
     ],
     "text": "t b b"
    }
   },
   {
    "box": {
     "id": "d_s0",
     "maxclass": "newobj",
     "numinlets": 1,
     "numoutlets": 0,
     "outlettype": [],
     "patching_rect": [
      1551.8,
      798.0,
      68.4,
      22.0
     ],
     "text": "s to_new"
    }
   },
   {
    "box": {
     "id": "d_m0",
     "maxclass": "message",
     "numinlets": 2,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      1551.8,
      734.0,
      97.4,
      22.0
     ],
     "text": "/osct/value 6"
    }
   },
   {
    "box": {
     "id": "d_d",
     "maxclass": "newobj",
     "numinlets": 2,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      1453.6,
      734.0,
      74.2,
      22.0
     ],
     "text": "delay 400"
    }
   },
   {
    "box": {
     "id": "d_o",
     "maxclass": "newobj",
     "numinlets": 1,
     "numoutlets": 2,
     "outlettype": [
      "",
      ""
     ],
     "patching_rect": [
      1453.6,
      798.0,
      51.0,
      22.0
     ],
     "text": "t b b"
    }
   },
   {
    "box": {
     "id": "d_c",
     "maxclass": "newobj",
     "numinlets": 2,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      999.3,
      926.0,
      51.0,
      22.0
     ],
     "text": "== 6."
    }
   },
   {
    "box": {
     "id": "d_a",
     "maxclass": "newobj",
     "numinlets": 1,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      999.3,
      1054.0,
      462.8,
      22.0
     ],
     "text": "test.assert Jamoma/Modular/osc_receive/basic/listens_on_the_port_that_is_set"
    }
   },
   {
    "box": {
     "id": "e_t",
     "maxclass": "newobj",
     "numinlets": 1,
     "numoutlets": 2,
     "outlettype": [
      "",
      ""
     ],
     "patching_rect": [
      1453.6,
      862.0,
      51.0,
      22.0
     ],
     "text": "t b 0"
    }
   },
   {
    "box": {
     "id": "e_s0",
     "maxclass": "newobj",
     "numinlets": 1,
     "numoutlets": 0,
     "outlettype": [],
     "patching_rect": [
      1551.8,
      926.0,
      68.4,
      22.0
     ],
     "text": "s to_act"
    }
   },
   {
    "box": {
     "id": "e_d",
     "maxclass": "newobj",
     "numinlets": 2,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      1453.6,
      926.0,
      74.2,
      22.0
     ],
     "text": "delay 400"
    }
   },
   {
    "box": {
     "id": "f_t",
     "maxclass": "newobj",
     "numinlets": 1,
     "numoutlets": 2,
     "outlettype": [
      "",
      ""
     ],
     "patching_rect": [
      1453.6,
      990.0,
      51.0,
      22.0
     ],
     "text": "t b b"
    }
   },
   {
    "box": {
     "id": "f_s0",
     "maxclass": "newobj",
     "numinlets": 1,
     "numoutlets": 0,
     "outlettype": [],
     "patching_rect": [
      1584.3,
      1118.0,
      68.4,
      22.0
     ],
     "text": "s to_new"
    }
   },
   {
    "box": {
     "id": "f_m0",
     "maxclass": "message",
     "numinlets": 2,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      1584.3,
      1054.0,
      97.4,
      22.0
     ],
     "text": "/osct/value 7"
    }
   },
   {
    "box": {
     "id": "f_d",
     "maxclass": "newobj",
     "numinlets": 2,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      1486.1,
      1054.0,
      74.2,
      22.0
     ],
     "text": "delay 400"
    }
   },
   {
    "box": {
     "id": "f_o",
     "maxclass": "newobj",
     "numinlets": 1,
     "numoutlets": 2,
     "outlettype": [
      "",
      ""
     ],
     "patching_rect": [
      1486.1,
      1118.0,
      51.0,
      22.0
     ],
     "text": "t b b"
    }
   },
   {
    "box": {
     "id": "f_c",
     "maxclass": "newobj",
     "numinlets": 2,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      1015.6,
      1246.0,
      51.0,
      22.0
     ],
     "text": "== 6."
    }
   },
   {
    "box": {
     "id": "f_a",
     "maxclass": "newobj",
     "numinlets": 1,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      1015.6,
      1374.0,
      480.2,
      22.0
     ],
     "text": "test.assert Jamoma/Modular/osc_receive/basic/an_inactive_model_forwards_nothing"
    }
   },
   {
    "box": {
     "id": "g_t",
     "maxclass": "newobj",
     "numinlets": 1,
     "numoutlets": 2,
     "outlettype": [
      "",
      ""
     ],
     "patching_rect": [
      1486.1,
      1182.0,
      51.0,
      22.0
     ],
     "text": "t b 1"
    }
   },
   {
    "box": {
     "id": "g_s0",
     "maxclass": "newobj",
     "numinlets": 1,
     "numoutlets": 0,
     "outlettype": [],
     "patching_rect": [
      1584.3,
      1246.0,
      68.4,
      22.0
     ],
     "text": "s to_act"
    }
   },
   {
    "box": {
     "id": "g_d",
     "maxclass": "newobj",
     "numinlets": 2,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      1486.1,
      1246.0,
      74.2,
      22.0
     ],
     "text": "delay 400"
    }
   },
   {
    "box": {
     "id": "h_t",
     "maxclass": "newobj",
     "numinlets": 1,
     "numoutlets": 2,
     "outlettype": [
      "",
      ""
     ],
     "patching_rect": [
      1486.1,
      1310.0,
      51.0,
      22.0
     ],
     "text": "t b b"
    }
   },
   {
    "box": {
     "id": "h_s0",
     "maxclass": "newobj",
     "numinlets": 1,
     "numoutlets": 0,
     "outlettype": [],
     "patching_rect": [
      1618.0,
      1438.0,
      68.4,
      22.0
     ],
     "text": "s to_new"
    }
   },
   {
    "box": {
     "id": "h_m0",
     "maxclass": "message",
     "numinlets": 2,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      1618.0,
      1374.0,
      97.4,
      22.0
     ],
     "text": "/osct/value 8"
    }
   },
   {
    "box": {
     "id": "h_d",
     "maxclass": "newobj",
     "numinlets": 2,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      1519.8,
      1374.0,
      74.2,
      22.0
     ],
     "text": "delay 400"
    }
   },
   {
    "box": {
     "id": "h_o",
     "maxclass": "newobj",
     "numinlets": 1,
     "numoutlets": 2,
     "outlettype": [
      "",
      ""
     ],
     "patching_rect": [
      1519.8,
      1438.0,
      51.0,
      22.0
     ],
     "text": "t b b"
    }
   },
   {
    "box": {
     "id": "h_c",
     "maxclass": "newobj",
     "numinlets": 2,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      1032.4,
      1566.0,
      51.0,
      22.0
     ],
     "text": "== 8."
    }
   },
   {
    "box": {
     "id": "h_a",
     "maxclass": "newobj",
     "numinlets": 1,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      1032.4,
      1694.0,
      433.8,
      22.0
     ],
     "text": "test.assert Jamoma/Modular/osc_receive/basic/forwards_again_when_active"
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
      1519.8,
      1502.0,
      103.2,
      22.0
     ],
     "text": "test.terminate"
    }
   },
   {
    "box": {
     "id": "tg_a_a",
     "maxclass": "toggle",
     "numinlets": 1,
     "numoutlets": 1,
     "outlettype": [
      "int"
     ],
     "parameter_enable": 0,
     "patching_rect": [
      1010.7,
      478.0,
      24.0,
      24.0
     ]
    }
   },
   {
    "box": {
     "id": "tg_b_a",
     "maxclass": "toggle",
     "numinlets": 1,
     "numoutlets": 1,
     "outlettype": [
      "int"
     ],
     "parameter_enable": 0,
     "patching_rect": [
      912.5,
      670.0,
      24.0,
      24.0
     ]
    }
   },
   {
    "box": {
     "id": "tg_d_a",
     "maxclass": "toggle",
     "numinlets": 1,
     "numoutlets": 1,
     "outlettype": [
      "int"
     ],
     "parameter_enable": 0,
     "patching_rect": [
      999.3,
      990.0,
      24.0,
      24.0
     ]
    }
   },
   {
    "box": {
     "id": "tg_f_a",
     "maxclass": "toggle",
     "numinlets": 1,
     "numoutlets": 1,
     "outlettype": [
      "int"
     ],
     "parameter_enable": 0,
     "patching_rect": [
      1015.6,
      1310.0,
      24.0,
      24.0
     ]
    }
   },
   {
    "box": {
     "id": "tg_h_a",
     "maxclass": "toggle",
     "numinlets": 1,
     "numoutlets": 1,
     "outlettype": [
      "int"
     ],
     "parameter_enable": 0,
     "patching_rect": [
      1032.4,
      1630.0,
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
      "osc",
      0
     ],
     "destination": [
      "out_route",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "r_to_default",
      0
     ],
     "destination": [
      "udp_default",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "r_to_new",
      0
     ],
     "destination": [
      "udp_new",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "r_to_port",
      0
     ],
     "destination": [
      "port",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "r_to_act",
      0
     ],
     "destination": [
      "act",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "rv",
      0
     ],
     "destination": [
      "a_h",
      1
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "out_route",
      0
     ],
     "destination": [
      "b_h",
      1
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "rv",
      0
     ],
     "destination": [
      "d_h",
      1
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "rv",
      0
     ],
     "destination": [
      "f_h",
      1
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "rv",
      0
     ],
     "destination": [
      "h_h",
      1
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
      "w0",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "w0",
      0
     ],
     "destination": [
      "a_t",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "a_t",
      1
     ],
     "destination": [
      "a_m0",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "a_m0",
      0
     ],
     "destination": [
      "a_s0",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "a_t",
      0
     ],
     "destination": [
      "a_d",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "a_d",
      0
     ],
     "destination": [
      "a_o",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "a_o",
      1
     ],
     "destination": [
      "a_h",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "a_h",
      0
     ],
     "destination": [
      "a_c",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "a_c",
      0
     ],
     "destination": [
      "tg_a_a",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "a_o",
      0
     ],
     "destination": [
      "b_t",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "b_t",
      0
     ],
     "destination": [
      "b_d",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "b_d",
      0
     ],
     "destination": [
      "b_o",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "b_o",
      1
     ],
     "destination": [
      "b_h",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "b_h",
      0
     ],
     "destination": [
      "b_c",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "b_c",
      0
     ],
     "destination": [
      "tg_b_a",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "b_o",
      0
     ],
     "destination": [
      "c_t",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "c_t",
      1
     ],
     "destination": [
      "c_s0",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "c_t",
      0
     ],
     "destination": [
      "c_d",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "c_d",
      0
     ],
     "destination": [
      "d_t",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "d_t",
      1
     ],
     "destination": [
      "d_m0",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "d_m0",
      0
     ],
     "destination": [
      "d_s0",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "d_t",
      0
     ],
     "destination": [
      "d_d",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "d_d",
      0
     ],
     "destination": [
      "d_o",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "d_o",
      1
     ],
     "destination": [
      "d_h",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "d_h",
      0
     ],
     "destination": [
      "d_c",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "d_c",
      0
     ],
     "destination": [
      "tg_d_a",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "d_o",
      0
     ],
     "destination": [
      "e_t",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "e_t",
      1
     ],
     "destination": [
      "e_s0",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "e_t",
      0
     ],
     "destination": [
      "e_d",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "e_d",
      0
     ],
     "destination": [
      "f_t",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "f_t",
      1
     ],
     "destination": [
      "f_m0",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "f_m0",
      0
     ],
     "destination": [
      "f_s0",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "f_t",
      0
     ],
     "destination": [
      "f_d",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "f_d",
      0
     ],
     "destination": [
      "f_o",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "f_o",
      1
     ],
     "destination": [
      "f_h",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "f_h",
      0
     ],
     "destination": [
      "f_c",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "f_c",
      0
     ],
     "destination": [
      "tg_f_a",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "f_o",
      0
     ],
     "destination": [
      "g_t",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "g_t",
      1
     ],
     "destination": [
      "g_s0",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "g_t",
      0
     ],
     "destination": [
      "g_d",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "g_d",
      0
     ],
     "destination": [
      "h_t",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "h_t",
      1
     ],
     "destination": [
      "h_m0",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "h_m0",
      0
     ],
     "destination": [
      "h_s0",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "h_t",
      0
     ],
     "destination": [
      "h_d",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "h_d",
      0
     ],
     "destination": [
      "h_o",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "h_o",
      1
     ],
     "destination": [
      "h_h",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "h_h",
      0
     ],
     "destination": [
      "h_c",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "h_c",
      0
     ],
     "destination": [
      "tg_h_a",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "h_o",
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
      "tg_a_a",
      0
     ],
     "destination": [
      "a_a",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "tg_b_a",
      0
     ],
     "destination": [
      "b_a",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "tg_d_a",
      0
     ],
     "destination": [
      "d_a",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "tg_f_a",
      0
     ],
     "destination": [
      "f_a",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "tg_h_a",
      0
     ],
     "destination": [
      "h_a",
      0
     ]
    }
   }
  ]
 }
}
