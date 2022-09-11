import java.io.*;
import java.util.*;

public class Logger {

protected static FileWriter myWriter;

public Logger (String filename) throws IOException {
	FileWriter myWriter = new FileWriter(filename, true);
	this.myWriter = myWriter;
}

public static Logger main (String args[]) throws IOException {
	if (args.length !=1) {
		throw new RuntimeException ("Syntax: Logger (filename)");
	}
	else {
		Logger tempLogger = new Logger (args[0]);
		return tempLogger;
	}
}

public static void write (int[] msg) throws IOException {
	for (int i=0;i<msg.length ;i++ ) {
		myWriter.write (msg[i]);
	}
	myWriter.write ("\n");
	myWriter.flush();
}

public static void write (String msg) throws IOException {
	myWriter.write (msg);
	myWriter.write ("\n");
	myWriter.flush();
}

public static void close () throws IOException {
	myWriter.flush();
	myWriter.close();
}
}