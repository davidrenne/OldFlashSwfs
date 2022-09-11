import java.io.*;
import java.util.*;

import org.jdom.*;
import org.jdom.input.SAXBuilder;
import org.jdom.output.*;

public class conversationObj extends Object {

public String username;
public String msg;

public conversationObj (String username, String msg) {
	this.username = username;
	this.msg = msg;
}

public Document getDocument() {
	Document returnDoc = new Document (new Element ("newMsg"));
	returnDoc.getRootElement().addAttribute ("username", this.username);
	returnDoc.getRootElement().addAttribute ("msg", this.msg);

	return returnDoc;
}

}