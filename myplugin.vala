using GLib;

/*
 * The Plugin implementation
 */
public class MyPlugin : Object, Plugin {
	public MyPlugin() {
	}

	public void message() {
		stdout.printf("blabla from plugin of type : %s\n", get_type().name());
	}
}

/*
 * The required function returning a new instance of the plugin
 */
public Plugin getPlugin() {
	return new MyPlugin();
}

