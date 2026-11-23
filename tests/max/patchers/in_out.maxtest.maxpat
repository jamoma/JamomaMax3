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
        "rect": [ 34.0, 96.0, 1258.0, 659.0 ],
        "boxes": [
            {
                "box": {
                    "id": "m",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [ "", "" ],
                    "patching_rect": [ 45.0, 39.0, 88.0, 22.0 ],
                    "text": "j.model io"
                }
            },
            {
                "box": {
                    "id": "ji",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [ "", "" ],
                    "patching_rect": [ 45.0, 168.0, 61.6, 22.0 ],
                    "text": "j.init"
                }
            },
            {
                "box": {
                    "id": "o",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [ "", "" ],
                    "patching_rect": [ 256.0, 360.0, 68.2, 22.0 ],
                    "text": "j.out 1"
                }
            },
            {
                "box": {
                    "id": "i",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [ "", "" ],
                    "patching_rect": [ 150.0, 360.0, 61.6, 22.0 ],
                    "text": "j.in 1"
                }
            },
            {
                "box": {
                    "id": "r",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 3,
                    "outlettype": [ "", "", "" ],
                    "patching_rect": [ 949.0, 168.0, 110.0, 22.0 ],
                    "text": "j.receive data/out.1"
                }
            },
            {
                "box": {
                    "id": "five",
                    "maxclass": "message",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 45.0, 296.0, 40.0, 22.0 ],
                    "text": "5"
                }
            },
            {
                "box": {
                    "id": "seven",
                    "maxclass": "message",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 150.0, 296.0, 40.0, 22.0 ],
                    "text": "7"
                }
            },
            {
                "box": {
                    "id": "mute",
                    "maxclass": "message",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 256.0, 296.0, 61.6, 22.0 ],
                    "text": "mute 1"
                }
            },
            {
                "box": {
                    "id": "six",
                    "maxclass": "message",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 368.0, 296.0, 40.0, 22.0 ],
                    "text": "6"
                }
            },
            {
                "box": {
                    "id": "q5",
                    "maxclass": "newobj",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [ "int" ],
                    "patching_rect": [ 256.0, 424.0, 48.4, 22.0 ],
                    "text": "== 5"
                }
            },
            {
                "box": {
                    "color": [ 0.7, 0.4, 0.3, 1.0 ],
                    "id": "a5",
                    "linecount": 2,
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 384.0, 605.0, 230.0, 35.0 ],
                    "text": "test.assert JamomaMax3/in_out/out_passes_values"
                }
            },
            {
                "box": {
                    "id": "zr",
                    "maxclass": "newobj",
                    "numinlets": 2,
                    "numoutlets": 2,
                    "outlettype": [ "", "" ],
                    "patching_rect": [ 657.0, 435.0, 61.6, 22.0 ],
                    "text": "zl reg"
                }
            },
            {
                "box": {
                    "id": "bg",
                    "maxclass": "message",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 480.0, 296.0, 48.4, 22.0 ],
                    "text": "bang"
                }
            },
            {
                "box": {
                    "id": "e5",
                    "maxclass": "newobj",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [ "int" ],
                    "patching_rect": [ 657.0, 499.0, 48.4, 22.0 ],
                    "text": "== 5"
                }
            },
            {
                "box": {
                    "color": [ 0.7, 0.4, 0.3, 1.0 ],
                    "id": "ah",
                    "linecount": 2,
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 657.0, 605.0, 241.0, 35.0 ],
                    "text": "test.assert JamomaMax3/in_out/muted_out_is_silent"
                }
            },
            {
                "box": {
                    "id": "rq",
                    "maxclass": "newobj",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [ "int" ],
                    "patching_rect": [ 949.0, 232.0, 48.4, 22.0 ],
                    "text": "== 5"
                }
            },
            {
                "box": {
                    "color": [ 0.7, 0.4, 0.3, 1.0 ],
                    "id": "ar",
                    "linecount": 2,
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 949.0, 605.0, 272.0, 35.0 ],
                    "text": "test.assert JamomaMax3/in_out/node_is_visible_to_receive"
                }
            },
            {
                "box": {
                    "id": "q7",
                    "maxclass": "newobj",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [ "int" ],
                    "patching_rect": [ 150.0, 424.0, 48.4, 22.0 ],
                    "text": "== 7"
                }
            },
            {
                "box": {
                    "color": [ 0.7, 0.4, 0.3, 1.0 ],
                    "id": "a7",
                    "linecount": 2,
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 150.0, 605.0, 223.0, 35.0 ],
                    "text": "test.assert JamomaMax3/in_out/in_passes_values"
                }
            },
            {
                "box": {
                    "id": "d1",
                    "maxclass": "newobj",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [ "bang" ],
                    "patching_rect": [ 45.0, 232.0, 81.4, 22.0 ],
                    "text": "delay 100"
                }
            },
            {
                "box": {
                    "id": "d2",
                    "maxclass": "newobj",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [ "bang" ],
                    "patching_rect": [ 150.0, 232.0, 81.4, 22.0 ],
                    "text": "delay 600"
                }
            },
            {
                "box": {
                    "id": "d3",
                    "maxclass": "newobj",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [ "bang" ],
                    "patching_rect": [ 256.0, 232.0, 88.0, 22.0 ],
                    "text": "delay 1200"
                }
            },
            {
                "box": {
                    "id": "d4",
                    "maxclass": "newobj",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [ "bang" ],
                    "patching_rect": [ 368.0, 232.0, 88.0, 22.0 ],
                    "text": "delay 2000"
                }
            },
            {
                "box": {
                    "id": "lb",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [ "bang" ],
                    "patching_rect": [ 189.0, 39.0, 74.8, 22.0 ],
                    "text": "loadbang"
                }
            },
            {
                "box": {
                    "id": "d5",
                    "maxclass": "newobj",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [ "bang" ],
                    "patching_rect": [ 480.0, 232.0, 88.0, 22.0 ],
                    "text": "delay 3000"
                }
            },
            {
                "box": {
                    "id": "d6",
                    "maxclass": "newobj",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [ "bang" ],
                    "patching_rect": [ 189.0, 72.0, 88.0, 22.0 ],
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
                    "patching_rect": [ 189.0, 110.0, 114.4, 22.0 ],
                    "text": "test.terminate"
                }
            },
            {
                "box": {
                    "id": "tg_a5",
                    "maxclass": "toggle",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [ "int" ],
                    "parameter_enable": 0,
                    "patching_rect": [ 384.0, 541.0, 24.0, 24.0 ]
                }
            },
            {
                "box": {
                    "id": "tg_ah",
                    "maxclass": "toggle",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [ "int" ],
                    "parameter_enable": 0,
                    "patching_rect": [ 657.0, 541.0, 24.0, 24.0 ]
                }
            },
            {
                "box": {
                    "id": "tg_ar",
                    "maxclass": "toggle",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [ "int" ],
                    "parameter_enable": 0,
                    "patching_rect": [ 949.0, 541.0, 24.0, 24.0 ]
                }
            },
            {
                "box": {
                    "id": "tg_a7",
                    "maxclass": "toggle",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [ "int" ],
                    "parameter_enable": 0,
                    "patching_rect": [ 150.0, 541.0, 24.0, 24.0 ]
                }
            }
        ],
        "lines": [
            {
                "patchline": {
                    "destination": [ "zr", 0 ],
                    "source": [ "bg", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "five", 0 ],
                    "source": [ "d1", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "seven", 0 ],
                    "source": [ "d2", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "mute", 0 ],
                    "source": [ "d3", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "six", 0 ],
                    "source": [ "d4", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "bg", 0 ],
                    "source": [ "d5", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "term", 0 ],
                    "source": [ "d6", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "tg_ah", 0 ],
                    "source": [ "e5", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "o", 0 ],
                    "source": [ "five", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "q7", 0 ],
                    "source": [ "i", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "d1", 0 ],
                    "order": 4,
                    "source": [ "ji", 1 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "d2", 0 ],
                    "order": 3,
                    "source": [ "ji", 1 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "d3", 0 ],
                    "order": 2,
                    "source": [ "ji", 1 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "d4", 0 ],
                    "order": 1,
                    "source": [ "ji", 1 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "d5", 0 ],
                    "order": 0,
                    "source": [ "ji", 1 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "d6", 0 ],
                    "source": [ "lb", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "o", 0 ],
                    "source": [ "mute", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "q5", 0 ],
                    "order": 1,
                    "source": [ "o", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "zr", 1 ],
                    "order": 0,
                    "source": [ "o", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "tg_a5", 0 ],
                    "source": [ "q5", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "tg_a7", 0 ],
                    "source": [ "q7", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "rq", 0 ],
                    "source": [ "r", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "tg_ar", 0 ],
                    "source": [ "rq", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "i", 0 ],
                    "source": [ "seven", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "o", 0 ],
                    "source": [ "six", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "a5", 0 ],
                    "source": [ "tg_a5", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "a7", 0 ],
                    "source": [ "tg_a7", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "ah", 0 ],
                    "source": [ "tg_ah", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "ar", 0 ],
                    "source": [ "tg_ar", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "e5", 0 ],
                    "source": [ "zr", 0 ]
                }
            }
        ],
        "autosave": 0
    }
}