#import "blocks.typ": block-quote
#import "path.typ": path

== Heat, Efficacy, and System Losses

#v(8pt)

LEDs are efficient, but they are not heatless. Heat is not a side effect outside the design problem; it changes the behavior of the light source itself.

#v(12pt)

#grid(
  columns: (0.3fr, 1fr),
  column-gutter: 18pt,
  align: top,

  [
    #text(size: 8pt, weight: "bold", fill: rgb("#66666d"))[
      HEAT AFFECTS
    ]
  ],

  [
    #set text(size: 9pt)

    light output / color stability / lifetime / forward voltage / phosphor behavior / driver stress / reliability
  ],
)

#v(16pt)

#line(length: 100%, stroke: rgb("#d8d8e2"))

#v(14pt)

#grid(
  columns: (0.45fr, 1fr),
  column-gutter: 20pt,
  align: top,

  [
    #text(size: 12pt, weight: "medium")[
      The critical temperature is not room temperature.
    ]

    #v(7pt)

    It is not fixture temperature either.

    #v(7pt)

    The critical temperature is the LED junction temperature: the temperature at the semiconductor junction where light is actually produced.
  ],

  [
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
  ],
)

#v(14pt)

#grid(
  columns: (0.3fr, 1fr),
  column-gutter: 18pt,
  align: top,

  [
    #text(size: 8pt, weight: "bold", fill: rgb("#66666d"))[
      CONSEQUENCE
    ]
  ],

  [
    A poor thermal path can make an otherwise good LED fail early, shift color, lose output, or become electrically unstable.
  ],
)

#v(18pt)

#line(length: 100%, stroke: rgb("#d8d8e2"))

#v(14pt)

#grid(
  columns: (0.45fr, 1fr),
  column-gutter: 20pt,
  align: top,

  [
    #text(size: 12pt, weight: "medium")[
      Package efficacy is not system efficacy.
    ]

    #v(7pt)

    LED performance is often described in lumens per watt, but useful delivered light depends on the whole chain.

    #v(7pt)

    Electrical conversion, current regulation, thermal behavior, optics, and fixture design all subtract from the theoretical performance of the LED package.
  ],

  [
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
  ],
)

#v(14pt)

#grid(
  columns: (0.3fr, 1fr),
  column-gutter: 18pt,
  align: top,

  [
    #text(size: 8pt, weight: "bold", fill: rgb("#66666d"))[
      BETTER QUESTION
    ]
  ],

  [
    Not only: #emph[How efficient is the LED?]

    #v(5pt)

    But: #emph[How much useful light does the complete system deliver, and under what thermal, optical, spectral, and control conditions?]
  ],
)

