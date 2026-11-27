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
        "rect": [ 34.0, 96.0, 1660.0, 798.0 ],
        "boxes": [
            {
                "box": {
                    "id": "obj-30",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [ 92.0, 310.78723404255317, 58.0, 22.0 ],
                    "text": "s to_map"
                }
            },
            {
                "box": {
                    "id": "obj-31",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 3,
                    "outlettype": [ "bang", "float", "bang" ],
                    "patching_rect": [ 75.0, 229.78723404255317, 52.0, 22.0 ],
                    "text": "t b 0.5 b"
                }
            },
            {
                "box": {
                    "id": "obj-32",
                    "maxclass": "message",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 108.0, 266.78723404255317, 158.0, 22.0 ],
                    "text": "function exponential, base 2"
                }
            },
            {
                "box": {
                    "id": "obj-27",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [ 530.0, 310.7872340425531, 58.0, 22.0 ],
                    "text": "s to_map"
                }
            },
            {
                "box": {
                    "id": "obj-28",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 3,
                    "outlettype": [ "bang", "float", "bang" ],
                    "patching_rect": [ 513.0, 229.7872340425531, 52.0, 22.0 ],
                    "text": "t b 0.25 b"
                }
            },
            {
                "box": {
                    "id": "obj-29",
                    "maxclass": "message",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 546.0, 266.7872340425531, 106.0, 22.0 ],
                    "text": "function nonesuch"
                }
            },
            {
                "box": {
                    "id": "obj-26",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [ 1004.0, 310.872340425532, 58.0, 22.0 ],
                    "text": "s to_map"
                }
            },
            {
                "box": {
                    "id": "obj-25",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 3,
                    "outlettype": [ "bang", "float", "bang" ],
                    "patching_rect": [ 987.0, 229.872340425532, 52.0, 22.0 ],
                    "text": "t b 0.5 b"
                }
            },
            {
                "box": {
                    "id": "obj-24",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [ 1301.0, 311.872340425532, 58.0, 22.0 ],
                    "text": "s to_map"
                }
            },
            {
                "box": {
                    "id": "obj-23",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 3,
                    "outlettype": [ "bang", "float", "bang" ],
                    "patching_rect": [ 1284.0, 230.872340425532, 52.0, 22.0 ],
                    "text": "t b 0.5 b"
                }
            },
            {
                "box": {
                    "id": "obj-17",
                    "maxclass": "newobj",
                    "numinlets": 0,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 1498.0, 324.0, 56.0, 22.0 ],
                    "text": "r to_map"
                }
            },
            {
                "box": {
                    "id": "obj-3",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 5,
                    "outlettype": [ "bang", "bang", "bang", "bang", "bang" ],
                    "patching_rect": [ 9.0, 67.02127659574468, 283.0, 22.0 ],
                    "text": "t b b b b b"
                }
            },
            {
                "box": {
                    "id": "m",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [ "", "" ],
                    "patching_rect": [ 1498.0, 361.0, 38.0, 22.0 ],
                    "text": "j.map"
                }
            },
            {
                "box": {
                    "id": "lb",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [ "bang" ],
                    "patching_rect": [ 9.0, 34.04255319148936, 58.0, 22.0 ],
                    "text": "loadbang"
                }
            },
            {
                "box": {
                    "id": "h",
                    "maxclass": "newobj",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [ "float" ],
                    "patching_rect": [ 1284.0, 474.872340425532, 45.0, 22.0 ],
                    "text": "float 0."
                }
            },
            {
                "box": {
                    "id": "q",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 1284.0, 520.872340425532, 170.0, 22.0 ],
                    "text": "expr abs($f1 - 0.25) < 0.00001"
                }
            },
            {
                "box": {
                    "color": [ 0.7, 0.4, 0.3, 1.0 ],
                    "id": "b_quad",
                    "linecount": 2,
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 1284.0, 597.872340425532, 291.0, 35.0 ],
                    "text": "test.assert Jamoma/Modular/j.map/functions/ease_in_quadratic"
                }
            },
            {
                "box": {
                    "id": "h2",
                    "maxclass": "newobj",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [ "float" ],
                    "patching_rect": [ 987.0, 474.872340425532, 45.0, 22.0 ],
                    "text": "float 0."
                }
            },
            {
                "box": {
                    "id": "bo",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 987.0, 520.872340425532, 190.0, 22.0 ],
                    "text": "expr abs($f1 - 0.71875) < 0.00001"
                }
            },
            {
                "box": {
                    "color": [ 0.7, 0.4, 0.3, 1.0 ],
                    "id": "b_bounce",
                    "linecount": 2,
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 987.0, 597.872340425532, 285.0, 35.0 ],
                    "text": "test.assert Jamoma/Modular/j.map/functions/ease_out_bounce"
                }
            },
            {
                "box": {
                    "id": "h3",
                    "maxclass": "newobj",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [ "float" ],
                    "patching_rect": [ 513.0, 474.7872340425531, 45.0, 22.0 ],
                    "text": "float 0."
                }
            },
            {
                "box": {
                    "id": "kept",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 513.0, 521.7872340425531, 190.0, 22.0 ],
                    "text": "expr abs($f1 - 0.47265625) < 0.00001"
                }
            },
            {
                "box": {
                    "color": [ 0.7, 0.4, 0.3, 1.0 ],
                    "id": "b_kept",
                    "linecount": 2,
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 513.0, 597.7872340425531, 448.0, 35.0 ],
                    "text": "test.assert Jamoma/Modular/j.map/functions/an_unknown_function_keeps_the_previous_one"
                }
            },
            {
                "box": {
                    "id": "h4",
                    "maxclass": "newobj",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [ "float" ],
                    "patching_rect": [ 75.0, 474.78723404255317, 45.0, 22.0 ],
                    "text": "float 0."
                }
            },
            {
                "box": {
                    "id": "ex",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 75.0, 521.7872340425531, 210.0, 22.0 ],
                    "text": "expr abs($f1 - 0.41421356) < 0.00001"
                }
            },
            {
                "box": {
                    "color": [ 0.7, 0.4, 0.3, 1.0 ],
                    "id": "b_exp",
                    "linecount": 2,
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 75.0, 597.7872340425531, 421.0, 35.0 ],
                    "text": "test.assert Jamoma/Modular/j.map/functions/a_function_parameter_is_set_by_message"
                }
            },
            {
                "box": {
                    "id": "s1",
                    "maxclass": "message",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 1317.0, 267.872340425532, 142.0, 22.0 ],
                    "text": "function easeInQuadratic"
                }
            },
            {
                "box": {
                    "id": "s4",
                    "maxclass": "message",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 1020.0, 266.872340425532, 140.0, 22.0 ],
                    "text": "function easeOutBounce"
                }
            },
            {
                "box": {
                    "color": [ 0.7, 0.4, 0.3, 1.0 ],
                    "id": "sterm",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [ 9.0, 729.0, 81.0, 22.0 ],
                    "text": "test.terminate"
                }
            },
            {
                "box": {
                    "id": "tg_b_quad",
                    "maxclass": "toggle",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [ "int" ],
                    "parameter_enable": 0,
                    "patching_rect": [ 1284.0, 556.872340425532, 24.0, 24.0 ]
                }
            },
            {
                "box": {
                    "id": "tg_b_bounce",
                    "maxclass": "toggle",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [ "int" ],
                    "parameter_enable": 0,
                    "patching_rect": [ 987.0, 557.872340425532, 24.0, 24.0 ]
                }
            },
            {
                "box": {
                    "id": "tg_b_kept",
                    "maxclass": "toggle",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [ "int" ],
                    "parameter_enable": 0,
                    "patching_rect": [ 513.0, 557.7872340425531, 24.0, 24.0 ]
                }
            },
            {
                "box": {
                    "id": "tg_b_exp",
                    "maxclass": "toggle",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [ "int" ],
                    "parameter_enable": 0,
                    "patching_rect": [ 75.0, 557.7872340425531, 24.0, 24.0 ]
                }
            }
        ],
        "lines": [
            {
                "patchline": {
                    "destination": [ "tg_b_bounce", 0 ],
                    "source": [ "bo", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "tg_b_exp", 0 ],
                    "source": [ "ex", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "q", 0 ],
                    "source": [ "h", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "bo", 0 ],
                    "source": [ "h2", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "kept", 0 ],
                    "source": [ "h3", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "ex", 0 ],
                    "source": [ "h4", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "tg_b_kept", 0 ],
                    "source": [ "kept", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-3", 0 ],
                    "source": [ "lb", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "h", 1 ],
                    "order": 0,
                    "source": [ "m", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "h2", 1 ],
                    "order": 1,
                    "source": [ "m", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "h3", 1 ],
                    "order": 2,
                    "source": [ "m", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "h4", 1 ],
                    "order": 3,
                    "source": [ "m", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "m", 0 ],
                    "source": [ "obj-17", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "h", 0 ],
                    "source": [ "obj-23", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-24", 0 ],
                    "source": [ "obj-23", 1 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "s1", 0 ],
                    "source": [ "obj-23", 2 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "h2", 0 ],
                    "source": [ "obj-25", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-26", 0 ],
                    "source": [ "obj-25", 1 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "s4", 0 ],
                    "source": [ "obj-25", 2 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "h3", 0 ],
                    "source": [ "obj-28", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-27", 0 ],
                    "source": [ "obj-28", 1 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-29", 0 ],
                    "source": [ "obj-28", 2 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-27", 0 ],
                    "source": [ "obj-29", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-23", 0 ],
                    "source": [ "obj-3", 4 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-25", 0 ],
                    "source": [ "obj-3", 3 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-28", 0 ],
                    "source": [ "obj-3", 2 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-31", 0 ],
                    "source": [ "obj-3", 1 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "sterm", 0 ],
                    "source": [ "obj-3", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "h4", 0 ],
                    "source": [ "obj-31", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-30", 0 ],
                    "source": [ "obj-31", 1 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-32", 0 ],
                    "source": [ "obj-31", 2 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-30", 0 ],
                    "source": [ "obj-32", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "tg_b_quad", 0 ],
                    "source": [ "q", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-24", 0 ],
                    "source": [ "s1", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-26", 0 ],
                    "source": [ "s4", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "b_bounce", 0 ],
                    "source": [ "tg_b_bounce", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "b_exp", 0 ],
                    "source": [ "tg_b_exp", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "b_kept", 0 ],
                    "source": [ "tg_b_kept", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "b_quad", 0 ],
                    "source": [ "tg_b_quad", 0 ]
                }
            }
        ],
        "autosave": 0
    }
}