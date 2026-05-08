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

#intro-hero-block()
#intro-atx-led-points()


