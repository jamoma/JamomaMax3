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
   4198.8,
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
      468.6,
      20.0
     ],
     "text": "j.namespace lists children and attributes and explores an address it is sent."
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
      2693.0,
      30.0,
      80.0,
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
      2797.0,
      30.0,
      265.6,
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
      3086.6,
      30.0,
      259.8,
      22.0
     ],
     "text": "j.parameter beta @type integer @default 2"
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
      3370.4,
      94.0,
      259.8,
      22.0
     ],
     "text": "j.namespace @address /pm @output children"
    }
   },
   {
    "box": {
     "id": "nc_r0",
     "maxclass": "newobj",
     "numinlets": 0,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      3370.4,
      30.0,
      138.0,
      22.0
     ],
     "text": "r ns_exp_to_children"
    }
   },
   {
    "box": {
     "id": "nc_s0",
     "maxclass": "newobj",
     "numinlets": 1,
     "numoutlets": 0,
     "outlettype": [],
     "patching_rect": [
      3370.4,
      158.0,
      126.4,
      22.0
     ],
     "text": "s ns_exp_from_list"
    }
   },
   {
    "box": {
     "id": "nc_s1",
     "maxclass": "newobj",
     "numinlets": 1,
     "numoutlets": 0,
     "outlettype": [],
     "patching_rect": [
      3520.8,
      158.0,
      149.6,
      22.0
     ],
     "text": "s ns_exp_from_children"
    }
   },
   {
    "box": {
     "id": "na",
     "maxclass": "newobj",
     "numinlets": 1,
     "numoutlets": 3,
     "outlettype": [
      "",
      "",
      ""
     ],
     "patching_rect": [
      3654.2,
      94.0,
      306.2,
      22.0
     ],
     "text": "j.namespace @address /pm/alpha @output attributes"
    }
   },
   {
    "box": {
     "id": "na_r0",
     "maxclass": "newobj",
     "numinlets": 0,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      3532.4,
      30.0,
      149.6,
      22.0
     ],
     "text": "r ns_exp_to_attributes"
    }
   },
   {
    "box": {
     "id": "na_s1",
     "maxclass": "newobj",
     "numinlets": 1,
     "numoutlets": 0,
     "outlettype": [],
     "patching_rect": [
      3694.4,
      158.0,
      161.2,
      22.0
     ],
     "text": "s ns_exp_from_attributes"
    }
   },
   {
    "box": {
     "id": "nm",
     "maxclass": "newobj",
     "numinlets": 1,
     "numoutlets": 3,
     "outlettype": [
      "",
      "",
      ""
     ],
     "patching_rect": [
      3984.4,
      94.0,
      184.4,
      22.0
     ],
     "text": "j.namespace @output children"
    }
   },
   {
    "box": {
     "id": "nm_r0",
     "maxclass": "newobj",
     "numinlets": 0,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      3706.0,
      30.0,
      132.2,
      22.0
     ],
     "text": "r ns_exp_to_message"
    }
   },
   {
    "box": {
     "id": "nm_s1",
     "maxclass": "newobj",
     "numinlets": 1,
     "numoutlets": 0,
     "outlettype": [],
     "patching_rect": [
      3984.4,
      158.0,
      143.8,
      22.0
     ],
     "text": "s ns_exp_from_message"
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
     "numoutlets": 5,
     "outlettype": [
      "",
      "",
      "",
      "",
      ""
     ],
     "patching_rect": [
      30.0,
      124.0,
      2152.8,
      22.0
     ],
     "text": "p explore",
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
       817.0,
       538.0
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
          126.4,
          22.0
         ],
         "text": "r ns_exp_from_list"
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
          157.2,
          94.0,
          85.8,
          22.0
         ],
         "text": "route alpha"
        }
       },
       {
        "box": {
         "id": "o0_0_1",
         "maxclass": "newobj",
         "numinlets": 2,
         "numoutlets": 2,
         "outlettype": [
          "",
          ""
         ],
         "patching_rect": [
          157.2,
          158.0,
          68.4,
          22.0
         ],
         "text": "sel beta"
        }
       },
       {
        "box": {
         "id": "o0_0_2",
         "maxclass": "newobj",
         "numinlets": 1,
         "numoutlets": 1,
         "outlettype": [
          ""
         ],
         "patching_rect": [
          157.2,
          222.0,
          40.0,
          22.0
         ],
         "text": "t 1"
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
          493.6,
          350.0,
          51.0,
          22.0
         ],
         "text": "int 0"
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
          244.4,
          30.0,
          149.6,
          22.0
         ],
         "text": "r ns_exp_from_children"
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
          568.6,
          350.0,
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
          568.6,
          414.0,
          45.2,
          22.0
         ],
         "text": "== 2"
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
          161.2,
          22.0
         ],
         "text": "r ns_exp_from_attributes"
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
          649.4,
          350.0,
          56.8,
          22.0
         ],
         "text": "int -1"
        }
       },
       {
        "box": {
         "id": "c2_0",
         "maxclass": "newobj",
         "numinlets": 2,
         "numoutlets": 1,
         "outlettype": [
          ""
         ],
         "patching_rect": [
          649.4,
          414.0,
          45.2,
          22.0
         ],
         "text": "> 10"
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
          603.2,
          30.0,
          143.8,
          22.0
         ],
         "text": "r ns_exp_from_message"
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
          730.2,
          350.0,
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
          730.2,
          414.0,
          45.2,
          22.0
         ],
         "text": "== 2"
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
          478.0,
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
          478.0,
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
          478.0,
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
          478.0,
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
          478.0,
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
         "numoutlets": 5,
         "outlettype": [
          "",
          "",
          "",
          "",
          ""
         ],
         "patching_rect": [
          30.0,
          94.0,
          103.2,
          22.0
         ],
         "text": "t b -1 -1 -1 0"
        }
       },
       {
        "box": {
         "id": "w0",
         "maxclass": "newobj",
         "numinlets": 1,
         "numoutlets": 1,
         "outlettype": [
          ""
         ],
         "patching_rect": [
          30.0,
          158.0,
          68.4,
          22.0
         ],
         "text": "deferlow"
        }
       },
       {
        "box": {
         "id": "w1",
         "maxclass": "newobj",
         "numinlets": 1,
         "numoutlets": 1,
         "outlettype": [
          ""
         ],
         "patching_rect": [
          30.0,
          222.0,
          68.4,
          22.0
         ],
         "text": "deferlow"
        }
       },
       {
        "box": {
         "id": "t2",
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
          286.0,
          120.6,
          22.0
         ],
         "text": "t b b b b b b b b"
        }
       },
       {
        "box": {
         "id": "s2_0",
         "maxclass": "newobj",
         "numinlets": 1,
         "numoutlets": 0,
         "outlettype": [],
         "patching_rect": [
          320.0,
          350.0,
          149.6,
          22.0
         ],
         "text": "s ns_exp_to_attributes"
        }
       },
       {
        "box": {
         "id": "s2_1",
         "maxclass": "newobj",
         "numinlets": 1,
         "numoutlets": 0,
         "outlettype": [],
         "patching_rect": [
          158.0,
          350.0,
          138.0,
          22.0
         ],
         "text": "s ns_exp_to_children"
        }
       },
       {
        "box": {
         "id": "s2_2",
         "maxclass": "newobj",
         "numinlets": 1,
         "numoutlets": 0,
         "outlettype": [],
         "patching_rect": [
          94.0,
          414.0,
          132.2,
          22.0
         ],
         "text": "s ns_exp_to_message"
        }
       },
       {
        "box": {
         "id": "m2_2",
         "maxclass": "message",
         "numinlets": 2,
         "numoutlets": 1,
         "outlettype": [
          ""
         ],
         "patching_rect": [
          94.0,
          350.0,
          40.0,
          22.0
         ],
         "text": "/pm"
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
          "o0_0_2",
          0
         ]
        }
       },
       {
        "patchline": {
         "source": [
          "o0_0_2",
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
          4
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
          3
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
          2
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
          1
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
          "w1",
          0
         ]
        }
       },
       {
        "patchline": {
         "source": [
          "w1",
          0
         ],
         "destination": [
          "t2",
          0
         ]
        }
       },
       {
        "patchline": {
         "source": [
          "t2",
          7
         ],
         "destination": [
          "s2_0",
          0
         ]
        }
       },
       {
        "patchline": {
         "source": [
          "t2",
          6
         ],
         "destination": [
          "s2_1",
          0
         ]
        }
       },
       {
        "patchline": {
         "source": [
          "t2",
          5
         ],
         "destination": [
          "m2_2",
          0
         ]
        }
       },
       {
        "patchline": {
         "source": [
          "m2_2",
          0
         ],
         "destination": [
          "s2_2",
          0
         ]
        }
       },
       {
        "patchline": {
         "source": [
          "t2",
          4
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
          "t2",
          3
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
          "t2",
          2
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
          "t2",
          1
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
          "t2",
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
      563.5,
      194.0,
      509.2,
      22.0
     ],
     "text": "test.assert Jamoma/Modular/j.namespace/explore/children_list_the_parameters_in_order"
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
      1096.9,
      194.0,
      451.2,
      22.0
     ],
     "text": "test.assert Jamoma/Modular/j.namespace/explore/size_is_the_number_of_items"
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
      1630.4,
      194.0,
      410.6,
      22.0
     ],
     "text": "test.assert Jamoma/Modular/j.namespace/explore/attributes_of_a_node"
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
      2163.8,
      194.0,
      451.2,
      22.0
     ],
     "text": "test.assert Jamoma/Modular/j.namespace/explore/an_address_message_explores"
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
      563.5,
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
      1096.9,
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
      1630.4,
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
      2163.8,
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
      "nc_r0",
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
      "nc",
      0
     ],
     "destination": [
      "nc_s0",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "nc",
      1
     ],
     "destination": [
      "nc_s1",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "na_r0",
      0
     ],
     "destination": [
      "na",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "na",
      1
     ],
     "destination": [
      "na_s1",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "nm_r0",
      0
     ],
     "destination": [
      "nm",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "nm",
      1
     ],
     "destination": [
      "nm_s1",
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
   }
  ]
 }
}
