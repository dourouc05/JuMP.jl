#  Copyright 2017, Iain Dunning, Joey Huchette, Miles Lubin, and contributors
#  This Source Code Form is subject to the terms of the Mozilla Public
#  License, v. 2.0. If a copy of the MPL was not distributed with this
#  file, You can obtain one at http://mozilla.org/MPL/2.0/.

# This file extends JuMP to allow constraint programming. It allows constraints
# of the form:
#
# @constraint(model, alldifferent(x, y))

function _build_alldifferent_constraint(
    errorf::Function,
    F::AbstractArray{<:AbstractJuMPScalar}
)
    return VectorConstraint(F, MOI.Complements(length(F)))
end

function parse_one_operator_constraint(
    errorf::Function,
    ::Bool,
    ::Val{:alldifferent},
    F
)
    f, parse_code = _MA.rewrite(F)
    return parse_code, :(_build_alldifferent_constraint($errorf, $f))
end
