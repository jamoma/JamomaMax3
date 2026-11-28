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
        "rect": [ 158.0, 199.0, 816.0, 504.0 ],
        "boxes": [
            {
                "box": {
                    "args": [ "@name", "osc_receive.model", "@description", "Receive OSC messages" ],
                    "bgmode": 1,
                    "border": 1,
                    "clickthrough": 0,
                    "enablehscroll": 0,
                    "enablevscroll": 0,
                    "id": "obj-7",
                    "lockeddragscroll": 0,
                    "lockedsize": 0,
                    "maxclass": "bpatcher",
                    "name": "j.maxhelpui.maxpat",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "offset": [ 0.0, 0.0 ],
                    "patching_rect": [ 0.0, 0.0, 762.0, 70.0 ],
                    "prototypename": "bphelp",
                    "varname": "maxhelpui",
                    "viewvisibility": 1
                }
            },
            {
                "box": {
                    "bubble": 1,
                    "id": "obj-12",
                    "linecount": 2,
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [ 259.0, 333.0, 194.0, 37.0 ],
                    "text": "Click on the message to send value to the qmetro exemple"
                }
            },
            {
                "box": {
                    "id": "obj-11",
                    "linecount": 2,
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [ 49.0, 291.0, 360.0, 33.0 ],
                    "text": "With an instance of the osc_receive.model in your patch, you can control all your jamoma models with simple OSC messages"
                }
            },
            {
                "box": {
                    "id": "obj-10",
                    "linecount": 2,
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [ 488.0, 146.0, 117.0, 33.0 ],
                    "text": "Jamoma module to control thru OSC"
                }
            },
            {
                "box": {
                    "id": "obj-6",
                    "maxclass": "message",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 478.0, 329.0, 161.0, 22.0 ],
                    "text": "time 1000"
                }
            },
            {
                "box": {
                    "annotation": "none",
                    "args": [ "qmetro_demo" ],
                    "bgmode": 0,
                    "border": 1,
                    "clickthrough": 0,
                    "enablehscroll": 0,
                    "enablevscroll": 0,
                    "id": "obj-5",
                    "lockeddragscroll": 0,
                    "lockedsize": 0,
                    "maxclass": "bpatcher",
                    "name": "qmetro.view.maxpat",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "offset": [ 0.0, 0.0 ],
                    "outlettype": [ "" ],
                    "patching_rect": [ 483.0, 201.0, 150.0, 70.0 ],
                    "viewvisibility": 1
                }
            },
            {
                "box": {
                    "id": "obj-9",
                    "linecount": 2,
                    "maxclass": "message",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 49.0, 333.0, 208.0, 35.0 ],
                    "text": "/qmetro_demo/time 0, /qmetro_demo/time 1000 ramp 3000"
                }
            },
            {
                "box": {
                    "annotation": "simple qmetro",
                    "id": "obj-4",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [ "", "" ],
                    "patching_rect": [ 478.0, 291.0, 161.0, 22.0 ],
                    "text": "qmetro.model qmetro_demo"
                }
            },
            {
                "box": {
                    "id": "obj-3",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [ 49.0, 378.0, 141.0, 22.0 ],
                    "text": "udpsend localhost 12000"
                }
            },
            {
                "box": {
                    "annotation": "none",
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-24",
                    "maxclass": "newobj",
                    "numinlets": 0,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 49.0, 216.0, 155.0, 22.0 ],
                    "text": "osc_receive.model osc_rcv"
                }
            },
            {
                "box": {
                    "annotation": "none",
                    "args": [ "osc_rcv" ],
                    "bgmode": 0,
                    "border": 1,
                    "clickthrough": 0,
                    "enablehscroll": 0,
                    "enablevscroll": 0,
                    "id": "obj-1",
                    "lockeddragscroll": 0,
                    "lockedsize": 0,
                    "maxclass": "bpatcher",
                    "name": "osc_receive.view.maxpat",
                    "numinlets": 0,
                    "numoutlets": 0,
                    "offset": [ 0.0, 0.0 ],
                    "patching_rect": [ 44.0, 128.0, 150.0, 70.0 ],
                    "viewvisibility": 1
                }
            },
            {
                "box": {
                    "angle": 270.0,
                    "border": 2,
                    "grad1": [ 0.376471, 0.384314, 0.4, 0.0 ],
                    "grad2": [ 0.290196, 0.309804, 0.301961, 0.0 ],
                    "id": "obj-2",
                    "maxclass": "panel",
                    "mode": 1,
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [ 471.0, 137.0, 179.0, 226.0 ],
                    "proportion": 0.39
                }
            }
        ],
        "lines": [
            {
                "patchline": {
                    "destination": [ "obj-6", 1 ],
                    "source": [ "obj-4", 1 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-3", 0 ],
                    "source": [ "obj-9", 0 ]
                }
            }
        ],
        "parameters": {
            "obj-1::obj-47": [ "monitor", "monitor", 0 ],
            "obj-1::obj-54": [ "live.numbox", "live.numbox", 0 ],
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