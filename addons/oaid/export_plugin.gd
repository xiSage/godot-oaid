@tool
extends EditorPlugin

var export_plugin: AndroidExportPlugin

func _enter_tree() -> void:
	export_plugin = AndroidExportPlugin.new()
	add_export_plugin(export_plugin)

func _exit_tree() -> void:
	remove_export_plugin(export_plugin)
	export_plugin = null

class AndroidExportPlugin extends EditorExportPlugin:
	var name = "OAID"
	
	func _get_name() -> String:
		return name
	
	func _supports_platform(platform: EditorExportPlatform) -> bool:
		if platform is EditorExportPlatformAndroid:
			return true
		else:
			return false
			
	func _get_export_options(platform: EditorExportPlatform) -> Array[Dictionary]:
		if platform is EditorExportPlatformAndroid:
			return [
				{
					"option" :
					{
						"name" : "oaid/version",
						"type" : TYPE_STRING,
					},
					"default_value" : "4.2.12"
				}
			]
		else:
			return []
	
	func _get_android_dependencies_maven_repos(platform: EditorExportPlatform, debug: bool) -> PackedStringArray:
		return ["https://jitpack.io", "https://developer.huawei.com/repo", "https://developer.hihonor.com/repo"]
		
	func _get_android_dependencies(platform: EditorExportPlatform, debug: bool) -> PackedStringArray:
		var version: String = get_option("oaid/version")
		return [
			"com.github.gzu-liyujiang:Android_CN_OAID:" + version
		]
