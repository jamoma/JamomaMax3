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
   5049.4,
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
      323.6,
      20.0
     ],
     "text": "The model does not output what its messages receive."
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
      3498.0,
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
      3498.0,
      94.0,
      138.0,
      22.0
     ],
     "text": "s mod_msg_from_model"
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
      3660.0,
      94.0,
      178.6,
      22.0
     ],
     "text": "j.message aaa @type decimal"
    }
   },
   {
    "box": {
     "id": "obj-2_r0",
     "maxclass": "newobj",
     "numinlets": 0,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      3584.6,
      30.0,
      97.4,
      22.0
     ],
     "text": "r mod_msg_aaa"
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
      3862.6,
      94.0,
      178.6,
      22.0
     ],
     "text": "j.message bbb @type integer"
    }
   },
   {
    "box": {
     "id": "obj-23_r0",
     "maxclass": "newobj",
     "numinlets": 0,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      3706.0,
      30.0,
      97.4,
      22.0
     ],
     "text": "r mod_msg_bbb"
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
      4065.2,
      94.0,
      172.8,
      22.0
     ],
     "text": "j.message ccc @type string"
    }
   },
   {
    "box": {
     "id": "obj-24_r0",
     "maxclass": "newobj",
     "numinlets": 0,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      3827.4,
      30.0,
      97.4,
      22.0
     ],
     "text": "r mod_msg_ccc"
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
      4262.0,
      94.0,
      178.6,
      22.0
     ],
     "text": "j.message ddd @type boolean"
    }
   },
   {
    "box": {
     "id": "obj-25_r0",
     "maxclass": "newobj",
     "numinlets": 0,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      3948.8,
      30.0,
      97.4,
      22.0
     ],
     "text": "r mod_msg_ddd"
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
      4464.6,
      94.0,
      167.0,
      22.0
     ],
     "text": "j.message eee @type array"
    }
   },
   {
    "box": {
     "id": "obj-26_r0",
     "maxclass": "newobj",
     "numinlets": 0,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      4070.2,
      30.0,
      97.4,
      22.0
     ],
     "text": "r mod_msg_eee"
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
      4655.6,
      94.0,
      178.6,
      22.0
     ],
     "text": "j.message fff @type generic"
    }
   },
   {
    "box": {
     "id": "obj-27_r0",
     "maxclass": "newobj",
     "numinlets": 0,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      4191.6,
      30.0,
      97.4,
      22.0
     ],
     "text": "r mod_msg_fff"
    }
   },
   {
    "box": {
     "id": "obj-80",
     "maxclass": "newobj",
     "numinlets": 1,
     "numoutlets": 2,
     "outlettype": [
      "",
      ""
     ],
     "patching_rect": [
      4858.2,
      94.0,
      161.2,
      22.0
     ],
     "text": "j.message ggg @type none"
    }
   },
   {
    "box": {
     "id": "obj-80_r0",
     "maxclass": "newobj",
     "numinlets": 0,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      4313.0,
      30.0,
      97.4,
      22.0
     ],
     "text": "r mod_msg_ggg"
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
     "numoutlets": 8,
     "outlettype": [
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
      124.0,
      3021.6,
      22.0
     ],
     "text": "p send_every_message",
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
       3961.4,
       370.0
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
          30.0,
          30.0
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
          1203.0,
          70.0,
          138.0,
          22.0
         ],
         "text": "r mod_msg_from_model"
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
          1203.0,
          110.0,
          74.2,
          22.0
         ],
         "text": "route aaa"
        }
       },
       {
        "box": {
         "id": "o0_0_1",
         "maxclass": "newobj",
         "numinlets": 1,
         "numoutlets": 1,
         "outlettype": [
          ""
         ],
         "patching_rect": [
          1203.0,
          150.0,
          40.0,
          22.0
         ],
         "text": "t 0"
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
          1203.0,
          190.0,
          51.0,
          22.0
         ],
         "text": "int 1"
        }
       },
       {
        "box": {
         "id": "zr0_0",
         "maxclass": "newobj",
         "numinlets": 0,
         "numoutlets": 1,
         "outlettype": [
          ""
         ],
         "patching_rect": [
          1353.0,
          110.0,
          219.2,
          22.0
         ],
         "text": "r mod_msg_send_every_message_begin"
        }
       },
       {
        "box": {
         "id": "zv0_0",
         "maxclass": "message",
         "numinlets": 2,
         "numoutlets": 1,
         "outlettype": [
          ""
         ],
         "patching_rect": [
          1353.0,
          150.0,
          40.0,
          22.0
         ],
         "text": "1"
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
          1596.2,
          70.0,
          138.0,
          22.0
         ],
         "text": "r mod_msg_from_model"
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
          1596.2,
          110.0,
          74.2,
          22.0
         ],
         "text": "route bbb"
        }
       },
       {
        "box": {
         "id": "o1_0_1",
         "maxclass": "newobj",
         "numinlets": 1,
         "numoutlets": 1,
         "outlettype": [
          ""
         ],
         "patching_rect": [
          1596.2,
          150.0,
          40.0,
          22.0
         ],
         "text": "t 0"
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
          1596.2,
          190.0,
          51.0,
          22.0
         ],
         "text": "int 1"
        }
       },
       {
        "box": {
         "id": "zr1_0",
         "maxclass": "newobj",
         "numinlets": 0,
         "numoutlets": 1,
         "outlettype": [
          ""
         ],
         "patching_rect": [
          1746.2,
          110.0,
          219.2,
          22.0
         ],
         "text": "r mod_msg_send_every_message_begin"
        }
       },
       {
        "box": {
         "id": "zv1_0",
         "maxclass": "message",
         "numinlets": 2,
         "numoutlets": 1,
         "outlettype": [
          ""
         ],
         "patching_rect": [
          1746.2,
          150.0,
          40.0,
          22.0
         ],
         "text": "1"
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
          1989.4,
          70.0,
          138.0,
          22.0
         ],
         "text": "r mod_msg_from_model"
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
          1989.4,
          110.0,
          74.2,
          22.0
         ],
         "text": "route ccc"
        }
       },
       {
        "box": {
         "id": "o2_0_1",
         "maxclass": "newobj",
         "numinlets": 1,
         "numoutlets": 1,
         "outlettype": [
          ""
         ],
         "patching_rect": [
          1989.4,
          150.0,
          40.0,
          22.0
         ],
         "text": "t 0"
        }
       },
       {
        "box": {
         "id": "h2_0",
         "maxclass": "newobj",
         "numinlets": 2,
         "numoutlets": 1,
         "outlettype": [
          ""
         ],
         "patching_rect": [
          1989.4,
          190.0,
          51.0,
          22.0
         ],
         "text": "int 1"
        }
       },
       {
        "box": {
         "id": "zr2_0",
         "maxclass": "newobj",
         "numinlets": 0,
         "numoutlets": 1,
         "outlettype": [
          ""
         ],
         "patching_rect": [
          2139.4,
          110.0,
          219.2,
          22.0
         ],
         "text": "r mod_msg_send_every_message_begin"
        }
       },
       {
        "box": {
         "id": "zv2_0",
         "maxclass": "message",
         "numinlets": 2,
         "numoutlets": 1,
         "outlettype": [
          ""
         ],
         "patching_rect": [
          2139.4,
          150.0,
          40.0,
          22.0
         ],
         "text": "1"
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
          2382.6,
          70.0,
          138.0,
          22.0
         ],
         "text": "r mod_msg_from_model"
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
          2382.6,
          110.0,
          74.2,
          22.0
         ],
         "text": "route ddd"
        }
       },
       {
        "box": {
         "id": "o3_0_1",
         "maxclass": "newobj",
         "numinlets": 1,
         "numoutlets": 1,
         "outlettype": [
          ""
         ],
         "patching_rect": [
          2382.6,
          150.0,
          40.0,
          22.0
         ],
         "text": "t 0"
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
          2382.6,
          190.0,
          51.0,
          22.0
         ],
         "text": "int 1"
        }
       },
       {
        "box": {
         "id": "zr3_0",
         "maxclass": "newobj",
         "numinlets": 0,
         "numoutlets": 1,
         "outlettype": [
          ""
         ],
         "patching_rect": [
          2532.6,
          110.0,
          219.2,
          22.0
         ],
         "text": "r mod_msg_send_every_message_begin"
        }
       },
       {
        "box": {
         "id": "zv3_0",
         "maxclass": "message",
         "numinlets": 2,
         "numoutlets": 1,
         "outlettype": [
          ""
         ],
         "patching_rect": [
          2532.6,
          150.0,
          40.0,
          22.0
         ],
         "text": "1"
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
          2775.8,
          70.0,
          138.0,
          22.0
         ],
         "text": "r mod_msg_from_model"
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
          2775.8,
          110.0,
          74.2,
          22.0
         ],
         "text": "route eee"
        }
       },
       {
        "box": {
         "id": "o4_0_1",
         "maxclass": "newobj",
         "numinlets": 1,
         "numoutlets": 1,
         "outlettype": [
          ""
         ],
         "patching_rect": [
          2775.8,
          150.0,
          40.0,
          22.0
         ],
         "text": "t 0"
        }
       },
       {
        "box": {
         "id": "h4_0",
         "maxclass": "newobj",
         "numinlets": 2,
         "numoutlets": 1,
         "outlettype": [
          ""
         ],
         "patching_rect": [
          2775.8,
          190.0,
          51.0,
          22.0
         ],
         "text": "int 1"
        }
       },
       {
        "box": {
         "id": "zr4_0",
         "maxclass": "newobj",
         "numinlets": 0,
         "numoutlets": 1,
         "outlettype": [
          ""
         ],
         "patching_rect": [
          2925.8,
          110.0,
          219.2,
          22.0
         ],
         "text": "r mod_msg_send_every_message_begin"
        }
       },
       {
        "box": {
         "id": "zv4_0",
         "maxclass": "message",
         "numinlets": 2,
         "numoutlets": 1,
         "outlettype": [
          ""
         ],
         "patching_rect": [
          2925.8,
          150.0,
          40.0,
          22.0
         ],
         "text": "1"
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
          3169.0,
          70.0,
          138.0,
          22.0
         ],
         "text": "r mod_msg_from_model"
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
          3169.0,
          110.0,
          74.2,
          22.0
         ],
         "text": "route fff"
        }
       },
       {
        "box": {
         "id": "o5_0_1",
         "maxclass": "newobj",
         "numinlets": 1,
         "numoutlets": 1,
         "outlettype": [
          ""
         ],
         "patching_rect": [
          3169.0,
          150.0,
          40.0,
          22.0
         ],
         "text": "t 0"
        }
       },
       {
        "box": {
         "id": "h5_0",
         "maxclass": "newobj",
         "numinlets": 2,
         "numoutlets": 1,
         "outlettype": [
          ""
         ],
         "patching_rect": [
          3169.0,
          190.0,
          51.0,
          22.0
         ],
         "text": "int 1"
        }
       },
       {
        "box": {
         "id": "zr5_0",
         "maxclass": "newobj",
         "numinlets": 0,
         "numoutlets": 1,
         "outlettype": [
          ""
         ],
         "patching_rect": [
          3319.0,
          110.0,
          219.2,
          22.0
         ],
         "text": "r mod_msg_send_every_message_begin"
        }
       },
       {
        "box": {
         "id": "zv5_0",
         "maxclass": "message",
         "numinlets": 2,
         "numoutlets": 1,
         "outlettype": [
          ""
         ],
         "patching_rect": [
          3319.0,
          150.0,
          40.0,
          22.0
         ],
         "text": "1"
        }
       },
       {
        "box": {
         "id": "r6_0",
         "maxclass": "newobj",
         "numinlets": 0,
         "numoutlets": 1,
         "outlettype": [
          ""
         ],
         "patching_rect": [
          3562.2,
          70.0,
          138.0,
          22.0
         ],
         "text": "r mod_msg_from_model"
        }
       },
       {
        "box": {
         "id": "o6_0_0",
         "maxclass": "newobj",
         "numinlets": 2,
         "numoutlets": 2,
         "outlettype": [
          "",
          ""
         ],
         "patching_rect": [
          3562.2,
          110.0,
          74.2,
          22.0
         ],
         "text": "route ggg"
        }
       },
       {
        "box": {
         "id": "o6_0_1",
         "maxclass": "newobj",
         "numinlets": 1,
         "numoutlets": 1,
         "outlettype": [
          ""
         ],
         "patching_rect": [
          3562.2,
          150.0,
          40.0,
          22.0
         ],
         "text": "t 0"
        }
       },
       {
        "box": {
         "id": "h6_0",
         "maxclass": "newobj",
         "numinlets": 2,
         "numoutlets": 1,
         "outlettype": [
          ""
         ],
         "patching_rect": [
          3562.2,
          190.0,
          51.0,
          22.0
         ],
         "text": "int 1"
        }
       },
       {
        "box": {
         "id": "zr6_0",
         "maxclass": "newobj",
         "numinlets": 0,
         "numoutlets": 1,
         "outlettype": [
          ""
         ],
         "patching_rect": [
          3712.2,
          110.0,
          219.2,
          22.0
         ],
         "text": "r mod_msg_send_every_message_begin"
        }
       },
       {
        "box": {
         "id": "zv6_0",
         "maxclass": "message",
         "numinlets": 2,
         "numoutlets": 1,
         "outlettype": [
          ""
         ],
         "patching_rect": [
          3712.2,
          150.0,
          40.0,
          22.0
         ],
         "text": "1"
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
          310.0,
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
          1203.0,
          310.0,
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
          1596.2,
          310.0,
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
          1989.4,
          310.0,
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
          2382.6,
          310.0,
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
          2775.8,
          310.0,
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
          3169.0,
          310.0,
          30.0,
          30.0
         ]
        }
       },
       {
        "box": {
         "id": "out6",
         "maxclass": "outlet",
         "numinlets": 1,
         "numoutlets": 0,
         "outlettype": [],
         "patching_rect": [
          3562.2,
          310.0,
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
         "numoutlets": 16,
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
          "",
          "",
          ""
         ],
         "patching_rect": [
          30.0,
          150.0,
          236.6,
          22.0
         ],
         "text": "t b b b b b b b b b b b 1 b 54 3.14 b"
        }
       },
       {
        "box": {
         "id": "s0_0",
         "maxclass": "newobj",
         "numinlets": 1,
         "numoutlets": 0,
         "outlettype": [],
         "patching_rect": [
          943.8,
          190.0,
          219.2,
          22.0
         ],
         "text": "s mod_msg_send_every_message_begin"
        }
       },
       {
        "box": {
         "id": "s0_1",
         "maxclass": "newobj",
         "numinlets": 1,
         "numoutlets": 0,
         "outlettype": [],
         "patching_rect": [
          830.4,
          190.0,
          97.4,
          22.0
         ],
         "text": "s mod_msg_aaa"
        }
       },
       {
        "box": {
         "id": "s0_2",
         "maxclass": "newobj",
         "numinlets": 1,
         "numoutlets": 0,
         "outlettype": [],
         "patching_rect": [
          717.0,
          190.0,
          97.4,
          22.0
         ],
         "text": "s mod_msg_bbb"
        }
       },
       {
        "box": {
         "id": "s0_3",
         "maxclass": "newobj",
         "numinlets": 1,
         "numoutlets": 0,
         "outlettype": [],
         "patching_rect": [
          603.6,
          230.0,
          97.4,
          22.0
         ],
         "text": "s mod_msg_ccc"
        }
       },
       {
        "box": {
         "id": "m0_3",
         "maxclass": "message",
         "numinlets": 2,
         "numoutlets": 1,
         "outlettype": [
          ""
         ],
         "patching_rect": [
          603.6,
          190.0,
          51.0,
          22.0
         ],
         "text": "hello"
        }
       },
       {
        "box": {
         "id": "s0_4",
         "maxclass": "newobj",
         "numinlets": 1,
         "numoutlets": 0,
         "outlettype": [],
         "patching_rect": [
          490.2,
          190.0,
          97.4,
          22.0
         ],
         "text": "s mod_msg_ddd"
        }
       },
       {
        "box": {
         "id": "s0_5",
         "maxclass": "newobj",
         "numinlets": 1,
         "numoutlets": 0,
         "outlettype": [],
         "patching_rect": [
          376.8,
          230.0,
          97.4,
          22.0
         ],
         "text": "s mod_msg_eee"
        }
       },
       {
        "box": {
         "id": "m0_5",
         "maxclass": "message",
         "numinlets": 2,
         "numoutlets": 1,
         "outlettype": [
          ""
         ],
         "patching_rect": [
          376.8,
          190.0,
          85.8,
          22.0
         ],
         "text": "1.1 2.2 3.3"
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
          263.4,
          230.0,
          97.4,
          22.0
         ],
         "text": "s mod_msg_fff"
        }
       },
       {
        "box": {
         "id": "m0_6",
         "maxclass": "message",
         "numinlets": 2,
         "numoutlets": 1,
         "outlettype": [
          ""
         ],
         "patching_rect": [
          263.4,
          190.0,
          80.0,
          22.0
         ],
         "text": "5.67 foo 2"
        }
       },
       {
        "box": {
         "id": "s0_7",
         "maxclass": "newobj",
         "numinlets": 1,
         "numoutlets": 0,
         "outlettype": [],
         "patching_rect": [
          150.0,
          190.0,
          97.4,
          22.0
         ],
         "text": "s mod_msg_ggg"
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
          "o0_0_1",
          0
         ]
        }
       },
       {
        "patchline": {
         "source": [
          "o0_0_1",
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
          "zr0_0",
          0
         ],
         "destination": [
          "zv0_0",
          0
         ]
        }
       },
       {
        "patchline": {
         "source": [
          "zv0_0",
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
          "o1_0_1",
          0
         ]
        }
       },
       {
        "patchline": {
         "source": [
          "o1_0_1",
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
          "zr1_0",
          0
         ],
         "destination": [
          "zv1_0",
          0
         ]
        }
       },
       {
        "patchline": {
         "source": [
          "zv1_0",
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
          "o2_0_1",
          0
         ]
        }
       },
       {
        "patchline": {
         "source": [
          "o2_0_1",
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
          "zr2_0",
          0
         ],
         "destination": [
          "zv2_0",
          0
         ]
        }
       },
       {
        "patchline": {
         "source": [
          "zv2_0",
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
          "o3_0_1",
          0
         ]
        }
       },
       {
        "patchline": {
         "source": [
          "o3_0_1",
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
          "zr3_0",
          0
         ],
         "destination": [
          "zv3_0",
          0
         ]
        }
       },
       {
        "patchline": {
         "source": [
          "zv3_0",
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
          "o4_0_1",
          0
         ]
        }
       },
       {
        "patchline": {
         "source": [
          "o4_0_1",
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
          "zr4_0",
          0
         ],
         "destination": [
          "zv4_0",
          0
         ]
        }
       },
       {
        "patchline": {
         "source": [
          "zv4_0",
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
          "o5_0_1",
          0
         ]
        }
       },
       {
        "patchline": {
         "source": [
          "o5_0_1",
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
          "zr5_0",
          0
         ],
         "destination": [
          "zv5_0",
          0
         ]
        }
       },
       {
        "patchline": {
         "source": [
          "zv5_0",
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
          "r6_0",
          0
         ],
         "destination": [
          "o6_0_0",
          0
         ]
        }
       },
       {
        "patchline": {
         "source": [
          "o6_0_0",
          0
         ],
         "destination": [
          "o6_0_1",
          0
         ]
        }
       },
       {
        "patchline": {
         "source": [
          "o6_0_1",
          0
         ],
         "destination": [
          "h6_0",
          1
         ]
        }
       },
       {
        "patchline": {
         "source": [
          "zr6_0",
          0
         ],
         "destination": [
          "zv6_0",
          0
         ]
        }
       },
       {
        "patchline": {
         "source": [
          "zv6_0",
          0
         ],
         "destination": [
          "h6_0",
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
          "out0",
          0
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
          "out1",
          0
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
          "out2",
          0
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
          "out3",
          0
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
          "out4",
          0
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
          "out5",
          0
         ]
        }
       },
       {
        "patchline": {
         "source": [
          "h6_0",
          0
         ],
         "destination": [
          "out6",
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
          15
         ],
         "destination": [
          "s0_0",
          0
         ]
        }
       },
       {
        "patchline": {
         "source": [
          "t0",
          14
         ],
         "destination": [
          "s0_1",
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
          "s0_2",
          0
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
          "m0_3",
          0
         ]
        }
       },
       {
        "patchline": {
         "source": [
          "m0_3",
          0
         ],
         "destination": [
          "s0_3",
          0
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
          "s0_4",
          0
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
          "m0_5",
          0
         ]
        }
       },
       {
        "patchline": {
         "source": [
          "m0_5",
          0
         ],
         "destination": [
          "s0_5",
          0
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
          "m0_6",
          0
         ]
        }
       },
       {
        "patchline": {
         "source": [
          "m0_6",
          0
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
          8
         ],
         "destination": [
          "s0_7",
          0
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
          "h0_0",
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
          "h1_0",
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
          "h2_0",
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
          "h3_0",
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
          "h4_0",
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
          "h5_0",
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
          "h6_0",
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
      458.9,
      194.0,
      404.8,
      22.0
     ],
     "text": "test.assert Jamoma/Modular/j.model/not_outputting_messages/decimal"
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
      887.9,
      194.0,
      404.8,
      22.0
     ],
     "text": "test.assert Jamoma/Modular/j.model/not_outputting_messages/integer"
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
      1316.8,
      194.0,
      399.0,
      22.0
     ],
     "text": "test.assert Jamoma/Modular/j.model/not_outputting_messages/string"
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
      1745.8,
      194.0,
      404.8,
      22.0
     ],
     "text": "test.assert Jamoma/Modular/j.model/not_outputting_messages/boolean"
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
      2174.7,
      194.0,
      393.2,
      22.0
     ],
     "text": "test.assert Jamoma/Modular/j.model/not_outputting_messages/array"
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
      2603.7,
      194.0,
      404.8,
      22.0
     ],
     "text": "test.assert Jamoma/Modular/j.model/not_outputting_messages/generic"
    }
   },
   {
    "box": {
     "id": "step0_a6",
     "maxclass": "newobj",
     "numinlets": 1,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      3032.6,
      194.0,
      387.4,
      22.0
     ],
     "text": "test.assert Jamoma/Modular/j.model/not_outputting_messages/none"
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
      458.9,
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
      887.9,
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
      1316.8,
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
      1745.8,
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
      2174.7,
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
      2603.7,
      160.0,
      24.0,
      24.0
     ]
    }
   },
   {
    "box": {
     "id": "tg_step0_a6",
     "maxclass": "toggle",
     "numinlets": 1,
     "numoutlets": 1,
     "outlettype": [
      "int"
     ],
     "parameter_enable": 0,
     "patching_rect": [
      3032.6,
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
      "obj-2_r0",
      0
     ],
     "destination": [
      "obj-2",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "obj-23_r0",
      0
     ],
     "destination": [
      "obj-23",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "obj-24_r0",
      0
     ],
     "destination": [
      "obj-24",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "obj-25_r0",
      0
     ],
     "destination": [
      "obj-25",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "obj-26_r0",
      0
     ],
     "destination": [
      "obj-26",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "obj-27_r0",
      0
     ],
     "destination": [
      "obj-27",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "obj-80_r0",
      0
     ],
     "destination": [
      "obj-80",
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
      7
     ],
     "destination": [
      "tg_step0_a6",
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
   },
   {
    "patchline": {
     "source": [
      "tg_step0_a6",
      0
     ],
     "destination": [
      "step0_a6",
      0
     ]
    }
   }
  ]
 }
}
