#import "panel-based-lighting/panel-layout-view.typ": panel-layout-view

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

#let link-label(src, display) = [
  #let color = rgb("#005eff")
  #set text(weight: 200, fill: color, size: 10pt)
  #box(stroke: 0.25pt + color, inset: (x: 4pt, y: 8pt))[
    #link(src)[#display]
  ]
]

#let display-link(symbol, url) = [
  #let color = rgb("#005eff")

  #grid(
    columns: (auto, 1fr),
    column-gutter: 10pt,
    text(
      weight: 100,
      size: 8pt,
      fill: color,
    )[#symbol],
    text(
      weight: 100,
      size: 8pt,
      fill: color,
    )[#link(url)[#url]],
  )
]

= Panel-based 48 V DC lighting architecture

// == Lighting as cabinet-fed low voltage

#grid(
  columns: (1fr, 1fr),
  column-gutter: 0pt,
  align: top,
  [
    #image(
      "../../assets/page-678.jpg",
      width: 100%,
      height: 3in,
      fit: "contain",
    )
  ],
  [
    #image(
      "../../assets/page-005-007-combined.jpg",
      width: 100%,
      height: 3in,
      fit: "contain",
    )
  ],
)

=== Panel Components

==== AC→DC Power Supply

#grid(
  columns: (1fr, 1fr),
  column-gutter: 10pt,
  align: top,
  [
    #let product-url = "https://atx-led.com/collections/controls-switches/products/atx-led®-structured-media-iec-62368-1-low-voltage-power-supply-96w"
    #let spec-sheet-url = "https://cdn.shopify.com/s/files/1/0897/9608/3996/files/ATX_Cut_Sheet_48-51V_Power_Supply_Rev7_WEB.pdf"

    ===== AL-PS-51V96W
    
    #image(
      "../../assets/products/low-voltage-power-supply-96w/DCPowerSupply.jpg",
      width: 100%,
      height: 2in,
      fit: "contain",
    )

    #spread-row[
      #link-label(product-url)[Product Link #super[†]]
    ][
      #link-label(spec-sheet-url)[Spec Sheet #super[‡]]
    ]

    ATX LED® Structured Media UL1310 Low Voltage Power Supply 96W

    TODO
    
    #display-link("†", product-url)

    #display-link("‡", spec-sheet-url)
  ],
  [
    #let product-url = "https://atx-led.com/collections/controls-switches/products/mean-well™-uhp-500-55-power-supply"
    #let spec-sheet-url = "https://atxled.com/pdf/UHP500.pdf"

    ===== UHP-500-55
    
    #image(
      "../../assets/products/mean-well-uhp-500-55-power-supply/UHP-500-55.jpg",
      width: 100%,
      height: 2in,
      fit: "contain",
    )

    #spread-row[
      #link-label(product-url)[Product Link #super[†]]
    ][
      #link-label(spec-sheet-url)[Spec Sheet #super[‡]]
    ]

    MEAN WELL™ UHP-500-55 Power Supply

    TODO
    
    #display-link("†", product-url)

    #display-link("‡", spec-sheet-url)
  ]
)


==== DC→DC Power Distributors

#grid(
  columns: (1fr, 1fr),
  column-gutter: 10pt,
  align: top,
  [
    #let product-url = "https://atx-led.com/collections/controls-switches/products/atx-led®-al-pse-4d-4-channel-distributor"
    #let spec-sheet-url = "https://cdn.shopify.com/s/files/1/0276/4360/9171/files/ATX_Cut-Sheet_AL-PSE-4D_4-Channel-Distributor_Rev8_WEB.pdf"
    #align(center)[
      ===== 4-Channel Power Distributor
    ]
    
    #image(
      "../../assets/products/4-channel-power-distributor/AL-PSE-4D.jpg",
      width: 100%,
      height: 2in,
      fit: "contain",
    )

    AL-PSE-4D

    #spread-row[
      #link-label(product-url)[Product Link #super[†]]
    ][
      #link-label(spec-sheet-url)[Spec Sheet #super[‡]]
    ]

    TODO
    
    #display-link("†", product-url)

    #display-link("‡", spec-sheet-url)
  ],

  [
    #let product-url = "https://atx-led.com/collections/controls-switches/products/atx-led®-al-pse-8d-8-channel-distributor"
    #let spec-sheet-url = "https://atx-led.com/collections/controls-switches/products/atx-led®-al-pse-8d-8-channel-distributor"
    #align(center)[
      ===== 8-Channel Power Distributor
    ]
    
    #image(
      "../../assets/products/8-Channel-Power-Distributor/AL-PSE-8D.jpg",
      width: 100%,
      height: 2in,
      fit: "contain",
    )

    AL-PSE-8D

    #spread-row[
      #link-label(product-url)[Product Link #super[†]]
    ][
      #link-label(spec-sheet-url)[Spec Sheet #super[‡]]
    ]

    TODO
    
    #display-link("†", product-url)

    #display-link("‡", spec-sheet-url)
  ],
)

==== Example Power Supply and Distributor Setup

#grid(
  columns: (1fr, 1fr),
  column-gutter: 0pt,
  align: top,
  [
    #image(
      "../../assets/page-025.png",
      width: 100%,
      height: 4in,
      fit: "contain",
    )
  ],
  [
    #image(
      "../../assets/page-025-annotated.jpg",
      width: 100%,
      height: 4in,
      fit: "contain",
    )
  ],
)

==== Controllers

#grid(
  columns: (1fr, 1fr),
  column-gutter: 10pt,
  align: top,
  [
    #let product-url = "https://atx-led.com/collections/controls-switches/products/atx-led-hub"
    #let spec-sheet-url = "https://cdn.shopify.com/s/files/1/0897/9608/3996/files/ATX_Cut_Sheet_ATX_LED_Smart_Hub_Rev4_WEB.pdf"
    #align(center)[
      ==== ATX LED HUB (DALI Interface)
    ]
    
    #image(
      "../../assets/products/da-bus-master-system-hub/atx-led-hub.jpg",
      width: 100%,
      height: 2in,
      fit: "contain",
    )

    #spread-row[
      #link-label(product-url)[Product Link #super[†]]
    ][
      #link-label(spec-sheet-url)[Spec Sheet #super[‡]]
    ]

    Da Bus Master System Hub

    TODO
    
    #display-link("†", product-url)

    #display-link("‡", spec-sheet-url)
  ],
)

==== Extras

#grid(
  columns: (1fr, 1fr),
  column-gutter: 10pt,
  align: top,

  [
    #align(center)[
      ===== LAN Network Controller
    ]
    
    #image(
      "../../assets/products/10-port-gigabit-switch/AL-GATS-10-7-1.jpg",
      width: 100%,
      height: 2in,
      fit: "contain",
    )

    #link("https://atx-led.com/collections/controls-switches/products/atx-led-10-port-gigabit-switch-with-8x-poe-802-3at-plus-1-port-injector")[Link]

    TODO
  ],
)
