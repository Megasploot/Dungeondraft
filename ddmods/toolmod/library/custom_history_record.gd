extends Reference

# example structure, you do not need this state var
var state = { "test": false }

func undo():
    print("undo requested by user!")
    state["test"] = !state["test"]
    print(state["test"])

func redo():
    print("undo requested by user!")
    state["test"] = !state["test"]
    print(state["test"])