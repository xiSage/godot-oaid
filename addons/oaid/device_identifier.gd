class_name DeviceIdentifier extends Object
## 对SDK的DeviceIdentifier类的包装，设备标识符工具类。

## DeviceIdentifier对应的[JavaClass]
static var java_class: JavaClass

## 获取当前的Application。
static func get_application_context() -> JavaObject:
	return Engine.get_singleton("AndroidRuntime").getApplicationContext()

static func _static_init() -> void:
	if OS.get_name() == "Android":
		java_class = JavaClassWrapper.wrap("com.github.gzuliyujiang.oaid.DeviceIdentifier")

## 在应用启动时预取客户端标识及 OAID，客户端标识按优先级尝试获取 IMEI/MEID、OAID/AAID、AndroidID、GUID。
## !!注意!!：若最终用户未同意隐私政策，或者不需要用到 [method get_client_id] 及 [method get_oaid]，请不要调用这个方法
static func register(try_widevine: bool = false) -> void:
	java_class.register(get_application_context(), try_widevine)

## 使用该方法获取客户端唯一标识，需要先调用[method register]预取。
static func get_client_id(return_raw: bool = false) -> String:
	return java_class.getClientId(return_raw)

## 获取唯一设备标识。Android 6.0-9.0 需要申请电话权限才能获取 IMEI/MEID，Android 10+ 非系统应用则不再允许获取 IMEI。
static func get_imei() -> String:
	return java_class.getIMEI(get_application_context())

## 用该方法获取OAID/AAID，需要先调用[method register]预取。
static func get_oaid() -> String:
	return java_class.getOAID(get_application_context())

## 获取AndroidID。
static func get_android_id() -> String:
	return java_class.getAndroidID(get_application_context())

## 获取数字版权管理设备ID。
static func get_widevine_id() -> String:
	return java_class.getWidevineID()

## 通过取出ROM版本、制造商、CPU型号以及其他硬件信息来伪造设备标识。
static func get_pseudo_id() -> String:
	return java_class.getPseudoID()

## 随机生成全局唯一标识并存到 [code]SharedPreferences[/code]、[code]ExternalStorage[/code] 及 [code]SystemSettings[/code]。
## 为保障在 Android 10 以下版本上的稳定性，需要加入权限 [code]WRITE_EXTERNAL_STORAGE[/code] 及 [code]WRITE_SETTINGS[/code]。
static func get_guid() -> String:
	return java_class.getGUID(get_application_context())
