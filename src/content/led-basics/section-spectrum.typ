#import "blocks.typ": block-quote
#import "path.typ": path

== Spectrum Is Engineered, Not Assumed

#v(8pt)

Incandescent lamps produce a continuous thermal spectrum. LEDs are engineered light sources.

#v(10pt)

Most white LEDs do not simply “glow white.” They combine a pump LED with phosphor conversion.

#v(12pt)

#path(
  (
    (
      title: [emission source],
      relation: "inline",
      steps: (
        [blue or violet pump LED],
        [phosphor conversion layer],
      ),
    ),
    (
      title: [result],
      relation: "inline",
      steps: (
        [broad white light],
        [measured SPD],
      ),
    ),
  ),
  title: [White LED spectrum],
)

#v(16pt)

#line(length: 100%, stroke: rgb("#d8d8e2"))

#v(14pt)

#grid(
  columns: (0.38fr, 1fr),
  column-gutter: 20pt,
  align: top,

  [
    #text(size: 12pt, weight: "medium")[
      CCT is a label.
    ]

    #v(6pt)

    #text(size: 12pt, weight: "medium")[
      SPD is the evidence.
    ]
  ],

  [
    Two LEDs can both be sold as 4000 K and still produce very different light.

    #v(7pt)

    The correlated color temperature may match, while the actual spectral power distribution differs in ways that matter visually, biologically, and architecturally.
  ],
)

#v(14pt)

#grid(
  columns: (1fr, 1fr),
  column-gutter: 24pt,
  align: top,

  [
    #text(size: 8pt, weight: "bold", fill: rgb("#66666d"))[
      SAME LABEL
    ]

    #v(5pt)

    4000 K \
    white light \
    acceptable lumen output \
    ordinary product category \
    apparently similar fixture
  ],

  [
    #text(size: 8pt, weight: "bold", fill: rgb("#66666d"))[
      DIFFERENT SPECTRUM
    ]

    #v(5pt)

    color rendering \
    cyan content \
    melanopic effect \
    blue spike intensity \
    phosphor smoothness \
    visual comfort
  ],
)

#v(16pt)

#line(length: 100%, stroke: rgb("#d8d8e2"))

#v(14pt)

#grid(
  columns: (0.38fr, 1fr),
  column-gutter: 20pt,
  align: top,

  [
    #text(size: 8pt, weight: "bold", fill: rgb("#66666d"))[
      CONSEQUENCE
    ]
  ],

  [
    LEDs make better spectral design possible, but they also make poor spectral design possible.

    #v(6pt)

    The spectrum has to be specified, measured, and verified.
  ],
)

#v(12pt)

#block-quote[
  Do not infer spectral quality from CCT alone.
]
