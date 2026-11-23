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
        "rect": [ 134.0, 168.0, 537.0, 338.0 ],
        "boxes": [
            {
                "box": {
                    "id": "md",
                    "maxclass": "newobj",
                    "numinlets": 0,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 30.0, 30.0, 57.0, 22.0 ],
                    "text": "vb.model"
                }
            },
            {
                "box": {
                    "id": "vw",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [ "", "" ],
                    "patching_rect": [ 128.8, 222.0, 49.0, 22.0 ],
                    "text": "vb.view"
                }
            },
            {
                "box": {
                    "id": "lb",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [ "bang" ],
                    "patching_rect": [ 128.8, 30.0, 58.0, 22.0 ],
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
                    "patching_rect": [ 128.8, 94.0, 61.0, 22.0 ],
                    "text": "delay 400"
                }
            },
            {
                "box": {
                    "id": "go",
                    "maxclass": "message",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 128.8, 158.0, 29.5, 22.0 ],
                    "text": "a 5"
                }
            },
            {
                "box": {
                    "id": "s",
                    "maxclass": "newobj",
                    "numinlets": 2,
                    "numoutlets": 2,
                    "outlettype": [ "bang", "" ],
                    "patching_rect": [ 30.0, 94.0, 34.0, 22.0 ],
                    "text": "sel 5"
                }
            },
            {
                "box": {
                    "id": "one",
                    "maxclass": "message",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 30.0, 158.0, 29.5, 22.0 ],
                    "text": "1"
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
                    "patching_rect": [ 30.0, 286.0, 430.0, 22.0 ],
                    "text": "test.assert JamomaMax3/view_basic/message_reaches_the_model_parameter"
                }
            },
            {
                "box": {
                    "id": "d2",
                    "maxclass": "newobj",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [ "bang" ],
                    "patching_rect": [ 221.0, 158.0, 61.0, 22.0 ],
                    "text": "delay 300"
                }
            },
            {
                "box": {
                    "color": [ 0.7, 0.4, 0.3, 1.0 ],
                    "id": "term",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [ 221.0, 222.0, 81.0, 22.0 ],
                    "text": "test.terminate"
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
                    "patching_rect": [ 30.0, 222.0, 24.0, 24.0 ]
                }
            }
        ],
        "lines": [
            {
                "patchline": {
                    "destination": [ "d2", 0 ],
                    "order": 0,
                    "source": [ "d", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "go", 0 ],
                    "order": 1,
                    "source": [ "d", 0 ]
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
                    "destination": [ "vw", 0 ],
                    "source": [ "go", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "d", 0 ],
                    "source": [ "lb", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "s", 0 ],
                    "source": [ "md", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "tg_as", 0 ],
                    "source": [ "one", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "one", 0 ],
                    "source": [ "s", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "as", 0 ],
                    "source": [ "tg_as", 0 ]
                }
            }
        ],
        "autosave": 0
    }
}