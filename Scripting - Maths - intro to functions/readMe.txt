	the info below is also found in Scene 1, frame 1, level comments.

// 
//	title: how to use functions();
//	author: nathaniel weinham
// 	date: 19-October-2000
//
//	Look in mc.root-one-one-one to view the function
// 		and to see how I chose to organize the mc.
//	Basic philosophy here is to place the function 
//		within the mc which will use it. If it's a 
//		function which'll be used lot's by many mc's
//		you could place it somewhere else like in an
//		mc at _root.
//
//	Important Note:
//		You *_MUST_* define the function before it is used!
//		This means you need to run the function once so it's
//		entered into relative existence. *_Only_* then can the 
//		function be called. This tripped me up at first, but
//		once I accepted this truth I figured you could put 
//		the function in an mc and place that mc on _root in 
//		frame 1 so it get's played immediately, thereby 'defining'
//		the function. After talking w/ some folks I agreed 
//		with the idea of implimenting a standard of placing all
//		mc-specific functions within an actionScript in frame 1 of
//		the mc which'll be using that function.
//
//
//		Floss your teeth!
//