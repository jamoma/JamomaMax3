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
        "rect": [ 34.0, 96.0, 1660.0, 796.0 ],
        "boxes": [
            {
                "box": {
                    "id": "about",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [ 30.0, 30.0, 555.6, 20.0 ],
                    "text": "The parameters initialise in the order of their priority, and j.init bangs when that starts."
                }
            },
            {
                "box": {
                    "id": "m",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [ "", "" ],
                    "patching_rect": [ 1180.0, 30.0, 103.2, 22.0 ],
                    "text": "j.model modelA"
                }
            },
            {
                "box": {
                    "id": "pa",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [ "", "" ],
                    "patching_rect": [ 1307.2, 30.0, 312.0, 22.0 ],
                    "text": "j.parameter a @type integer @default 1 @priority 1"
                }
            },
            {
                "box": {
                    "id": "pa_s0",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [ 1307.2, 94.0, 143.8, 22.0 ],
                    "text": "s mod_pri_from_params"
                }
            },
            {
                "box": {
                    "id": "pb",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [ "", "" ],
                    "patching_rect": [ 1643.2, 30.0, 312.0, 22.0 ],
                    "text": "j.parameter b @type integer @default 2 @priority 0"
                }
            },
            {
                "box": {
                    "id": "pb_s0",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [ 1643.2, 94.0, 143.8, 22.0 ],
                    "text": "s mod_pri_from_params"
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
                    "id": "ji_s0",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [ 30.0, 114.0, 167.0, 22.0 ],
                    "text": "s mod_pri_from_init_start"
                }
            },
            {
                "box": {
                    "id": "step0",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 3,
                    "outlettype": [ "bang", "", "int" ],
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
                        "rect": [ 34.0, 96.0, 534.8, 330.0 ],
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
                                    "patching_rect": [ 170.0, 70.0, 143.8, 22.0 ],
                                    "text": "r mod_pri_from_params"
                                }
                            },
                            {
                                "box": {
                                    "id": "o0_0_0",
                                    "maxclass": "newobj",
                                    "numinlets": 2,
                                    "numoutlets": 2,
                                    "outlettype": [ "", "" ],
                                    "patching_rect": [ 170.0, 110.0, 80.0, 22.0 ],
                                    "text": "zl group 2"
                                }
                            },
                            {
                                "box": {
                                    "id": "h0_0",
                                    "maxclass": "newobj",
                                    "numinlets": 2,
                                    "numoutlets": 2,
                                    "outlettype": [ "", "" ],
                                    "patching_rect": [ 170.0, 150.0, 85.8, 22.0 ],
                                    "text": "zl reg none"
                                }
                            },
                            {
                                "box": {
                                    "id": "c0_0",
                                    "maxclass": "newobj",
                                    "numinlets": 2,
                                    "numoutlets": 2,
                                    "outlettype": [ "", "" ],
                                    "patching_rect": [ 170.0, 190.0, 103.2, 22.0 ],
                                    "text": "zl compare 2 1"
                                }
                            },
                            {
                                "box": {
                                    "id": "r1_0",
                                    "maxclass": "newobj",
                                    "numinlets": 0,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "patching_rect": [ 337.8, 70.0, 167.0, 22.0 ],
                                    "text": "r mod_pri_from_init_start"
                                }
                            },
                            {
                                "box": {
                                    "id": "o1_0_0",
                                    "maxclass": "newobj",
                                    "numinlets": 1,
                                    "numoutlets": 1,
                                    "outlettype": [ "int" ],
                                    "patching_rect": [ 337.8, 110.0, 40.0, 22.0 ],
                                    "text": "t 1"
                                }
                            },
                            {
                                "box": {
                                    "id": "h1_0",
                                    "maxclass": "newobj",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [ "int" ],
                                    "patching_rect": [ 337.8, 150.0, 51.0, 22.0 ],
                                    "text": "int 0"
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
                                    "patching_rect": [ 170.0, 270.0, 30.0, 30.0 ]
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
                                    "patching_rect": [ 337.8, 270.0, 30.0, 30.0 ]
                                }
                            },
                            {
                                "box": {
                                    "id": "t0",
                                    "maxclass": "newobj",
                                    "numinlets": 1,
                                    "numoutlets": 3,
                                    "outlettype": [ "bang", "bang", "bang" ],
                                    "patching_rect": [ 30.0, 110.0, 62.6, 22.0 ],
                                    "text": "t b b b"
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
                                    "destination": [ "out1", 0 ],
                                    "source": [ "h1_0", 0 ]
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
                                    "destination": [ "done", 0 ],
                                    "source": [ "t0", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "h0_0", 0 ],
                                    "source": [ "t0", 2 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "h1_0", 0 ],
                                    "source": [ "t0", 1 ]
                                }
                            }
                        ]
                    },
                    "patching_rect": [ 30.0, 208.0, 750.0, 22.0 ],
                    "text": "p after_initialisation"
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
                    "patching_rect": [ 395.0, 278.0, 335.2, 22.0 ],
                    "text": "test.assert Jamoma/Modular/j.model/init/priority_order"
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
                    "patching_rect": [ 761.0, 278.0, 341.0, 22.0 ],
                    "text": "test.assert Jamoma/Modular/j.model/init/init_start_bang"
                }
            },
            {
                "box": {
                    "color": [ 0.7, 0.4, 0.3, 1.0 ],
                    "id": "term",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [ 30.0, 328.0, 103.2, 22.0 ],
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
                    "patching_rect": [ 395.0, 244.0, 24.0, 24.0 ]
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
                    "patching_rect": [ 761.0, 244.0, 24.0, 24.0 ]
                }
            }
        ],
        "lines": [
            {
                "patchline": {
                    "destination": [ "ji_s0", 0 ],
                    "source": [ "ji", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "step0", 0 ],
                    "source": [ "ji", 1 ]
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
                    "destination": [ "pb_s0", 0 ],
                    "source": [ "pb", 0 ]
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
                    "destination": [ "step0_a0", 0 ],
                    "source": [ "tg_step0_a0", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "step0_a1", 0 ],
                    "source": [ "tg_step0_a1", 0 ]
                }
            }
        ],
        "autosave": 0
    }
}