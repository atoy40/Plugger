using GLib;

public class Plugger : Object {

	/*
	 *  the delegate (the function implemented in plugins)
	 */
	private delegate Plugin GetPluginFunction();

	/*
	 * The glib module loader
	 */
	private static Module module;

	/*
	 * the main entry point
	 */
	public static int main(string[] args) {

		if (args.length < 2) {
			stderr.printf("Need the plugin name\n");
			return 0;
		}

		Plugin plugin = loadPlugin(args[1]);

		if (plugin == null) {
			return 0;
		}

		// call the plugin method
		plugin.message();

		return 1;
	}

	/*
	 * - load the plugin library
	 * - find the "getPlugin" symbol
	 * - call it and return the given object
	 */
	public static Plugin? loadPlugin(string file) {
		string path = Module.build_path(Environment.get_variable("PWD"), file);
		module = Module.open(path, ModuleFlags.BIND_LAZY);

		if (module == null) {
			stderr.printf("Unable to load %s\n", path);
			return null;
		}

		void *symbol;
		module.symbol("getPlugin", out symbol);

		if (symbol == null) {
			stderr.printf("Unable to find symbol\n");
			return null;
		}

		GetPluginFunction fct = (GetPluginFunction)symbol;

		return fct();
	}
}
