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
        "rect": [ 134.0, 168.0, 630.0, 466.0 ],
        "boxes": [
            {
                "box": {
                    "id": "g",
                    "maxclass": "newobj",
                    "numinlets": 2,
                    "numoutlets": 2,
                    "outlettype": [ "", "" ],
                    "patching_rect": [ 168.3, 94.0, 88.0, 22.0 ],
                    "text": "zl group 2"
                }
            },
            {
                "box": {
                    "id": "u",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [ "int", "int" ],
                    "patching_rect": [ 168.4, 158.0, 88.0, 22.0 ],
                    "text": "unpack 0 0"
                }
            },
            {
                "box": {
                    "id": "e",
                    "maxclass": "newobj",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 168.4, 222.0, 121.0, 22.0 ],
                    "text": "expr $i1*10+$i2"
                }
            },
            {
                "box": {
                    "id": "q",
                    "maxclass": "newobj",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [ "int" ],
                    "patching_rect": [ 168.4, 286.0, 55.0, 22.0 ],
                    "text": "== 34"
                }
            },
            {
                "box": {
                    "color": [ 0.7, 0.4, 0.3, 1.0 ],
                    "id": "as",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 168.4, 414.0, 431.2, 22.0 ],
                    "text": "test.assert JamomaMax3/receive_relative/each_follows_its_model"
                }
            },
            {
                "box": {
                    "id": "dl",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [ "bang" ],
                    "patching_rect": [ 30.0, 30.0, 74.8, 22.0 ],
                    "text": "loadbang"
                }
            },
            {
                "box": {
                    "id": "d",
                    "maxclass": "newobj",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [ "bang" ],
                    "patching_rect": [ 30.0, 94.0, 88.0, 22.0 ],
                    "text": "delay 4000"
                }
            },
            {
                "box": {
                    "color": [ 0.7, 0.4, 0.3, 1.0 ],
                    "id": "term",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [ 30.0, 158.0, 114.4, 22.0 ],
                    "text": "test.terminate"
                }
            },
            {
                "box": {
                    "id": "one",
                    "maxclass": "newobj",
                    "numinlets": 0,
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
                        "rect": [ 134.0, 168.0, 557.0, 240.0 ],
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
                                    "patching_rect": [ 432.2, 30.0, 94.6, 22.0 ],
                                    "text": "j.receive a"
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
                                    "patching_rect": [ 432.2, 94.0, 30.0, 30.0 ]
                                }
                            }
                        ],
                        "lines": [
                            {
                                "patchline": {
                                    "destination": [ "o", 0 ],
                                    "source": [ "r", 0 ]
                                }
                            }
                        ]
                    },
                    "patching_rect": [ 168.3, 30.0, 55.0, 22.0 ],
                    "text": "p one"
                }
            },
            {
                "box": {
                    "id": "two",
                    "maxclass": "newobj",
                    "numinlets": 0,
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
                        "rect": [ 60.0, 60.0, 556.8, 240.0 ],
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
                                    "patching_rect": [ 432.2, 30.0, 94.6, 22.0 ],
                                    "text": "j.receive a"
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
                                    "patching_rect": [ 432.2, 94.0, 30.0, 30.0 ]
                                }
                            }
                        ],
                        "lines": [
                            {
                                "patchline": {
                                    "destination": [ "o", 0 ],
                                    "source": [ "r", 0 ]
                                }
                            }
                        ]
                    },
                    "patching_rect": [ 247.3, 30.0, 55.0, 22.0 ],
                    "text": "p two"
                }
            },
            {
                "box": {
                    "id": "tg_as",
                    "maxclass": "toggle",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [ "int" ],
                    "parameter_enable": 0,
                    "patching_rect": [ 168.4, 350.0, 24.0, 24.0 ]
                }
            }
        ],
        "lines": [
            {
                "patchline": {
                    "destination": [ "term", 0 ],
                    "source": [ "d", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "d", 0 ],
                    "source": [ "dl", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "q", 0 ],
                    "source": [ "e", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "u", 0 ],
                    "source": [ "g", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "g", 0 ],
                    "source": [ "one", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "tg_as", 0 ],
                    "source": [ "q", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "as", 0 ],
                    "source": [ "tg_as", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "g", 0 ],
                    "source": [ "two", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "e", 1 ],
                    "source": [ "u", 1 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "e", 0 ],
                    "source": [ "u", 0 ]
                }
            }
        ],
        "autosave": 0
    }
}