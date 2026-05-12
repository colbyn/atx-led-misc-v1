#import "shift.typ": shift
#import "tables.typ": argument-table, table-label, table-body, table-rule, table-strong-rule

== LEDs Are a Different Technological Category

#v(8pt)

#text(size: 12.5pt, weight: "medium")[
  The mistake is treating the LED as a tiny light bulb.
]

#v(10pt)

Incandescent lamps and LEDs are not merely two versions of the same source. They belong to different technological categories.

#v(14pt)

#argument-table(
  columns: (0.95fr, 1.1fr, 1.35fr),

  table.header(
    [#table-label[INCANDESCENT]],
    [#table-label[LED]],
    [#table-label[DESIGN MEANING]],
  ),

  table-strong-rule(),

  [#table-body[thermal radiator]],
  [#table-body[semiconductor emitter]],
  [#table-body[The source is no longer a heated object. It is an electronic device that emits light.]],

  table-rule(),

  [#table-body[mains-voltage load]],
  [#table-body[low-voltage device]],
  [#table-body[The old socket is not the native electrical interface.]],

  table-rule(),

  [#table-body[self-stabilizing filament]],
  [#table-body[current-regulated load]],
  [#table-body[The LED needs a driver. It cannot be treated as a forgiving resistive lamp.]],

  table-rule(),

  [#table-body[continuous thermal spectrum]],
  [#table-body[engineered spectrum]],
  [#table-body[Light quality becomes something to specify, measure, and verify.]],

  table-rule(),

  [#table-body[simple electrical dimming]],
  [#table-body[electronic control problem]],
  [#table-body[Dimming behavior, flicker, control protocol, and driver design become part of the architecture.]],
)

#v(18pt)

#shift(
  from: [How do we make LEDs fit old lamp sockets?],
  to: [What architecture makes sense for semiconductor light?],
  from-label: [retrofit frame],
  to-label: [native frame],
  title: [The design question changes],
)

#v(16pt)

#argument-table(
  columns: (0.28fr, 1fr),

  [#table-label[CONSEQUENCE]],
  [
    #table-body[
      LED basics is not only about the diode.

      #v(5pt)

      It is about the system required to make semiconductor light useful: current regulation, heat removal, optical delivery, spectral design, dimming behavior, and control architecture.
    ]
  ],
)

