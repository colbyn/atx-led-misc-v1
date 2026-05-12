#import "blocks.typ": block-quote
#import "path.typ": path
#import "@preview/lilaq:0.6.0" as lq
#import "spectrum-plot.typ": spectrum-plot

#set par(justify: false)

// ============================================================================
// SECTION: Spectrum
// ============================================================================
//
// This section uses illustrative synthetic SPD archetypes.
// These are not measured product spectra.
//
// They are designed to teach spectral structure:
// - thermal continuum
// - blue pump + phosphor hump
// - cyan gap
// - weak deep red
// - improved high-CRI fill
// - violet-pump / full-spectrum reconstruction
//
// Do not use these curves for:
// - CCT calculation
// - CRI / TM-30
// - melanopic EDI
// - efficacy
// - absolute radiant power
// - product comparison
//
// Each curve is independently normalized for shape comparison.


// ============================================================================
// Data primitives
// ============================================================================

#let wl = lq.linspace(380, 780, num: 401)

#let gauss(x, center, width, amp: 1.0) = {
  amp * calc.exp(-0.5 * calc.pow((x - center) / width, 2))
}

#let skewed-gauss(x, center, left-width, right-width, amp: 1.0) = {
  if x < center {
    gauss(x, center, left-width, amp: amp)
  } else {
    gauss(x, center, right-width, amp: amp)
  }
}

#let normalize(values) = {
  let max-val = calc.max(..values)

  if max-val == 0 {
    values
  } else {
    values.map(v => v / max-val)
  }
}

#let make-series(f) = normalize(wl.map(f))

#let sub-dip(x, center, width, depth: 0.1) = {
  1.0 - depth * gauss(x, center, width)
}

#let blackbody(x, temp) = {
  // Relative Planck-like curve.
  // x is wavelength in nm.
  // c2 = h*c/k in nm*K.
  let c2 = 14387768.0
  let xr = x / 560.0
  let e = calc.exp(c2 / (x * temp))

  1.0 / (calc.pow(xr, 5.0) * (e - 1.0))
}

#let spectral-window(values, min-wl, max-wl) = {
  let pairs = ()
  for i in range(wl.len()) {
    let x = wl.at(i)
    if x >= min-wl and x <= max-wl {
      pairs.push(values.at(i))
    }
  }

  if pairs.len() == 0 {
    0
  } else {
    pairs.sum() / pairs.len()
  }
}

#let band-score(values, min-wl, max-wl) = {
  let score = spectral-window(values, min-wl, max-wl)
  calc.round(score * 100)
}


// ============================================================================
// Synthetic spectral archetypes
// ============================================================================

#let spd-daylight-reference(x) = {
  // Idealized daylight-like reference: solar-ish continuum plus absorption texture.
  let base = blackbody(x, 5778)

  let atmosphere = (
    sub-dip(x, 430, 8, depth: 0.030) *
    sub-dip(x, 486, 6, depth: 0.035) *
    sub-dip(x, 517, 8, depth: 0.025) *
    sub-dip(x, 589, 5, depth: 0.045) *
    sub-dip(x, 656, 7, depth: 0.035) *
    sub-dip(x, 690, 9, depth: 0.030) *
    sub-dip(x, 760, 12, depth: 0.090)
  )

  base * atmosphere
}

#let spd-candle(x) = {
  // Very warm thermal source.
  blackbody(x, 1900)
}

#let spd-incandescent(x) = {
  // Household tungsten archetype.
  blackbody(x, 2700)
}

#let spd-halogen(x) = {
  // Slightly hotter tungsten-halogen archetype.
  blackbody(x, 3000)
}

#let spd-cheap-blue-pump(x) = {
  // Low-cost blue-pump white LED:
  // obvious 450 nm pump, green/yellow phosphor, cyan hole, weak deep red.
  (
    gauss(x, 450, 11, amp: 1.22) +
    skewed-gauss(x, 560, 42, 78, amp: 0.82) +
    gauss(x, 610, 52, amp: 0.22) +
    gauss(x, 660, 34, amp: 0.055)
  )
}

#let spd-commodity-blue-pump(x) = {
  // Generic commodity white LED:
  // less ugly than the cheap case but still visibly pump-driven.
  (
    gauss(x, 450, 14, amp: 0.64) +
    gauss(x, 520, 47, amp: 0.30) +
    skewed-gauss(x, 575, 58, 88, amp: 0.78) +
    gauss(x, 635, 72, amp: 0.34)
  )
}

#let spd-high-cri-blue-pump(x) = {
  // High-CRI blue-pump archetype:
  // better cyan and red fill, still anchored by blue pump.
  (
    gauss(x, 450, 15, amp: 0.48) +
    gauss(x, 505, 47, amp: 0.40) +
    gauss(x, 560, 76, amp: 0.66) +
    gauss(x, 620, 84, amp: 0.64) +
    gauss(x, 665, 46, amp: 0.32)
  )
}

#let spd-violet-pump(x) = {
  // Violet-pump / full-spectrum archetype:
  // pump is moved down toward violet; visible region is rebuilt with phosphors.
  (
    gauss(x, 410, 12, amp: 0.44) +
    gauss(x, 445, 34, amp: 0.20) +
    gauss(x, 490, 54, amp: 0.43) +
    gauss(x, 555, 84, amp: 0.70) +
    gauss(x, 620, 86, amp: 0.62) +
    gauss(x, 675, 52, amp: 0.36)
  )
}

#let spd-rgb-white(x) = {
  // RGB mixed white archetype:
  // can make white visually, but spectral coverage is sparse.
  (
    gauss(x, 460, 18, amp: 0.88) +
    gauss(x, 530, 24, amp: 0.96) +
    gauss(x, 625, 28, amp: 0.74)
  )
}

#let daylight = make-series(spd-daylight-reference)
#let candle = make-series(spd-candle)
#let incandescent = make-series(spd-incandescent)
#let halogen = make-series(spd-halogen)
#let cheap-blue-pump = make-series(spd-cheap-blue-pump)
#let commodity-blue-pump = make-series(spd-commodity-blue-pump)
#let high-cri-blue-pump = make-series(spd-high-cri-blue-pump)
#let violet-pump = make-series(spd-violet-pump)
#let rgb-white = make-series(spd-rgb-white)


// ============================================================================
// Design tokens
// ============================================================================

#let ink = rgb("#24242a")
#let soft-ink = rgb("#4d4d58")
#let mute = rgb("#6f707b")
#let faint = rgb("#f5f5f8")
#let panel = rgb("#fbfbfd")
#let rule-color = rgb("#d9d9e3")
#let hairline = rgb("#e8e8ef")

#let blue = rgb("#005eff")
#let cyan = rgb("#008f9a")
#let green = rgb("#3a9a00")
#let violet = rgb("#7a3cff")
#let amber = rgb("#bd6a00")
#let red = rgb("#a83232")
#let black = rgb("#111111")

#let fine-label(body, fill: mute) = [
  #text(size: 7.4pt, weight: "bold", tracking: 0.09em, fill: fill)[
    #upper(body)
  ]
]

#let section-rule() = [
  #v(20pt)
  #line(length: 100%, stroke: rule-color + 0.8pt)
  #v(16pt)
]

#let small-note(body) = [
  #block(
    width: 100%,
    inset: (x: 10pt, y: 8pt),
    radius: 7pt,
    fill: faint,
    stroke: hairline + 0.6pt,
  )[
    #text(size: 8.4pt, fill: soft-ink)[#body]
  ]
]

#let data-chip(label, value, accent: black) = [
  #block(
    inset: (x: 7pt, y: 5pt),
    radius: 5pt,
    fill: rgb("#ffffff"),
    stroke: hairline + 0.55pt,
  )[
    #text(size: 6.8pt, weight: "bold", tracking: 0.06em, fill: mute)[
      #upper(label)
    ]

    #h(5pt)

    #text(size: 8pt, weight: "medium", fill: accent)[#value]
  ]
]

#let callout-card(title, body, accent: black) = [
  #block(
    width: 100%,
    inset: (x: 12pt, y: 11pt),
    radius: 9pt,
    fill: panel,
    stroke: hairline + 0.7pt,
  )[
    #fine-label(title, fill: accent)

    #v(7pt)

    #text(size: 9.4pt, fill: ink)[#body]
  ]
]

#let big-number(label, value, accent: black) = [
  #block(
    width: 100%,
    inset: (x: 10pt, y: 9pt),
    radius: 8pt,
    fill: white,
    stroke: hairline + 0.6pt,
  )[
    #fine-label(label)

    #v(5pt)

    #text(size: 18pt, weight: "medium", fill: accent)[#value]
  ]
]

#let matrix-row(a, b, c, d) = (
  [
    #set text(size: 8.8pt)
    #a
  ],
  [
    #set text(size: 8.8pt)
    #b
  ],
  [
    #set text(size: 8.8pt)
    #c
  ],
  [
    #set text(size: 8.8pt)
    #d
  ],
)


// ============================================================================
// Plot helpers
// ============================================================================

#let daylight-series = (
  (
    label: [idealized daylight],
    values: daylight,
    stroke: black + 1.0pt,
    draw-area: false,
  ),
)

#let thermal-series = (
  (
    label: [candle / flame],
    values: candle,
    stroke: rgb("#8b3f00") + 0.9pt,
    draw-area: false,
  ),
  (
    label: [incandescent],
    values: incandescent,
    stroke: amber + 1.0pt,
    draw-area: false,
  ),
  (
    label: [halogen],
    values: halogen,
    stroke: rgb("#d98900") + 0.9pt,
    draw-area: false,
  ),
)

#let led-family-series = (
  (
    label: [cheap blue-pump],
    values: cheap-blue-pump,
    stroke: blue + 0.9pt,
    draw-area: false,
  ),
  (
    label: [commodity blue-pump],
    values: commodity-blue-pump,
    stroke: cyan + 0.9pt,
    draw-area: false,
  ),
  (
    label: [high-CRI blue-pump],
    values: high-cri-blue-pump,
    stroke: green + 0.9pt,
    draw-area: false,
  ),
  (
    label: [violet-pump],
    values: violet-pump,
    stroke: violet + 0.9pt,
    draw-area: false,
  ),
  (
    label: [RGB mixed white],
    values: rgb-white,
    stroke: red + 0.9pt,
    draw-area: false,
  ),
)

#let all-archetypes-series = daylight-series + thermal-series + led-family-series

#let compare-to-daylight(label, values, stroke, title: [], height: 4.1cm, area: true) = {
  spectrum-plot(
    wl,
    title: title,
    height: height,
    legend-position: "bottom",
    series: daylight-series + (
      (
        label: label,
        values: values,
        stroke: stroke,
        draw-area: area,
      ),
    ),
  )
}

#let compare-two(a-label, a-values, a-stroke, b-label, b-values, b-stroke, title: [], height: 4.5cm) = {
  spectrum-plot(
    wl,
    title: title,
    height: height,
    legend-position: "bottom",
    series: (
      (
        label: a-label,
        values: a-values,
        stroke: a-stroke,
        draw-area: true,
      ),
      (
        label: b-label,
        values: b-values,
        stroke: b-stroke,
        draw-area: false,
      ),
    ),
  )
}

#let archetype-card(
  eyebrow,
  title,
  values,
  stroke,
  accent,
  body,
  chips: (),
) = [
  #block(
    width: 100%,
    inset: 0pt,
    radius: 11pt,
    fill: white,
    stroke: hairline + 0.7pt,
  )[
    #block(inset: (x: 11pt, y: 10pt))[
      #fine-label(eyebrow, fill: accent)

      #v(5pt)

      #text(size: 11pt, weight: "medium", fill: ink)[#title]
    ]

    #compare-to-daylight(
      title,
      values,
      stroke,
      title: [],
      height: 3.55cm,
    )

    #block(inset: (x: 11pt, y: 10pt))[
      #text(size: 8.7pt, fill: soft-ink)[#body]

      #if chips.len() > 0 [
        #v(8pt)

        #grid(
          columns: (auto, auto, auto),
          column-gutter: 5pt,
          row-gutter: 5pt,
          ..chips,
        )
      ]
    ]
  ]
]

#let score-strip(label, values, accent) = [
  #grid(
    columns: (0.85fr, auto, auto, auto),
    column-gutter: 6pt,
    align: horizon,

    [
      #text(size: 8pt, weight: "medium")[#label]
    ],
    data-chip([cyan], [#band-score(values, 470, 510)], accent: accent),
    data-chip([red], [#band-score(values, 620, 700)], accent: accent),
    data-chip([violet/blue], [#band-score(values, 400, 460)], accent: accent),
  )
]


// ============================================================================
// Section content
// ============================================================================

== Spectrum Is the Real Light Source

#v(10pt)

#grid(
  columns: (0.42fr, 1fr),
  column-gutter: 24pt,
  align: top,

  [
    #fine-label[the hidden layer]

    #v(8pt)

    #text(size: 24pt, weight: "medium", fill: ink)[
      White light is not a substance.
    ]

    #v(8pt)

    #text(size: 13pt, fill: soft-ink)[
      It is a spectral construction that happens to land on a white appearance.
    ]

    #v(14pt)

    #small-note[
      These plots are synthetic archetypes. They are intentionally normalized and simplified so the construction of each light source is easy to see.
    ]

    #v(10pt)

    #small-note[
      The design question is not only “what CCT is this?” The better question is “what wavelengths are actually reaching the eye, the camera, and the surfaces in the room?”
    ]
  ],

  [
    #spectrum-plot(
      wl,
      title: [Different ways to make something that looks white],
      height: 7.2cm,
      legend-position: auto,
      series: all-archetypes-series,
    )
  ],
)

#v(18pt)

#grid(
  columns: (1fr, 1fr, 1fr),
  column-gutter: 12pt,
  align: top,

  callout-card(
    [thermal light],
    [
      A hot object emits a continuum. The spectrum is a consequence of temperature.
    ],
    accent: amber,
  ),

  callout-card(
    [phosphor-converted LED],
    [
      A narrow semiconductor pump excites phosphors. The spectrum is assembled from pump leakage plus converted light.
    ],
    accent: blue,
  ),

  callout-card(
    [multi-channel light],
    [
      Multiple primaries can mix to white while leaving large spectral gaps between channels.
    ],
    accent: red,
  ),
)

#section-rule()

== The Same Word “White” Hides Different Machinery

#v(8pt)

#grid(
  columns: (0.40fr, 1fr),
  column-gutter: 24pt,
  align: top,

  [
    #fine-label[mechanism matters]

    #v(8pt)

    #text(size: 18pt, weight: "medium", fill: ink)[
      Incandescent light is emitted.
    ]

    #v(6pt)

    #text(size: 18pt, weight: "medium", fill: ink)[
      LED white is engineered.
    ]

    #v(10pt)

    #text(size: 10pt, fill: soft-ink)[
      That single difference changes what has to be specified, verified, and controlled.
    ]
  ],

  [
    #path(
      (
        (
          title: [thermal continuum],
          relation: "inline",
          steps: (
            [temperature],
            [continuous spectrum],
            [warm white appearance],
          ),
        ),
        (
          title: [LED construction],
          relation: "inline",
          steps: (
            [semiconductor pump],
            [phosphor conversion],
            [mixed white output],
            [measured SPD],
          ),
        ),
      ),
      title: [Two routes to white],
    )
  ],
)

#v(18pt)

#grid(
  columns: (1fr, 1fr),
  column-gutter: 16pt,
  row-gutter: 16pt,
  align: top,

  [
    #compare-two(
      [incandescent],
      incandescent,
      amber + 1.0pt,
      [idealized daylight],
      daylight,
      black + 0.9pt,
      title: [Thermal light: continuous, warm, red-heavy],
      height: 4.8cm,
    )

    #v(7pt)

    #text(size: 9pt, fill: soft-ink)[
      Incandescent is spectrally continuous, but tilted heavily toward long wavelengths. Its weakness is efficiency, not spectral assembly.
    ]
  ],

  [
    #compare-two(
      [cheap blue-pump LED],
      cheap-blue-pump,
      blue + 1.0pt,
      [idealized daylight],
      daylight,
      black + 0.9pt,
      title: [Basic LED: spike, valley, phosphor hump],
      height: 4.8cm,
    )

    #v(7pt)

    #text(size: 9pt, fill: soft-ink)[
      A basic blue-pump LED can look white while still having a hard pump spike, a cyan depression, and weak deep red.
    ]
  ],
)

#section-rule()

== The Spectral Anatomy of Common White Light

#v(8pt)

This is the useful mental model: not “warm versus cool,” but **where the energy is**.

#v(14pt)

#grid(
  columns: (1fr, 1fr),
  column-gutter: 16pt,
  row-gutter: 16pt,
  align: top,

  archetype-card(
    [thermal continuum],
    [Incandescent],
    incandescent,
    amber + 0.95pt,
    amber,
    [
      Smooth and red-heavy. Good continuity, poor efficiency, weak short-wavelength output.
    ],
    chips: (
      data-chip([shape], [smooth], accent: amber),
      data-chip([blue], [low], accent: amber),
      data-chip([red], [high], accent: amber),
    ),
  ),

  archetype-card(
    [blue-pump minimum],
    [Cheap blue-pump LED],
    cheap-blue-pump,
    blue + 0.95pt,
    blue,
    [
      Obvious pump spike near 450 nm, broad phosphor hump, weak cyan and red. Often the spectral pattern behind cheap “white” light.
    ],
    chips: (
      data-chip([pump], [450 nm], accent: blue),
      data-chip([cyan], [weak], accent: blue),
      data-chip([red], [weak], accent: blue),
    ),
  ),

  archetype-card(
    [commodity white],
    [Commodity blue-pump LED],
    commodity-blue-pump,
    cyan + 0.95pt,
    cyan,
    [
      The blend is more acceptable, but the source is still visibly structured by the blue pump and phosphor package.
    ],
    chips: (
      data-chip([pump], [visible], accent: cyan),
      data-chip([cyan], [partial], accent: cyan),
      data-chip([red], [partial], accent: cyan),
    ),
  ),

  archetype-card(
    [better phosphor blend],
    [High-CRI blue-pump LED],
    high-cri-blue-pump,
    green + 0.95pt,
    green,
    [
      Better cyan and red fill. Still not thermal, still not daylight, but far better spectral coverage than a cheap blue-pump lamp.
    ],
    chips: (
      data-chip([pump], [present], accent: green),
      data-chip([cyan], [better], accent: green),
      data-chip([red], [better], accent: green),
    ),
  ),

  archetype-card(
    [violet-pump strategy],
    [Violet-pump full-spectrum LED],
    violet-pump,
    violet + 0.95pt,
    violet,
    [
      Moves the pump toward violet and rebuilds more of the visible spectrum through phosphors. The goal is less blue-spike dominance and smoother visible coverage.
    ],
    chips: (
      data-chip([pump], [~410 nm], accent: violet),
      data-chip([blue spike], [reduced], accent: violet),
      data-chip([coverage], [broad], accent: violet),
    ),
  ),

  archetype-card(
    [white by mixing],
    [RGB mixed white],
    rgb-white,
    red + 0.95pt,
    red,
    [
      Can land on a white appearance while leaving large gaps between primaries. Useful for color effects, weaker as a general-quality white source.
    ],
    chips: (
      data-chip([channels], [3], accent: red),
      data-chip([gaps], [large], accent: red),
      data-chip([white], [metameric], accent: red),
    ),
  ),
)

#section-rule()

== CCT Is the Headline. SPD Is the Article.

#v(8pt)

Correlated color temperature describes the apparent white point. It does not describe the spectral structure that produced that white point.

#v(12pt)

#grid(
  columns: (0.52fr, 1fr),
  column-gutter: 22pt,
  align: top,

  [
    #fine-label[the label problem]

    #v(8pt)

    #text(size: 21pt, weight: "medium", fill: ink)[
      4000 K is not a spectrum.
    ]

    #v(9pt)

    #text(size: 10pt, fill: soft-ink)[
      Two products can share a CCT label while differing in pump wavelength, cyan energy, red rendering, spectral smoothness, melanopic weighting, and material appearance.
    ]

    #v(12pt)

    #small-note[
      CCT tells you where the white point appears. SPD tells you what wavelengths are actually present.
    ]
  ],

  [
    #table(
      columns: (0.72fr, 1.0fr, 1.45fr),
      inset: (x: 8pt, y: 7pt),
      stroke: none,
      align: top,

      table.header(
        [
          #fine-label[same sales label]
        ],
        [
          #fine-label[hidden variable]
        ],
        [
          #fine-label[what changes]
        ],
      ),

      table.hline(stroke: rule-color + 0.8pt),

      [
        #set text(size: 9pt)
        4000 K
      ],
      [
        #set text(size: 9pt)
        pump wavelength
      ],
      [
        #set text(size: 9pt)
        Blue-pump and violet-pump products can reach similar apparent white points through different spectral construction.
      ],

      table.hline(stroke: hairline + 0.6pt),

      [
        #set text(size: 9pt)
        4000 K
      ],
      [
        #set text(size: 9pt)
        cyan energy
      ],
      [
        #set text(size: 9pt)
        The same CCT can feel visually fresh or dull depending on energy around the blue-green region.
      ],

      table.hline(stroke: hairline + 0.6pt),

      [
        #set text(size: 9pt)
        4000 K
      ],
      [
        #set text(size: 9pt)
        red content
      ],
      [
        #set text(size: 9pt)
        Skin, wood, food, leather, textiles, and warm finishes can look alive or dead under the same label.
      ],

      table.hline(stroke: hairline + 0.6pt),

      [
        #set text(size: 9pt)
        4000 K
      ],
      [
        #set text(size: 9pt)
        spectral smoothness
      ],
      [
        #set text(size: 9pt)
        One lamp can be smooth and broad; another can be spiky and sparse.
      ],

      table.hline(stroke: hairline + 0.6pt),

      [
        #set text(size: 9pt)
        4000 K
      ],
      [
        #set text(size: 9pt)
        melanopic weighting
      ],
      [
        #set text(size: 9pt)
        Biological potency depends on wavelength-weighted energy at the eye, not on the CCT label alone.
      ],
    )
  ],
)

#section-rule()

== A More Useful Spectral Scorecard

#v(8pt)

These are not formal color-science metrics. They are quick visual indices derived from the synthetic curves so the section teaches what to look for.

#v(12pt)

#grid(
  columns: (0.42fr, 1fr),
  column-gutter: 22pt,
  align: top,

  [
    #fine-label[reading the graph]

    #v(8pt)

    #text(size: 18pt, weight: "medium", fill: ink)[
      Look at bands, not just peaks.
    ]

    #v(9pt)

    #text(size: 9.5pt, fill: soft-ink)[
      Cyan tells you about the blue-green region. Red tells you about warm material rendering. Violet/blue tells you how much short-wavelength energy is driving the construction.
    ]

    #v(12pt)

    #small-note[
      These scores are normalized band averages from the illustrative curves, scaled 0–100. They are teaching aids, not measurement results.
    ]
  ],

  [
    #block(
      width: 100%,
      inset: (x: 12pt, y: 11pt),
      radius: 10pt,
      fill: panel,
      stroke: hairline + 0.7pt,
    )[
      #score-strip([Incandescent], incandescent, amber)
      #v(6pt)
      #score-strip([Cheap blue-pump LED], cheap-blue-pump, blue)
      #v(6pt)
      #score-strip([Commodity blue-pump LED], commodity-blue-pump, cyan)
      #v(6pt)
      #score-strip([High-CRI blue-pump LED], high-cri-blue-pump, green)
      #v(6pt)
      #score-strip([Violet-pump LED], violet-pump, violet)
      #v(6pt)
      #score-strip([RGB mixed white], rgb-white, red)
    ]
  ],
)

#section-rule()

== The Practical Design Consequence

#v(8pt)

A lighting specification that stops at CCT is under-specified.

#v(12pt)

#grid(
  columns: (1fr, 1fr, 1fr),
  column-gutter: 12pt,
  row-gutter: 12pt,
  align: top,

  callout-card(
    [do not specify only CCT],
    [
      “3000 K” or “4000 K” describes apparent color temperature. It does not describe spectral quality.
    ],
    accent: red,
  ),

  callout-card(
    [ask for the SPD],
    [
      The spectral power distribution shows the actual wavelength content behind the white appearance.
    ],
    accent: blue,
  ),

  callout-card(
    [connect spectrum to use],
    [
      Rendering, comfort, camera behavior, circadian effect, and architectural atmosphere all depend on spectral distribution.
    ],
    accent: green,
  ),
)

#v(16pt)

#grid(
  columns: (0.35fr, 1fr),
  column-gutter: 20pt,
  align: top,

  [
    #fine-label[minimum evidence]
  ],

  [
    #table(
      columns: (0.55fr, 1.15fr),
      inset: (x: 8pt, y: 7pt),
      stroke: none,
      align: top,

      table.header(
        [
          #fine-label[ask for]
        ],
        [
          #fine-label[why it matters]
        ],
      ),

      table.hline(stroke: rule-color + 0.8pt),

      [
        #set text(size: 9pt)
        SPD graph
      ],
      [
        #set text(size: 9pt)
        Shows pump spikes, cyan gaps, red weakness, spectral smoothness, and full visible coverage.
      ],

      table.hline(stroke: hairline + 0.6pt),

      [
        #set text(size: 9pt)
        TM-30
      ],
      [
        #set text(size: 9pt)
        Better than CRI alone for seeing fidelity, gamut, and hue-specific distortion.
      ],

      table.hline(stroke: hairline + 0.6pt),

      [
        #set text(size: 9pt)
        Flicker data
      ],
      [
        #set text(size: 9pt)
        Spectrum is not the only quality variable. Driver behavior affects comfort, camera performance, and perceived quality.
      ],

      table.hline(stroke: hairline + 0.6pt),

      [
        #set text(size: 9pt)
        Melanopic data
      ],
      [
        #set text(size: 9pt)
        Circadian potency depends on wavelength-weighted light at the eye, not the CCT label.
      ],

      table.hline(stroke: hairline + 0.6pt),

      [
        #set text(size: 9pt)
        Application context
      ],
      [
        #set text(size: 9pt)
        A gallery, kitchen, bedroom, office, bathroom mirror, and circadian system should not be judged by the same single label.
      ],
    )
  ],
)

#v(16pt)

#block-quote[
  White is the appearance. Spectrum is the mechanism.
]

#v(8pt)

#block-quote[
  Do not infer light quality from CCT alone. Specify the spectrum, measure the spectrum, and design around the spectrum.
]

