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
        "rect": [ 134.0, 168.0, 1032.0, 530.0 ],
        "boxes": [
            {
                "box": {
                    "id": "qm",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 30.0, 30.0, 127.6, 22.0 ],
                    "text": "qmetro.module q1"
                }
            },
            {
                "box": {
                    "id": "rt",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 3,
                    "outlettype": [ "", "", "" ],
                    "patching_rect": [ 181.6, 222.0, 167.2, 22.0 ],
                    "text": "j.receive /qmetro/time"
                }
            },
            {
                "box": {
                    "id": "ra",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 3,
                    "outlettype": [ "", "", "" ],
                    "patching_rect": [ 584.0, 222.0, 213.4, 22.0 ],
                    "text": "j.receive /qmetro/data/active"
                }
            },
            {
                "box": {
                    "id": "lb",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [ "bang" ],
                    "patching_rect": [ 181.6, 30.0, 74.8, 22.0 ],
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
                    "patching_rect": [ 181.6, 94.0, 88.0, 22.0 ],
                    "text": "delay 1500"
                }
            },
            {
                "box": {
                    "id": "bg",
                    "maxclass": "message",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 181.6, 158.0, 48.4, 22.0 ],
                    "text": "bang"
                }
            },
            {
                "box": {
                    "id": "d2",
                    "maxclass": "newobj",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [ "bang" ],
                    "patching_rect": [ 821.0, 158.0, 81.4, 22.0 ],
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
                    "patching_rect": [ 821.0, 222.0, 81.0, 22.0 ],
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
                    "patching_rect": [ 181.6, 286.0, 68.2, 22.0 ],
                    "text": "sel 100"
                }
            },
            {
                "box": {
                    "id": "o1",
                    "maxclass": "message",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 181.6, 350.0, 40.0, 22.0 ],
                    "text": "1"
                }
            },
            {
                "box": {
                    "color": [ 0.7, 0.4, 0.3, 1.0 ],
                    "id": "as1",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 181.6, 478.0, 321.0, 22.0 ],
                    "text": "test.assert JamomaMax3/qmetro/default_preset_sets_time"
                }
            },
            {
                "box": {
                    "id": "s2",
                    "maxclass": "newobj",
                    "numinlets": 2,
                    "numoutlets": 2,
                    "outlettype": [ "bang", "" ],
                    "patching_rect": [ 584.0, 286.0, 55.0, 22.0 ],
                    "text": "sel 0"
                }
            },
            {
                "box": {
                    "id": "o2",
                    "maxclass": "message",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 584.0, 350.0, 40.0, 22.0 ],
                    "text": "1"
                }
            },
            {
                "box": {
                    "color": [ 0.7, 0.4, 0.3, 1.0 ],
                    "id": "as2",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 584.0, 478.0, 359.0, 22.0 ],
                    "text": "test.assert JamomaMax3/qmetro/default_preset_stops_the_metro"
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
                    "patching_rect": [ 181.6, 414.0, 24.0, 24.0 ]
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
                    "patching_rect": [ 584.0, 414.0, 24.0, 24.0 ]
                }
            }
        ],
        "lines": [
            {
                "patchline": {
                    "destination": [ "ra", 0 ],
                    "order": 0,
                    "source": [ "bg", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "rt", 0 ],
                    "order": 1,
                    "source": [ "bg", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "bg", 0 ],
                    "order": 1,
                    "source": [ "d", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "d2", 0 ],
                    "order": 0,
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
                    "destination": [ "d", 0 ],
                    "source": [ "lb", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "tg_as1", 0 ],
                    "source": [ "o1", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "tg_as2", 0 ],
                    "source": [ "o2", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "s2", 0 ],
                    "source": [ "ra", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "s1", 0 ],
                    "source": [ "rt", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "o1", 0 ],
                    "source": [ "s1", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "o2", 0 ],
                    "source": [ "s2", 0 ]
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
            }
        ],
        "autosave": 0
    }
}