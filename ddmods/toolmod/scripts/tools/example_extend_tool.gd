var script_class = "tool"

# the following variables are not necessary. you can declare more yourself
var select_tool = null


# this method is required. it is called just after the script is loaded.
func start():
    var tool_panel = Global.Editor.Toolset.GetToolPanel("SelectTool")
    var button = tool_panel.CreateButton("Straighten", Global.Root + "icons/question.png")
    # moving a button from the bottom to the top of the panel
    tool_panel.Align.move_child(button, 0)
    button.connect("pressed", self, "straighten")
    var button2 = tool_panel.CreateButton("Select All Objects", Global.Root + "icons/question.png")
    tool_panel.Align.move_child(button2, 1)
    button2.connect("pressed", self, "select_all_objects")
    # cache the select tool to make it easier to reference in this script
    select_tool = Global.Editor.Tools["SelectTool"]

# this method is not necessary. it just shows you how to tell every tick if a tool is enabled
func update(delta):
    if select_tool == Global.Editor.ActiveTool:
        pass
        # print("!")
        # uncomment the previous line if you want to see in the DungeondraftConsole whenever select tool is active

func straighten():
    # Selected is an array of selected objects
    print(select_tool.Selected)
    print("TEST3")
    # Selectables is a dictionary of the selected objects as keys and their types as values
    var average = Vector2.ZERO
    var count = 0
    for thing in select_tool.Selectables:
        print(select_tool.Selectables[thing])
        # 4 is object types
        if select_tool.Selectables[thing] == 4:
            average += thing.global_position
            count += 1
    # prevent divide by zero
    if count > 0:
        average /= count
        # align horizontally at the average height
        for thing in select_tool.Selectables:
            if select_tool.Selectables[thing] == 4:
                thing.global_position.x = average.x

func select_all_objects():
    for object in Global.World.GetLevelByID(Global.World.CurrentLevelId).Objects.get_children():
        select_tool.SelectThing(object, true)
    select_tool.EnableTransformBox(true)
