#let _shift-theme = (
  text-size: 10pt,
  label-size: 8pt,

  accent: rgb("#5f6370"),

  from-fill: rgb("#fffafa"),
  from-stroke: rgb("#ded4d4"),

  to-fill: rgb("#f8fbff"),
  to-stroke: rgb("#cfd8e6"),

  radius: 6pt,
  pad: (x: 9pt, y: 7pt),
  gap: 8pt,
  body-gap: 4pt,

  arrow: "→",
)

#let _shift-title(body, cfg) = [
  #text(
    size: cfg.text-size,
    weight: "bold",
    fill: cfg.accent,
  )[#body]
]

#let _shift-label(body, cfg) = [
  #text(
    size: cfg.label-size,
    weight: "bold",
    fill: cfg.accent,
  )[#body]
]

#let _shift-arrow(cfg) = [
  #text(
    size: 13pt,
    weight: "bold",
    fill: cfg.accent,
  )[#cfg.arrow]
]

#let _shift-card-body(label, body, cfg, fill-height: false) = {
  if fill-height {
    block(width: 100%, height: 100%)[
      #grid(
        columns: (1fr,),
        rows: (auto, 1fr),
        row-gutter: cfg.body-gap,
        align: left,

        [
          #_shift-label(label, cfg)
        ],

        align(center + horizon)[
          #set text(size: cfg.text-size)
          #quote[
            #body
          ]
        ],
      )
    ]
  } else {
    [
      #_shift-label(label, cfg)
      #v(cfg.body-gap)

      #set text(size: cfg.text-size)

      #align(center)[
        #quote[
          #body
        ]
      ]
    ]
  }
}

#let _shift-card(
  label,
  body,
  cfg,
  fill,
  stroke,
  width: 100%,
  height: auto,
) = box(
  width: width,
  height: height,
  inset: cfg.pad,
  radius: cfg.radius,
  fill: fill,
  stroke: stroke,
)[
  #_shift-card-body(
    label,
    body,
    cfg,
    fill-height: height != auto,
  )
]

#let shift(
  from: none,
  to: none,
  from-label: [old frame],
  to-label: [better frame],
  title: none,
  width: 100%,
) = {
  assert(from != none, message: "shift requires a `from` value")
  assert(to != none, message: "shift requires a `to` value")

  let cfg = _shift-theme

  block(width: width)[
    #if title != none [
      #_shift-title(title, cfg)
      #v(4pt)
    ]

    #layout(size => {
      let arrow = align(center + horizon)[
        #_shift-arrow(cfg)
      ]

      let arrow-width = measure(arrow).width
      let card-width = (size.width - arrow-width - 2 * cfg.gap) / 2

      let from-card = _shift-card(
        from-label,
        from,
        cfg,
        cfg.from-fill,
        cfg.from-stroke,
        width: card-width,
      )

      let to-card = _shift-card(
        to-label,
        to,
        cfg,
        cfg.to-fill,
        cfg.to-stroke,
        width: card-width,
      )

      let card-height = calc.max(
        measure(from-card).height,
        measure(to-card).height,
      )

      grid(
        columns: (card-width, arrow-width, card-width),
        column-gutter: cfg.gap,
        align: horizon,

        _shift-card(
          from-label,
          from,
          cfg,
          cfg.from-fill,
          cfg.from-stroke,
          width: card-width,
          height: card-height,
        ),

        align(center + horizon)[
          #_shift-arrow(cfg)
        ],

        _shift-card(
          to-label,
          to,
          cfg,
          cfg.to-fill,
          cfg.to-stroke,
          width: card-width,
          height: card-height,
        ),
      )
    })
  ]
}

