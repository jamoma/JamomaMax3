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
        "rect": [ 34.0, 96.0, 835.0, 452.0 ],
        "boxes": [
            {
                "box": {
                    "id": "lb",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [ "bang" ],
                    "patching_rect": [ 30.0, 30.0, 58.0, 22.0 ],
                    "text": "loadbang"
                }
            },
            {
                "box": {
                    "id": "d1",
                    "maxclass": "newobj",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [ "bang" ],
                    "patching_rect": [ 30.0, 94.0, 67.0, 22.0 ],
                    "text": "delay 1800"
                }
            },
            {
                "box": {
                    "id": "seven",
                    "maxclass": "message",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 30.0, 158.0, 29.5, 22.0 ],
                    "text": "7"
                }
            },
            {
                "box": {
                    "id": "d2",
                    "maxclass": "newobj",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [ "bang" ],
                    "patching_rect": [ 725.0, 94.0, 67.0, 22.0 ],
                    "text": "delay 4500"
                }
            },
            {
                "box": {
                    "color": [ 0.7, 0.4, 0.3, 1.0 ],
                    "id": "term",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [ 725.0, 158.0, 81.0, 22.0 ],
                    "text": "test.terminate"
                }
            },
            {
                "box": {
                    "id": "s1",
                    "maxclass": "newobj",
                    "numinlets": 2,
                    "numoutlets": 2,
                    "outlettype": [ "bang", "" ],
                    "patching_rect": [ 30.0, 237.0, 34.0, 22.0 ],
                    "text": "sel 7"
                }
            },
            {
                "box": {
                    "id": "b1",
                    "maxclass": "message",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 30.0, 278.0, 29.5, 22.0 ],
                    "text": "1"
                }
            },
            {
                "box": {
                    "color": [ 0.7, 0.4, 0.3, 1.0 ],
                    "id": "a1",
                    "linecount": 2,
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 30.0, 386.0, 276.0, 35.0 ],
                    "text": "test.assert JamomaMax3/send_relative/own_model_reached"
                }
            },
            {
                "box": {
                    "id": "zr",
                    "maxclass": "newobj",
                    "numinlets": 2,
                    "numoutlets": 2,
                    "outlettype": [ "", "" ],
                    "patching_rect": [ 359.0, 237.0, 38.0, 22.0 ],
                    "text": "zl reg"
                }
            },
            {
                "box": {
                    "id": "d3",
                    "maxclass": "newobj",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [ "bang" ],
                    "patching_rect": [ 531.0, 94.0, 67.0, 22.0 ],
                    "text": "delay 4000"
                }
            },
            {
                "box": {
                    "id": "bg",
                    "maxclass": "message",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 531.0, 158.0, 35.0, 22.0 ],
                    "text": "bang"
                }
            },
            {
                "box": {
                    "id": "q4",
                    "maxclass": "newobj",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [ "int" ],
                    "patching_rect": [ 359.0, 278.0, 33.0, 22.0 ],
                    "text": "== 4"
                }
            },
            {
                "box": {
                    "color": [ 0.7, 0.4, 0.3, 1.0 ],
                    "id": "a2",
                    "linecount": 2,
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 359.0, 386.0, 324.0, 35.0 ],
                    "text": "test.assert JamomaMax3/send_relative/other_model_keeps_its_value"
                }
            },
            {
                "box": {
                    "id": "one",
                    "maxclass": "newobj",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
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
                        "rect": [ 60.0, 60.0, 655.6, 240.0 ],
                        "boxes": [
                            {
                                "box": {
                                    "id": "m",
                                    "maxclass": "newobj",
                                    "numinlets": 1,
                                    "numoutlets": 2,
                                    "outlettype": [ "", "" ],
                                    "patching_rect": [ 30.0, 30.0, 81.4, 22.0 ],
                                    "text": "j.model m"
                                }
                            },
                            {
                                "box": {
                                    "id": "a",
                                    "maxclass": "newobj",
                                    "numinlets": 1,
                                    "numoutlets": 2,
                                    "outlettype": [ "", "" ],
                                    "patching_rect": [ 135.4, 30.0, 272.8, 22.0 ],
                                    "text": "j.parameter a @type integer @default 3"
                                }
                            },
                            {
                                "box": {
                                    "id": "r",
                                    "maxclass": "newobj",
                                    "numinlets": 1,
                                    "numoutlets": 3,
                                    "outlettype": [ "", "", "" ],
                                    "patching_rect": [ 531.0, 94.0, 94.6, 22.0 ],
                                    "text": "j.receive a"
                                }
                            },
                            {
                                "box": {
                                    "id": "s",
                                    "maxclass": "newobj",
                                    "numinlets": 1,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "patching_rect": [ 432.2, 94.0, 74.8, 22.0 ],
                                    "text": "j.send a"
                                }
                            },
                            {
                                "box": {
                                    "comment": "",
                                    "id": "i0",
                                    "index": 1,
                                    "maxclass": "inlet",
                                    "numinlets": 0,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "patching_rect": [ 432.2, 30.0, 30.0, 30.0 ]
                                }
                            },
                            {
                                "box": {
                                    "comment": "",
                                    "id": "i1",
                                    "index": 2,
                                    "maxclass": "inlet",
                                    "numinlets": 0,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "patching_rect": [ 511.2, 30.0, 30.0, 30.0 ]
                                }
                            },
                            {
                                "box": {
                                    "comment": "",
                                    "id": "o",
                                    "index": 1,
                                    "maxclass": "outlet",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "patching_rect": [ 531.0, 158.0, 30.0, 30.0 ]
                                }
                            }
                        ],
                        "lines": [
                            {
                                "patchline": {
                                    "destination": [ "s", 0 ],
                                    "source": [ "i0", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "r", 0 ],
                                    "source": [ "i1", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "o", 0 ],
                                    "source": [ "r", 0 ]
                                }
                            }
                        ]
                    },
                    "patching_rect": [ 30.0, 191.0, 39.0, 22.0 ],
                    "text": "p one"
                }
            },
            {
                "box": {
                    "id": "two",
                    "maxclass": "newobj",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
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
                        "rect": [ 60.0, 60.0, 655.6, 240.0 ],
                        "boxes": [
                            {
                                "box": {
                                    "id": "m",
                                    "maxclass": "newobj",
                                    "numinlets": 1,
                                    "numoutlets": 2,
                                    "outlettype": [ "", "" ],
                                    "patching_rect": [ 30.0, 30.0, 81.4, 22.0 ],
                                    "text": "j.model m"
                                }
                            },
                            {
                                "box": {
                                    "id": "a",
                                    "maxclass": "newobj",
                                    "numinlets": 1,
                                    "numoutlets": 2,
                                    "outlettype": [ "", "" ],
                                    "patching_rect": [ 135.4, 30.0, 272.8, 22.0 ],
                                    "text": "j.parameter a @type integer @default 4"
                                }
                            },
                            {
                                "box": {
                                    "id": "r",
                                    "maxclass": "newobj",
                                    "numinlets": 1,
                                    "numoutlets": 3,
                                    "outlettype": [ "", "", "" ],
                                    "patching_rect": [ 531.0, 94.0, 94.6, 22.0 ],
                                    "text": "j.receive a"
                                }
                            },
                            {
                                "box": {
                                    "id": "s",
                                    "maxclass": "newobj",
                                    "numinlets": 1,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "patching_rect": [ 432.2, 94.0, 74.8, 22.0 ],
                                    "text": "j.send a"
                                }
                            },
                            {
                                "box": {
                                    "comment": "",
                                    "id": "i0",
                                    "index": 1,
                                    "maxclass": "inlet",
                                    "numinlets": 0,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "patching_rect": [ 432.2, 30.0, 30.0, 30.0 ]
                                }
                            },
                            {
                                "box": {
                                    "comment": "",
                                    "id": "i1",
                                    "index": 2,
                                    "maxclass": "inlet",
                                    "numinlets": 0,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "patching_rect": [ 511.2, 30.0, 30.0, 30.0 ]
                                }
                            },
                            {
                                "box": {
                                    "comment": "",
                                    "id": "o",
                                    "index": 1,
                                    "maxclass": "outlet",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "patching_rect": [ 531.0, 158.0, 30.0, 30.0 ]
                                }
                            }
                        ],
                        "lines": [
                            {
                                "patchline": {
                                    "destination": [ "s", 0 ],
                                    "source": [ "i0", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "r", 0 ],
                                    "source": [ "i1", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "o", 0 ],
                                    "source": [ "r", 0 ]
                                }
                            }
                        ]
                    },
                    "patching_rect": [ 378.0, 30.0, 37.0, 22.0 ],
                    "text": "p two"
                }
            },
            {
                "box": {
                    "id": "tg_a1",
                    "maxclass": "toggle",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [ "int" ],
                    "parameter_enable": 0,
                    "patching_rect": [ 30.0, 322.0, 24.0, 24.0 ]
                }
            },
            {
                "box": {
                    "id": "tg_a2",
                    "maxclass": "toggle",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [ "int" ],
                    "parameter_enable": 0,
                    "patching_rect": [ 359.0, 322.0, 24.0, 24.0 ]
                }
            }
        ],
        "lines": [
            {
                "patchline": {
                    "destination": [ "tg_a1", 0 ],
                    "source": [ "b1", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "zr", 0 ],
                    "source": [ "bg", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "seven", 0 ],
                    "source": [ "d1", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "term", 0 ],
                    "source": [ "d2", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "bg", 0 ],
                    "source": [ "d3", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "d1", 0 ],
                    "order": 2,
                    "source": [ "lb", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "d2", 0 ],
                    "order": 0,
                    "source": [ "lb", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "d3", 0 ],
                    "order": 1,
                    "source": [ "lb", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "s1", 0 ],
                    "source": [ "one", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "tg_a2", 0 ],
                    "source": [ "q4", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "b1", 0 ],
                    "source": [ "s1", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "one", 0 ],
                    "source": [ "seven", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "a1", 0 ],
                    "source": [ "tg_a1", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "a2", 0 ],
                    "source": [ "tg_a2", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "zr", 1 ],
                    "source": [ "two", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "q4", 0 ],
                    "source": [ "zr", 0 ]
                }
            }
        ],
        "autosave": 0
    }
}