package create

import "core:os"
import "core:fmt"
import "core:slice"
import "core:strings"
import "core:unicode/utf8"
import "core:encoding/json"

folder :: proc(path_slice: ^[]string) {
    folder_name := path_slice[len(path_slice) - 1]
    project_path := strings.concatenate(path_slice^)
    if !os.exists(project_path) {
        err_create_project_folder := os.make_directory(project_path)

        if err_create_project_folder != nil {
            fmt.eprintfln("Folder creation error: %v", err_create_project_folder)
            os.exit(0)
        }

        fmt.printfln("Folder `%s` has been created!", folder_name)
    }
}

main_file :: proc(path_slice: ^[dynamic]string) {
    main_odin_path := strings.concatenate(path_slice[:])
    defer delete(main_odin_path)

    when ODIN_OS == .Linux {
        main_handle, err_main_handle := os.open(main_odin_path, os.O_CREATE | os.O_WRONLY, 0o755)
    } else when ODIN_OS == .Windows {
        main_handle, err_main_handle := os.open(main_odin_path, os.O_CREATE | os.O_WRONLY)
    } else when ODIN_OS == .Darwin {
        fmt.eprintln("It doesn't work for `Darwin` yet!")
    }

    if err_main_handle != nil {
        fmt.eprintfln("Error writing `main.odin` text to file: %v", err_main_handle)
        os.exit(0)
    } else {
        main_to_runes := utf8.string_to_runes(MAIN_ODIN_DATA)

        for r in main_to_runes {
            _, err_main_write := os.write_rune(main_handle, r)

            if err_main_write != nil {
                fmt.eprintfln("Error writing `main.odin` text to file: %v", err_main_write)
                os.exit(0)
            }
        }
        os.flush(main_handle)
        os.close(main_handle)
        fmt.println("`main.odin` has been created!")
    }
}

ols :: proc(path_slice: ^[dynamic]string) {
    ols_path := strings.concatenate(path_slice[:])

    json_data_init, err_m := json.marshal(OLS_INSTANCE)
    defer delete(json_data_init)

    json_data_init_edit, err_p := json.parse(json_data_init)

    if err_p == .None {
        my_map := json_data_init_edit.(json.Object)

        new_key := "$schema"
        old_key := "schema"
        
        if value, ok := my_map[old_key]; ok {
            new_map := json.Object{}
            defer delete(new_map)

            for k, v in my_map {
                if k != old_key {
                    new_map[k] = v
                }
            }
            new_map[new_key] = value
            my_map = new_map

            json_data_final, err_m_f := json.marshal(my_map, {
                pretty = true, use_spaces = true
            })

            err_ols_write := os.write_entire_file_or_err(ols_path, json_data_final)

            if err_ols_write != nil {
                fmt.eprintfln("Error writing `OLS` configuration to file: %v", err_ols_write)
                os.exit(0)
            }

            fmt.println("`OLS` configuration has been created!")
        }
    } else {
        fmt.eprintfln("Parse error: %v", err_p)
        os.exit(0)
    }
}

vscode_config :: proc(path_slice: ^[dynamic]string) {
    vscode_path_slice := slice.clone(path_slice[:])
    vscode_path := strings.concatenate(path_slice[:])
    vscode_launch_path := strings.concatenate({vscode_path, "/", "launch.json"})
    vscode_tasks_path := strings.concatenate({vscode_path, "/", "tasks.json"})

    folder(&vscode_path_slice)

    json_data_launch, _ := json.marshal(VSCODE_LAUNCH_INSTANCE, {
        pretty = true, use_spaces = true
    })
    defer delete(json_data_launch)

    err_launch_write := os.write_entire_file_or_err(vscode_launch_path, json_data_launch)

    if err_launch_write != nil {
        fmt.eprintfln("Error writing `vscode/launch` configuration to file: %v", err_launch_write)
        os.exit(0)
    }

    json_data_tasks, _ := json.marshal(VSCODE_TASKS_INSTANCE, {
        pretty = true, use_spaces = true
    })
    defer delete(json_data_tasks)

    err_tasks_write := os.write_entire_file_or_err(vscode_tasks_path, json_data_tasks)

    if err_tasks_write != nil {
        fmt.eprintfln("Error writing `vscode/tasks` configuration to file: %v", err_tasks_write)
        os.exit(0)
    }

    fmt.println("`VSCode` configuration has been created!")
}