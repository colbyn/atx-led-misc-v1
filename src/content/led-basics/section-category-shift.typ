#import "shift.typ": shift

== LEDs Are a Different Technological Category

#v(8pt)

#grid(
  columns: (1.35fr, 0.65fr),
  column-gutter: 24pt,
  align: top,

  [
    #text(size: 12.5pt, weight: "medium")[
      The mistake is treating the LED as a tiny light bulb.
    ]

    #v(8pt)

    Incandescent lamps are thermal radiators: mains-voltage devices whose glowing filament also acts as a crude current limiter.

    #v(6pt)

    LEDs are semiconductor emitters: low-voltage, current-driven, thermally sensitive devices whose behavior depends on the surrounding electrical, thermal, optical, spectral, and control system.

    #v(8pt)

    This is not merely a difference in efficiency. It changes the design problem.
  ],

  [
    #set text(size: 8.25pt)

    #text(size: 7.8pt, weight: "bold", fill: rgb("#66666d"))[INCANDESCENT]

    #v(2.5pt)

    thermal radiator \
    mains-voltage load \
    self-stabilizing filament \
    continuous thermal spectrum \
    simple electrical dimming

    #v(10pt)

    #line(length: 100%, stroke: rgb("#d8d8e2"))

    #v(10pt)

    #text(size: 7.8pt, weight: "bold", fill: rgb("#66666d"))[LED]

    #v(2.5pt)

    semiconductor emitter \
    low-voltage device \
    current-regulated load \
    engineered spectrum \
    electronic control problem
  ],
)

#v(18pt)

#shift(
  from: [How do we make LEDs fit old lamp sockets?],
  to: [What architecture makes sense for semiconductor light?],
  from-label: [retrofit frame],
  to-label: [native frame],
  title: [The design question changes],
)

#v(14pt)

#grid(
  columns: (0.32fr, 1fr),
  column-gutter: 18pt,
  align: top,

  [
    #text(size: 8.25pt, weight: "bold", fill: rgb("#66666d"))[
      CONSEQUENCE
    ]
  ],

  [
    LED basics is not only about the diode.

    #v(5pt)

    It is about the system required to make semiconductor light useful: current regulation, heat removal, optical delivery, spectral design, dimming behavior, and control architecture.
  ],
)

