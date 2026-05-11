#import "blocks.typ": block-quote

== Drivers: The Real Electrical Interface

#v(8pt)

An LED driver is not optional support hardware. It is the electrical interface that makes the LED usable.

#v(10pt)

#grid(
  columns: (0.34fr, 1fr),
  column-gutter: 18pt,
  align: top,

  [
    #text(size: 8pt, weight: "bold", fill: rgb("#66666d"))[
      DRIVER JOB
    ]
  ],

  [
    It converts available supply power into usable LED power, regulates current through the LED, and provides the dimming or control behavior.
  ],
)

#v(14pt)

#line(length: 100%, stroke: rgb("#d8d8e2"))

#v(14pt)

#grid(
  columns: (1fr, 1fr),
  column-gutter: 22pt,
  align: top,

  [
    #text(size: 8pt, weight: "bold", fill: rgb("#66666d"))[
      CONSTANT VOLTAGE
    ]

    #v(5pt)

    #text(size: 12pt, weight: "medium")[
      Fixed voltage distribution.
    ]

    #v(7pt)

    A constant-voltage supply provides a fixed voltage, such as 12 V, 24 V, or 48 V.

    #v(6pt)

    This works when the connected load has its own current regulation or current-limiting elements.

    #v(8pt)

    #line(length: 100%, stroke: rgb("#d8d8e2"))

    #v(7pt)

    #set text(size: 9pt)

    LED tape with onboard resistors \
    fixtures with integrated drivers \
    DC buses feeding downstream regulators \
    useful for distribution \
    not direct bare-LED driving
  ],

  [
    #text(size: 8pt, weight: "bold", fill: rgb("#66666d"))[
      CONSTANT CURRENT
    ]

    #v(5pt)

    #text(size: 12pt, weight: "medium")[
      Direct LED current regulation.
    ]

    #v(7pt)

    A constant-current driver regulates the current through the LED.

    #v(6pt)

    The LED voltage is allowed to float within a permitted range while current is held steady.

    #v(8pt)

    #line(length: 100%, stroke: rgb("#d8d8e2"))

    #v(7pt)

    #set text(size: 9pt)

    bare LED engines \
    COB modules \
    serious luminaires \
    predictable output \
    correct electrical interface
  ],
)

#v(16pt)

#grid(
  columns: (0.34fr, 1fr),
  column-gutter: 18pt,
  align: top,

  [
    #text(size: 8pt, weight: "bold", fill: rgb("#66666d"))[
      COMMON CURRENTS
    ]
  ],

  [
    #set text(size: 9pt)

    350 mA / 500 mA / 660 mA / 700 mA / 1050 mA / 1400 mA
  ],
)

#v(14pt)

#block-quote[
  The driver must be able to supply the LED's required current while staying inside both the LED module's forward-voltage range and the driver's output-voltage range.
]

#v(14pt)

#grid(
  columns: (0.34fr, 1fr),
  column-gutter: 18pt,
  align: top,

  [
    #text(size: 8pt, weight: "bold", fill: rgb("#66666d"))[
      NOT JUST WATTS
    ]
  ],

  [
    An LED does not behave like a resistor. White LED packages often have forward voltages around 2.7–3.3 V, while COBs and modules may contain many dies in series or series-parallel arrangements, producing higher voltage ranges such as 18 V, 36 V, 48 V, or more.

    #v(6pt)

    Driver matching is not merely matching “watts.” It means matching current, voltage range, thermal capacity, and control behavior.
  ],
)

