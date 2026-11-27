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
        "rect": [ 34.0, 96.0, 1626.0, 458.0 ],
        "boxes": [
            {
                "box": {
                    "id": "about",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [ 30.0, 30.0, 503.4, 20.0 ],
                    "text": "The text of the preset editor replaces the presets; a damaged text changes nothing."
                }
            },
            {
                "box": {
                    "id": "m",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [ "", "" ],
                    "patching_rect": [ 1307.0, 201.0, 80.0, 22.0 ],
                    "text": "j.model pm"
                }
            },
            {
                "box": {
                    "id": "m_r0",
                    "maxclass": "newobj",
                    "numinlets": 0,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 1307.0, 30.0, 126.4, 22.0 ],
                    "text": "r mod_edt_to_model"
                }
            },
            {
                "box": {
                    "id": "m_s1",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [ 1307.0, 265.0, 132.2, 22.0 ],
                    "text": "s mod_edt_from_dump"
                }
            },
            {
                "box": {
                    "id": "pa",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [ "", "" ],
                    "patching_rect": [ 994.0, 30.0, 242.4, 22.0 ],
                    "text": "j.parameter a @type integer @default 1"
                }
            },
            {
                "box": {
                    "id": "pa_s0",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [ 994.0, 94.0, 114.8, 22.0 ],
                    "text": "s mod_edt_from_a"
                }
            },
            {
                "box": {
                    "id": "recall_r",
                    "maxclass": "newobj",
                    "numinlets": 0,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 1463.8, 30.0, 132.2, 22.0 ],
                    "text": "r mod_edt_to_recall"
                }
            },
            {
                "box": {
                    "id": "recall",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 1463.8, 94.0, 103.2, 22.0 ],
                    "text": "prepend preset"
                }
            },
            {
                "box": {
                    "id": "ji",
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
                    "numoutlets": 2,
                    "outlettype": [ "bang", "int" ],
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
                        "rect": [ 34.0, 96.0, 1183.4, 330.0 ],
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
                                    "patching_rect": [ 882.8, 110.0, 114.8, 22.0 ],
                                    "text": "r mod_edt_from_a"
                                }
                            },
                            {
                                "box": {
                                    "id": "h0_0",
                                    "maxclass": "newobj",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [ "int" ],
                                    "patching_rect": [ 882.8, 150.0, 56.8, 22.0 ],
                                    "text": "int -1"
                                }
                            },
                            {
                                "box": {
                                    "id": "zr0_0",
                                    "maxclass": "newobj",
                                    "numinlets": 0,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "patching_rect": [ 1009.6, 70.0, 143.8, 22.0 ],
                                    "text": "r mod_edt_apply_begin"
                                }
                            },
                            {
                                "box": {
                                    "id": "zv0_0",
                                    "maxclass": "message",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "patching_rect": [ 1009.6, 110.0, 40.0, 22.0 ],
                                    "text": "-1"
                                }
                            },
                            {
                                "box": {
                                    "id": "c0_0",
                                    "maxclass": "newobj",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [ "int" ],
                                    "patching_rect": [ 882.8, 190.0, 45.2, 22.0 ],
                                    "text": "== 7"
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
                                    "patching_rect": [ 882.8, 270.0, 30.0, 30.0 ]
                                }
                            },
                            {
                                "box": {
                                    "id": "t0",
                                    "maxclass": "newobj",
                                    "numinlets": 1,
                                    "numoutlets": 6,
                                    "outlettype": [ "bang", "bang", "bang", "bang", "bang", "bang" ],
                                    "patching_rect": [ 30.0, 110.0, 97.4, 22.0 ],
                                    "text": "t b b b b b b"
                                }
                            },
                            {
                                "box": {
                                    "id": "s0_0",
                                    "maxclass": "newobj",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "patching_rect": [ 699.0, 150.0, 143.8, 22.0 ],
                                    "text": "s mod_edt_apply_begin"
                                }
                            },
                            {
                                "box": {
                                    "id": "s0_1",
                                    "maxclass": "newobj",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "patching_rect": [ 556.6, 190.0, 126.4, 22.0 ],
                                    "text": "s mod_edt_to_model"
                                }
                            },
                            {
                                "box": {
                                    "id": "m0_1",
                                    "maxclass": "message",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "patching_rect": [ 556.6, 150.0, 103.2, 22.0 ],
                                    "text": "preset:new one"
                                }
                            },
                            {
                                "box": {
                                    "id": "s0_2",
                                    "maxclass": "newobj",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "patching_rect": [ 298.2, 190.0, 126.4, 22.0 ],
                                    "text": "s mod_edt_to_model"
                                }
                            },
                            {
                                "box": {
                                    "id": "m0_2",
                                    "maxclass": "message",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "patching_rect": [ 298.2, 150.0, 242.4, 22.0 ],
                                    "text": "preset:edit/apply \"- preset two\\\\na 7\""
                                }
                            },
                            {
                                "box": {
                                    "id": "s0_3",
                                    "maxclass": "newobj",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "patching_rect": [ 150.0, 190.0, 132.2, 22.0 ],
                                    "text": "s mod_edt_to_recall"
                                }
                            },
                            {
                                "box": {
                                    "id": "m0_3",
                                    "maxclass": "message",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "patching_rect": [ 150.0, 150.0, 40.0, 22.0 ],
                                    "text": "two"
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
                                    "destination": [ "c0_0", 0 ],
                                    "source": [ "h0_0", 0 ]
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
                                    "destination": [ "s0_1", 0 ],
                                    "source": [ "m0_1", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "s0_2", 0 ],
                                    "source": [ "m0_2", 0 ]
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
                                    "destination": [ "h0_0", 1 ],
                                    "source": [ "r0_0", 0 ]
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
                                    "source": [ "t0", 1 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "m0_1", 0 ],
                                    "source": [ "t0", 4 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "m0_2", 0 ],
                                    "source": [ "t0", 3 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "m0_3", 0 ],
                                    "source": [ "t0", 2 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "s0_0", 0 ],
                                    "source": [ "t0", 5 ]
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
                                    "destination": [ "h0_0", 1 ],
                                    "source": [ "zv0_0", 0 ]
                                }
                            }
                        ]
                    },
                    "patching_rect": [ 30.0, 124.0, 472.0, 22.0 ],
                    "text": "p apply"
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
                    "patching_rect": [ 483.0, 194.0, 428.0, 22.0 ],
                    "text": "test.assert Jamoma/Modular/j.model/preset_edit/applies_the_edited_text"
                }
            },
            {
                "box": {
                    "id": "step1",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [ "bang", "int" ],
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
                        "rect": [ 34.0, 96.0, 1168.6, 370.0 ],
                        "boxes": [
                            {
                                "box": {
                                    "comment": "",
                                    "id": "in",
                                    "index": 1,
                                    "maxclass": "inlet",
                                    "numinlets": 0,
                                    "numoutlets": 1,
                                    "outlettype": [ "bang" ],
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
                                    "patching_rect": [ 810.0, 70.0, 132.2, 22.0 ],
                                    "text": "r mod_edt_from_dump"
                                }
                            },
                            {
                                "box": {
                                    "id": "o0_0_0",
                                    "maxclass": "newobj",
                                    "numinlets": 2,
                                    "numoutlets": 2,
                                    "outlettype": [ "", "" ],
                                    "patching_rect": [ 810.0, 110.0, 126.4, 22.0 ],
                                    "text": "route preset:names"
                                }
                            },
                            {
                                "box": {
                                    "id": "o0_0_1",
                                    "maxclass": "newobj",
                                    "numinlets": 2,
                                    "numoutlets": 2,
                                    "outlettype": [ "", "" ],
                                    "patching_rect": [ 810.0, 150.0, 56.8, 22.0 ],
                                    "text": "zl len"
                                }
                            },
                            {
                                "box": {
                                    "id": "h0_0",
                                    "maxclass": "newobj",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [ "int" ],
                                    "patching_rect": [ 810.0, 190.0, 51.0, 22.0 ],
                                    "text": "int 0"
                                }
                            },
                            {
                                "box": {
                                    "id": "zr0_0",
                                    "maxclass": "newobj",
                                    "numinlets": 0,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "patching_rect": [ 954.2, 110.0, 184.4, 22.0 ],
                                    "text": "r mod_edt_damaged_text_begin"
                                }
                            },
                            {
                                "box": {
                                    "id": "zv0_0",
                                    "maxclass": "message",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "patching_rect": [ 954.2, 150.0, 40.0, 22.0 ],
                                    "text": "0"
                                }
                            },
                            {
                                "box": {
                                    "id": "c0_0",
                                    "maxclass": "newobj",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [ "int" ],
                                    "patching_rect": [ 810.0, 230.0, 45.2, 22.0 ],
                                    "text": "== 1"
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
                                    "patching_rect": [ 30.0, 310.0, 30.0, 30.0 ]
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
                                    "patching_rect": [ 810.0, 310.0, 30.0, 30.0 ]
                                }
                            },
                            {
                                "box": {
                                    "id": "t0",
                                    "maxclass": "newobj",
                                    "numinlets": 1,
                                    "numoutlets": 5,
                                    "outlettype": [ "bang", "bang", "bang", "bang", "bang" ],
                                    "patching_rect": [ 30.0, 150.0, 85.8, 22.0 ],
                                    "text": "t b b b b b"
                                }
                            },
                            {
                                "box": {
                                    "id": "s0_0",
                                    "maxclass": "newobj",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "patching_rect": [ 585.6, 190.0, 184.4, 22.0 ],
                                    "text": "s mod_edt_damaged_text_begin"
                                }
                            },
                            {
                                "box": {
                                    "id": "s0_1",
                                    "maxclass": "newobj",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "patching_rect": [ 292.4, 230.0, 126.4, 22.0 ],
                                    "text": "s mod_edt_to_model"
                                }
                            },
                            {
                                "box": {
                                    "id": "m0_1",
                                    "maxclass": "message",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "patching_rect": [ 292.4, 190.0, 277.2, 22.0 ],
                                    "text": "preset:edit/apply \"nothing that is a preset\""
                                }
                            },
                            {
                                "box": {
                                    "id": "s0_2",
                                    "maxclass": "newobj",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "patching_rect": [ 150.0, 230.0, 126.4, 22.0 ],
                                    "text": "s mod_edt_to_model"
                                }
                            },
                            {
                                "box": {
                                    "id": "m0_2",
                                    "maxclass": "message",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "patching_rect": [ 150.0, 190.0, 91.6, 22.0 ],
                                    "text": "preset:names"
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
                                    "destination": [ "c0_0", 0 ],
                                    "source": [ "h0_0", 0 ]
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
                                    "destination": [ "s0_1", 0 ],
                                    "source": [ "m0_1", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "s0_2", 0 ],
                                    "source": [ "m0_2", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "o0_0_1", 0 ],
                                    "source": [ "o0_0_0", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "h0_0", 1 ],
                                    "source": [ "o0_0_1", 0 ]
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
                                    "destination": [ "done", 0 ],
                                    "source": [ "t0", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "h0_0", 0 ],
                                    "source": [ "t0", 1 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "m0_1", 0 ],
                                    "source": [ "t0", 3 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "m0_2", 0 ],
                                    "source": [ "t0", 2 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "s0_0", 0 ],
                                    "source": [ "t0", 4 ]
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
                                    "destination": [ "h0_0", 1 ],
                                    "source": [ "zv0_0", 0 ]
                                }
                            }
                        ]
                    },
                    "patching_rect": [ 30.0, 244.0, 501.0, 22.0 ],
                    "text": "p damaged_text"
                }
            },
            {
                "box": {
                    "color": [ 0.7, 0.4, 0.3, 1.0 ],
                    "id": "step1_a0",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 512.0, 314.0, 457.0, 22.0 ],
                    "text": "test.assert Jamoma/Modular/j.model/preset_edit/damaged_text_changes_nothing"
                }
            },
            {
                "box": {
                    "color": [ 0.7, 0.4, 0.3, 1.0 ],
                    "id": "term",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [ 30.0, 364.0, 103.2, 22.0 ],
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
                    "patching_rect": [ 483.0, 160.0, 24.0, 24.0 ]
                }
            },
            {
                "box": {
                    "id": "tg_step1_a0",
                    "maxclass": "toggle",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [ "int" ],
                    "parameter_enable": 0,
                    "patching_rect": [ 512.0, 280.0, 24.0, 24.0 ]
                }
            }
        ],
        "lines": [
            {
                "patchline": {
                    "destination": [ "step0", 0 ],
                    "source": [ "ji", 1 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "m_s1", 0 ],
                    "source": [ "m", 1 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "m", 0 ],
                    "source": [ "m_r0", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "pa_s0", 0 ],
                    "source": [ "pa", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "m", 0 ],
                    "source": [ "recall", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "recall", 0 ],
                    "source": [ "recall_r", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "step1", 0 ],
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
                    "destination": [ "term", 0 ],
                    "source": [ "step1", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "tg_step1_a0", 0 ],
                    "source": [ "step1", 1 ]
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
                    "destination": [ "step1_a0", 0 ],
                    "source": [ "tg_step1_a0", 0 ]
                }
            }
        ],
        "autosave": 0
    }
}