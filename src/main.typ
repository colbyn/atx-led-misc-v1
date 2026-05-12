// #import "../styles/theme.typ": *
#import "blocks/intro-hero.typ": intro-hero-block
#import "blocks/intro-points.typ": intro-atx-led-points

#set document(
  title: "On Lighting",
  author: "Colbyn Wadman",
)

#set page(
  paper: "us-letter",
  margin: (
    top: 0.5in,
    bottom: 0.5in,
    left: 0.5in,
    right: 0.5in,
  ),
  fill: white,
)

// -----------------------------------------------------------------------------
// Typography
// -----------------------------------------------------------------------------

#let ink = rgb("#343437")
#let muted = rgb("#66666d")
#let faint = rgb("#85858c")

#let serif = "Bodoni 72"
#let sans = "Avenir Next"

// Body text

#set text(
  font: sans,
  size: 12pt,
  weight: 400,
  fill: ink,
)

#set par(
  leading: 0.78em,
  justify: true,
)

// Headings

#let heading-block(
  above: 0.8em,
  below: 0.45em,
  font: "Bodoni 72",
  size: 16pt,
  weight: 500,
  tracking: 0pt,
  fill: rgb("#444446"),
  body,
) = block(
  above: above,
  below: below,
)[
  #set text(
    font: font,
    size: size,
    weight: weight,
    tracking: tracking,
    fill: fill,
  )

  #set par(
    leading: 0.95em,
  )

  #body
]

#show heading.where(level: 1): it => heading-block(
  below: 0.75em,
  size: 31pt,
  weight: 700,
  fill: rgb("#343437"),
  it.body,
)

#show heading.where(level: 2): it => heading-block(
  above: 1.0em,
  below: 0.6em,
  size: 23pt,
  weight: 600,
  fill: rgb("#404044"),
  it.body,
)

#show heading.where(level: 3): it => heading-block(
  above: 0.85em,
  below: 0.5em,
  size: 16pt,
  weight: 500,
  fill: rgb("#55555b"),
  it.body,
)

#show heading.where(level: 4): it => heading-block(
  above: 0.75em,
  below: 0.35em,
  font: "Avenir Next",
  size: 10.5pt,
  weight: 700,
  tracking: 0.035em,
  fill: rgb("#505057"),
  smallcaps(it.body),
)

#show heading.where(level: 5): it => heading-block(
  above: 0.6em,
  below: 0.25em,
  font: "Avenir Next",
  size: 8.6pt,
  weight: 700,
  tracking: 0.08em,
  fill: rgb("#66666d"),
  smallcaps(it.body),
)

#show heading.where(level: 6): it => heading-block(
  above: 0.45em,
  below: 0.2em,
  font: "Avenir Next",
  size: 7.8pt,
  weight: 600,
  tracking: 0.09em,
  fill: rgb("#85858c"),
  smallcaps(it.body),
)

#intro-hero-block()
#intro-atx-led-points()
#pagebreak()

#include "content.typ"

