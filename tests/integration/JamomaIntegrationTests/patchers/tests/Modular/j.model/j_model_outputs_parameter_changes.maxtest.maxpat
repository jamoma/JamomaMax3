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
        "rect": [ 34.0, 96.0, 1660.0, 338.0 ],
        "boxes": [
            {
                "box": {
                    "id": "about",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [ 30.0, 30.0, 393.2, 20.0 ],
                    "text": "The model outputs every change of its parameters, for each type."
                }
            },
            {
                "box": {
                    "id": "obj-1",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [ "", "" ],
                    "patching_rect": [ 3127.2, 30.0, 62.6, 22.0 ],
                    "text": "j.model"
                }
            },
            {
                "box": {
                    "id": "obj-1_s0",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [ 3127.2, 94.0, 138.0, 22.0 ],
                    "text": "s mod_out_from_model"
                }
            },
            {
                "box": {
                    "id": "obj-2",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [ "", "" ],
                    "patching_rect": [ 3289.2, 94.0, 190.2, 22.0 ],
                    "text": "j.parameter aaa @type decimal"
                }
            },
            {
                "box": {
                    "id": "obj-2_r0",
                    "maxclass": "newobj",
                    "numinlets": 0,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 3289.2, 30.0, 97.4, 22.0 ],
                    "text": "r mod_out_aaa"
                }
            },
            {
                "box": {
                    "id": "obj-23",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [ "", "" ],
                    "patching_rect": [ 3503.4, 94.0, 190.2, 22.0 ],
                    "text": "j.parameter bbb @type integer"
                }
            },
            {
                "box": {
                    "id": "obj-23_r0",
                    "maxclass": "newobj",
                    "numinlets": 0,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 3503.4, 30.0, 97.4, 22.0 ],
                    "text": "r mod_out_bbb"
                }
            },
            {
                "box": {
                    "id": "obj-24",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [ "", "" ],
                    "patching_rect": [ 3717.6, 94.0, 184.4, 22.0 ],
                    "text": "j.parameter ccc @type string"
                }
            },
            {
                "box": {
                    "id": "obj-24_r0",
                    "maxclass": "newobj",
                    "numinlets": 0,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 3717.6, 30.0, 97.4, 22.0 ],
                    "text": "r mod_out_ccc"
                }
            },
            {
                "box": {
                    "id": "obj-25",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [ "", "" ],
                    "patching_rect": [ 3926.0, 94.0, 190.2, 22.0 ],
                    "text": "j.parameter ddd @type boolean"
                }
            },
            {
                "box": {
                    "id": "obj-25_r0",
                    "maxclass": "newobj",
                    "numinlets": 0,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 3926.0, 30.0, 97.4, 22.0 ],
                    "text": "r mod_out_ddd"
                }
            },
            {
                "box": {
                    "id": "obj-26",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [ "", "" ],
                    "patching_rect": [ 4140.2, 94.0, 178.6, 22.0 ],
                    "text": "j.parameter eee @type array"
                }
            },
            {
                "box": {
                    "id": "obj-26_r0",
                    "maxclass": "newobj",
                    "numinlets": 0,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 4140.2, 30.0, 97.4, 22.0 ],
                    "text": "r mod_out_eee"
                }
            },
            {
                "box": {
                    "id": "obj-27",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [ "", "" ],
                    "patching_rect": [ 4342.8, 94.0, 190.2, 22.0 ],
                    "text": "j.parameter fff @type generic"
                }
            },
            {
                "box": {
                    "id": "obj-27_r0",
                    "maxclass": "newobj",
                    "numinlets": 0,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 4346.0, 30.0, 97.4, 22.0 ],
                    "text": "r mod_out_fff"
                }
            },
            {
                "box": {
                    "id": "obj-11",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [ "", "" ],
                    "patching_rect": [ 30.0, 60.0, 56.8, 22.0 ],
                    "text": "j.init"
                }
            },
            {
                "box": {
                    "id": "step0",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 7,
                    "outlettype": [ "bang", "int", "int", "", "int", "", "" ],
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
                        "rect": [ 34.0, 96.0, 3617.2, 330.0 ],
                        "boxes": [
                            {
                                "box": {
                                    "comment": "",
                                    "id": "in",
                                    "index": 1,
                                    "maxclass": "inlet",
                                    "numinlets": 0,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "patching_rect": [ 30.0, 30.0, 30.0, 30.0 ]
                                }
                            },
                            {
                                "box": {
                                    "id": "r0_0",
                                    "maxclass": "newobj",
                                    "numinlets": 0,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "patching_rect": [ 1112.8, 70.0, 138.0, 22.0 ],
                                    "text": "r mod_out_from_model"
                                }
                            },
                            {
                                "box": {
                                    "id": "o0_0_0",
                                    "maxclass": "newobj",
                                    "numinlets": 2,
                                    "numoutlets": 2,
                                    "outlettype": [ "", "" ],
                                    "patching_rect": [ 1112.8, 110.0, 74.2, 22.0 ],
                                    "text": "route aaa"
                                }
                            },
                            {
                                "box": {
                                    "id": "h0_0",
                                    "maxclass": "newobj",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [ "float" ],
                                    "patching_rect": [ 1112.8, 150.0, 74.2, 22.0 ],
                                    "text": "float -1."
                                }
                            },
                            {
                                "box": {
                                    "id": "zr0_0",
                                    "maxclass": "newobj",
                                    "numinlets": 0,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "patching_rect": [ 1262.8, 70.0, 242.4, 22.0 ],
                                    "text": "r mod_out_change_every_parameter_begin"
                                }
                            },
                            {
                                "box": {
                                    "id": "zv0_0",
                                    "maxclass": "message",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "patching_rect": [ 1262.8, 110.0, 40.0, 22.0 ],
                                    "text": "-1."
                                }
                            },
                            {
                                "box": {
                                    "id": "c0_0",
                                    "maxclass": "newobj",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [ "int" ],
                                    "patching_rect": [ 1112.8, 190.0, 62.6, 22.0 ],
                                    "text": "== 3.14"
                                }
                            },
                            {
                                "box": {
                                    "id": "r1_0",
                                    "maxclass": "newobj",
                                    "numinlets": 0,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "patching_rect": [ 1529.2, 70.0, 138.0, 22.0 ],
                                    "text": "r mod_out_from_model"
                                }
                            },
                            {
                                "box": {
                                    "id": "o1_0_0",
                                    "maxclass": "newobj",
                                    "numinlets": 2,
                                    "numoutlets": 2,
                                    "outlettype": [ "", "" ],
                                    "patching_rect": [ 1529.2, 110.0, 74.2, 22.0 ],
                                    "text": "route bbb"
                                }
                            },
                            {
                                "box": {
                                    "id": "h1_0",
                                    "maxclass": "newobj",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [ "int" ],
                                    "patching_rect": [ 1529.2, 150.0, 56.8, 22.0 ],
                                    "text": "int -1"
                                }
                            },
                            {
                                "box": {
                                    "id": "zr1_0",
                                    "maxclass": "newobj",
                                    "numinlets": 0,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "patching_rect": [ 1679.2, 70.0, 242.4, 22.0 ],
                                    "text": "r mod_out_change_every_parameter_begin"
                                }
                            },
                            {
                                "box": {
                                    "id": "zv1_0",
                                    "maxclass": "message",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "patching_rect": [ 1679.2, 110.0, 40.0, 22.0 ],
                                    "text": "-1"
                                }
                            },
                            {
                                "box": {
                                    "id": "c1_0",
                                    "maxclass": "newobj",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [ "int" ],
                                    "patching_rect": [ 1529.2, 190.0, 51.0, 22.0 ],
                                    "text": "== 54"
                                }
                            },
                            {
                                "box": {
                                    "id": "r2_0",
                                    "maxclass": "newobj",
                                    "numinlets": 0,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "patching_rect": [ 1945.6, 70.0, 138.0, 22.0 ],
                                    "text": "r mod_out_from_model"
                                }
                            },
                            {
                                "box": {
                                    "id": "o2_0_0",
                                    "maxclass": "newobj",
                                    "numinlets": 2,
                                    "numoutlets": 2,
                                    "outlettype": [ "", "" ],
                                    "patching_rect": [ 1945.6, 110.0, 74.2, 22.0 ],
                                    "text": "route ccc"
                                }
                            },
                            {
                                "box": {
                                    "id": "h2_0",
                                    "maxclass": "newobj",
                                    "numinlets": 2,
                                    "numoutlets": 2,
                                    "outlettype": [ "", "" ],
                                    "patching_rect": [ 1945.6, 150.0, 85.8, 22.0 ],
                                    "text": "zl reg none"
                                }
                            },
                            {
                                "box": {
                                    "id": "zr2_0",
                                    "maxclass": "newobj",
                                    "numinlets": 0,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "patching_rect": [ 2095.6, 70.0, 242.4, 22.0 ],
                                    "text": "r mod_out_change_every_parameter_begin"
                                }
                            },
                            {
                                "box": {
                                    "id": "zv2_0",
                                    "maxclass": "message",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "patching_rect": [ 2095.6, 110.0, 45.2, 22.0 ],
                                    "text": "none"
                                }
                            },
                            {
                                "box": {
                                    "id": "c2_0",
                                    "maxclass": "newobj",
                                    "numinlets": 2,
                                    "numoutlets": 2,
                                    "outlettype": [ "", "" ],
                                    "patching_rect": [ 1945.6, 190.0, 114.8, 22.0 ],
                                    "text": "zl compare hello"
                                }
                            },
                            {
                                "box": {
                                    "id": "r3_0",
                                    "maxclass": "newobj",
                                    "numinlets": 0,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "patching_rect": [ 2362.0, 70.0, 138.0, 22.0 ],
                                    "text": "r mod_out_from_model"
                                }
                            },
                            {
                                "box": {
                                    "id": "o3_0_0",
                                    "maxclass": "newobj",
                                    "numinlets": 2,
                                    "numoutlets": 2,
                                    "outlettype": [ "", "" ],
                                    "patching_rect": [ 2362.0, 110.0, 74.2, 22.0 ],
                                    "text": "route ddd"
                                }
                            },
                            {
                                "box": {
                                    "id": "h3_0",
                                    "maxclass": "newobj",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [ "int" ],
                                    "patching_rect": [ 2362.0, 150.0, 56.8, 22.0 ],
                                    "text": "int -1"
                                }
                            },
                            {
                                "box": {
                                    "id": "zr3_0",
                                    "maxclass": "newobj",
                                    "numinlets": 0,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "patching_rect": [ 2512.0, 70.0, 242.4, 22.0 ],
                                    "text": "r mod_out_change_every_parameter_begin"
                                }
                            },
                            {
                                "box": {
                                    "id": "zv3_0",
                                    "maxclass": "message",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "patching_rect": [ 2512.0, 110.0, 40.0, 22.0 ],
                                    "text": "-1"
                                }
                            },
                            {
                                "box": {
                                    "id": "c3_0",
                                    "maxclass": "newobj",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [ "int" ],
                                    "patching_rect": [ 2362.0, 190.0, 45.2, 22.0 ],
                                    "text": "== 1"
                                }
                            },
                            {
                                "box": {
                                    "id": "r4_0",
                                    "maxclass": "newobj",
                                    "numinlets": 0,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "patching_rect": [ 2778.4, 70.0, 138.0, 22.0 ],
                                    "text": "r mod_out_from_model"
                                }
                            },
                            {
                                "box": {
                                    "id": "o4_0_0",
                                    "maxclass": "newobj",
                                    "numinlets": 2,
                                    "numoutlets": 2,
                                    "outlettype": [ "", "" ],
                                    "patching_rect": [ 2778.4, 110.0, 74.2, 22.0 ],
                                    "text": "route eee"
                                }
                            },
                            {
                                "box": {
                                    "id": "h4_0",
                                    "maxclass": "newobj",
                                    "numinlets": 2,
                                    "numoutlets": 2,
                                    "outlettype": [ "", "" ],
                                    "patching_rect": [ 2778.4, 150.0, 85.8, 22.0 ],
                                    "text": "zl reg none"
                                }
                            },
                            {
                                "box": {
                                    "id": "zr4_0",
                                    "maxclass": "newobj",
                                    "numinlets": 0,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "patching_rect": [ 2928.4, 70.0, 242.4, 22.0 ],
                                    "text": "r mod_out_change_every_parameter_begin"
                                }
                            },
                            {
                                "box": {
                                    "id": "zv4_0",
                                    "maxclass": "message",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "patching_rect": [ 2928.4, 110.0, 45.2, 22.0 ],
                                    "text": "none"
                                }
                            },
                            {
                                "box": {
                                    "id": "c4_0",
                                    "maxclass": "newobj",
                                    "numinlets": 2,
                                    "numoutlets": 2,
                                    "outlettype": [ "", "" ],
                                    "patching_rect": [ 2778.4, 190.0, 149.6, 22.0 ],
                                    "text": "zl compare 1.1 2.2 3.3"
                                }
                            },
                            {
                                "box": {
                                    "id": "r5_0",
                                    "maxclass": "newobj",
                                    "numinlets": 0,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "patching_rect": [ 3194.8, 70.0, 138.0, 22.0 ],
                                    "text": "r mod_out_from_model"
                                }
                            },
                            {
                                "box": {
                                    "id": "o5_0_0",
                                    "maxclass": "newobj",
                                    "numinlets": 2,
                                    "numoutlets": 2,
                                    "outlettype": [ "", "" ],
                                    "patching_rect": [ 3194.8, 110.0, 74.2, 22.0 ],
                                    "text": "route fff"
                                }
                            },
                            {
                                "box": {
                                    "id": "h5_0",
                                    "maxclass": "newobj",
                                    "numinlets": 2,
                                    "numoutlets": 2,
                                    "outlettype": [ "", "" ],
                                    "patching_rect": [ 3194.8, 150.0, 85.8, 22.0 ],
                                    "text": "zl reg none"
                                }
                            },
                            {
                                "box": {
                                    "id": "zr5_0",
                                    "maxclass": "newobj",
                                    "numinlets": 0,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "patching_rect": [ 3344.8, 70.0, 242.4, 22.0 ],
                                    "text": "r mod_out_change_every_parameter_begin"
                                }
                            },
                            {
                                "box": {
                                    "id": "zv5_0",
                                    "maxclass": "message",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "patching_rect": [ 3344.8, 110.0, 45.2, 22.0 ],
                                    "text": "none"
                                }
                            },
                            {
                                "box": {
                                    "id": "c5_0",
                                    "maxclass": "newobj",
                                    "numinlets": 2,
                                    "numoutlets": 2,
                                    "outlettype": [ "", "" ],
                                    "patching_rect": [ 3194.8, 190.0, 143.8, 22.0 ],
                                    "text": "zl compare 5.67 foo 2"
                                }
                            },
                            {
                                "box": {
                                    "comment": "",
                                    "id": "done",
                                    "index": 1,
                                    "maxclass": "outlet",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "patching_rect": [ 30.0, 270.0, 30.0, 30.0 ]
                                }
                            },
                            {
                                "box": {
                                    "comment": "",
                                    "id": "out0",
                                    "index": 2,
                                    "maxclass": "outlet",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "patching_rect": [ 1112.8, 270.0, 30.0, 30.0 ]
                                }
                            },
                            {
                                "box": {
                                    "comment": "",
                                    "id": "out1",
                                    "index": 3,
                                    "maxclass": "outlet",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "patching_rect": [ 1529.2, 270.0, 30.0, 30.0 ]
                                }
                            },
                            {
                                "box": {
                                    "comment": "",
                                    "id": "out2",
                                    "index": 4,
                                    "maxclass": "outlet",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "patching_rect": [ 1945.6, 270.0, 30.0, 30.0 ]
                                }
                            },
                            {
                                "box": {
                                    "comment": "",
                                    "id": "out3",
                                    "index": 5,
                                    "maxclass": "outlet",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "patching_rect": [ 2362.0, 270.0, 30.0, 30.0 ]
                                }
                            },
                            {
                                "box": {
                                    "comment": "",
                                    "id": "out4",
                                    "index": 6,
                                    "maxclass": "outlet",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "patching_rect": [ 2778.4, 270.0, 30.0, 30.0 ]
                                }
                            },
                            {
                                "box": {
                                    "comment": "",
                                    "id": "out5",
                                    "index": 7,
                                    "maxclass": "outlet",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "patching_rect": [ 3194.8, 270.0, 30.0, 30.0 ]
                                }
                            },
                            {
                                "box": {
                                    "id": "t0",
                                    "maxclass": "newobj",
                                    "numinlets": 1,
                                    "numoutlets": 14,
                                    "outlettype": [ "bang", "bang", "bang", "bang", "bang", "bang", "bang", "bang", "bang", "int", "bang", "int", "float", "bang" ],
                                    "patching_rect": [ 30.0, 110.0, 213.4, 22.0 ],
                                    "text": "t b b b b b b b b b 1 b 54 3.14 b"
                                }
                            },
                            {
                                "box": {
                                    "id": "s0_0",
                                    "linecount": 2,
                                    "maxclass": "newobj",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "patching_rect": [ 830.4, 150.0, 242.4, 22.0 ],
                                    "text": "s mod_out_change_every_parameter_begin"
                                }
                            },
                            {
                                "box": {
                                    "id": "s0_1",
                                    "maxclass": "newobj",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "patching_rect": [ 717.0, 150.0, 97.4, 22.0 ],
                                    "text": "s mod_out_aaa"
                                }
                            },
                            {
                                "box": {
                                    "id": "s0_2",
                                    "maxclass": "newobj",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "patching_rect": [ 603.6, 150.0, 97.4, 22.0 ],
                                    "text": "s mod_out_bbb"
                                }
                            },
                            {
                                "box": {
                                    "id": "s0_3",
                                    "maxclass": "newobj",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "patching_rect": [ 490.2, 190.0, 97.4, 22.0 ],
                                    "text": "s mod_out_ccc"
                                }
                            },
                            {
                                "box": {
                                    "id": "m0_3",
                                    "maxclass": "message",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "patching_rect": [ 490.2, 150.0, 51.0, 22.0 ],
                                    "text": "hello"
                                }
                            },
                            {
                                "box": {
                                    "id": "s0_4",
                                    "maxclass": "newobj",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "patching_rect": [ 376.8, 150.0, 97.4, 22.0 ],
                                    "text": "s mod_out_ddd"
                                }
                            },
                            {
                                "box": {
                                    "id": "s0_5",
                                    "maxclass": "newobj",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "patching_rect": [ 263.4, 190.0, 97.4, 22.0 ],
                                    "text": "s mod_out_eee"
                                }
                            },
                            {
                                "box": {
                                    "id": "m0_5",
                                    "maxclass": "message",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "patching_rect": [ 263.4, 150.0, 85.8, 22.0 ],
                                    "text": "1.1 2.2 3.3"
                                }
                            },
                            {
                                "box": {
                                    "id": "s0_6",
                                    "maxclass": "newobj",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "patching_rect": [ 150.0, 190.0, 97.4, 22.0 ],
                                    "text": "s mod_out_fff"
                                }
                            },
                            {
                                "box": {
                                    "id": "m0_6",
                                    "maxclass": "message",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "patching_rect": [ 150.0, 150.0, 80.0, 22.0 ],
                                    "text": "5.67 foo 2"
                                }
                            }
                        ],
                        "lines": [
                            {
                                "patchline": {
                                    "destination": [ "out0", 0 ],
                                    "source": [ "c0_0", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "out1", 0 ],
                                    "source": [ "c1_0", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "out2", 0 ],
                                    "source": [ "c2_0", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "out3", 0 ],
                                    "source": [ "c3_0", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "out4", 0 ],
                                    "source": [ "c4_0", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "out5", 0 ],
                                    "source": [ "c5_0", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "c0_0", 0 ],
                                    "source": [ "h0_0", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "c1_0", 0 ],
                                    "source": [ "h1_0", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "c2_0", 0 ],
                                    "source": [ "h2_0", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "c3_0", 0 ],
                                    "source": [ "h3_0", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "c4_0", 0 ],
                                    "source": [ "h4_0", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "c5_0", 0 ],
                                    "source": [ "h5_0", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "t0", 0 ],
                                    "source": [ "in", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "s0_3", 0 ],
                                    "source": [ "m0_3", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "s0_5", 0 ],
                                    "source": [ "m0_5", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "s0_6", 0 ],
                                    "source": [ "m0_6", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "h0_0", 1 ],
                                    "source": [ "o0_0_0", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "h1_0", 1 ],
                                    "source": [ "o1_0_0", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "h2_0", 1 ],
                                    "source": [ "o2_0_0", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "h3_0", 1 ],
                                    "source": [ "o3_0_0", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "h4_0", 1 ],
                                    "source": [ "o4_0_0", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "h5_0", 1 ],
                                    "source": [ "o5_0_0", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "o0_0_0", 0 ],
                                    "source": [ "r0_0", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "o1_0_0", 0 ],
                                    "source": [ "r1_0", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "o2_0_0", 0 ],
                                    "source": [ "r2_0", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "o3_0_0", 0 ],
                                    "source": [ "r3_0", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "o4_0_0", 0 ],
                                    "source": [ "r4_0", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "o5_0_0", 0 ],
                                    "source": [ "r5_0", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "done", 0 ],
                                    "source": [ "t0", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "h0_0", 0 ],
                                    "source": [ "t0", 6 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "h1_0", 0 ],
                                    "source": [ "t0", 5 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "h2_0", 0 ],
                                    "source": [ "t0", 4 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "h3_0", 0 ],
                                    "source": [ "t0", 3 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "h4_0", 0 ],
                                    "source": [ "t0", 2 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "h5_0", 0 ],
                                    "source": [ "t0", 1 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "m0_3", 0 ],
                                    "source": [ "t0", 10 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "m0_5", 0 ],
                                    "source": [ "t0", 8 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "m0_6", 0 ],
                                    "source": [ "t0", 7 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "s0_0", 0 ],
                                    "source": [ "t0", 13 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "s0_1", 0 ],
                                    "source": [ "t0", 12 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "s0_2", 0 ],
                                    "source": [ "t0", 11 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "s0_4", 0 ],
                                    "source": [ "t0", 9 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "zv0_0", 0 ],
                                    "source": [ "zr0_0", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "zv1_0", 0 ],
                                    "source": [ "zr1_0", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "zv2_0", 0 ],
                                    "source": [ "zr2_0", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "zv3_0", 0 ],
                                    "source": [ "zr3_0", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "zv4_0", 0 ],
                                    "source": [ "zr4_0", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "zv5_0", 0 ],
                                    "source": [ "zr5_0", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "h0_0", 1 ],
                                    "source": [ "zv0_0", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "h1_0", 1 ],
                                    "source": [ "zv1_0", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "h2_0", 1 ],
                                    "source": [ "zv2_0", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "h3_0", 1 ],
                                    "source": [ "zv3_0", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "h4_0", 1 ],
                                    "source": [ "zv4_0", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "h5_0", 1 ],
                                    "source": [ "zv5_0", 0 ]
                                }
                            }
                        ]
                    },
                    "patching_rect": [ 30.0, 124.0, 2627.6, 22.0 ],
                    "text": "p change_every_parameter"
                }
            },
            {
                "box": {
                    "color": [ 0.7, 0.4, 0.3, 1.0 ],
                    "id": "step0_a0",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 464.8, 194.0, 410.6, 22.0 ],
                    "text": "test.assert Jamoma/Modular/j.model/outputs_parameter_change/decimal"
                }
            },
            {
                "box": {
                    "color": [ 0.7, 0.4, 0.3, 1.0 ],
                    "id": "step0_a1",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 899.5, 194.0, 410.6, 22.0 ],
                    "text": "test.assert Jamoma/Modular/j.model/outputs_parameter_change/integer"
                }
            },
            {
                "box": {
                    "color": [ 0.7, 0.4, 0.3, 1.0 ],
                    "id": "step0_a2",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 1334.3, 194.0, 404.8, 22.0 ],
                    "text": "test.assert Jamoma/Modular/j.model/outputs_parameter_change/string"
                }
            },
            {
                "box": {
                    "color": [ 0.7, 0.4, 0.3, 1.0 ],
                    "id": "step0_a3",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 1769.1, 194.0, 410.6, 22.0 ],
                    "text": "test.assert Jamoma/Modular/j.model/outputs_parameter_change/boolean"
                }
            },
            {
                "box": {
                    "color": [ 0.7, 0.4, 0.3, 1.0 ],
                    "id": "step0_a4",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 2203.8, 194.0, 399.0, 22.0 ],
                    "text": "test.assert Jamoma/Modular/j.model/outputs_parameter_change/array"
                }
            },
            {
                "box": {
                    "color": [ 0.7, 0.4, 0.3, 1.0 ],
                    "id": "step0_a5",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 2638.6, 194.0, 410.6, 22.0 ],
                    "text": "test.assert Jamoma/Modular/j.model/outputs_parameter_change/generic"
                }
            },
            {
                "box": {
                    "color": [ 0.7, 0.4, 0.3, 1.0 ],
                    "id": "term",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [ 30.0, 244.0, 103.2, 22.0 ],
                    "text": "test.terminate"
                }
            },
            {
                "box": {
                    "id": "tg_step0_a0",
                    "maxclass": "toggle",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [ "int" ],
                    "parameter_enable": 0,
                    "patching_rect": [ 464.8, 160.0, 24.0, 24.0 ]
                }
            },
            {
                "box": {
                    "id": "tg_step0_a1",
                    "maxclass": "toggle",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [ "int" ],
                    "parameter_enable": 0,
                    "patching_rect": [ 899.5, 160.0, 24.0, 24.0 ]
                }
            },
            {
                "box": {
                    "id": "tg_step0_a2",
                    "maxclass": "toggle",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [ "int" ],
                    "parameter_enable": 0,
                    "patching_rect": [ 1334.3, 160.0, 24.0, 24.0 ]
                }
            },
            {
                "box": {
                    "id": "tg_step0_a3",
                    "maxclass": "toggle",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [ "int" ],
                    "parameter_enable": 0,
                    "patching_rect": [ 1769.1, 160.0, 24.0, 24.0 ]
                }
            },
            {
                "box": {
                    "id": "tg_step0_a4",
                    "maxclass": "toggle",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [ "int" ],
                    "parameter_enable": 0,
                    "patching_rect": [ 2203.8, 160.0, 24.0, 24.0 ]
                }
            },
            {
                "box": {
                    "id": "tg_step0_a5",
                    "maxclass": "toggle",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [ "int" ],
                    "parameter_enable": 0,
                    "patching_rect": [ 2638.6, 160.0, 24.0, 24.0 ]
                }
            }
        ],
        "lines": [
            {
                "patchline": {
                    "destination": [ "obj-1_s0", 0 ],
                    "source": [ "obj-1", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "step0", 0 ],
                    "source": [ "obj-11", 1 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-23", 0 ],
                    "source": [ "obj-23_r0", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-24", 0 ],
                    "source": [ "obj-24_r0", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-25", 0 ],
                    "source": [ "obj-25_r0", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-26", 0 ],
                    "source": [ "obj-26_r0", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-27", 0 ],
                    "source": [ "obj-27_r0", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-2", 0 ],
                    "source": [ "obj-2_r0", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "term", 0 ],
                    "source": [ "step0", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "tg_step0_a0", 0 ],
                    "source": [ "step0", 1 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "tg_step0_a1", 0 ],
                    "source": [ "step0", 2 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "tg_step0_a2", 0 ],
                    "source": [ "step0", 3 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "tg_step0_a3", 0 ],
                    "source": [ "step0", 4 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "tg_step0_a4", 0 ],
                    "source": [ "step0", 5 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "tg_step0_a5", 0 ],
                    "source": [ "step0", 6 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "step0_a0", 0 ],
                    "source": [ "tg_step0_a0", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "step0_a1", 0 ],
                    "source": [ "tg_step0_a1", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "step0_a2", 0 ],
                    "source": [ "tg_step0_a2", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "step0_a3", 0 ],
                    "source": [ "tg_step0_a3", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "step0_a4", 0 ],
                    "source": [ "tg_step0_a4", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "step0_a5", 0 ],
                    "source": [ "tg_step0_a5", 0 ]
                }
            }
        ],
        "autosave": 0
    }
}