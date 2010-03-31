using GLib;

/*
 * The Plugin implementation
 */
public class MyOtherPlugin : Object, Plugin {
	public MyOtherPlugin() {
	}

	public void message() {
		stdout.printf("bloblo from plugin of type : %s\n", get_type().name());
	}
}

/*
 * The required function returning a new instance of the plugin
 */
public Plugin get_plugin() {
	return new MyOtherPlugin();
}

