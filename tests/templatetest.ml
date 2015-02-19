open Template

let dummy_request =
    Request.create Verb.GET "/" "HTTP/1.1" [] ""

let context = Context.make [
    ("name", Context.Var "Phil");
    ("world", Context.Var "World")
]

let test =
    let _assert tmp str =
        let err = (fun a b -> Printf.printf
            "Failed fulfilling template:\n%s\nGot:\n%s\n" a b) in
        Assert.test (templatize tmp context dummy_request) str err in

    _assert
    "Hello, `world`! My name is `name`."
    "Hello, World! My name is Phil.";

    _assert
    "Hello, `world``world`! My name is `name`"
    "Hello, WorldWorld! My name is Phil";

    _assert
    "\\`name\\``name`\\``name`"
    "`name`Phil`Phil";

    ()
