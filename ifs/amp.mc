# Copyright (c) 2026 MCode. Built with MCode Bench(TM).
# Licensed under the Apache License, Version 2.0.

// AMP - Operational Amplifier Interface Standard Definition
// Core Rule: One inverting input and one non-inverting input sum at a
//            virtual- or real-summing node; the output drives a feedback
//            network that returns to the inverting input. Two inputs
//            converge on the output - they are not a differential pair
//            (a diff pair rejects the common mode; op-amp inputs sum
//            and amplify the difference, with negative feedback shaping
//            the closed-loop gain).
// Device Definition: TRANSMITTER = amplifier output stage,
//                    RECEIVER = amplifier input stage (the inverting
//                    and non-inverting inputs are both RECEIVER - a
//                    summing node, not a measurement pair).

interface AMP(role)
{
    topology = "point to point"
    mode = ["input", "output"]

    // Corpus verdict: the analog-input family is one inverting input
    // and one non-inverting input summing at the amplifier's virtual-
    // ground (or, for single-input buffer variants, the single input
    // drives the output stage). Supply rides the DC faces. Gain /
    // bandwidth / slew rate live as per-part rated-condition tables -
    // the electrical contract is owned by the AMP family recipe; the
    // AMP interface itself states no per-lane rows beyond the pin map.
    //
    // @sum_node hook: a summing node is the same physical net as
    // multiple RECEIVER inputs converging on one TRANSMITTER output
    // (classic op-amp feedback). A consumer component binding the AMP
    // interface may annotate a pin with @sum_node to mark the explicit
    // summing point - the mcc net checker then suppresses the
    // multi-drive diagnostic on that net exactly like the live op-amp
    // feedback case.
    //
    // No .ELEC book: the electrical contract is owned by the AMP
    // family recipe; the AMP interface states no per-lane rows beyond
    // the pin map.

    // The two input rows (IN\+/IN\-) are the non-inverting and inverting
    // inputs of one op-amp; they sum at the amplifier's summing node
    // (or, for AMP.BUFFER, only one input is present and the buffer
    // stage drives OUT). The @class(analog) row attribute is the
    // library-default signal class (same as ADC.SINGLE / ADC.DIFF):
    // an analog signal face even when the amplifier is a precision
    // instrumentation or comparator variant.
    pins = [
        1 = IN\+ @class(analog), "Non-inverting Input"  // Non-inverting (positive) input
        2 = IN\- @class(analog), "Inverting Input"       // Inverting (negative) input
        3 = OUT @class(analog), "Output"                // Amplifier output
    ]

    role TRANSMITTER {  // AMP Transmitter - Amplifier output stage (inherits the view's 3 lanes)
        name = "AMP Transmitter"
        peer = RECEIVER(3)
    }
    role RECEIVER {  // AMP Receiver - Amplifier input stage (inherits the view's 3 lanes)
        name = "AMP Receiver"
        peer = TRANSMITTER(1)
    }
}
