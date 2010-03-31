using GLib;

public class Plugger : Object {

	/*
	 *  The delegate (the function implemented in plugins)
	 */
	private delegate Plugin GetPluginFunction();

	/*
	 * The main entry point.
	 */
	public static int main(string[] args) {

		if (args.length < 2) {
			stderr.printf("Need the plugin directory\n");
			return 0;
		}

		var directory = File.new_for_path(args[1]);
		var enumerator = directory.enumerate_children(FILE_ATTRIBUTE_STANDARD_NAME, 0, null);

		FileInfo file_info;
		while((file_info = enumerator.next_file (null)) != null) {
			var name = file_info.get_name();
			if (name.has_suffix(".so")) {
				var plugin = get_plugin(directory.get_path(), name);
				if (plugin != null)
					plugin.message();
			}
		}

		return 1;
	}

	/*
	 * Open plugin and return a new instance.
	 */
	public static Plugin? get_plugin(string plugin_path, string file) {

		// load the module library file
		var path = Module.build_path(plugin_path, file);
		var module = Module.open(path, ModuleFlags.BIND_LAZY);

		if (module == null) {
			stderr.printf("Unable to load %s\n", path);
			return null;
		}

		// force module to stay loaded
		module.make_resident();

		// get a reference to the entry point symbol
		void *symbol;
		module.symbol("get_plugin", out symbol);

		if (symbol == null) {
			stderr.printf("Unable to find symbol\n");
			return null;
		}

		var fct = (GetPluginFunction)symbol;

		// return a new instance of the plugin
		return fct();
	}
}
