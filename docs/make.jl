using Fortran
using Documenter

makedocs(;
    modules=[Fortran],
    authors="Stefanos Carlström <stefanos.carlstrom@gmail.com> and contributors",
    repo="https://github.com/jagot/Fortran.jl/blob/{commit}{path}#L{line}",
    sitename="Fortran.jl",
    format=Documenter.HTML(;
        prettyurls=get(ENV, "CI", "false") == "true",
        canonical="https://jagot.github.io/Fortran.jl",
        assets=String[],
    ),
    pages=[
        "Home" => "index.md",
    ],
)

deploydocs(;
    repo="github.com/jagot/Fortran.jl",
)
