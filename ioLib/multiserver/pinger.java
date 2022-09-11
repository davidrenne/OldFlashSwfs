import java.io.*;
import java.util.*;

import org.jdom.*;
import org.jdom.input.SAXBuilder;
import org.jdom.output.*;

public class pinger extends Thread  {

public XmlHandler owner;
public InputStream i;
public OutputStream o;

public pinger (XmlHandler owner,InputStream i, OutputStream o) {
	this.owner = owner;
	this.i = i;
	this.o = o;
}

public void run() {

	try
	{	
		while (this.owner.thisThreadRunning)
		{
		
			//thisThreadRunning = Thread.currentThread().isAlive();
			this.sleep (10000);
			
			Document replyDoc = new Document (new Element ("ping"));
			this.owner.reply (replyDoc);
		}
	}
	catch (InterruptedException ex)
	{
	}

}

}