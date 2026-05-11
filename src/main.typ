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

#show heading.where(level: 1): set text(
  font: "Bodoni 72",
  size: 30pt,
  weight: 700,
  fill: rgb("#333336"),
)

#show heading.where(level: 2): set text(
  font: "Bodoni 72",
  size: 24pt,
  weight: 600,
  fill: rgb("#444446"),
)

#show heading.where(level: 3): set text(
  font: "Bodoni 72",
  size: 20pt,
  weight: 500,
  tracking: 0.04em,
  fill: rgb("#66666d"),
)

#show heading.where(level: 4): set text(
  font: "Bodoni 72",
  size: 16pt,
  weight: 300,
  tracking: 0.04em,
  fill: rgb("#66666d"),
)

#show heading.where(level: 5): set text(
  font: "Bodoni 72",
  size: 12pt,
  weight: 300,
  tracking: 0.04em,
  fill: rgb("#66666d"),
)

#show heading.where(level: 6): set text(
  font: "Bodoni 72",
  size: 10pt,
  weight: 200,
  tracking: 0.04em,
  fill: rgb("#66666d"),
)

#set text(
  font: "Avenir Next",
  fill: rgb("#444446"),
  size: 10pt,
)

#set par(
  leading: 0.72em,
  justify: true,
)

#intro-hero-block()
#intro-atx-led-points()
#pagebreak()

#include "content.typ"

