# mcode

the mcode basic library

MCode is an industrial-grade circuit programming language aimed at precise and
efficient circuit programming. This repository is the standard component and
interface library of the language. It is loaded with `--lib mcode`.

## Repository Layout

```
mcode.mc        library entry point; pub-use aggregates every module below
res.mc          resistors        (RES, RES.SMD, RES.THT, RES.POT, RES.NTC, ...)
cap.mc          capacitors       (CAP, CAP.ELEC, CAP.MLCC, CAP.DISC, CAP.TANT, ...)
ind.mc          inductors        (IND, IND.SMD, IND.POWER, IND.HF, IND.FB, IND.CMC)
dio.mc          diodes           (DIO, DIO.SCH, DIO.ZEN, DIO.TVS, DIO.ESD, DIO.PHOTO)
led.mc          LEDs             (LED, LED.RGB, LED.IR, LED.HP)
xfr.mc          transformers     (XFR, XFR.POWER, XFR.AUDIO, XFR.ISO, XFR.CT)
trans.mc        transistors      (bipolar / FET families)
reg.mc          regulators       (linear / switching)
opto.mc         opto-isolators
relay.mc        relays
fuse.mc         fuses
filter.mc       filters
sensor.mc       sensors
switch.mc       switches
tp.mc           test points
ant.mc          antennas
amp.mc          amplifiers
dc.mc           DC supplies / converters
xtal.mc         crystal oscillators
units.mc        unit system reference (UV.VOLT, UV.AMP, UV.CAP, UV.OHM, ...)
package.mc      package definitions
ifs/            interface definitions (UART.TTL, I2C, SPI, CAN, USB, GPIO, ...)
conn/           connector definitions (HDR_*, circular, audio, video, power)
cp.sh           install script: copies the library to ~/.mcode/mcode
```

One component family per file; the file is named after the family. Each family
file starts with the Apache-2.0 license header, lists the generic component
first, then its `.`-suffixed variants (`RES`, `RES.SMD`, `RES.THT`, ...), and
ends with a `# Usage Examples` comment block showing canonical call sites.

## Component Authoring Rules

These rules unify how every component in the library is written. They are the
contract for adding or editing a component.

### A. Component identity and BOM metadata

Every component logically carries five metadata attributes:

```mc
component CAP.MLCC(cap::UV.CAP, volt::UV.VOLT)
{
    name = "MLCC Capacitor"
    description = "Multilayer Ceramic Capacitor (MLCC), non-polarized"

    pins = [ ... ]
    spec = [ ... ]
}
```

| attribute      | meaning                             | rule                                                                  |
|----------------|-------------------------------------|-----------------------------------------------------------------------|
| `name`         | display label                       | required per variant; the string users see in tools / BOM             |
| `description`  | one-line functional description     | optional; defaults to `name` when absent                              |
| `partno`       | manufacturer part number            | optional; omitted means unassigned (`_`)                              |
| `package`      | footprint / package name            | optional; omitted means unassigned (`_`)                              |
| `manufacturer` | manufacturer name                   | optional; omitted means unassigned (`_`)                              |

`name` and `description` are always written (each variant has a distinct
display name); `description` may be omitted and defaults to the `name` value.
A missing `name` is a lint recommendation, not a syntax error.

The three BOM metadata attributes (`partno`, `package`, `manufacturer`) are
**optional - an omitted attribute means unassigned (`_`)**, exactly as if it
were written `key = _`:

1. The library writes them only when a value is actually known; there is no
   `partno = _` / `package = _` / `manufacturer = _` boilerplate.
2. The consumer (BOM exporter) owns the default: it reads `partno`, `package`,
   `manufacturer` and `description` when present and treats a missing key as
   unassigned. The compiler does not inject default attributes, so there is no
   name collision with a `partno` constructor parameter (used by
   variant-selector components) and no change to `mcc show` / `mcc def`
   output.
3. BOM fields are never constructor parameters and never live inside `spec`;
   they are injected at the call site or defined by the BOM (Decision Record
   1).

Status: the library follows this convention. The mcc BOM exporter does not
consume these attributes yet; wiring them in is a compiler follow-up.

### B. Constructor parameters

The constructor carries **only a few core electrical formals**, so call sites
stay readable:

```mc
component CAP(cap::UV.CAP, volt::UV.VOLT, tol::UV.PERCENT = 10%, diel = CAP.X7R, cons = CAP.MLCC)
```

1. Formal list is short: the electrical parameters that define the part
   (capacitance, voltage, tolerance, dielectric, construction). Everything else
   goes into `spec`.
2. Every electrical formal is unit-typed with the `::UV.UNIT` syntax
   (`UV.VOLT`, `UV.AMP`, `UV.CAP`, `UV.OHM`, `UV.IND`, `UV.WATT`, `UV.PERCENT`,
   `UV.HZ`, `UV.PPM/UV.TEMP`, ...). The unit set is defined in `units.mc`.
3. Optional formals get a default value (`tol::UV.PERCENT = 10%`,
   `channel_count::INT = 4`). Required formals come first; once a default is
   given, later formals must keep defaults.
4. Tolerance defaults carry the plus/minus prefix (in source this is the
   U+00B1 character, written before the magnitude, as in
   `tol::UV.PERCENT = 10%`). The plus/minus marker is a magnitude marker, not
   an arithmetic operator.
5. BOM fields never appear as formals (Rule A).
6. A same-name `func` (e.g. `func GD25Q32E(...)`) declares the actual
   construction arity and overrides class-level params for call sites; the two
   are never mixed (COMPONENT_PARAM_FUNC_CONFLICT).
7. Instances may omit required formals: the instance is still created - a
   missing parameter is silent in dev mode and is reported as a warning
   (E4178 / E5352) only under `mcc check --strict`. Default values are never
   used to mean "unassigned".

### C. `spec` - the electrical parameter table

`spec` is a key-value table holding **all secondary electrical parameters and
operating ratings**:

```mc
spec = [
    capacitance = cap
    voltage = volt
    tolerance = tol
    dielectric = diel
    construction = cons
    polarized = false
    esr = _
    temp_min = _
    temp_max = _
    rohs = _
    derating_note = _
]
```

Rules:

1. One `key = value` entry per line. `spec` is the single electrical parameter
   table of a component; BOM metadata does not live here.
2. Keys are snake_case, full words, unique within the table (duplicates are
   rejected). Prefer the established vocabulary:
   `resistance`, `capacitance`, `inductance`, `voltage` / `voltage_rated`,
   `power_rated`, `tolerance`, `temp_coeff`, `temp_min`, `temp_max`,
   `forward_voltage`, `forward_current`, `zener_voltage`, `breakdown_voltage`,
   `clamping_voltage`, `rated_current`, `sat_current`, `trip_current`,
   `beta_coefficient`, `esr`, `srf`, `impedance`, `test_frequency`,
   `wavelength`, `construction`, `polarized`, `safety_class`, `rohs`,
   `derating_note`.
3. Values reference constructor formals (`capacitance = cap`), literals
   (`polarized = false`, `construction = "SMD"`), enum members
   (`dielectric = CAP.X7R`, `safety_class = SC_NONE`), or `_` for unassigned.
4. `_` marks "not specified" - it is not a fake default value. A component that
   does not know its ESR writes `esr = _`, never `esr = 0`.
5. Shared conventions: `temp_min` / `temp_max` bound the operating range,
   `construction` is a string tag (`"SMD"`, `"THT"`, `"SMD_POWER"`),
   `polarized` is the unified DRC/BOM polarity flag, `rohs` records RoHS
   status, `derating_note` holds derating guidance.
6. Naming semantics are fixed: `rated_current` is the thermal rating,
   `sat_current` is the saturation current (power inductors),
   `test_frequency` is the measurement condition (ferrite beads).
7. A `spec` attribute may be split into `spec.X = ...` or be made conditional
   with `if (param == ...) { spec = [ ... ] }` blocks. Duplicate spec keys are
   still rejected.

### D. `pins` - pin declaration rules

`pins` maps physical pins to logical names. One pin per line; left is the
physical id, right is the logical name. All forms below are used in the
library:

```mc
pins = [
    1 = ANODE, "Anode"                 // named pin with functional description
    1 = 1, "Term 1"                    // numeric name + description
    1 = \+ , "Anode"                   // polarity marker (polarized parts)
    io [1:4] = GPIO[0:3]               // direction prefix + range -> indexed names
    ps 6 = GND                         // power-supply pin
    1:cols = R[1:rows]C[1:cols]        // dynamic ranges from parameters
    1:4 = DC2{VDD, GND}                // bus grouping
    1:2 = UART0::UART.TTL(DCE)         // interface binding with role
]
```

Rules:

1. Physical id is an integer, a range `1:n`, or a list `[7,8]`; ids are unique
   and non-overlapping (overlap is checked).
2. Logical names are the wiring contract used at call sites
   (`R.ANODE`, `U_SENSOR.VCC`). Prefer family conventions: `ANODE`/`CATHODE`,
   `Term 1`/`Term 2`, `W1_IN`/`W1_OUT`, `PRIMARY+`/`SECONDARY-`, `VCC`/`GND`.
3. Polarity / phase markers: `\+` and `\-` mark a polarized or phased terminal
   (`1 = \+ , "Anode"`, `1 = PRIMARY\+`).
4. Direction prefixes (a bare identifier before the range) classify a pin:
   `io`, `in`, `out`, `ps` (power supply). `io [1:4] = GPIO[0:3]` declares a
   4-bit GPIO port.
5. `NC` as a name marks a not-connected pin; a name starting with `_` marks an
   active-low signal.
6. Ranges may be parameter-driven (`1:cols = R[1:rows]C[1:cols]`) and are
   resolved at instantiation time (dynamic pins).
7. Variant-dependent pins are added with `pins += [ ... ]` inside
   `if (param == "...")` blocks; `pins +=` requires a prior `pins =` base.
8. Declare pins in physical order; the declaration order is preserved (it does
   not follow the sorted id table).

### E. `func` - methods and construction

A `func` is a method that wires pins of the instance:

```mc
func Cap(net1, net2)
{
    net1 - this - net2
    return net1, net2
}

func Pullup(net1, vcc)
{
    net1 - this{1}
    this{2} - vcc
    return net1
}

func ColorIndicator(red_control, green_control, blue_control, ground)
{
    red_control - this.RED_ANODE
    green_control - this.GREEN_ANODE
    blue_control - this.BLUE_ANODE
    this.COMMON_CATHODE - ground
    return this
}
```

Rules:

1. A `func` named after the component class is the construction func and
   defines the construction arity (`func GD25Q32E(...)`); otherwise class-level
   params are authoritative. The two never overlap.
2. Inside a func, `this` is the instance. Pins are reached with `this.PIN_NAME`
   or `this{PIN_ID}`; bare pin names also work. A chain `net1 - this - net2`
   is the two-terminal idiom.
3. Connect with `-` / `->`; return the nets you opened so callers can chain or
   reuse (`return net1, net2`). `return this` returns the instance and enables
   method chaining: `D_STATUS.ConnectAnode(A).ConnectCathode(GND)`.
4. Parameters are net names, or interface-typed objects for complex drivers
   (`func Illumination(driver::DC())` - binds `driver.VCC` / `driver.GND`).
5. Two-terminal passives (RES, CAP, IND) all provide `Series(netA, netB)`;
   RES adds `Pullup` / `Pulldown`, CAP and IND share the same `Series` shape.
   Parts with a different topology (RES.POT, IND.CMC, RES.ARRAY) get dedicated
   functions and do not inherit the two-terminal helpers.
6. func params never duplicate component params (COMPONENT_PARAM_FUNC_CONFLICT).
7. A func body may contain `if` / `else` conditions; funcs are pure wiring and
   do not construct other components.
8. Callers must pass exactly as many arguments as the func declares: each
   parameter is a net endpoint that becomes a connection, so a missing or
   excess argument is an error (E4176). `_` is an explicit placeholder that
   counts as an argument (it defers that endpoint); `NC` is valid only in
   `CLASS(NC)` or a constructor argument list - never as a method argument.

### F. Enums for variant selection

Use a scoped `enum` when a family shares a small closed set of selectors:

```mc
enum CAP
{
    C0G, X7R, X7S, X5R,       // dielectric codes
    WET_ALUMINUM, MLCC, FILM, // construction
    SC_NONE, SC_X1, SC_X2,    // safety class
}
```

1. Inside the component the members are bare (`diel = CAP.X7R` default, or
   directly as a formal default); outside they are qualified (`CAP.X7R`).
2. Keep one logical group per enum. If several groups are needed, use
   dedicated enums (`CAP_DIELECTRIC`, `CAP_CONSTRUCTION`, `CAP_SAFETY_CLASS`);
   do not cross-group-assign members.
3. When the set is open or free-form, prefer a plain string tag
   (`construction = "SMD"`, `construction = "THT"`).

## Usage Examples

Every family file ends with a `# Usage Examples` block that is the contract
for the call site:

```mc
# CAP.MLCC(100nF, 50V, 10%).Cap(vcc, gnd)
# RES.SMD(470R, 50V, 0.125W, 5%).Pulldown(enable, gnd)
# IND.POWER(47uH, 3A, 4A, 0.05R).Series(sw, out)
# DIO.SCH(0.3V, 40V, 5A).FastRectifier(high_freq_ac, dc_output)
# RES.POT(10kR, 50V, 0.1W, 20%).VoltageDivider(vcc, fb, gnd)
# R_PULLUP::RES(10000R, 50V).Pullup(BUTTON_IN, V3V3)
```

Keep this block in sync with the constructor signature and the func names; it
is the first thing a user reads to learn how to use the component.

## Loading The Library

```bash
./cp.sh                 # install the library into ~/.mcode/mcode
mcc parse <file>.mc --lib mcode --pass1 --pass2
export MCC_SYSTEM_ROOT="$(cd .. && pwd)"   # point at the repo when hacking locally
```

## Decision Records

### Decision Record 1: Component-Spec Separation

1. Component constructor parameters carry only a few core electrical
   parameters. They do not carry BOM metadata (partno / manufacturer /
   package); such metadata is injected at the call site or defined by the BOM.
2. All secondary electrical parameters live in the `spec[]` dictionary, with
   `_` marking an unassigned entry. BOM metadata (partno / package /
   manufacturer) is top-level and optional (Rule A).
3. Function parameter default values are not used to express "unassigned".
4. Instances may omit core constructor parameters; arguments at an instance
   definition, class, or constructor call are never required to be complete.
   A missing required parameter is silent in dev mode and is reported as a
   warning (E4178 / E5352) only in strict mode (`mcc check --strict`).
   Instance creation is never blocked by missing arguments - circuit topology
   only needs pins; parameter values are supplied later via spec or the BOM.

Rationale: a component can have many parameters; making them all constructor
formals would produce unusable call sites. Keeping only a few core electrical
formals and pushing the rest into `spec[]` / the BOM keeps constructors
readable while the instance is still created when formals are omitted.
