#import "blocks.typ": block-quote
#import "path.typ": path
#import "shift.typ": shift

== Architecture Should Follow the Technology

#v(8pt)

The LED is a low-voltage, current-driven, thermally sensitive semiconductor light source.

#v(6pt)

But most retrofit lamps force it to impersonate a mains-voltage incandescent bulb.

#v(14pt)

#grid(
  columns: (0.38fr, 1fr),
  column-gutter: 20pt,
  align: top,

  [
    #text(size: 12pt, weight: "medium")[
      The retrofit lamp hides the real system.
    ]
  ],

  [
    The AC socket remains. The Edison shape remains. But inside the lamp, the LED still needs rectification, current regulation, heat management, optical control, and spectral design.

    #v(6pt)

    The result is not native LED architecture. It is semiconductor lighting compressed into the assumptions of another technology.
  ],
)

#v(14pt)

#path(
  (
    [mains AC socket],
    (
      title: [miniaturized electronics],
      steps: (
        [tiny hidden rectifier],
        [tiny hidden driver],
      ),
    ),
    (
      title: [thermal constraint],
      steps: (
        [heat-constrained LED package],
        [Edison-shaped product],
      ),
    ),
  ),
  title: [Retrofit compromise],
)

#v(18pt)

#line(length: 100%, stroke: rgb("#d8d8e2"))

#v(14pt)

#grid(
  columns: (0.38fr, 1fr),
  column-gutter: 20pt,
  align: top,

  [
    #text(size: 12pt, weight: "medium")[
      A native architecture separates the layers.
    ]
  ],

  [
    Instead of hiding the electrical interface inside each lamp, the system can expose the real structure: power conversion, low-voltage distribution, control inputs, current regulation, LED engines, optics, and thermal paths.

    #v(6pt)

    This does not mean every LED system must look the same. It means the architecture should begin with what the LED actually is.
  ],
)

#v(14pt)

#path(
  (
    [AC mains],
    (
      title: [power conversion],
      steps: (
        [breaker / branch circuit],
        [centralized AC/DC supply],
        [48 V DC bus],
      ),
    ),
    (
      title: [low-voltage system],
      steps: (
        [power distribution],
        (
          title: [control inputs],
          relation: "combine",
          steps: (
            [sensors],
            [schedules],
            [manual overrides],
          ),
        ),
        [driver commands],
      ),
    ),
    (
      title: [luminaire],
      steps: (
        [constant-current regulation],
        [LED engine],
        [optics / diffuser],
      ),
    ),
  ),
  title: [Native LED architecture],
)

#v(18pt)

#shift(
  from: [How do we hide semiconductor lighting inside old lamp assumptions?],
  to: [How do we design the power, thermal, optical, spectral, and control layers around the LED itself?],
  from-label: [retrofit compromise],
  to-label: [native architecture],
  title: [The chapter claim],
)

