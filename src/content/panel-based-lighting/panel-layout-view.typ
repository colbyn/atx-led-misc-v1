// Panel-based 48 V DC lighting architecture
#let panel-layout-view() = [
  #let ink = rgb("#333336")
  #let muted = rgb("#66666d")
  #let rule = rgb("#d7d7df")

  #let font-size = 12pt

  #let field(label, value) = grid(
    columns: (72pt, 1fr),
    column-gutter: 8pt,
    align: top,

    align(right)[
      #text(
        size: 7.2pt,
        weight: 650,
        tracking: 0.08em,
        fill: muted,
      )[#upper(label)]
    ],

    text(
      size: font-size * 0.86,
      weight: 400,
      fill: ink,
    )[#value],
  )

  #grid(
    columns: (1fr, 1fr),
    column-gutter: 12pt,
    align: top,
    [
      #image(
        "../../../assets/page-678.jpg",
        width: 100%,
        height: 3.65in,
        fit: "contain",
      )
    ],
    [
      #image(
        "../../../assets/page-005-007-combined.jpg",
        width: 100%,
        height: 3.65in,
        fit: "contain",
      )
    ],
  )

  #grid(
    columns: (1fr),
    row-gutter: 10pt,

    field(
      [SHARED CABINET],
      [The cabinet groups the shared parts of the lighting system: DC supply, output modules, control hub, and network-adjacent hardware.]
    ),

    field(
      [AC IN, DC OUT],
      [The cabinet is the transition point: mains power feeds the supply, while downstream lighting leaves as low-voltage DC circuits.]
    ),

    field(
      [LOW-VOLTAGE RUNS],
      [The modules split the shared DC bus into outgoing lighting runs, with the terminations visible at the cabinet.]
    ),

    field(
      [CONTROL BESIDE POWER],
      [The hub and bus wiring sit next to the distribution hardware, making lighting control part of the same cabinet system.]
    ),

    field(
      [POE-ADJACENT],
      [Because the voltage range is close to PoE practice, lighting power can coexist with routers, access points, and other low-voltage network equipment.]
    ),

    field(
      [BACKUP READY],
      [A shared DC supply point makes battery backup or redundant supplies simpler than backing up each fixture individually.]
    ),
  )
]

