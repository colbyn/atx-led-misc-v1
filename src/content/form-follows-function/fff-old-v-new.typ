#let form-follows-function-comparison() = {
  // ---- Colors ---------------------------------------------------------------

  let primary-color-text = rgb("#444446")
  let primary-color-text-lighter = rgb("#68686f")
  let primary-color-border = rgb("#acacb5")

  let accent = rgb("#ff009d")
  let border-stroke = rgb("#77777d")
  let new-color = accent

  // ---- Fonts ----------------------------------------------------------------

  let font-title = "Bodoni 72 Smallcaps"
  let font-title-normal = "Bodoni 72"
  let font-body = "Avenir Next"
  let font-meta = "Avenir Next"

  // ---- Sizing ---------------------------------------------------------------

  let stroke-width = 0.25pt
  let emphasis-stroke-width = 0.55pt

  let size-heading = 21pt
  let size-visual-title = 16pt
  let size-visual-body = 10.5pt
  let size-row-body = 10.4pt
  let size-label = 8.7pt
  let size-credit = 7pt
  let size-arrow-small = 15pt
  let size-arrow-large = 22pt

  let leading-body = 0.78em
  let leading-compact = 0.72em

  // ---- Fixed editorial geometry --------------------------------------------

  let image-stage-height = 1.75in
  let text-meta-height = 12pt
  let text-title-height = 21pt
  let text-body-height = 34pt

  // Shared three-column comparison geometry.
  //
  // Both the visual comparison and the table-like rows use the same
  // left | middle | right column system.
  let compare-mid-width = 76pt
  let compare-gutter = 14pt
  let compare-columns = (1fr, compare-mid-width, 1fr)

  // ---- Helpers --------------------------------------------------------------

  let meta-label(body, fill-color: primary-color-text-lighter) = text(
    font: font-meta,
    size: size-label,
    weight: 500,
    tracking: 0.045em,
    fill: fill-color,
  )[#upper(body)]

  let section-heading(body) = text(
    font: font-title-normal,
    size: size-heading,
    weight: 400,
    fill: primary-color-text,
  )[#body]

  let arrow-mark(size: size-arrow-large) = text(
    font: font-body,
    size: size,
    weight: 400,
    fill: accent,
  )[$arrow.r$]

  let rotated-credit(body, side: "left") = {
    let x-offset-delta = 20pt
    let x-offset = if side == "left" {
      (x-offset-delta + 10pt) * -1
    } else {
      100% + x-offset-delta
    }

    place(
      top + left,
      dx: x-offset,
      dy: 0pt,
      rotate(
        -90deg,
        reflow: true,
      )[
        #align(center)[
          #text(
            font: font-body,
            size: size-credit,
            weight: 400,
            fill: primary-color-text-lighter.lighten(18%),
          )[#body]
        ]
      ],
    )
  }

  let normalized-image(path, credit: none, credit-side: "left") = box(
    width: 100%,
    height: image-stage-height,
    fill: white,
    inset: 0pt,
  )[
    // This is the actual image layout.
    // The credit is overlayed separately and does not affect this box.
    #align(center + horizon)[
      #box(inset: 10pt)[
        #image(
          path,
          width: 100%,
          height: 100%,
          fit: "contain",
        )
      ]
    ]

    // Marginal credit: visually attached, layout-neutral.
    #if credit != none {
      rotated-credit(credit, side: credit-side)
    }
  ]

  let visual-column(
    image-path,
    label,
    title,
    description,
    color: primary-color-text-lighter,
    credit: none,
    credit-side: "left",
  ) = box(
    width: 100%,
  )[
    #grid(
      rows: (image-stage-height, auto),
      row-gutter: 4pt,
      align: top,

      // Image stage.
      box(
        width: 100%,
        stroke: (top: stroke-width + color),
        inset: (
          top: 9pt,
          x: 8pt,
          bottom: 0pt,
        ),
      )[
        #normalized-image(
          image-path,
          credit: credit,
          credit-side: credit-side,
        )
      ],

      // Text architecture.
      box(
        width: 100%,
        stroke: (top: stroke-width + primary-color-border),
        inset: (
          top: 8pt,
          right: 4pt,
        ),
      )[
        #grid(
          rows: (
            text-meta-height,
            text-title-height,
            text-body-height,
          ),
          row-gutter: 4pt,
          align: top,

          box(height: text-meta-height)[
            #align(left + top)[
              #meta-label(label, fill-color: color)
            ]
          ],

          box(height: text-title-height)[
            #align(left + top)[
              #text(
                font: font-body,
                size: size-visual-title,
                weight: 500,
                fill: color,
              )[#title]
            ]
          ],

          box(width: 100%)[
            #set par(
              leading: leading-body,
              justify: true,
            )

            #text(
              font: font-body,
              size: size-visual-body,
              weight: 400,
              fill: primary-color-text-lighter,
            )[#description]
          ],
        )
      ],
    )
  ]

  let lead-cell(lead, detail, side: "old", emphasis: false) = {
    let lead-color = if side == "new" {
      new-color
    } else {
      border-stroke
    }

    let detail-color = if emphasis and side == "new" {
      primary-color-text
    } else {
      primary-color-text-lighter
    }

    box(
      width: 100%,
      inset: (
        top: 5pt,
        bottom: 5pt,
      ),
    )[
      #set par(
        leading: leading-compact,
        justify: false,
      )

      #text(
        font: font-body,
        size: size-row-body,
        weight: 600,
        fill: lead-color,
      )[#lead]

      #text(
        font: font-body,
        size: size-row-body,
        weight: 400,
        fill: detail-color,
      )[ #detail]
    ]
  }

  let comparison-row(
    label,
    old-lead,
    old-detail,
    new-lead,
    new-detail,
    emphasis: false,
  ) = {
    let row-rule-color = if emphasis {
      accent
    } else {
      primary-color-border
    }

    let row-rule-width = if emphasis {
      emphasis-stroke-width
    } else {
      stroke-width
    }

    box(
      width: 100%,
      stroke: (
        top: row-rule-width + row-rule-color,
      ),
      inset: (
        top: 4pt,
        bottom: 4pt,
      ),
    )[
      #grid(
        columns: compare-columns,
        column-gutter: compare-gutter,
        align: top,

        lead-cell(
          old-lead,
          old-detail,
          side: "old",
          emphasis: false,
        ),

        box(
          width: 100%,
          inset: (
            top: 6pt,
          ),
        )[
          #align(center)[
            #meta-label(
              label,
              fill-color: if emphasis {
                accent
              } else {
                primary-color-text-lighter
              },
            )
          ]
        ],

        lead-cell(
          new-lead,
          new-detail,
          side: "new",
          emphasis: emphasis,
        ),
      )
    ]
  }

  // ---- Block ----------------------------------------------------------------

  block(width: 100%)[
    #set text(
      font: font-body,
      size: 10.5pt,
      fill: primary-color-text,
    )

    #set par(
      leading: leading-body,
      justify: true,
    )

    #stack(
      spacing: 12pt,

      // Visual comparison.
      //
      // Same left | middle | right geometry as the comparison rows.
      // The arrow is centered inside the shared middle lane.
      grid(
        columns: compare-columns,
        column-gutter: compare-gutter,
        align: top,

        visual-column(
          "../../../assets/incandescent-E27-screw-base.jpg",
          [voltage-fed resistor],
          [Incandescent lamp],
          [
            A filament is a hot resistor. Feed it rated mains voltage and its own heat pushes it toward a stable operating point.
          ],
          color: border-stroke,
          credit: [E27 incandescent lamp / Wikimedia Commons],
          credit-side: "left",
        ),

        box(
          width: 100%,
          height: image-stage-height,
          inset: (top: 9pt),
        )[
          #align(center + horizon)[
            #arrow-mark(size: size-arrow-large)
          ]
        ],

        visual-column(
          "../../../assets/seoulsemicon-acrich-module.png",
          [current-driven semiconductor],
          [Solid-state light engine],
          [
            An LED junction can run away. Heat lowers forward voltage, current rises, more heat follows. The driver must break the loop.
          ],
          color: border-stroke,
          credit: [LED module / Seoul Semiconductor],
          credit-side: "right",
        ),
      ),

      // Comparison rows.
      stack(
        spacing: 0pt,

                comparison-row(
          [Electrical model],
          [Resistive load.],
          [Current is naturally limited by the filament’s rising hot resistance.],
          [Semiconductor junction.],
          [Current rises steeply; small voltage shifts can become large current changes.],
          emphasis: true,
        ),

        comparison-row(
          [Supply method],
          [Voltage-fed.],
          [The lamp is designed to sit directly across rated mains voltage.],
          [Current-regulated.],
          [The LED needs a driver that sets and limits current.],
          emphasis: true,
        ),

        comparison-row(
          [Self-stability],
          [Self-limiting.],
          [Heat increases resistance, which damps runaway current.],
          [Runaway-prone.],
          [Heat lowers forward voltage, so current can climb unless actively controlled.],
          emphasis: true,
        ),

        comparison-row(
          [Heat],
          [Heat is the source.],
          [The lamp makes light by running a filament white-hot.],
          [Heat is the constraint.],
          [Junction temperature governs output, color, lifetime, and failure.],
          emphasis: true,
        ),

        comparison-row(
          [Dimming],
          [Chop the waveform.],
          [The filament averages rough AC dimming into heat and glow.],
          [Command the driver.],
          [Good LED dimming belongs in current control, PWM strategy, or driver logic.],
        ),

        comparison-row(
          [Architecture],
          [Mains everywhere.],
          [Each socket gets AC because the lamp is the complete load.],
          [Conversion upstream.],
          [Convert AC once, then distribute low-voltage DC to light engines.],
          emphasis: true,
        ),

        comparison-row(
          [Form follows function],
          [Bulb form was logical.],
          [Glass bulb, filament, socket, and mains circuit were one coherent system.],
          [Bulb mimicry is incoherent.],
          [A semiconductor light engine should not masquerade as a hot resistor.],
          emphasis: true,
        ),
      ),
    )
  ]
}
