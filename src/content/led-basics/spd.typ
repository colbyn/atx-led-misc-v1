#import "@preview/lilaq:0.6.0" as lq
#import "spectrum-plot.typ": spectrum-plot

#let wl = lq.linspace(380, 780, num: 401)


// ---------------------------------------------
// Numeric helpers
// ---------------------------------------------

#let clamp(x, lo: 0.0, hi: 1.0) = {
  calc.min(hi, calc.max(lo, x))
}

#let gauss(x, center, width, amp: 1.0) = {
  amp * calc.exp(-0.5 * calc.pow((x - center) / width, 2))
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


// ---------------------------------------------
// Blackbody / incandescent approximations
// ---------------------------------------------

#let blackbody(x, temp) = {
  // Relative Planck-like curve.
  // x is wavelength in nm.
  // c2 = h*c/k in nm*K.
  let c2 = 14387768.0

  // Use x / 560 to keep powers numerically tame.
  let xr = x / 560.0
  let e = calc.exp(c2 / (x * temp))

  1.0 / (calc.pow(xr, 5.0) * (e - 1.0))
}

#let spd-candle(x) = {
  // Flame / candle-like: extremely warm, very weak blue.
  blackbody(x, 1850)
}

#let spd-warm-incandescent(x) = {
  // Classic low-watt warm incandescent, roughly 2400–2550 K.
  blackbody(x, 2450)
}

#let spd-household-incandescent(x) = {
  // Standard tungsten incandescent, roughly 2700 K.
  blackbody(x, 2700)
}

#let spd-halogen(x) = {
  // Tungsten-halogen, somewhat higher filament temperature.
  blackbody(x, 3000)
}

#let spd-photoflood-tungsten(x) = {
  // Studio / photoflood tungsten, often around 3200 K.
  blackbody(x, 3200)
}


// ---------------------------------------------
// Daylight reference approximation
// ---------------------------------------------

#let spd-sunlight(x) = {
  // Smooth daylight-ish ground reference.
  // Starts from solar blackbody shape, then adds small atmospheric
  // absorption features so it does not look like a perfect bell curve.
  let base = blackbody(x, 5778)

  let atmospheric = (
    sub-dip(x, 430, 9, depth: 0.035) *
    sub-dip(x, 486, 6, depth: 0.030) *
    sub-dip(x, 517, 8, depth: 0.025) *
    sub-dip(x, 589, 5, depth: 0.040) *
    sub-dip(x, 656, 7, depth: 0.035) *
    sub-dip(x, 760, 10, depth: 0.080)
  )

  base * atmospheric
}


// ---------------------------------------------
// LED approximations: bad -> better
// ---------------------------------------------

#let spd-bad-cool-led(x) = {
  // Cheap / low-CRI cool white blue-pump LED.
  // Strong 450 nm pump, cyan gap, green-yellow phosphor hill,
  // weak deep red.
  (
    gauss(x, 450, 13, amp: 1.15)
    + gauss(x, 555, 48, amp: 0.82)
    + gauss(x, 610, 62, amp: 0.28)
    + gauss(x, 650, 38, amp: 0.08)
  )
}

#let spd-cheap-warm-led(x) = {
  // Cheap warm white LED.
  // Pump still visible, broad yellow/orange phosphor,
  // limited cyan and red rendering.
  (
    gauss(x, 450, 14, amp: 0.60)
    + gauss(x, 565, 62, amp: 1.00)
    + gauss(x, 620, 72, amp: 0.45)
    + gauss(x, 660, 38, amp: 0.10)
  )
}

#let spd-commodity-80cri-led(x) = {
  // Generic 80 CRI LED.
  // Better than the cheap examples, but still a classic blue-pump
  // phosphor shape with a cyan valley and modest red tail.
  (
    gauss(x, 450, 15, amp: 0.55)
    + gauss(x, 535, 58, amp: 0.52)
    + gauss(x, 595, 76, amp: 0.85)
    + gauss(x, 650, 55, amp: 0.22)
  )
}

#let spd-high-cri-blue-pump-led(x) = {
  // High-CRI blue-pump LED.
  // Adds broader phosphor coverage and stronger red component,
  // but still has a visible pump spike and incomplete cyan fill.
  (
    gauss(x, 450, 15, amp: 0.46)
    + gauss(x, 505, 52, amp: 0.34)
    + gauss(x, 560, 72, amp: 0.70)
    + gauss(x, 620, 78, amp: 0.62)
    + gauss(x, 665, 42, amp: 0.30)
  )
}

#let spd-premium-high-cri-led(x) = {
  // Premium high-CRI phosphor-converted LED.
  // Still blue-pump, but smoother, better cyan, better red.
  (
    gauss(x, 450, 16, amp: 0.36)
    + gauss(x, 495, 54, amp: 0.42)
    + gauss(x, 555, 78, amp: 0.68)
    + gauss(x, 620, 82, amp: 0.66)
    + gauss(x, 665, 48, amp: 0.38)
  )
}

#let spd-violet-pump-full-spectrum-led(x) = {
  // Violet-pump / full-spectrum style LED.
  // Violet pump is shifted out of the usual 450 nm blue spike,
  // with broader visible phosphor coverage.
  (
    gauss(x, 410, 13, amp: 0.40)
    + gauss(x, 455, 42, amp: 0.30)
    + gauss(x, 505, 58, amp: 0.48)
    + gauss(x, 565, 82, amp: 0.72)
    + gauss(x, 625, 82, amp: 0.62)
    + gauss(x, 670, 48, amp: 0.34)
  )
}

#let spd-daylight-class-violet-led(x) = {
  // Better daylight-class violet-pump approximation.
  // Intended to look less like a blue-pump LED and more like
  // a broad visible continuum, while still synthetic.
  (
    gauss(x, 410, 13, amp: 0.32)
    + gauss(x, 455, 48, amp: 0.46)
    + gauss(x, 510, 70, amp: 0.66)
    + gauss(x, 575, 88, amp: 0.78)
    + gauss(x, 640, 78, amp: 0.56)
    + gauss(x, 690, 52, amp: 0.25)
  )
}


// ---------------------------------------------
// Data
// ---------------------------------------------

#let sunlight = make-series(spd-sunlight)

#let candle = make-series(spd-candle)
#let warm-incandescent = make-series(spd-warm-incandescent)
#let household-incandescent = make-series(spd-household-incandescent)
#let halogen = make-series(spd-halogen)
#let photoflood-tungsten = make-series(spd-photoflood-tungsten)

#let bad-cool-led = make-series(spd-bad-cool-led)
#let cheap-warm-led = make-series(spd-cheap-warm-led)
#let commodity-80cri-led = make-series(spd-commodity-80cri-led)
#let high-cri-blue-pump-led = make-series(spd-high-cri-blue-pump-led)
#let premium-high-cri-led = make-series(spd-premium-high-cri-led)
#let violet-pump-full-spectrum-led = make-series(spd-violet-pump-full-spectrum-led)
#let daylight-class-violet-led = make-series(spd-daylight-class-violet-led)


// ---------------------------------------------
// Series groups
// ---------------------------------------------

#let sunlight-series = (
  (
    label: [Sunlight reference],
    values: sunlight,
    stroke: rgb("#111111") + 1.1pt,
    draw-area: false,
  ),
)

#let incandescent-series = (
  (
    label: [Candle / flame-like, approx. 1850 K],
    values: candle,
    stroke: rgb("#7a2f00") + 0.9pt,
    draw-area: false,
  ),
  (
    label: [Very warm incandescent, approx. 2450 K],
    values: warm-incandescent,
    stroke: rgb("#9a4c00") + 0.9pt,
    draw-area: false,
  ),
  (
    label: [Household incandescent, approx. 2700 K],
    values: household-incandescent,
    stroke: rgb("#bd6a00") + 0.9pt,
    draw-area: false,
  ),
  (
    label: [Halogen tungsten, approx. 3000 K],
    values: halogen,
    stroke: rgb("#d98a00") + 0.9pt,
    draw-area: false,
  ),
  (
    label: [Studio tungsten, approx. 3200 K],
    values: photoflood-tungsten,
    stroke: rgb("#f0a000") + 0.9pt,
    draw-area: false,
  ),
)

#let led-series = (
  (
    label: [Bad cool LED / low CRI],
    values: bad-cool-led,
    stroke: rgb("#005eff") + 0.9pt,
    draw-area: false,
  ),
  (
    label: [Cheap warm LED],
    values: cheap-warm-led,
    stroke: rgb("#0077cc") + 0.9pt,
    draw-area: false,
  ),
  (
    label: [Commodity 80 CRI LED],
    values: commodity-80cri-led,
    stroke: rgb("#008f9a") + 0.9pt,
    draw-area: false,
  ),
  (
    label: [High-CRI blue-pump LED],
    values: high-cri-blue-pump-led,
    stroke: rgb("#3a9a00") + 0.9pt,
    draw-area: false,
  ),
  (
    label: [Premium high-CRI LED],
    values: premium-high-cri-led,
    stroke: rgb("#7a8f00") + 0.9pt,
    draw-area: false,
  ),
  (
    label: [Violet-pump full-spectrum LED],
    values: violet-pump-full-spectrum-led,
    stroke: rgb("#7a3cff") + 0.9pt,
    draw-area: false,
  ),
  (
    label: [Daylight-class violet-pump LED],
    values: daylight-class-violet-led,
    stroke: rgb("#b000c8") + 0.9pt,
    draw-area: false,
  ),
)

#let comparison-plot(
  lamp,
  title,
  stroke,
  height: 4.8cm,
) = {
  spectrum-plot(
    wl,
    title: title,
    height: height,
    legend-position: "bottom",
    series: (
      (
        label: [Sunlight reference],
        values: sunlight,
        stroke: rgb("#111111") + 1.0pt,
        draw-area: false,
      ),
      (
        label: lamp.label,
        values: lamp.values,
        stroke: stroke,
        draw-area: true,
      ),
    ),
  )
}


// ---------------------------------------------
// Document
// ---------------------------------------------

= SPD Plot Playground

WIP Reference.

== Sunlight reference

#spectrum-plot(
  wl,
  title: [Sunlight reference],
  height: 5.2cm,
  legend-position: "bottom",
  series: sunlight-series,
)

#v(14pt)

== Incandescent and tungsten sources against sunlight

#spectrum-plot(
  wl,
  title: [Incandescent sources: continuous spectra shifted by filament temperature],
  height: 6.2cm,
  legend-position: auto,
  series: sunlight-series + incandescent-series,
)

#v(14pt)

== LEDs from bad to better against sunlight

#spectrum-plot(
  wl,
  title: [LED progression: blue-pump spike, phosphor gaps, then broader full-spectrum coverage],
  height: 6.2cm,
  legend-position: auto,
  series: sunlight-series + led-series,
)

#v(14pt)

== Individual incandescent comparisons

#grid(
  columns: (1fr, 1fr),
  column-gutter: 18pt,
  row-gutter: 18pt,
  align: top,

  [
    #comparison-plot(
      (
        label: [Candle / flame-like, approx. 1850 K],
        values: candle,
      ),
      [Candle / flame-like: continuous but extremely red-heavy],
      rgb("#7a2f00") + 0.9pt,
    )
  ],

  [
    #comparison-plot(
      (
        label: [Very warm incandescent, approx. 2450 K],
        values: warm-incandescent,
      ),
      [Very warm incandescent: weak blue, strong amber-red output],
      rgb("#9a4c00") + 0.9pt,
    )
  ],

  [
    #comparison-plot(
      (
        label: [Household incandescent, approx. 2700 K],
        values: household-incandescent,
      ),
      [Household incandescent: smooth thermal continuum],
      rgb("#bd6a00") + 0.9pt,
    )
  ],

  [
    #comparison-plot(
      (
        label: [Halogen tungsten, approx. 3000 K],
        values: halogen,
      ),
      [Halogen: still warm, but more short-wavelength output],
      rgb("#d98a00") + 0.9pt,
    )
  ],

  [
    #comparison-plot(
      (
        label: [Studio tungsten, approx. 3200 K],
        values: photoflood-tungsten,
      ),
      [Studio tungsten: higher-temperature incandescent reference],
      rgb("#f0a000") + 0.9pt,
    )
  ],
)

#v(14pt)

== Individual LED comparisons

#grid(
  columns: (1fr, 1fr),
  column-gutter: 18pt,
  row-gutter: 18pt,
  align: top,

  [
    #comparison-plot(
      (
        label: [Bad cool LED / low CRI],
        values: bad-cool-led,
      ),
      [Bad cool LED: large pump spike, cyan gap, weak red],
      rgb("#005eff") + 0.9pt,
    )
  ],

  [
    #comparison-plot(
      (
        label: [Cheap warm LED],
        values: cheap-warm-led,
      ),
      [Cheap warm LED: warmer phosphor hump, still spectrally thin],
      rgb("#0077cc") + 0.9pt,
    )
  ],

  [
    #comparison-plot(
      (
        label: [Commodity 80 CRI LED],
        values: commodity-80cri-led,
      ),
      [Commodity 80 CRI LED: acceptable white, incomplete spectrum],
      rgb("#008f9a") + 0.9pt,
    )
  ],

  [
    #comparison-plot(
      (
        label: [High-CRI blue-pump LED],
        values: high-cri-blue-pump-led,
      ),
      [High-CRI blue-pump: better red, but pump signature remains],
      rgb("#3a9a00") + 0.9pt,
    )
  ],

  [
    #comparison-plot(
      (
        label: [Premium high-CRI LED],
        values: premium-high-cri-led,
      ),
      [Premium high-CRI LED: smoother phosphor blend],
      rgb("#7a8f00") + 0.9pt,
    )
  ],

  [
    #comparison-plot(
      (
        label: [Violet-pump full-spectrum LED],
        values: violet-pump-full-spectrum-led,
      ),
      [Violet-pump full-spectrum: less 450 nm dominance],
      rgb("#7a3cff") + 0.9pt,
    )
  ],

  [
    #comparison-plot(
      (
        label: [Daylight-class violet-pump LED],
        values: daylight-class-violet-led,
      ),
      [Daylight-class violet-pump: broadest synthetic LED example],
      rgb("#b000c8") + 0.9pt,
    )
  ],
)
