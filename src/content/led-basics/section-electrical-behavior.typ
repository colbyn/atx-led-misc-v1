#import "@preview/fletcher:0.5.8" as fletcher: diagram, node, edge
#import "path.typ": path

== Electrical Behavior: Incandescent vs LED

#v(8pt)

The fundamental difference is not efficiency. It is how each source behaves electrically when connected to power.

#v(12pt)

#grid(
  columns: (1fr, 1fr),
  column-gutter: 22pt,
  align: top,

  [
    #text(size: 8pt, weight: "bold", fill: rgb("#66666d"))[
      INCANDESCENT
    ]

    #v(5pt)

    #text(size: 12pt, weight: "medium")[
      Voltage-driven and self-stabilizing.
    ]

    #v(7pt)

    An incandescent lamp connects directly to mains voltage. Its filament heats until it glows white-hot.

    #v(6pt)

    As the filament temperature rises, its resistance also rises. That rising resistance naturally limits current.

    #v(8pt)

    #line(length: 100%, stroke: rgb("#d8d8e2"))

    #v(7pt)

    #set text(size: 9pt)

    voltage source \
    heating filament \
    rising resistance \
    crude current limiting \
    electrically forgiving load
  ],

  [
    #text(size: 8pt, weight: "bold", fill: rgb("#66666d"))[
      LED
    ]

    #v(5pt)

    #text(size: 12pt, weight: "medium")[
      Current-driven and thermally sensitive.
    ]

    #v(7pt)

    An LED has a forward-voltage region where it begins conducting strongly.

    #v(6pt)

    Once it enters that region, small voltage changes can produce large current changes. As the junction gets hotter, forward voltage usually falls.

    #v(8pt)

    #line(length: 100%, stroke: rgb("#d8d8e2"))

    #v(7pt)

    #set text(size: 9pt)

    low-voltage diode \
    steep I–V behavior \
    falling forward voltage with heat \
    current can increase further \
    requires regulation
  ],
)

#v(16pt)

#grid(
  columns: (0.28fr, 1fr),
  column-gutter: 18pt,
  align: top,

  [
    #text(size: 8pt, weight: "bold", fill: rgb("#66666d"))[
      FAILURE MODE
    ]
  ],

  [
    The LED’s electrical and thermal behavior can reinforce itself. More current creates more heat; more heat can lower forward voltage; lower forward voltage can allow still more current.
  ],
)

#v(8pt)

#let feedback-node(body) = [
  #box(
    inset: (x: 7pt, y: 5pt),
    radius: 4pt,
    fill: rgb("#fafafe"),
    stroke: rgb("#d8d8e2"),
  )[
    #set text(size: 8.75pt)
    #body
  ]
]

#text(size: 9pt, weight: "bold", fill: rgb("#66666d"))[
  Thermal runaway tendency
]

#v(6pt)

#align(center)[
  #diagram(
    node-stroke: none,
    edge-stroke: rgb("#5f6370") + 0.8pt,
    spacing: (42pt, 30pt),
    edge-corner-radius: 6pt,

    node((0, 0), feedback-node[more current], name: <current>),
    node((1, 0), feedback-node[more heat], name: <heat>),
    node((1, 1), feedback-node[lower forward voltage], name: <vf>),
    node((0, 1), feedback-node[allows still more current], name: <more-current>),

    edge(<current>, <heat>, "-|>", [I²R / junction heating], label-pos: 0.5),
    edge(<heat>, <vf>, "-|>", [temperature rises], label-pos: 0.5),
    edge(<vf>, <more-current>, "-|>", [same voltage pushes harder], label-pos: 0.5),
    edge(<more-current>, <current>, "-|>", [positive feedback], label-pos: 0.5),
  )
]

#v(10pt)

#grid(
  columns: (0.28fr, 1fr),
  column-gutter: 18pt,
  align: top,

  [
    #text(size: 8pt, weight: "bold", fill: rgb("#66666d"))[
      CONSEQUENCE
    ]
  ],

  [
    LEDs are not naturally self-stabilizing in the way incandescent filaments are. They need a driver that regulates current and a thermal path that keeps junction temperature under control.
  ],
)

