#let _path-theme = (
  text-size: 9pt,
  compact-text-size: 8.5pt,

  accent: rgb("#5f6370"),

  node-fill: rgb("#fafafe"),
  node-stroke: rgb("#d8d8e2"),

  group-fill: rgb("#ffffff"),
  group-stroke: rgb("#c9c9d3"),

  radius: 5pt,

  node-pad: (x: 7pt, y: 4.5pt),
  compact-node-pad: (x: 5pt, y: 3pt),

  group-pad: (x: 8pt, y: 6pt),
  compact-group-pad: (x: 6pt, y: 5pt),

  gap: 5pt,
  compact-gap: 3pt,

  inline-node-width: auto,

  arrow: "→",
  stack-arrow: "↓",
  combine-arrow: "+",
)

#let _path-is-group(node) = {
  type(node) == dictionary and node.keys().contains("steps")
}

#let _path-leaf-count(items) = {
  let count = 0

  for item in items {
    if _path-is-group(item) {
      count += _path-leaf-count(item.steps)
    } else {
      count += 1
    }
  }

  count
}

#let _path-depth(items) = {
  let depth = 1

  for item in items {
    if _path-is-group(item) {
      depth = calc.max(depth, 1 + _path-depth(item.steps))
    }
  }

  depth
}

#let _path-has-groups(items) = {
  for item in items {
    if _path-is-group(item) {
      return true
    }
  }

  false
}

#let _path-mode(items) = {
  let leaves = _path-leaf-count(items)
  let depth = _path-depth(items)

  if depth >= 3 or leaves > 5 {
    "strip"
  } else if _path-has-groups(items) {
    "strip"
  } else {
    "inline"
  }
}

#let _path-config(mode) = {
  let compact = mode == "inline"

  (
    mode: mode,

    text-size: if compact {
      _path-theme.compact-text-size
    } else {
      _path-theme.text-size
    },

    accent: _path-theme.accent,

    node-fill: _path-theme.node-fill,
    node-stroke: _path-theme.node-stroke,

    group-fill: _path-theme.group-fill,
    group-stroke: _path-theme.group-stroke,

    radius: _path-theme.radius,

    node-pad: if compact {
      _path-theme.compact-node-pad
    } else {
      _path-theme.node-pad
    },

    group-pad: if compact {
      _path-theme.compact-group-pad
    } else {
      _path-theme.group-pad
    },

    gap: if compact {
      _path-theme.compact-gap
    } else {
      _path-theme.gap
    },

    node-width: if compact {
      _path-theme.inline-node-width
    } else {
      100%
    },

    arrow: _path-theme.arrow,
    stack-arrow: _path-theme.stack-arrow,
    combine-arrow: _path-theme.combine-arrow,
  )
}

#let _path-title(body, cfg) = [
  #text(
    size: cfg.text-size,
    weight: "bold",
    fill: cfg.accent,
  )[#body]
]

#let _path-mark(value, cfg) = [
  #text(
    size: cfg.text-size,
    fill: cfg.accent,
  )[#value]
]

#let _path-relation-mark(relation, cfg) = {
  if relation == "combine" {
    cfg.combine-arrow
  } else if relation == "stack" {
    cfg.stack-arrow
  } else {
    cfg.arrow
  }
}

#let _path-card(body, cfg, width: auto, grow: false) = box(
  width: if grow { 100% } else { width },
  inset: cfg.node-pad,
  radius: cfg.radius,
  fill: cfg.node-fill,
  stroke: cfg.node-stroke,
)[
  #body
]

#let _path-group-card(title, body, cfg, width: auto, grow: false) = box(
  width: if grow { 100% } else { width },
  inset: cfg.group-pad,
  radius: cfg.radius,
  fill: cfg.group-fill,
  stroke: cfg.group-stroke,
)[
  #if title != none [
    #text(
      size: cfg.text-size,
      weight: "bold",
      fill: cfg.accent,
    )[#title]
    #v(4pt)
  ]

  #body
]

#let _path-node(item, cfg, width: auto, grow: false) = {
  if not _path-is-group(item) {
    _path-card(
      item,
      cfg,
      width: width,
      grow: grow,
    )
  } else {
    let title = item.at("title", default: none)
    let steps = item.steps
    let relation = item.at("relation", default: "stack")
    let mark = _path-relation-mark(relation, cfg)

    let inline-body = relation == "inline" or (
      relation == "combine"
    ) or (
      cfg.mode == "inline" and
      steps.len() <= 2 and
      _path-all-plain(steps)
    )

    let body = if inline-body {
      let cols = ()
      let cells = ()

      for i in range(steps.len()) {
        cols.push(1fr)
        cells.push(align(center + horizon)[
          #_path-node(steps.at(i), cfg, width: 100%, grow: true)
        ])

        if i < steps.len() - 1 {
          cols.push(auto)
          cells.push(align(center + horizon)[
            #_path-mark(mark, cfg)
          ])
        }
      }

      grid(
        columns: cols,
        column-gutter: cfg.gap,
        align: center + horizon,
        ..cells,
      )
    } else {
      block(width: 100%)[
        #for i in range(steps.len()) {
          _path-node(steps.at(i), cfg, width: 100%, grow: true)

          if i < steps.len() - 1 {
            v(cfg.gap)
            align(center)[#_path-mark(mark, cfg)]
            v(cfg.gap)
          }
        }
      ]
    }

    _path-group-card(
      title,
      body,
      cfg,
      width: width,
      grow: grow,
    )
  }
}

#let _path-stack(items, cfg) = {
  block(width: 100%)[
    #for i in range(items.len()) {
      _path-node(items.at(i), cfg, width: 100%, grow: true)

      if i < items.len() - 1 {
        v(cfg.gap)
        align(center)[#_path-mark(cfg.stack-arrow, cfg)]
        v(cfg.gap)
      }
    }
  ]
}

#let _path-inline(items, cfg) = {
  let cols = ()
  let cells = ()

  for i in range(items.len()) {
    cols.push(auto)
    cells.push(align(center + horizon)[
      #_path-node(items.at(i), cfg, width: cfg.node-width)
    ])

    if i < items.len() - 1 {
      cols.push(auto)
      cells.push(align(center + horizon)[
        #_path-mark(cfg.arrow, cfg)
      ])
    }
  }

  grid(
    columns: cols,
    column-gutter: cfg.gap,
    align: center + horizon,
    ..cells,
  )
}

#let _path-strip(items, cfg) = {
  let cols = (1fr, auto, 1fr)
  let cells = ()

  let rows = calc.ceil(items.len() / 2)

  for row in range(rows) {
    let left-index = row * 2
    let right-index = left-index + 1
    let reversed = calc.rem(row, 2) == 1

    let has-left = left-index < items.len()
    let has-right = right-index < items.len()

    if not reversed {
      // left node
      if has-left {
        cells.push(align(center + horizon)[
          #_path-node(items.at(left-index), cfg, width: 100%, grow: true)
        ])
      } else {
        cells.push([])
      }

      // horizontal arrow
      if has-right {
        cells.push(align(center + horizon)[
          #_path-mark(cfg.arrow, cfg)
        ])
      } else {
        cells.push([])
      }

      // right node
      if has-right {
        cells.push(align(center + horizon)[
          #_path-node(items.at(right-index), cfg, width: 100%, grow: true)
        ])
      } else {
        cells.push([])
      }
    } else {
      // right-to-left visual order, but same logical sequence
      if has-right {
        cells.push(align(center + horizon)[
          #_path-node(items.at(right-index), cfg, width: 100%, grow: true)
        ])
      } else {
        cells.push([])
      }

      if has-right {
        cells.push(align(center + horizon)[
          #_path-mark("←", cfg)
        ])
      } else {
        cells.push([])
      }

      if has-left {
        cells.push(align(center + horizon)[
          #_path-node(items.at(left-index), cfg, width: 100%, grow: true)
        ])
      } else {
        cells.push([])
      }
    }

    // vertical connector row between pairs
    if row < rows - 1 {
      if reversed {
        // next step continues from left side
        cells.push(align(center)[#_path-mark(cfg.stack-arrow, cfg)])
        cells.push([])
        cells.push([])
      } else {
        // next step continues from right side
        cells.push([])
        cells.push([])
        cells.push(align(center)[#_path-mark(cfg.stack-arrow, cfg)])
      }
    }
  }

  grid(
    columns: cols,
    column-gutter: cfg.gap,
    row-gutter: cfg.gap,
    align: center + horizon,
    ..cells,
  )
}

#let path(
  steps,
  title: none,
  mode: auto,
  width: 100%,
) = {
  assert(
    type(steps) == array,
    message: "path steps must be an array",
  )

  let resolved-mode = if mode == auto {
    _path-mode(steps)
  } else {
    mode
  }

  assert(
    resolved-mode in ("inline", "strip", "stack"),
    message: "path mode must be auto, inline, strip, or stack",
  )

  let cfg = _path-config(resolved-mode)

  block(width: width)[
    #set text(size: cfg.text-size)

    #if title != none [
      #_path-title(title, cfg)
      #v(3pt)
    ]

    #if resolved-mode == "inline" {
      _path-inline(steps, cfg)
    } else if resolved-mode == "stack" {
      _path-stack(steps, cfg)
    } else {
      _path-strip(steps, cfg)
    }
  ]
}

