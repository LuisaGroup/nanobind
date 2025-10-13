target("nanobind")
add_rules("lc_basic_settings", {
    project_kind = "shared",
    enable_exception = true,
    rtti = true
})
add_includedirs("include", "ext/robin_map/include", {
    public = true
})
add_files("src/nb_combined.cpp")
on_load(function(target)
    local function split_str(str, chr, func)
        local kv = str:split(chr, {
            plain = true
        })
        for _, v in ipairs(kv) do
            func(v)
        end
    end
    local lc_py_include = get_config("lc_py_include")
    local lc_py_linkdir = get_config("lc_py_linkdir")
    local lc_py_libs = get_config("lc_py_libs")
    if (not lc_py_include) or (not lc_py_linkdir) or (not lc_py_libs) then
        utils.error("Python not found, nanobind disabled.")
        target:set("enabled", false)
        return
    end
    split_str(lc_py_include, ';', function(v)
        target:add("includedirs", v, {
            public = true
        })
    end)
    if type(lc_py_linkdir) == "string" then
        split_str(lc_py_linkdir, ';', function(v)
            target:add("linkdirs", v, {
                public = true
            })
        end)
    end
    if type(lc_py_libs) == "string" then
        split_str(lc_py_libs, ';', function(v)
            target:add("links", v, {
                public = true
            })
        end)
    end
    target:add("defines", "NB_SHARED", {
        public = true
    })
    target:add("defines", "NB_BUILD")
    target:add("deps", "lc-core")
end)
target_end()

if enable_nanobind_tests then
    function create_nanobind_test(name)
        target(name .. "_ext")
        set_extension(".pyd")
        add_rules("lc_basic_settings", {
            project_kind = "shared",
            enable_exception = true,
            rtti = true
        })
        add_deps("nanobind", "nanobind_test_common")
        add_files("tests/" .. name .. ".cpp")
        target_end()
    end
    target("nanobind_test_common")
    add_rules("lc_basic_settings", {
        project_kind = "shared",
        enable_exception = true,
        rtti = true
    })
    add_defines("SHARED_BUILD")
    add_deps("nanobind")
    add_files("tests/inter_module.cpp")
    target_end()
    create_nanobind_test("test_accessor")
    create_nanobind_test("test_callbacks")
    create_nanobind_test("test_chrono")
    create_nanobind_test("test_classes")
    create_nanobind_test("test_enum")
    create_nanobind_test("test_eval")
    create_nanobind_test("test_exception")
    create_nanobind_test("test_functions")
    create_nanobind_test("test_holders")
    create_nanobind_test("test_inter_module_1")
    create_nanobind_test("test_inter_module_2")
    create_nanobind_test("test_issue")
    create_nanobind_test("test_jax")
    create_nanobind_test("test_make_iterator")
    create_nanobind_test("test_ndarray")
    create_nanobind_test("test_stl")
    create_nanobind_test("test_stl_bind_map")
    create_nanobind_test("test_stl_bind_vector")
    create_nanobind_test("test_thread")
    create_nanobind_test("test_typing")
end
