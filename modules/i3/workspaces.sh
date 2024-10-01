#!/bin/bash
i3-msg -t subscribe -m '["workspace", "output"]' | {
    i3-msg -t get_workspaces;
    while read; do i3-msg -t get_workspaces; done;
} | jq --unbuffered -c '
    def fake_ws(name): {
        name: name,
        output: "eDP-1-1",
    };
    . + [fake_ws("1"), fake_ws("2"),
         fake_ws("a"),
         fake_ws("p🗎"), fake_ws("n󰆧"),
         fake_ws("i"), fake_ws("m"),
         fake_ws("u"), fake_ws("r"), fake_ws("t")] | unique_by(.name)
'

