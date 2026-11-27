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
        "rect": [ 34.0, 96.0, 1660.0, 458.0 ],
        "boxes": [
            {
                "box": {
                    "id": "about",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [ 30.0, 30.0, 462.8, 20.0 ],
                    "text": "Presets are written to a file and read back; a missing file changes nothing."
                }
            },
            {
                "box": {
                    "id": "m",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [ "", "" ],
                    "patching_rect": [ 1347.8, 158.0, 80.0, 22.0 ],
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
                    "patching_rect": [ 1347.8, 30.0, 126.4, 22.0 ],
                    "text": "r mod_fil_to_model"
                }
            },
            {
                "box": {
                    "id": "m_s1",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [ 1347.8, 222.0, 132.2, 22.0 ],
                    "text": "s mod_fil_from_dump"
                }
            },
            {
                "box": {
                    "id": "pa",
                    "linecount": 3,
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [ "", "" ],
                    "patching_rect": [ 1209.0, 94.0, 116.4, 49.0 ],
                    "text": "j.parameter a @type integer @default 1"
                }
            },
            {
                "box": {
                    "id": "pa_r0",
                    "maxclass": "newobj",
                    "numinlets": 0,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 1209.0, 30.0, 103.2, 22.0 ],
                    "text": "r mod_fil_to_a"
                }
            },
            {
                "box": {
                    "id": "pa_s0",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [ 1209.0, 158.0, 114.8, 22.0 ],
                    "text": "s mod_fil_from_a"
                }
            },
            {
                "box": {
                    "id": "pb",
                    "linecount": 3,
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [ "", "" ],
                    "patching_rect": [ 1509.0, 30.0, 116.4, 49.0 ],
                    "text": "j.parameter b @type integer @default 2"
                }
            },
            {
                "box": {
                    "id": "pb_s0",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [ 1509.0, 94.0, 114.8, 22.0 ],
                    "text": "s mod_fil_from_b"
                }
            },
            {
                "box": {
                    "id": "recall_r",
                    "maxclass": "newobj",
                    "numinlets": 0,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 1647.0, 30.0, 132.2, 22.0 ],
                    "text": "r mod_fil_to_recall"
                }
            },
            {
                "box": {
                    "id": "recall",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 1647.0, 94.0, 103.2, 22.0 ],
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
                        "rect": [ 34.0, 96.0, 1952.4, 370.0 ],
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
                                    "patching_rect": [ 1460.8, 110.0, 114.8, 22.0 ],
                                    "text": "r mod_fil_from_a"
                                }
                            },
                            {
                                "box": {
                                    "id": "h0_0",
                                    "maxclass": "newobj",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [ "int" ],
                                    "patching_rect": [ 1460.8, 150.0, 56.8, 22.0 ],
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
                                    "patching_rect": [ 1587.6, 70.0, 196.0, 22.0 ],
                                    "text": "r mod_fil_write_and_read_begin"
                                }
                            },
                            {
                                "box": {
                                    "id": "zv0_0",
                                    "maxclass": "message",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "patching_rect": [ 1587.6, 110.0, 40.0, 22.0 ],
                                    "text": "-1"
                                }
                            },
                            {
                                "box": {
                                    "id": "r0_1",
                                    "maxclass": "newobj",
                                    "numinlets": 0,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "patching_rect": [ 1807.6, 110.0, 114.8, 22.0 ],
                                    "text": "r mod_fil_from_b"
                                }
                            },
                            {
                                "box": {
                                    "id": "h0_1",
                                    "maxclass": "newobj",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [ "int" ],
                                    "patching_rect": [ 1807.6, 150.0, 56.8, 22.0 ],
                                    "text": "int -1"
                                }
                            },
                            {
                                "box": {
                                    "id": "c0_0",
                                    "maxclass": "newobj",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "patching_rect": [ 1460.8, 190.0, 109.0, 22.0 ],
                                    "text": "expr $i1*10+$i2"
                                }
                            },
                            {
                                "box": {
                                    "id": "c0_1",
                                    "maxclass": "newobj",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [ "int" ],
                                    "patching_rect": [ 1460.8, 230.0, 51.0, 22.0 ],
                                    "text": "== 12"
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
                                    "patching_rect": [ 1460.8, 310.0, 30.0, 30.0 ]
                                }
                            },
                            {
                                "box": {
                                    "id": "t0",
                                    "maxclass": "newobj",
                                    "numinlets": 1,
                                    "numoutlets": 10,
                                    "outlettype": [ "bang", "bang", "bang", "bang", "int", "bang", "bang", "bang", "bang", "bang" ],
                                    "patching_rect": [ 30.0, 110.0, 149.6, 22.0 ],
                                    "text": "t b b b b 11 b b b b b"
                                }
                            },
                            {
                                "box": {
                                    "id": "s0_0",
                                    "maxclass": "newobj",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "patching_rect": [ 1224.8, 150.0, 196.0, 22.0 ],
                                    "text": "s mod_fil_write_and_read_begin"
                                }
                            },
                            {
                                "box": {
                                    "id": "s0_1",
                                    "maxclass": "newobj",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "patching_rect": [ 1082.4, 190.0, 126.4, 22.0 ],
                                    "text": "s mod_fil_to_model"
                                }
                            },
                            {
                                "box": {
                                    "id": "m0_1",
                                    "maxclass": "message",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "patching_rect": [ 1082.4, 150.0, 103.2, 22.0 ],
                                    "text": "preset:new one"
                                }
                            },
                            {
                                "box": {
                                    "id": "s0_2",
                                    "maxclass": "newobj",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "patching_rect": [ 818.2, 190.0, 126.4, 22.0 ],
                                    "text": "s mod_fil_to_model"
                                }
                            },
                            {
                                "box": {
                                    "id": "m0_2",
                                    "maxclass": "message",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "patching_rect": [ 818.2, 150.0, 248.2, 22.0 ],
                                    "text": "preset:write /tmp/jamoma_m3_presets.txt"
                                }
                            },
                            {
                                "box": {
                                    "id": "s0_3",
                                    "maxclass": "newobj",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "patching_rect": [ 675.8, 190.0, 126.4, 22.0 ],
                                    "text": "s mod_fil_to_model"
                                }
                            },
                            {
                                "box": {
                                    "id": "m0_3",
                                    "maxclass": "message",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "patching_rect": [ 675.8, 150.0, 91.6, 22.0 ],
                                    "text": "preset:clear"
                                }
                            },
                            {
                                "box": {
                                    "id": "s0_4",
                                    "maxclass": "newobj",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "patching_rect": [ 417.4, 190.0, 126.4, 22.0 ],
                                    "text": "s mod_fil_to_model"
                                }
                            },
                            {
                                "box": {
                                    "id": "m0_4",
                                    "maxclass": "message",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "patching_rect": [ 417.4, 150.0, 242.4, 22.0 ],
                                    "text": "preset:read /tmp/jamoma_m3_presets.txt"
                                }
                            },
                            {
                                "box": {
                                    "id": "s0_5",
                                    "maxclass": "newobj",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "patching_rect": [ 298.2, 150.0, 103.2, 22.0 ],
                                    "text": "s mod_fil_to_a"
                                }
                            },
                            {
                                "box": {
                                    "id": "s0_6",
                                    "maxclass": "newobj",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "patching_rect": [ 150.0, 190.0, 132.2, 22.0 ],
                                    "text": "s mod_fil_to_recall"
                                }
                            },
                            {
                                "box": {
                                    "id": "m0_6",
                                    "maxclass": "message",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "patching_rect": [ 150.0, 150.0, 40.0, 22.0 ],
                                    "text": "one"
                                }
                            }
                        ],
                        "lines": [
                            {
                                "patchline": {
                                    "destination": [ "c0_1", 0 ],
                                    "source": [ "c0_0", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "out0", 0 ],
                                    "source": [ "c0_1", 0 ]
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
                                    "destination": [ "c0_0", 1 ],
                                    "source": [ "h0_1", 0 ]
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
                                    "destination": [ "s0_4", 0 ],
                                    "source": [ "m0_4", 0 ]
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
                                    "source": [ "r0_0", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "h0_1", 1 ],
                                    "source": [ "r0_1", 0 ]
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
                                    "destination": [ "h0_1", 0 ],
                                    "source": [ "t0", 2 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "m0_1", 0 ],
                                    "source": [ "t0", 8 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "m0_2", 0 ],
                                    "source": [ "t0", 7 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "m0_3", 0 ],
                                    "source": [ "t0", 6 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "m0_4", 0 ],
                                    "source": [ "t0", 5 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "m0_6", 0 ],
                                    "source": [ "t0", 3 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "s0_0", 0 ],
                                    "source": [ "t0", 9 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "s0_5", 0 ],
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
                    "patching_rect": [ 30.0, 124.0, 506.8, 22.0 ],
                    "text": "p write_and_read"
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
                    "patching_rect": [ 517.8, 194.0, 462.8, 22.0 ],
                    "text": "test.assert Jamoma/Modular/j.model/preset_files/read_brings_the_presets_back"
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
                        "rect": [ 34.0, 96.0, 1162.8, 370.0 ],
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
                                    "patching_rect": [ 804.2, 70.0, 132.2, 22.0 ],
                                    "text": "r mod_fil_from_dump"
                                }
                            },
                            {
                                "box": {
                                    "id": "o0_0_0",
                                    "maxclass": "newobj",
                                    "numinlets": 2,
                                    "numoutlets": 2,
                                    "outlettype": [ "", "" ],
                                    "patching_rect": [ 804.2, 110.0, 126.4, 22.0 ],
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
                                    "patching_rect": [ 804.2, 150.0, 56.8, 22.0 ],
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
                                    "patching_rect": [ 804.2, 190.0, 51.0, 22.0 ],
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
                                    "patching_rect": [ 948.4, 110.0, 184.4, 22.0 ],
                                    "text": "r mod_fil_missing_file_begin"
                                }
                            },
                            {
                                "box": {
                                    "id": "zv0_0",
                                    "maxclass": "message",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "patching_rect": [ 948.4, 150.0, 40.0, 22.0 ],
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
                                    "patching_rect": [ 804.2, 230.0, 45.2, 22.0 ],
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
                                    "patching_rect": [ 804.2, 310.0, 30.0, 30.0 ]
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
                                    "patching_rect": [ 579.8, 190.0, 184.4, 22.0 ],
                                    "text": "s mod_fil_missing_file_begin"
                                }
                            },
                            {
                                "box": {
                                    "id": "s0_1",
                                    "maxclass": "newobj",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "patching_rect": [ 292.4, 230.0, 126.4, 22.0 ],
                                    "text": "s mod_fil_to_model"
                                }
                            },
                            {
                                "box": {
                                    "id": "m0_1",
                                    "maxclass": "message",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "patching_rect": [ 292.4, 190.0, 271.4, 22.0 ],
                                    "text": "preset:read /tmp/jamoma_m3_missing_file.txt"
                                }
                            },
                            {
                                "box": {
                                    "id": "s0_2",
                                    "maxclass": "newobj",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "patching_rect": [ 150.0, 230.0, 126.4, 22.0 ],
                                    "text": "s mod_fil_to_model"
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
                    "patching_rect": [ 30.0, 244.0, 506.8, 22.0 ],
                    "text": "p missing_file"
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
                    "patching_rect": [ 517.8, 314.0, 462.8, 22.0 ],
                    "text": "test.assert Jamoma/Modular/j.model/preset_files/missing_file_changes_nothing"
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
                    "patching_rect": [ 517.8, 160.0, 24.0, 24.0 ]
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
                    "patching_rect": [ 517.8, 280.0, 24.0, 24.0 ]
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
                    "destination": [ "pa", 0 ],
                    "source": [ "pa_r0", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "pb_s0", 0 ],
                    "source": [ "pb", 0 ]
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