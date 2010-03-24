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
			stderr.printf("Need the plugin name\n");
			return 0;
		}

		var plugin = loadPlugin(args[1]);

		if (plugin == null) {
			return 0;
		}

		// call the plugin method
		plugin.message();

		return 1;
	}

	/*
	 * Open plugin and return a new instance.
	 */
	public static Plugin? loadPlugin(string file) {

		// load the module library file
		var path = Module.build_path(Environment.get_variable("PWD"), file);
		var module = Module.open(path, ModuleFlags.BIND_LAZY);

		if (module == null) {
			stderr.printf("Unable to load %s\n", path);
			return null;
		}

		// force module to stay loaded
		module.make_resident();

		// get a reference to the entry point symbol
		void *symbol;
		module.symbol("getPlugin", out symbol);

		if (symbol == null) {
			stderr.printf("Unable to find symbol\n");
			return null;
		}

		var fct = (GetPluginFunction)symbol;

		// return a new instance of the plugin
		return fct();
	}
}
