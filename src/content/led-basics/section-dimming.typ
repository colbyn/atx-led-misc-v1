== Dimming Is Not Just “Less Power”

#v(8pt)

With LEDs, dimming is not a single electrical behavior.

#v(6pt)

The same visible result — less light — can come from pulsing the LED, lowering the LED current, or combining both methods. That choice affects flicker, color stability, camera behavior, low-end smoothness, and perceived quality.

#v(14pt)

#grid(
  columns: (0.28fr, 1fr),
  column-gutter: 18pt,
  align: top,

  [
    #text(size: 8pt, weight: "bold", fill: rgb("#66666d"))[
      THE QUESTION
    ]
  ],

  [
    A product being “dimmable” is not enough. The real question is how it dims.
  ],
)

#v(16pt)

#line(length: 100%, stroke: rgb("#d8d8e2"))

#v(14pt)

#grid(
  columns: (1fr, 1fr, 1fr),
  column-gutter: 16pt,
  row-gutter: 10pt,
  align: top,

  [
    #text(size: 8pt, weight: "bold", fill: rgb("#66666d"))[
      PWM DIMMING
    ]

    #v(5pt)

    Pulse-width modulation turns the LED on and off rapidly. Brightness is controlled by changing the duty cycle.

    #v(6pt)

    PWM is common because it is simple and controllable. But if implemented poorly, it can create visible flicker, camera banding, eyestrain, or low-quality dimming behavior.
  ],

  [
    #text(size: 8pt, weight: "bold", fill: rgb("#66666d"))[
      CURRENT REDUCTION
    ]

    #v(5pt)

    Current reduction lowers the actual LED current.

    #v(6pt)

    This avoids hard on/off pulsing and can produce very low-flicker dimming. But it may also introduce color shift, reduced driver accuracy at low levels, or a narrower practical dimming range.
  ],

  [
    #text(size: 8pt, weight: "bold", fill: rgb("#66666d"))[
      HYBRID DIMMING
    ]

    #v(5pt)

    Better drivers often use current reduction through most of the dimming range, then reserve high-frequency PWM for the very lowest output levels.

    #v(6pt)

    The goal is smooth dimming without sacrificing low-end control.
  ],
)

#v(18pt)

#text(size: 12pt, weight: "medium")[
  What “less light” looks like electrically
]

#v(7pt)

The visible output may look similar, but the electrical waveform can be completely different.

#v(12pt)

#let signal-strip(samples, height: 24pt) = {
  let cols = ()
  let cells = ()

  for s in samples {
    cols.push(1fr)

    let bar-height = if s == 0 {
      2pt
    } else {
      height * s
    }

    let bar-fill = if s == 0 {
      luma(230)
    } else {
      black
    }

    cells.push(
      align(bottom)[
        #rect(
          width: 100%,
          height: bar-height,
          fill: bar-fill,
          radius: 0.5pt,
        )
      ]
    )
  }

  grid(
    columns: cols,
    column-gutter: 1.5pt,
    align: bottom,
    ..cells,
  )
}

#let signal-row(label, samples) = grid(
  columns: (1.25fr, 3fr),
  column-gutter: 10pt,
  align: horizon,

  [
    #text(size: 8.5pt, fill: luma(90), weight: "medium")[#label]
  ],

  [
    #signal-strip(samples)
  ],
)

#let signal-section(title, subtitle, body) = block(
  width: 100%,
  inset: 10pt,
  stroke: luma(220),
  radius: 4pt,
  breakable: false,
)[
  #grid(
    columns: (1.1fr, 2.9fr),
    column-gutter: 16pt,
    align: top,

    [
      #text(weight: "bold", size: 12pt)[#title]

      #v(3pt)

      #text(size: 8.5pt, fill: luma(90))[#subtitle]
    ],

    [
      #body
    ],
  )
]

#signal-section(
  [PWM Dimming],
  [same current, less time on],
  [
    #signal-row(
      [High output — long on-time],
      (1, 1, 1, 1, 0, 1, 1, 1, 1, 0, 1, 1),
    )
    #signal-row(
      [Medium output — balanced on/off],
      (1, 1, 0, 0, 1, 1, 0, 0, 1, 1, 0, 0),
    )
    #signal-row(
      [Low output — short on-time],
      (1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1, 0),
    )
  ],
)

#signal-section(
  [Current Reduction],
  [same time on, less current],
  [
    #signal-row(
      [High output — higher current],
      (0.85, 0.85, 0.85, 0.85, 0.85, 0.85, 0.85, 0.85, 0.85, 0.85, 0.85, 0.85),
    )

    #v(7pt)

    #signal-row(
      [Medium output — reduced current],
      (0.55, 0.55, 0.55, 0.55, 0.55, 0.55, 0.55, 0.55, 0.55, 0.55, 0.55, 0.55),
    )

    #v(7pt)

    #signal-row(
      [Low output — low current],
      (0.25, 0.25, 0.25, 0.25, 0.25, 0.25, 0.25, 0.25, 0.25, 0.25, 0.25, 0.25),
    )
  ],
)

#signal-section(
  [Hybrid Dimming],
  [current reduction first, PWM only after the analog floor],
  [
    #signal-row(
      [High output — continuous current],
      (0.85, 0.85, 0.85, 0.85, 0.85, 0.85, 0.85, 0.85, 0.85, 0.85, 0.85, 0.85),
    )

    #v(7pt)

    #signal-row(
      [Medium output — reduced current],
      (0.55, 0.55, 0.55, 0.55, 0.55, 0.55, 0.55, 0.55, 0.55, 0.55, 0.55, 0.55),
    )

    #v(7pt)

    #signal-row(
      [Low output — analog floor],
      (0.25, 0.25, 0.25, 0.25, 0.25, 0.25, 0.25, 0.25, 0.25, 0.25, 0.25, 0.25),
    )

    #v(7pt)

    #signal-row(
      [Very low output — PWM below the floor],
      (0.25, 0, 0, 0, 0, 0.25, 0, 0, 0, 0, 0.25, 0),
    )
  ],
)
