// ---- Colors ----

#let primary-color-text = rgb("#444446")
#let primary-color-text-lighter = rgb("#68686f")
#let primary-color-border = rgb("#acacb5")
// #let primary-color-soft = rgb("#f7f7f8")

// ---- Font families ----

#let font-title = "Bodoni 72 Smallcaps"
#let font-title-normal = "Bodoni 72"
#let font-heading = "Hoefler Text"
#let font-subtitle = "Avenir Next"
#let font-body = "Avenir Next"
#let font-meta = "Avenir Next"

// ---- Typesetting ----

#let paragraph-spacing = 12pt

// ---- Local text helpers ----

#let meta-text(body) = text(
  font: font-meta,
  size: 20pt,
  weight: 100,
  fill: primary-color-text,
)[#body]

#let label-pill(body) = box(
  stroke: 0.25pt + primary-color-border,
  inset: (x: 0.2in, y: 0.13in),
)[
  #text(
    font: font-meta,
    size: 12pt,
    weight: 400,
    fill: primary-color-text,
  )[#body]
]

#let label-tag(body) = box(
  stroke: (
    top: 0.25pt + primary-color-border,
    bottom: 0.25pt + primary-color-border,
  ),
  inset: (x: 0.2in, y: 0.13in),
)[
  #text(
    font: font-meta,
    size: 12pt,
    weight: 400,
    fill: primary-color-text,
  )[#body]
]

#let spread-row(transform: x => x, ..items) = {
  let children = items.pos()
  let count = children.len()

  let cols = ()
  let cells = ()

  for i in range(count) {
    cols.push(auto)
    cells.push(transform(children.at(i)))

    if i < count - 1 {
      cols.push(1fr)
      cells.push([])
    }
  }

  block(width: 100%)[
    #grid(
      columns: cols,
      gutter: 0pt,
      ..cells,
    )
  ]
}

#let title-block() = box(
  width: 100%,
  stroke: (
    top: 0.25pt + primary-color-border,
    bottom: 0.25pt + primary-color-border,
  ),
  inset: (x: 20pt, y: 20pt),
)[
  #align(center)[
    #stack(
      dir: ttb,
      spacing: paragraph-spacing,

      text(
        font: font-title,
        size: 76pt,
        weight: 900,
        fill: primary-color-text,
      )[On ATX-LED],
    )
  ]
]

#let note-block(body) = box(
  width: 100%,
  stroke: (
    // top: 0.25pt + primary-color-border,
    // bottom: 0.25pt + primary-color-border,
    left: 0.25pt + primary-color-border,
    // right: 0.25pt + primary-color-border,
  ),
  inset: (
    top: 10pt,
    bottom: 10pt,
    left: 10pt,
  )
)[
  #set par(
    leading: 0.72em,
    justify: true,
  )
  #text(
    font: font-body,
    size: 12pt,
    weight: 400,
    fill: primary-color-text-lighter,
  )[#body]
]

// ---- Exported block ----

#let intro-hero-block() = [
  #set text(
    font: font-body,
    size: 10.5pt,
    fill: primary-color-text,
  )

  #set par(
    spacing: paragraph-spacing,
    leading: 0.68em,
    justify: true,
  )

  #spread-row[
    #align(left)[
      #text(
        font: font-title,
        size: 30pt,
        weight: 500,
        fill: primary-color-text,
      )[Colbyn Wadman,]
    ]
  ][
    #align(right)[
      #text(
        font: font-meta,
        size: 20pt,
        weight: 100,
        fill: primary-color-text,
      )[Salt Lake City, UT]
    ]
  ]

  #title-block()

  #spread-row(
    transform: x => label-pill(x),
  )[
    #link("mailto:email@example.com")[email\@example.com]
  ][
    #link("https://example.com")[example.com]
  ]

  #text(
    size: 18pt,
    weight: 400,
    font: font-title-normal,
    fill: primary-color-text,
  )[Brief]

  #note-block[
    ATX LED is a panel-based 48 V DC lighting architecture for homes. It converts AC once, distributes Class 2 power from a central enclosure, drives LED loads without a tiny AC driver at every lamp, and uses the higher DC bus voltage to reduce current, voltage drop, wire size, and copper demand.
  ]
]

