var script_class = "export_format"
var export_format_name = "Custom Export Format"
var export_file_extension = "myexport"
var export_image_format = "webp"
var show_quality_slider = true


# this method is required. it is called just after the script is loaded.
func start():
    pass

# this method is required. it is called just image export.
func process(path : String, image : File, ppi : int):
    var imageAsText = Marshalls.raw_to_base64(image.get_buffer((image.get_len())))
    var data = {
        "title" : Global.World.Title,
        "pixel_size" : [ Global.World.WoxelDimensions.x, Global.World.WoxelDimensions.y ],
        "creation_timestamp" : OS.get_unix_time(),
        "image" : imageAsText
    }
    var file = File.new()
    var error = file.open(path, File.WRITE);
    file.store_line(JSON.print(data, "\t"));
    file.close();