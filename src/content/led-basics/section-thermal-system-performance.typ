#import "blocks.typ": block-quote
#import "path.typ": path
#import "tables.typ": argument-table, table-label, table-body, table-rule, table-strong-rule

== Heat, Efficacy, and System Losses

#v(8pt)

LEDs are efficient, but they are not heatless. Heat is not a side effect outside the design problem; it changes the behavior of the light source itself.

#v(14pt)

#argument-table(
  columns: (0.7fr, 1.35fr, 1.3fr),

  table.header(
    [#table-label[HEAT AFFECTS]],
    [#table-label[WHAT CHANGES]],
    [#table-label[DESIGN CONSEQUENCE]],
  ),

  table-strong-rule(),

  [#table-body[light output]],
  [#table-body[LED flux usually falls as junction temperature rises]],
  [#table-body[The same electrical input can produce less useful light.]],

  table-rule(),

  [#table-body[color stability]],
  [#table-body[LED and phosphor behavior shift with temperature]],
  [#table-body[The fixture can drift away from its intended appearance.]],

  table-rule(),

  [#table-body[lifetime]],
  [#table-body[high temperature accelerates degradation]],
  [#table-body[Thermal design determines whether specifications survive real use.]],

  table-rule(),

  [#table-body[forward voltage]],
  [#table-body[Vf usually falls as the junction gets hotter]],
  [#table-body[The electrical design must prevent thermal feedback from becoming instability.]],

  table-rule(),

  [#table-body[driver stress]],
  [#table-body[heat affects nearby electronics and power conversion]],
  [#table-body[The whole luminaire is a thermal system, not just the LED package.]],
)

#v(18pt)

#line(length: 100%, stroke: rgb("#d8d8e2"))

#v(14pt)

#argument-table(
  columns: (0.36fr, 1fr),

  [#table-label[JUNCTION TEMPERATURE]],
  [
    #table-body[
      The critical temperature is not room temperature.

      #v(5pt)

      It is not fixture temperature either.

      #v(5pt)

      The critical temperature is the LED junction temperature: the temperature at the semiconductor junction where light is actually produced.
    ]
  ],
)

#v(12pt)

#path(
  (
    (
      title: [inside LED package],
      relation: "inline",
      steps: (
        [junction],
        [solder point or case],
      ),
    ),
    (
      title: [fixture thermal path],
      steps: (
        [circuit board],
        [heat sink],
        [surrounding air],
      ),
    ),
  ),
  title: [Thermal path],
)

#v(14pt)

#argument-table(
  columns: (0.3fr, 1fr),

  [#table-label[CONSEQUENCE]],
  [
    #table-body[
      A poor thermal path can make an otherwise good LED fail early, shift color, lose output, or become electrically unstable.
    ]
  ],
)

#v(18pt)

#line(length: 100%, stroke: rgb("#d8d8e2"))

#v(14pt)

#argument-table(
  columns: (0.36fr, 1fr),

  [#table-label[SYSTEM EFFICACY]],
  [
    #table-body[
      Package efficacy is not system efficacy.

      #v(5pt)

      LED performance is often described in lumens per watt, but useful delivered light depends on the whole chain.

      #v(5pt)

      Electrical conversion, current regulation, thermal behavior, optics, and fixture design all subtract from the theoretical performance of the LED package.
    ]
  ],
)

#v(12pt)

#path(
  (
    [AC input],
    (
      title: [electrical conversion],
      steps: (
        [power supply losses],
        [driver losses],
      ),
    ),
    (
      title: [light generation],
      steps: (
        [LED conversion efficiency],
      ),
    ),
    (
      title: [delivery losses],
      steps: (
        [optical losses],
        [fixture losses],
      ),
    ),
    [delivered light],
  ),
  title: [System efficacy chain],
)

#v(14pt)

#argument-table(
  columns: (0.3fr, 1fr),

  [#table-label[BETTER QUESTION]],
  [
    #table-body[
      Not only: #emph[How efficient is the LED?]

      #v(5pt)

      But: #emph[How much useful light does the complete system deliver, and under what thermal, optical, spectral, and control conditions?]
    ]
  ],
)