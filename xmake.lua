BuildProject({
    projectName = "nanobind",
    projectType = "shared"
})
add_linkdirs("../python/libs")
add_links("python3", "python310")
add_includedirs("include", "ext/robin_map/include", "../python/include", {public = true})
add_files("src/**.cpp")
add_defines("NB_SHARED", {public = true})
add_defines("NB_BUILD")