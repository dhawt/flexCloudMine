package flexcloudmine.lib
{
	import flash.events.Event;
	import flash.events.HTTPStatusEvent;
	import flash.events.IOErrorEvent;
	import flash.events.SecurityErrorEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	
	import flashx.textLayout.debug.assert;
	
	import mx.controls.Alert;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;
	import mx.rpc.http.HTTPService;
	import mx.utils.Base64Encoder;
	
	/**
	 * Class containing general utility methods for interacting with the CloudMine web service.
	 */
	public class Util
	{
		
		public function Util()
		{
		}
		
		/**
		 * Generate a BASE64-encoded user authorization value for API calls.
		 * @param	email		email address of user
		 * @param	password	password of user
		 * @return	authorization header string compliant with CM API ("Basic XXXXXXXXXXXXX")
		 */
		public static function getUserAuthValue(email:String, password:String):String
		{
			var encoder:Base64Encoder = new Base64Encoder;
			encoder.encode(email + ":" + password);
			return "Basic " + encoder.toString(); 
		}
		
		/**
		 * Make a API request to the specified CloudMine endpoint.  Convenience function wrapping generic HTTPService functionality.
		 * @param url		CloudMine URL endpoint
		 * @param method	HTTP Method (GET, PUT, etc)
		 * @param onResult	Callback function accepting <code>CMResultData</code> containing result data
		 * @param onFault	Callback function accepting <code>CMFaultData</code> containg fault data
		 * @param headers	HTTP headers, specified in Array.
		 * @param request	Object of name-value pairs used as parameters to the URL
		 */
		public static function invokeApiCall(url:String, method:String, 
											 onResult:Function = null, onFault:Function = null, 
											 headers:Array = null, request:Object = null):void
		{
			var req:URLRequest = new URLRequest(url);
			req.method = method;
			req.requestHeaders = headers;
			req.data = request;
			req.contentType = "application/json";
			var loader:URLLoader = new URLLoader;
			loader.addEventListener(Event.COMPLETE, function f(result:Event):void { onResult(new ResultData(null, result)); } );
			loader.addEventListener(IOErrorEvent.IO_ERROR, function f(fault:FaultEvent):void { onFault(new FaultData(fault)); } );
			loader.addEventListener(SecurityErrorEvent.SECURITY_ERROR, function f(fault:FaultEvent):void { onFault(new FaultData(fault)); } );

			// TODO: handle status here.  We will get HTTP_RESPONSE_STATUS before we get COMPLETE event, so figure out how to
			// store the status somewhere (with the URLLoader object itself? an asyncToken?) for later use when we get the 
			// COMPLETE event...
			loader.addEventListener(HTTPStatusEvent.HTTP_RESPONSE_STATUS, function f(e:Event):void { Alert.show("STATUS"); });
			
			loader.load(req);
		}
		
	}
}