import java.net.*;
import java.io.*;
import java.util.*;

public class XmlServer {

public XmlServer (int port) throws IOException {
	ServerSocket server = new ServerSocket (port);
	Logger logger = new Logger ("multiserver.log");
	while (true) {
		Socket client = server.accept ();
		System.out.println ("Accepted from " + client.getInetAddress ());
		XmlHandler c=new XmlHandler (client, logger);
		c.start ();
	}
}

public static void main (String args[]) throws IOException {
	if (args.length !=1) {
		throw new RuntimeException ("Syntax: XmlServer (portnumber)");
	}
	new XmlServer (Integer.parseInt (args[0]));
	
}

}