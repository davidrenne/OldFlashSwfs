import java.net.*;
import java.io.*;
import java.util.*;

//xml support
import java.net.URL;
import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.ParserConfigurationException;
import org.xml.sax.*;

import org.jdom.*;
import org.jdom.input.SAXBuilder;
import org.jdom.output.*;

public class XmlHandler extends Thread {

protected Socket s;
protected static Logger log;
protected String username;
protected InputStream i;
protected OutputStream o;
protected pinger pingThread;

public volatile boolean thisThreadRunning;

public XmlHandler (Socket s, Logger log) throws IOException {
	this.s = s;
	this.s.setTcpNoDelay(true);
	this.s.setSoTimeout(60000);
	this.log = log;
	this.username = "";

	this.i = s.getInputStream();
	this.o = s.getOutputStream();
}

protected static Vector handlers = new Vector ();
protected static Vector conversationObjects = new Vector ();

public void kill() {

	if (thisThreadRunning)
	{	
		try
		{
			this.log.write ("-----KILL " + this.getName());
			this.s.shutdownInput();
			this.s.shutdownOutput();
		}
		catch (IOException ex)
		{
		}
		thisThreadRunning=false;
	}

}

public void run() {

	try
	{	
		thisThreadRunning = Thread.currentThread().isAlive();
		this.setName(this.s.getInetAddress().getHostAddress());

		this.log.write ("-----NEW " + this.getName());

		synchronized (handlers) {
			handlers.addElement (this);
		}

		this.pingThread = new pinger(this,this.i,this.o);
		this.pingThread.start();

		Document xmlDoc;

		//If we want to do something when a new user connects:
		newUser ();

		while (thisThreadRunning)
		{
			int[] readBuffer = new int[2048];
			byte b=1;
			boolean readFlag = false;
			int count = 0;
			
			do {
				//add character to byte collection
				b = (byte) i.read();
				//this.log.write ("-----BYTE " + this.getName() + "  " + (int)b);

				if ((int) b!=-1)
				{
					if ((int)b!=0)
					{
						readBuffer[count] = b;
						count++;
					}
				}
				else {
					this.log.write ("-----NORMAL DISCONNECTION " + this.getName());
					this.kill();
				}
				this.yield();
			} while((int) b != 0 && thisThreadRunning);

			if (thisThreadRunning)
			{
				//drop from the buffer to the array
				byte[] xmlByte = new byte[count];
				int[] xmlInt = new int[count];

				for (int i=0;i<count;i++ )
				{
					xmlByte[i] = (byte) readBuffer[i];
					xmlInt[i] = readBuffer[i];
				}

				//build a Stream from the array
				ByteArrayInputStream bais = new ByteArrayInputStream(xmlByte);

				SAXBuilder saxb = new SAXBuilder(false);

				//get the doc
				xmlDoc = saxb.build(bais); 

				//log it
				log.write(xmlInt);

				//process it
				process(xmlDoc);

				//give the server a break
				this.yield();
			}
		}
	}
	catch (JDOMException ex)
	{
		System.out.println ("MAIN THREAD DEATH via JDOM X");
		try
		{
			this.log.write ("-----XML ERROR " + this.getName());
		}
		catch (IOException x)
		{
		}

		//ex.printStackTrace();
		this.kill();
	}
	catch (InterruptedIOException ex)
	{
		System.out.println ("MAIN THREAD DEATH via Interrupted X");
		try
		{
			this.log.write ("-----TIMEOUT " + this.getName());
		}
		catch (IOException x)
		{
		}
		
		//ex.printStackTrace();
		this.kill();
	} 

	catch (IOException ex)
	{
		System.out.println ("MAIN THREAD DEATH via IO X");
		try
		{
			this.log.write ("-----IO ERROR " + this.getName());
		}
		catch (IOException x)
		{
		}

		//ex.printStackTrace();
		this.kill();
	}
	finally 
	{
		try
		{
			synchronized (handlers) {
				handlers.removeElement (this);
			}

			//tell others of disconnect
			//sendToOthers removeUser
			if (this.username != "")
			{
				Document othersDoc = new Document (new Element ("newMsg"));
				othersDoc.getRootElement().addAttribute ("username", "#00CCFF" + this.username);
				othersDoc.getRootElement().addAttribute ("msg", "has exited chat.");
				sendToOthers (othersDoc);
			}

			upDateUserCount();
			this.i.close();
			this.o.close();
			s.close();
			System.out.println ("THREAD SIGNING OFF");
		}
		catch (IOException ex)
		{
			System.out.println ("SOCKET CLOSE FAILURE via IO X");
			//ex.printStackTrace();
		}
	}
}




//---------------------


//  Process(xml) 

//		This is the main xml processing function. Use it to add your own custom xml processing types.
//		


//---------------------
protected void process (Document xmlDoc) {

	String name;
	
	name = xmlDoc.getRootElement().getName();
	System.out.println("ELEMENT "+ name);
	List attributes = xmlDoc.getRootElement().getAttributes();

	if (name.equals("broadcast")) {
		System.out.println("broadcast");
		//send this message to all currently connected users.
		broadcast(xmlDoc);
	}
	
	//neccessary?
	if (name.equals("newUser")) {
		System.out.println("newUser");
		processNewUser(xmlDoc);
	}

	if (name.equals("newMsg")) {
		System.out.println("newMsg");
		processNewMsg(xmlDoc);
	}

	//neccessary?	
	if (name.equals("pong")) {
		System.out.println("pong");
		pong(xmlDoc);
	}
}

protected static void broadcast (Document xmlDoc) {
	Enumeration e;
	synchronized (handlers) {
		e=handlers.elements();
	}
	while (e.hasMoreElements())
	{
		XmlHandler c=(XmlHandler) e.nextElement ();
		if (c.thisThreadRunning)
		{
			try
			{
				synchronized (c.o) {
					XMLOutputter xmlOut = new XMLOutputter ();
					xmlOut.output(xmlDoc, c.o) ;
					c.o.write (0);
					c.o.flush();
					//log.write("broadcast:");
					//log.write(xmlDoc.toString());
				}
			}
			catch (IOException ex)
			{
				c.kill();
				System.out.println ("BROADCAST FAILURE via IO X");
			}
		}
	}
}

public void sendToOthers (Document xmlDoc) {
	System.out.println ("sendToOthers");

	Enumeration e;
	synchronized (handlers) {
		e=handlers.elements();
	}
	while (e.hasMoreElements())
	{
		XmlHandler c=(XmlHandler) e.nextElement ();
		if (c != this && c.thisThreadRunning) {	
			try	 {
				synchronized (c.o) {
					XMLOutputter xmlOut = new XMLOutputter ();
					xmlOut.output(xmlDoc, c.o) ;
					c.o.write (0);
					c.o.flush();
					//log.write("sendToOthers:");
					//log.write(xmlDoc.toString());
				}
			}
			catch (IOException ex)
			{
				c.kill();
			System.out.println ("SENDTOOTHERS FAILURE via IO X");
			}
		}
		else {
			System.out.println("do not send to self");
		}
	}
}

public void reply (Document xmlDoc) {
System.out.println ("reply");
	if (this.thisThreadRunning)
	{
		try	 {
			synchronized (this.o) {
				XMLOutputter xmlOut = new XMLOutputter ();
				xmlOut.output(xmlDoc, this.o) ;
				this.o.write (0);
				this.o.flush();
				//log.write("reply:");
				//log.write(xmlDoc.toString());
			}
		}
		catch (IOException ex)
		{
			this.kill();
			System.out.println ("REPLY FAILURE via IO X");
		}
	}
}

protected void newUser () {
	initializeWorld();
	upDateUserCount();

	int count = handlers.size();
	Document replyDoc = new Document (new Element ("newUser"));
	replyDoc.getRootElement().addAttribute ("count", "" + count);
			
	reply (replyDoc);
}

protected void upDateUserCount() {
	
		int count = handlers.size();

		//broadcast
		Document othersDoc = new Document (new Element ("newUser"));
		othersDoc.getRootElement().addAttribute ("count", "" + count);
			
		sendToOthers (othersDoc);
}


//--------------

// Implementation Specific Processing

//--------------

protected void initializeWorld() {

	Object[] a;
	Document replyDoc;
	conversationObj nextObj;

	synchronized (conversationObjects) {
		a=conversationObjects.toArray();
	}

	for (int i=a.length-1; i >= 0 ;i -- )
	{
		System.out.println(i);
		//get object
		nextObj = (conversationObj) a[i];

		if (nextObj != null)
		{	
			replyDoc = nextObj.getDocument();
			reply (replyDoc);
		}
			
	}
}

protected void processNewUser (Document xmlDoc) {
	//get name attribute
	
	String username = xmlDoc.getRootElement().getAttributeValue("username");

	this.username = username;

	if (this.username != "") {
		Document allDoc = new Document (new Element ("newMsg"));
		allDoc.getRootElement().addAttribute ("username", "#00CCFF" + this.username);
		allDoc.getRootElement().addAttribute ("msg", "has entered chat.");	
		broadcast (allDoc);
	}
}

protected void processNewMsg (Document xmlDoc) {
	//get name attribute
	String username = xmlDoc.getRootElement().getAttributeValue("username");
	String msg = xmlDoc.getRootElement().getAttributeValue("msg");

	//save in conversationObjects
	conversationObj thisMessage = new conversationObj (username, msg);
	synchronized (conversationObjects) {
		if (conversationObjects.size() > 20)
		{
			conversationObjects.removeElementAt(20);
		}
		conversationObjects.insertElementAt(thisMessage, 0);
	}

	Document allDoc = new Document (new Element ("newMsg"));
	allDoc.getRootElement().addAttribute ("username", username);
	allDoc.getRootElement().addAttribute ("msg", msg);
	
	broadcast (allDoc);
}

protected void pong (Document xmlDoc) {
	try
	{
		this.log.write ("-----PONG " + this.getName());
	}
	catch (IOException ex)
	{
	}
	
}

}