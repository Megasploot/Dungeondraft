var script_class = "tool"


# this method is required. it is called just after the script is loaded.
func start():
    var category = "Design"
    var id = "example_ui"
    var name = "Example UI"
    var icon = Global.Root + "icons/example_tool.png"
    var icon1 = Global.Root + "icons/add.png"
    var icon2 = Global.Root + "icons/question.png"
    var tool_panel = Global.Editor.Toolset.CreateModTool(self, category, id, name, icon)
    tool_panel.CreateLabel("Tool Section")
    var button = tool_panel.CreateButton("Button", icon2)
    button.connect("pressed", self, "on_button_press")
    var toggle = tool_panel.CreateToggle("ToggleID", false, "On", icon1, "Off", icon2)
    toggle.connect("toggled", self, "on_toggle")
    var check_button = tool_panel.CreateCheckButton("CheckButton", "CheckButtonID", false)
    check_button.connect("toggled", self, "on_checkbutton_toggle")
    tool_panel.CreateSeparator()
    tool_panel.CreateNote("Add tool information here if desired.")
    var dropdown_menu = tool_panel.CreateDropdownMenu("DropdownMenuID", ["Option 1", "Option 2", "Option 3"], "Option 2")
    dropdown_menu.connect("item_selected", self, "on_dropdown_select")
    var labeled_dropdown_menu = tool_panel.CreateLabeledDropdownMenu("DropdownMenuID", "Dropdown Menu", ["Option 1", "Option 2", "Option 3"], "Option 3")
    labeled_dropdown_menu.connect("item_selected", self, "on_labeled_dropdown_select")
    var layer_menu = tool_panel.CreateLayerMenu()

    # file selection is special, and emits signals called on_file_selected and on_file_cleared automatically
    var win_img_filter = "All Images,*.png;*.jpg;*jpeg,PNG (*.png),*.png,JPEG (*.jpg),*.jpg;*jpeg";
    var osx_img_filter = "jpg,png";
    var linux_img_filter = "*.jpg *.png";
    var img_filter = null
    match OS.get_name():
        "Windows":
            img_filter = win_img_filter
        "OSX":
            img_filter = osx_img_filter
        "X11":
            img_filter = linux_img_filter
    var file_selector = tool_panel.CreateFileSelector("FileSelectorID", img_filter, OS.get_system_dir(OS.SYSTEM_DIR_DESKTOP))

    var stretched = false
    tool_panel.BeginSection(stretched)
    var slider = tool_panel.CreateSlider("SliderID", 0.5, 0.0, 1.0, 0.1, false)
    slider.connect("value_changed", self, "on_slider_change")
    # cannot use the name range because range is a reserved keyword
    var _range = tool_panel.CreateRange("RangeID", 0.0, 1.0, 0.01, 0.25, 0.75)
    _range.MinRange.connect("value_changed", self, "on_range_min_change")
    _range.MaxRange.connect("value_changed", self, "on_range_max_change")
    tool_panel.EndSection()
    var colors = ["eccd8b", "eaefca", "80beff", "ffad58", "4dd569"]
    # color palette automatically emits a signal called on_color_change for single select and on_colors_change for multiselect
    var color_palette = tool_panel.CreateColorPalette("ColorPaletteID", false, "eccd8b", colors, true, true)
    var texture_menu = tool_panel.CreateTextureGridMenu("PortalTexture", "Portals", true);

func on_button_press():
    print("Button pressed")

func on_toggle(value):
    if value:
        print("Toggle on")
    else:
        print("Toggle off")

func on_checkbutton_toggle(value):
    if value:
        print("CheckButton on")
    else:
        print("CheckButton off")

func on_dropdown_select(index):
    print(str(index) + " is selected")

func on_labeled_dropdown_select(index):
    print(str(index) + " is selected")

func on_file_selected(id, path):
    print(str(id) +  " selected file at " + path)

func on_file_cleared(id):
    print(str(id) +  " cleared")

func on_slider_change(value):
    print(value)

func on_range_min_change(value):
    print(value)

func on_range_max_change(value):
    print(value)

func on_colors_change(id, colors):
    print("colors changed")
    for color in colors:
        print("color")
        print(color)