using Documenter
using Inequality

DocMeta.setdocmeta!(Inequality, :DocTestSetup, :(using Inequality); recursive=true)

makedocs(
    sitename = "Inequality.jl",
    format = Documenter.HTML(),
    modules = [Inequality],
    pages = [
		"Introduction" => "index.md",
		"Getting Started" => "gettingstarted.md",
		"Library" => "library.md"]
)

# Documenter can also automatically deploy documentation to gh-pages.
# See "Hosting Documentation" and deploydocs() in the Documenter manual
# for more information.
#=deploydocs(
    repo = "<repository url>"
)=#
deploydocs(
    repo = "github.com/JosepER/Inequality.jl.git"
)