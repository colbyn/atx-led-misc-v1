#import "@preview/fletcher:0.5.8" as fletcher: diagram, node, edge
#import "tables.typ": argument-table, table-label, table-body, table-rule, table-strong-rule

== Electrical Behavior: Incandescent vs LED

#v(8pt)

The fundamental difference is not efficiency. It is how each source behaves electrically when connected to power.

#v(14pt)

#argument-table(
  columns: (0.95fr, 1.1fr, 1.35fr),

  table.header(
    [#table-label[INCANDESCENT]],
    [#table-label[LED]],
    [#table-label[DESIGN MEANING]],
  ),

  table-strong-rule(),

  [#table-body[voltage-driven load]],
  [#table-body[current-driven diode]],
  [#table-body[The incandescent lamp can tolerate direct voltage. The LED needs controlled current.]],

  table-rule(),

  [#table-body[filament heats until it glows]],
  [#table-body[junction emits when forward biased]],
  [#table-body[The LED’s operating point depends on semiconductor behavior, not bulk heating alone.]],

  table-rule(),

  [#table-body[resistance rises with heat]],
  [#table-body[forward voltage usually falls with heat]],
  [#table-body[The incandescent filament tends to limit current. The LED can move toward more current.]],

  table-rule(),

  [#table-body[naturally self-stabilizing]],
  [#table-body[thermally sensitive]],
  [#table-body[The LED requires both current regulation and a thermal path.]],

  table-rule(),

  [#table-body[electrically forgiving]],
  [#table-body[requires regulation]],
  [#table-body[The driver is not accessory hardware. It is the real electrical interface.]],
)

#v(18pt)

#argument-table(
  columns: (0.28fr, 1fr),

  [#table-label[FAILURE MODE]],
  [
    #table-body[
      The LED’s electrical and thermal behavior can reinforce itself. More current creates more heat; more heat can lower forward voltage; lower forward voltage can allow still more current.
    ]
  ],
)

#v(10pt)

#let feedback-node(body) = [
  #box(
    width: 150pt,
    inset: (x: 9pt, y: 6pt),
    radius: 4pt,
    fill: rgb("#fafafe"),
    stroke: rgb("#d8d8e2"),
  )[
    #set text(size: 8.75pt)
    #align(center)[#body]
  ]
]

#text(size: 9pt, weight: "bold", fill: rgb("#66666d"))[
  Thermal runaway tendency
]

#v(8pt)

#align(center)[
  #diagram(
    node-stroke: none,
    edge-stroke: rgb("#5f6370") + 0.8pt,
    spacing: (200pt, 64pt),
    edge-corner-radius: 10pt,

    node((0, 0), feedback-node[more current], name: <current>),
    node((1, 0), feedback-node[more heat], name: <heat>),
    node((1, 1), feedback-node[lower forward voltage], name: <vf>),
    node((0, 1), feedback-node[allows still more current], name: <more-current>),

    edge(
      <current>,
      <heat>,
      "-|>",
      [I²R / junction heating],
      label-pos: 0.5,
      label-side: left,
    ),

    edge(
      <heat>,
      <vf>,
      "-|>",
      [temperature rises],
      label-pos: 0.5,
      label-side: right,
    ),

    edge(
      <vf>,
      <more-current>,
      "-|>",
      [same voltage pushes harder],
      label-pos: 0.5,
      label-side: left,
    ),

    edge(
      <more-current>,
      <current>,
      "-|>",
      [positive feedback],
      label-pos: 0.5,
      label-side: right,
    ),
  )
]

#v(12pt)

#argument-table(
  columns: (0.28fr, 1fr),

  [#table-label[CONSEQUENCE]],
  [
    #table-body[
      LEDs are not naturally self-stabilizing in the way incandescent filaments are. They need a driver that regulates current and a thermal path that keeps junction temperature under control.
    ]
  ],
)

