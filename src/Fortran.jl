module Fortran

using PyCall

const fparser = PyNULL()
const fparser_api = PyNULL()

function __init__()
    copy!(fparser, pyimport_conda("fparser", "fparser", "conda-forge"))
    copy!(fparser_api, pyimport_conda("fparser.api", "fparser", "conda-forge"))
end

fparse(source::String; kwargs...) = fparser_api.parse(source; kwargs...)
fparse(io::IO; kwargs...) = fparse(String(read(io)); kwargs...)

export fparse

end
