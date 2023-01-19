var script_class = "tool"

# the following variables are not necessary. you can declare more yourself
var tool_enabled : bool = false
var mirror_object : bool = false


# this method is required. it is called just after the script is loaded.
func start():
    var category = "Design"
    var id = "example_tool"
    var name = "Example Tool"
    var icon = Global.Root + "icons/example_tool.png"
    var tool_panel = Global.Editor.Toolset.CreateModTool(self, category, id, name, icon)
    tool_panel.UsesObjectLibrary = true
    tool_panel.CreateLabel("Tool Section")
    var button1 = tool_panel.CreateButton("Show Dialog Box", Global.Root + "icons/question.png")
    button1.connect("pressed", self, "show_dialog_box")
    var button2 = tool_panel.CreateButton("Randomize Asset", Global.Root + "icons/add.png")
    button2.connect("pressed", self, "randomize_asset")

# this method is automatically called every frame. delta is a float in seconds. can be removed from script.
func update(delta : float):
    if tool_enabled:
        # you can call Global.Editor.Tools["ObjectTool"]._Update(delta) here if you want the default Object Tool behaviors
        Global.Editor.Tools["ObjectTool"].Preview.global_position = Global.World.get_global_mouse_position()

# this method is called whenever a mod created tool in this script is selected in UI
func on_tool_enable(tool_id):
    Global.Editor.Tools["ObjectTool"].Enable()
    tool_enabled = true

# this method is called whenever a mod created tool in this script is deselected in UI
func on_tool_disable(tool_id):
    Global.Editor.Tools["ObjectTool"].Disable()
    tool_enabled = false

# this method is called whenever a mod created tool detects a user input on the canvas
func on_content_input(event):
    Global.Editor.Tools["ObjectTool"]._ContentInput(event)
    # do something after a mouse click is detected after the object tool created a new preview
    if event is InputEventMouseButton:
        if event.button_index == BUTTON_LEFT and event.pressed:
            Global.Editor.Tools["ObjectTool"].Preview.Mirror = mirror_object
            mirror_object = !mirror_object

func show_dialog_box():
    OS.alert("Display message here.", "Title")

func randomize_asset():
    var asset_list = Script.GetAssetList("Objects")
    var r : int = randi() % asset_list.size()
    Global.Editor.Tools["ObjectTool"].Preview.Texture = Script.GetAssetTexture("Objects", asset_list[r])
    # pulls color from the object tool selection and hands it off to the object instance
    Global.Editor.Tools["ObjectTool"].PromoteCustomColor()