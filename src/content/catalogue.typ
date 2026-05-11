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

#let safe-link(dest, body) = {
  let dest = dest
    .replace("®", "%C2%AE")
    .replace("™", "%E2%84%A2")
    .replace(" ", "%20")

  link(dest)[#body]
}

#let link-label(dest, display) = [
  #let color = rgb("#005eff")
  #set text(weight: 200, fill: color, size: 10pt)

  #safe-link(dest)[
    #box(stroke: 0.25pt + color, inset: (x: 4pt, y: 8pt))[
      #display
    ]
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
      fill: rgb("#5b6069"),
    )[#symbol],
    text(
      weight: 100,
      size: 8pt,
      fill: color,
    )[#safe-link(url)[#url]],
  )
]

#let fallback-links = state("catalogue-fallback-links", ())
#let fallback-link-counter = counter("catalogue-fallback-link-counter")

#let register-fallback-link(url) = [
  #fallback-link-counter.step()
  #fallback-links.update(entries => {
    entries.push(url)
    entries
  })
]

#let catalog-link(url, body) = [
  #fallback-links.update(entries => {
    entries.push(url)
    entries
  })

  #fallback-link-counter.step()

  #context {
    let n = fallback-link-counter.get().first()
    let mark = str(n)

    link-label(url)[
      #body#super(mark, typographic: false)
    ]
  }
]

#let print-fallback-links() = context {
  let entries = fallback-links.get()

  if entries.len() > 0 {
    [
      #v(10pt)
      #line(length: 100%, stroke: 0.35pt + rgb("#d7d7df"))
      #v(5pt)

      #text(
        size: 10pt,
        weight: 500,
        fill: rgb("#898a8d"),
      )[Print links]

      #v(4pt)

      #for i in range(entries.len()) [
        #display-link(str(i + 1), entries.at(i))
      ]
    ]
  }
}

#let catalogue-card(item, image-height: 2in) = [
  #let level = item.at("level", default: 5)

  #align(center)[
    #heading(level: level)[#item.label]
  ]

  #image(
    item.image,
    width: 100%,
    height: image-height,
    fit: "contain",
  )

  #spread-row[
    #catalog-link(item.link)[Product Link]
  ][
    #catalog-link(item.docs)[Spec Sheet]
  ]

  #item.title

  #item.description
]

#let catalogue-grid(
  items,
  columns: (1fr, 1fr),
  image-height: 2in,
  column-gap: 10pt,
  row-gutter: 10pt,
  rule: 0.5pt + rgb("#d7d7df"),
) = {
  let col-count = columns.len()

  grid(
    columns: columns,
    column-gutter: 0pt,
    row-gutter: row-gutter,
    align: top,

    stroke: (x, y) => {
      let is-last-col = calc.rem(x + 1, col-count) == 0

      (
        right: if is-last-col { none } else { rule },
      )
    },

    inset: (x, y) => {
      let is-first-col = x == 0
      let is-last-col = calc.rem(x + 1, col-count) == 0

      (
        left: if is-first-col { 0pt } else { column-gap / 2 },
        right: if is-last-col { 0pt } else { column-gap / 2 },
      )
    },

    ..items.map(catalogue-card.with(image-height: image-height)),
  )
}

= Catalogue

== Panel Components

=== AC→DC Power Supply

#let panel-power-supply-list = (
  (
    link: "https://atx-led.com/collections/controls-switches/products/atx-led®-structured-media-iec-62368-1-low-voltage-power-supply-96w",
    docs: "https://cdn.shopify.com/s/files/1/0897/9608/3996/files/ATX_Cut_Sheet_48-51V_Power_Supply_Rev7_WEB.pdf",
    level: 4,
    label: "AL-PS-51V96W",
    title: "ATX LED® Structured Media UL1310 Low Voltage Power Supply 96W",
    image: "../../assets/products/low-voltage-power-supply-96w/DCPowerSupply.jpg",
    description: [TODO],
  ),
  (
    link: "https://atx-led.com/collections/controls-switches/products/mean-well™-uhp-500-55-power-supply",
    docs: "https://atxled.com/pdf/UHP500.pdf",
    level: 4,
    label: "UHP-500-55",
    title: "MEAN WELL™ UHP-500-55 Power Supply",
    image: "../../assets/products/mean-well-uhp-500-55-power-supply/UHP-500-55.jpg",
    description: [TODO],
  ),
)

#catalogue-grid(panel-power-supply-list)

=== DC→DC Power Distributors

#let panel-power-distributor-list = (
  (
    link: "https://atx-led.com/collections/controls-switches/products/atx-led®-al-pse-4d-4-channel-distributor",
    docs: "https://cdn.shopify.com/s/files/1/0276/4360/9171/files/ATX_Cut-Sheet_AL-PSE-4D_4-Channel-Distributor_Rev8_WEB.pdf",
    level: 4,
    label: "AL-PSE-4D",
    title: "4-Channel Power Distributor",
    image: "../../assets/products/4-channel-power-distributor/AL-PSE-4D.jpg",
    description: [TODO],
  ),
  (
    link: "https://atx-led.com/collections/controls-switches/products/atx-led®-al-pse-8d-8-channel-distributor",
    docs: "https://atx-led.com/collections/controls-switches/products/atx-led®-al-pse-8d-8-channel-distributor",
    level: 4,
    label: "AL-PSE-8D",
    title: "8-Channel Power Distributor",
    image: "../../assets/products/8-Channel-Power-Distributor/AL-PSE-8D.jpg",
    description: [TODO],
  ),
)

#catalogue-grid(panel-power-distributor-list)

=== Central Controllers

#let panel-controller-list = (
  (
    link: "https://atx-led.com/collections/controls-switches/products/atx-led-hub",
    docs: "https://cdn.shopify.com/s/files/1/0897/9608/3996/files/ATX_Cut_Sheet_ATX_LED_Smart_Hub_Rev4_WEB.pdf",
    level: 4,
    label: "ATX LED HUB",
    title: "Da Bus Master System Hub / DALI Interface",
    image: "../../assets/products/da-bus-master-system-hub/atx-led-hub.jpg",
    description: [TODO],
  ),
)

#catalogue-grid(panel-controller-list)

=== Extras

#let panel-extras-list = (
  (
    link: "https://atx-led.com/collections/controls-switches/products/atx-led-10-port-gigabit-switch-with-8x-poe-802-3at-plus-1-port-injector",
    docs: "https://cdn.shopify.com/s/files/1/0897/9608/3996/files/ATX_Cut_Sheet_AL-GATS-10-7_1_10_Port_Gigabit_Switch_Rev7_WEB.pdf",
    level: 4,
    label: "AL-GATS-10-7-1",
    title: "10 Port Gigabit Switch",
    image: "../../assets/products/10-port-gigabit-switch/AL-GATS-10-7-1.jpg",
    description: [TODO],
  ),
)

#catalogue-grid(panel-extras-list)

== Downstream

=== Control Gear

==== Switched CC Drivers

#let switched-cc-drivers-list = (
  (
    link: "https://atx-led.com/collections/atx-led®-dimmers-and-switches/products/atx-led®-al-ws-dr1-local-dimmer-wall-switch-driver",
    docs: "https://cdn.shopify.com/s/files/1/0897/9608/3996/files/ATX_Cut_Sheet_AL-WS-DR1_Local_Dimmer_Wall_Switch_Driver_Rev12_WEB.pdf",
    level: 5,
    label: "AL-WS-DR1",
    title: "AL-WS-DR1 Rocker On/Off Dimmer Switch",
    image: "../../assets/products/AL-WS-DR1.jpg",
    description: [TODO],
  ),
  (
    link: "https://atx-led.com/collections/atx-led®-dimmers-and-switches/products/al-ws-dr2-tunable-white-dimmer-switch",
    docs: "https://cdn.shopify.com/s/files/1/0897/9608/3996/files/ATX_Cut_Sheet_AL-WS-DR2_Tunable_White_Dimmer_Switch_Rev3_WEB.pdf",
    level: 5,
    label: "AL-WS-DR2",
    title: "AL-WS-DR2 Tunable White Dimmer Switch",
    image: "../../assets/products/AL-WS-DR2.jpg",
    description: [TODO],
  ),
)

#catalogue-grid(switched-cc-drivers-list)

==== Others

#let control-gear-others-list = (
  (
    link: "https://atx-led.com/collections/atx-led®-dimmers-and-switches/products/atx-led®-al-ws-m-3-way-switch",
    docs: "https://cdn.shopify.com/s/files/1/0897/9608/3996/files/ATX_Cut_Sheet_AL-WS-M_3_Way_Switch_Rev6_WEB.pdf",
    level: 5,
    label: "AL-WS-M",
    title: "Momentary 3-Way Dimmer Switch",
    image: "../../assets/products/AL-WS-M.jpg",
    description: [TODO],
  ),
  (
    link: "https://atx-led.com/collections/atx-led®-dimmers-and-switches/products/atx-led-al-ws-dali-8b-smart-bus-control",
    docs: "https://cdn.shopify.com/s/files/1/0897/9608/3996/files/ATX_Cut_Sheet_AL-WS-8B_Smart_Bus_Rev2_WEB_9257819d-7440-409a-a6c9-365b64d15db7.pdf",
    level: 5,
    label: "AL-WS-8B-DIY",
    title: "ATX LED® AL-WS-8B Smart Bus (Works with Legrand LVSW-100 Switches)",
    image: "../../assets/products/AL-WS-8B-DIY.other.jpg",
    description: [TODO],
  ),
  (
    link: "https://atx-led.com/collections/controls-switches/products/atx-led®-raspberry-pi-to-dali-co-processor",
    docs: "https://cdn.shopify.com/s/files/1/0897/9608/3996/files/ATX_Cut_Sheet_AL-DA-HAT_Raspberry_Pi_to_DALI_Co-Processor_Rev1_WEB.pdf",
    level: 5,
    label: "AL-DALI-Pi-Hat",
    title: "Raspberry Pi to DALI Co-Processor",
    image: "../../assets/products/AL-DALI-Pi-Hat.jpg",
    description: [TODO],
  ),
)

#catalogue-grid(control-gear-others-list)

=== Luminaires (Light Fixtures)

==== Edison Style Bulbs \& Strips

#let luminaires-edison-bulbs-strips-list = (
  (
    link: "https://atx-led.com/collections/atx-led®-light-bulbs-and-light-strips/products/48v-a19-bulb-with-e26-base",
    docs: "https://cdn.shopify.com/s/files/1/0897/9608/3996/files/ATX_Cut_Sheet_E26-E12_Series_LED_Light_Bulbs_Rev6_WEB.pdf",
    level: 5,
    label: "E26-48v6w-4000K",
    title: "ATX LED® 48V Candelabra E26 Light Bulb",
    image: "../../assets/products/E26-48v6w-4000K.jpg",
    description: [TODO],
  ),
  (
    link: "https://atx-led.com/collections/atx-led®-light-bulbs-and-light-strips/products/atx-led®-g9-lvdc-bulbs-optional-driver",
    docs: "https://cdn.shopify.com/s/files/1/0897/9608/3996/files/ATX_Cut_Sheet_MR16_G9_GU10_LED_Light_Series_Rev3_WEB.pdf",
    level: 5,
    label: "G4-48V4W-2700K",
    title: "G4 & G9 LED Bulbs",
    image: "../../assets/products/G4-48V4W-2700K.jpg",
    description: [TODO],
  ),
  (
    link: "https://atx-led.com/collections/atx-led®-light-bulbs-and-light-strips/products/atx-led®-low-voltage-48vdc-filament-e12-c35-style-led-bulb",
    docs: "https://cdn.shopify.com/s/files/1/0897/9608/3996/files/ATX_Cut_Sheet_E26-E12_Series_LED_Light_Bulbs_Rev6_WEB.pdf",
    level: 5,
    label: "AL-E12-48v3w-2700K-C35",
    title: "ATX LED® 48V Candelabra E12 Light Bulb",
    image: "../../assets/products/AL-E12-48v3w-2700K-C35.jpg",
    description: [TODO],
  ),
  (
    link: "https://atx-led.com/collections/atx-led®-light-bulbs-and-light-strips/products/atx-led®-al-sl-strip-lights",
    docs: "https://cdn.shopify.com/s/files/1/0897/9608/3996/files/ATX_Cut_Sheet_AL-SL-42V_AL-SL-48V_Strip_Lights_Rev6_WEB.pdf",
    level: 5,
    label: "AL-SL-42V1.5w-27/5000K",
    title: "Flexible Strip Lights",
    image: "../../assets/products/AL-SL-42V1.5w-27-5000K.jpg",
    description: [TODO],
  ),
  (
    link: "https://atx-led.com/collections/atx-led®-light-bulbs-and-light-strips/products/atx-led®-gu-10-lvdc-bulbs-optional-driver",
    docs: "https://cdn.shopify.com/s/files/1/0897/9608/3996/files/ATX_Cut_Sheet_MR16_G9_GU10_LED_Light_Series_Rev3_WEB.pdf",
    level: 5,
    label: "AL-GU10-48V5W-3500K",
    title: "GU10 LED Bulb",
    image: "../../assets/products/AL-GU10-48V5W-3500K.jpg",
    description: [TODO],
  ),
  (
    link: "https://atx-led.com/collections/atx-led®-light-bulbs-and-light-strips/products/atx-led®-mr16-lvdc-bulbs-optional-driver",
    docs: "https://cdn.shopify.com/s/files/1/0897/9608/3996/files/ATX_Cut_Sheet_MR16_G9_GU10_LED_Light_Series_Rev3_WEB.pdf?v=1748656812",
    level: 5,
    label: "AL-MR16-48V5W-3500K",
    title: "MR16 LED Bulb",
    image: "../../assets/products/AL-MR16-48V5W-3500K.jpg",
    description: [TODO],
  ),
)

#catalogue-grid(luminaires-edison-bulbs-strips-list, columns: (1fr, 1fr, 1fr), image-height: 1.5in)

==== Downlights

#let luminaires-downlights-list = (
  (
    link: "https://atx-led.com/collections/downlights/products/atx-led-low-voltage-recessed-led-light",
    docs: "https://cdn.shopify.com/s/files/1/0897/9608/3996/files/ATX_Cut_Sheet_DL-120_Recessed_LED_Lights_Rev3_WEB.pdf",
    level: 5,
    label: "DL-120-660MA-27/5000K",
    title: "DL-120 Signature Recessed Downlight",
    image: "../../assets/product-images/DL-120-660MA-27--5000K.jpg",
    description: [TODO],
  ),
  (
    link: "https://atx-led.com/collections/downlights/products/atx-led®-p023r6-4-puck-downlight-constant-current-driver-required",
    docs: "https://atxled.com/pdf/P023R6.pdf",
    level: 5,
    label: "P023R6-660mA-3000K",
    title: "ATX LED® P023R6 4\" Puck Downlight (Constant Current Driver Required)",
    image: "../../assets/product-images/P023R6-660mA-3000K.jpg",
    description: [TODO],
  ),
  (
    link: "https://atx-led.com/collections/downlights/products/atx-led®-p023r6-m-4-motion-sensing-fixture",
    docs: "https://cdn.shopify.com/s/files/1/0897/9608/3996/files/ATX_Cut_Sheet_P023R6_Motion_Sensing_Fixtures_Rev4_WEB.pdf",
    level: 5,
    label: "P023R6-M-52v6w-3000K",
    title: "4\" Motion Sensor Recessed Downlights",
    image: "../../assets/product-images/P023R6-M-52v6w-3000K.jpg",
    description: [TODO],
  ),
  (
    link: "https://atx-led.com/collections/downlights/products/atx-led®-dl-98b-dl-127-recessed-3-gimbal-fixtures-driver-required",
    docs: "https://cdn.shopify.com/s/files/1/0897/9608/3996/files/ATX_Cut_Sheet_DL-98B_DL-125_DL-127_Gimbal_Fixtures_Rev6_WEB.pdf",
    level: 5,
    label: "DL-98B-660MA-27/5000K",
    title: "Gimbal Downlights",
    image: "../../assets/product-images/DL-98B-660MA-27--5000K.jpg",
    description: [TODO],
  ),
  (
    link: "https://atx-led.com/collections/downlights/products/atx-led®-tl-60-trimless-2-inch-fixture",
    docs: "https://cdn.shopify.com/s/files/1/0897/9608/3996/files/ATX_Cut_Sheet_TL-60_TL-120_Recessed_Trimless_Fixtures_Rev6_WEB.pdf",
    level: 5,
    label: "TL-60-RD-M",
    title: "Trimless Downlights",
    image: "../../assets/product-images/TL-60-RD-M.jpg",
    description: [TODO],
  ),
  (
    link: "https://atx-led.com/collections/downlights/products/atx-led®-tl-120-trimless-4-inch-fixture",
    docs: "https://cdn.shopify.com/s/files/1/0897/9608/3996/files/ATX_Cut_Sheet_TL-60_TL-120_Recessed_Trimless_Fixtures_Rev6_WEB.pdf",
    level: 5,
    label: "TL-120-LE+RD",
    title: "ATX LED® TL-120 Trimless 4 inch Fixture",
    image: "../../assets/product-images/TL-120-LE+RD.jpg",
    description: [TODO],
  ),
  (
    link: "https://atx-led.com/collections/downlights/products/atx-led®-p02106-6-puck-downlight-dimmer-required",
    docs: "https://cdn.shopify.com/s/files/1/0897/9608/3996/files/ATX_Cut_Sheet_P02106_6in_Downlights_Rev5_WEB.pdf",
    level: 5,
    label: "P02106-Q2D-27/5000K",
    title: "6\" Recessed Wafer Downlight",
    image: "../../assets/product-images/P02106-Q2D-27--5000K.jpg",
    description: [TODO],
  ),
  (
    link: "https://atx-led.com/collections/downlights/products/atx-led®-p023r11-6-puck-downlight",
    docs: "https://cdn.shopify.com/s/files/1/0897/9608/3996/files/ATX_Cut_Sheet_P023R11_Downlights_Rev7_WEB.pdf",
    level: 5,
    label: "P023R11-1440mA-27/5000K",
    title: "6\" Recessed Wafer Downlights",
    image: "../../assets/product-images/P023R11-1440mA-27--5000K.jpg",
    description: [TODO],
  ),
  (
    link: "https://atx-led.com/collections/downlights/products/4-inch-recessed-wafer-downlights-low-voltage-led",
    docs: "https://cdn.shopify.com/s/files/1/0897/9608/3996/files/ATX_Cut_Sheet_P023R6-S_5_Semi_Flush_Fixtures_Rev4_WEB.pdf",
    level: 5,
    label: "P023R6-51V6W-3000K",
    title: "4\" Recessed Wafer Downlights",
    image: "../../assets/product-images/P023R6-51V6W-3000K.jpg",
    description: [TODO],
  ),
  (
    link: "https://atx-led.com/collections/downlights/products/atx-led®-p023r6-f-5-flush-mount-fixture",
    docs: "https://cdn.shopify.com/s/files/1/0897/9608/3996/files/ATX_Cut_Sheet_P023R6-F_5in_Flush_Mount_Fixtures_Rev3_WEB.pdf",
    level: 5,
    label: "P023R6-F-660MA-3000K",
    title: "5\" Flush Mount Downlight",
    image: "../../assets/product-images/P023R6-F-660MA-3000K.jpg",
    description: [TODO],
  ),
  (
    link: "https://atx-led.com/collections/downlights/products/atx-led®-p023r6-s-5-semi-flush-fixture",
    docs: "https://cdn.shopify.com/s/files/1/0897/9608/3996/files/ATX_Cut_Sheet_P023R6-S_5in_Semi_Flush_Fixture_Rev5_WEB.pdf",
    level: 5,
    label: "P023R6-S-51v6w-3000K",
    title: "5\" Surface Mount Semi-Flush Downlight",
    image: "../../assets/product-images/P023R6-S-51v6w-3000K.jpg",
    description: [TODO],
  ),
)

#catalogue-grid(luminaires-downlights-list, columns: ((1fr, 1fr, 1fr)), image-height: 1.5in)

#print-fallback-links()
