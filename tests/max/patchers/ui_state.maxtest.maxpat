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
        "rect": [ 80.0, 96.0, 1614.0, 987.0 ],
        "boxes": [
            {
                "box": {
                    "id": "vw",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 259.0, 638.0, 49.0, 22.0 ],
                    "text": "vu.view"
                }
            },
            {
                "box": {
                    "id": "tp",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [ "", "" ],
                    "patching_rect": [ 30.0, 693.0, 67.0, 22.0 ],
                    "save": [ "#N", "thispatcher", ";", "#Q", "end", ";" ],
                    "text": "thispatcher"
                }
            },
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
                    "patching_rect": [ 30.0, 94.0, 61.0, 22.0 ],
                    "text": "delay 200"
                }
            },
            {
                "box": {
                    "id": "mk",
                    "maxclass": "message",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 30.0, 145.0, 211.0, 22.0 ],
                    "text": "script newdefault m1 30 800 vu.model"
                }
            },
            {
                "box": {
                    "id": "d2",
                    "maxclass": "newobj",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [ "bang" ],
                    "patching_rect": [ 259.0, 145.0, 61.0, 22.0 ],
                    "text": "delay 400"
                }
            },
            {
                "box": {
                    "id": "dump1",
                    "maxclass": "message",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 259.0, 199.0, 39.0, 22.0 ],
                    "text": "dump"
                }
            },
            {
                "box": {
                    "id": "d3",
                    "maxclass": "newobj",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [ "bang" ],
                    "patching_rect": [ 324.0, 199.0, 61.0, 22.0 ],
                    "text": "delay 200"
                }
            },
            {
                "box": {
                    "id": "n1",
                    "maxclass": "message",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 324.0, 246.0, 77.0, 22.0 ],
                    "text": "preset:new x"
                }
            },
            {
                "box": {
                    "id": "d3b",
                    "maxclass": "newobj",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [ "bang" ],
                    "patching_rect": [ 415.0, 246.0, 61.0, 22.0 ],
                    "text": "delay 100"
                }
            },
            {
                "box": {
                    "id": "n2",
                    "maxclass": "message",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 415.0, 297.0, 77.0, 22.0 ],
                    "text": "preset:new y"
                }
            },
            {
                "box": {
                    "id": "d4",
                    "maxclass": "newobj",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [ "bang" ],
                    "patching_rect": [ 526.0, 297.0, 61.0, 22.0 ],
                    "text": "delay 200"
                }
            },
            {
                "box": {
                    "id": "dump2",
                    "maxclass": "message",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 526.0, 343.0, 39.0, 22.0 ],
                    "text": "dump"
                }
            },
            {
                "box": {
                    "id": "d5",
                    "maxclass": "newobj",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [ "bang" ],
                    "patching_rect": [ 573.0, 343.0, 61.0, 22.0 ],
                    "text": "delay 200"
                }
            },
            {
                "box": {
                    "id": "rm",
                    "maxclass": "message",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 573.0, 396.0, 93.0, 22.0 ],
                    "text": "script delete m1"
                }
            },
            {
                "box": {
                    "id": "d6",
                    "maxclass": "newobj",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [ "bang" ],
                    "patching_rect": [ 681.0, 396.0, 61.0, 22.0 ],
                    "text": "delay 300"
                }
            },
            {
                "box": {
                    "id": "dump3",
                    "maxclass": "message",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 681.0, 447.0, 39.0, 22.0 ],
                    "text": "dump"
                }
            },
            {
                "box": {
                    "id": "d7",
                    "maxclass": "newobj",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [ "bang" ],
                    "patching_rect": [ 732.0, 447.0, 61.0, 22.0 ],
                    "text": "delay 200"
                }
            },
            {
                "box": {
                    "id": "mk2",
                    "maxclass": "message",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 732.0, 501.0, 211.0, 22.0 ],
                    "text": "script newdefault m2 30 850 vu.model"
                }
            },
            {
                "box": {
                    "id": "d8",
                    "maxclass": "newobj",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [ "bang" ],
                    "patching_rect": [ 960.0, 501.0, 61.0, 22.0 ],
                    "text": "delay 400"
                }
            },
            {
                "box": {
                    "id": "dump4",
                    "maxclass": "message",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 960.0, 544.0, 39.0, 22.0 ],
                    "text": "dump"
                }
            },
            {
                "box": {
                    "id": "d9",
                    "maxclass": "newobj",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [ "bang" ],
                    "patching_rect": [ 1033.0, 544.0, 61.0, 22.0 ],
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
                    "patching_rect": [ 1033.0, 587.0, 81.0, 22.0 ],
                    "text": "test.terminate"
                }
            },
            {
                "box": {
                    "id": "rt",
                    "maxclass": "newobj",
                    "numinlets": 4,
                    "numoutlets": 4,
                    "outlettype": [ "", "", "", "" ],
                    "patching_rect": [ 259.0, 673.0, 264.0, 22.0 ],
                    "text": "route model:address model:waiting preset:count"
                }
            },
            {
                "box": {
                    "id": "sa",
                    "maxclass": "newobj",
                    "numinlets": 2,
                    "numoutlets": 2,
                    "outlettype": [ "bang", "" ],
                    "patching_rect": [ 259.0, 737.0, 43.0, 22.0 ],
                    "text": "sel /vu"
                }
            },
            {
                "box": {
                    "id": "one",
                    "maxclass": "message",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 259.0, 776.0, 29.5, 22.0 ],
                    "text": "1"
                }
            },
            {
                "box": {
                    "color": [ 0.7, 0.4, 0.3, 1.0 ],
                    "id": "as1",
                    "linecount": 2,
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 259.0, 859.0, 236.0, 35.0 ],
                    "text": "test.assert JamomaMax3/ui_state/reports_its_model"
                }
            },
            {
                "box": {
                    "id": "bg",
                    "maxclass": "message",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 508.5, 776.0, 29.5, 22.0 ],
                    "text": "1"
                }
            },
            {
                "box": {
                    "color": [ 0.7, 0.4, 0.3, 1.0 ],
                    "id": "as2",
                    "linecount": 2,
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 509.0, 859.0, 222.0, 35.0 ],
                    "text": "test.assert JamomaMax3/ui_state/reports_waiting"
                }
            },
            {
                "box": {
                    "id": "zl",
                    "maxclass": "newobj",
                    "numinlets": 2,
                    "numoutlets": 2,
                    "outlettype": [ "bang", "" ],
                    "patching_rect": [ 747.0, 737.0, 34.0, 22.0 ],
                    "text": "sel 2"
                }
            },
            {
                "box": {
                    "id": "e2",
                    "maxclass": "message",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 747.0, 776.0, 29.5, 22.0 ],
                    "text": "1"
                }
            },
            {
                "box": {
                    "color": [ 0.7, 0.4, 0.3, 1.0 ],
                    "id": "as3",
                    "linecount": 2,
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 747.0, 859.0, 267.0, 35.0 ],
                    "text": "test.assert JamomaMax3/ui_state/lists_the_preset_names"
                }
            },
            {
                "box": {
                    "id": "vm",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [ 415.0, 343.0, 86.0, 22.0 ],
                    "text": "s vu_model_in"
                }
            },
            {
                "box": {
                    "id": "tg_as1",
                    "maxclass": "toggle",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [ "int" ],
                    "parameter_enable": 0,
                    "patching_rect": [ 259.0, 818.0, 24.0, 24.0 ]
                }
            },
            {
                "box": {
                    "id": "tg_as2",
                    "maxclass": "toggle",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [ "int" ],
                    "parameter_enable": 0,
                    "patching_rect": [ 508.5, 818.0, 24.0, 24.0 ]
                }
            },
            {
                "box": {
                    "id": "tg_as3",
                    "maxclass": "toggle",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [ "int" ],
                    "parameter_enable": 0,
                    "patching_rect": [ 747.0, 818.0, 24.0, 24.0 ]
                }
            }
        ],
        "lines": [
            {
                "patchline": {
                    "destination": [ "tg_as2", 0 ],
                    "source": [ "bg", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "d2", 0 ],
                    "order": 0,
                    "source": [ "d1", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "mk", 0 ],
                    "order": 1,
                    "source": [ "d1", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "d3", 0 ],
                    "order": 0,
                    "source": [ "d2", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "dump1", 0 ],
                    "order": 1,
                    "source": [ "d2", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "d3b", 0 ],
                    "order": 0,
                    "source": [ "d3", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "n1", 0 ],
                    "order": 1,
                    "source": [ "d3", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "d4", 0 ],
                    "order": 0,
                    "source": [ "d3b", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "n2", 0 ],
                    "order": 1,
                    "source": [ "d3b", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "d5", 0 ],
                    "order": 0,
                    "source": [ "d4", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "dump2", 0 ],
                    "order": 1,
                    "source": [ "d4", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "d6", 0 ],
                    "order": 0,
                    "source": [ "d5", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "rm", 0 ],
                    "order": 1,
                    "source": [ "d5", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "d7", 0 ],
                    "order": 0,
                    "source": [ "d6", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "dump3", 0 ],
                    "order": 1,
                    "source": [ "d6", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "d8", 0 ],
                    "order": 0,
                    "source": [ "d7", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "mk2", 0 ],
                    "order": 1,
                    "source": [ "d7", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "d9", 0 ],
                    "order": 0,
                    "source": [ "d8", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "dump4", 0 ],
                    "order": 1,
                    "source": [ "d8", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "term", 0 ],
                    "source": [ "d9", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "vw", 0 ],
                    "source": [ "dump1", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "vw", 0 ],
                    "source": [ "dump2", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "vw", 0 ],
                    "source": [ "dump3", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "vw", 0 ],
                    "source": [ "dump4", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "tg_as3", 0 ],
                    "source": [ "e2", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "d1", 0 ],
                    "source": [ "lb", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "tp", 0 ],
                    "source": [ "mk", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "tp", 0 ],
                    "source": [ "mk2", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "vm", 0 ],
                    "source": [ "n1", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "vm", 0 ],
                    "source": [ "n2", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "tg_as1", 0 ],
                    "source": [ "one", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "tp", 0 ],
                    "source": [ "rm", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "bg", 0 ],
                    "source": [ "rt", 1 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "sa", 0 ],
                    "source": [ "rt", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "zl", 0 ],
                    "source": [ "rt", 2 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "one", 0 ],
                    "source": [ "sa", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "as1", 0 ],
                    "source": [ "tg_as1", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "as2", 0 ],
                    "source": [ "tg_as2", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "as3", 0 ],
                    "source": [ "tg_as3", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "rt", 0 ],
                    "source": [ "vw", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "e2", 0 ],
                    "source": [ "zl", 0 ]
                }
            }
        ],
        "autosave": 0
    }
}