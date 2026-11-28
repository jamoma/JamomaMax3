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
        "rect": [ 670.0, 344.0, 516.0, 334.0 ],
        "openinpresentation": 1,
        "boxes": [
            {
                "box": {
                    "annotation": "none",
                    "bgmode": 0,
                    "border": 0,
                    "clickthrough": 0,
                    "enablehscroll": 0,
                    "enablevscroll": 0,
                    "id": "obj-7",
                    "lockeddragscroll": 0,
                    "lockedsize": 0,
                    "maxclass": "bpatcher",
                    "name": "mapper.view.maxpat",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "offset": [ 0.0, 0.0 ],
                    "outlettype": [ "" ],
                    "patching_rect": [ 0.0, 0.0, 450.0, 105.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 0.0, 0.0, 450.0, 105.0 ],
                    "viewvisibility": 1
                }
            },
            {
                "box": {
                    "comment": "",
                    "id": "obj-5",
                    "index": 0,
                    "maxclass": "outlet",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [ 28.0, 240.0, 25.0, 25.0 ]
                }
            },
            {
                "box": {
                    "comment": "",
                    "id": "obj-3",
                    "index": 0,
                    "maxclass": "inlet",
                    "numinlets": 0,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 28.0, 162.0, 25.0, 25.0 ]
                }
            },
            {
                "box": {
                    "annotation": "edit a one to one data mapping",
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-1",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [ "", "" ],
                    "patching_rect": [ 28.0, 205.2, 103.0, 22.0 ],
                    "text": "mapper.model #1"
                }
            }
        ],
        "lines": [
            {
                "patchline": {
                    "destination": [ "obj-5", 0 ],
                    "source": [ "obj-1", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-1", 0 ],
                    "source": [ "obj-3", 0 ]
                }
            }
        ],
        "parameters": {
            "obj-7::obj-10::obj-145": [ "live.menu[1]", "live.menu", 0 ],
            "obj-7::obj-10::obj-174": [ "live.text[5]", "live.text[1]", 0 ],
            "obj-7::obj-10::obj-188": [ "live.text[6]", "live.text[1]", 0 ],
            "obj-7::obj-10::obj-196": [ "live.text[7]", "live.text", 0 ],
            "obj-7::obj-10::obj-95": [ "live.text[8]", "live.text", 0 ],
            "obj-7::obj-182": [ "live.text[4]", "live.text[4]", 0 ],
            "obj-7::obj-21": [ "live.text[9]", "live.text", 0 ],
            "obj-7::obj-8": [ "live.text[10]", "live.text", 0 ],
            "parameterbanks": {
                "0": {
                    "index": 0,
                    "name": "",
                    "parameters": [ "-", "-", "-", "-", "-", "-", "-", "-" ],
                    "buttons": [ "-", "-", "-", "-", "-", "-", "-", "-" ]
                }
            },
            "inherited_shortname": 1
        },
        "autosave": 0
    }
}