#import "blocks.typ": block-quote
#import "tables.typ": argument-table, table-label, table-body, table-rule, table-strong-rule

== Drivers: The Real Electrical Interface

#v(8pt)

An LED driver is not optional support hardware. It is the electrical interface that makes the LED usable.

#v(14pt)

#argument-table(
  columns: (0.34fr, 1fr),

  [#table-label[DRIVER JOB]],
  [
    #table-body[
      It converts available supply power into usable LED power, regulates current through the LED, and provides the dimming or control behavior.
    ]
  ],
)

#v(18pt)

#line(length: 100%, stroke: rgb("#d8d8e2"))

#v(14pt)

#argument-table(
  columns: (0.95fr, 1.05fr, 1.35fr),

  table.header(
    [#table-label[INTERFACE]],
    [#table-label[WHAT IT PROVIDES]],
    [#table-label[WHERE IT BELONGS]],
  ),

  table-strong-rule(),

  [#table-body[constant voltage]],
  [#table-body[fixed voltage such as 12 V, 24 V, or 48 V]],
  [#table-body[distribution buses, LED tape with onboard limiting, fixtures with downstream regulation]],

  table-rule(),

  [#table-body[constant current]],
  [#table-body[regulated LED current with voltage allowed to float inside a permitted range]],
  [#table-body[bare LED engines, COB modules, serious luminaires, predictable output]],

  table-rule(),

  [#table-body[wrong match]],
  [#table-body[voltage supplied where current regulation is required]],
  [#table-body[unstable output, overheating, shortened life, or immediate LED failure]],
)

#v(16pt)

#argument-table(
  columns: (0.34fr, 1fr),

  [#table-label[COMMON CURRENTS]],
  [
    #table-body[
      350 mA / 500 mA / 660 mA / 700 mA / 1050 mA / 1400 mA
    ]
  ],
)

#v(14pt)

#block-quote[
  The driver must be able to supply the LED's required current while staying inside both the LED module's forward-voltage range and the driver's output-voltage range.
]

#v(14pt)

#argument-table(
  columns: (0.34fr, 1fr),

  [#table-label[NOT JUST WATTS]],
  [
    #table-body[
      An LED does not behave like a resistor. White LED packages often have forward voltages around 2.7–3.3 V, while COBs and modules may contain many dies in series or series-parallel arrangements, producing higher voltage ranges such as 18 V, 36 V, 48 V, or more.

      #v(6pt)

      Driver matching is not merely matching “watts.” It means matching current, voltage range, thermal capacity, and control behavior.
    ]
  ],
)

