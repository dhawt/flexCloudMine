package flexcloudmine.api
{
	
	import com.adobe.serialization.json.JSON;
	
	import flash.net.URLRequestHeader;
	
	import flexcloudmine.Controller;
	import flexcloudmine.lib.ApiData;

	/**
	 * Methods for interacting with the CloudMine user JSON document storage API.
	 */
	public class JSONApi
	{
		private var _controller:Controller;
		
		public function JSONApi(controller:Controller)
		{
			_controller = controller;
		}
		
		/**
		 * Get data for the specified keys.
		 * @param	keys		String containing comma-separated list of keys to fetch.  Ex: "key1,key2,key3"
		 * @param	callback	Function accepting one parameter to receive a <code>QueryResult</code> object.
		 */
		public function get(keys:String, callback:Function):void
		{
			var headers:Array = [];
			//headers["Authorization"] = Util.getUserAuthValue(email, password);
			_controller.doApiCall("/text?keys=" + keys, "GET", 
				function f(d:ApiData):void { getCallback(d, callback) }, 
				function f(d:ApiData):void { getCallback(d, callback) }, 
				headers);
		}
		
		/**
		 * Handle result/fault from get call.
		 * @param	data		Accepts <code>ApiData</code> returned from api call.
		 * @param	callback	Function to receive <code>QueryResult</code> object with the result of the api call.
		 */
		protected function getCallback(data:ApiData, callback:Function):void
		{
			if (data.isFault())
			{
				if (data.statusCode == 401)
					callback(new QueryResult(QueryResult.UNAUTHORIZED, data.data));
				else if (data.statusCode == 404)
					callback(new QueryResult(QueryResult.NOTFOUND, data.data));
				else
					callback(new QueryResult(ApiCallResult.UNKNOWN, data.data));
			}
			else
			{
				if (data.statusCode == 200)
					callback(new QueryResult(QueryResult.OK, data.data));
				else
					callback(new QueryResult(ApiCallResult.UNKNOWN, data.data));
			}
		}
		
		/**
		 * Set data for the specified keys.
		 * @param	data		Associative array of key/value pairs: { key1: value1, key2: value2, ... }. 
		 * 						Keys should be valid CM strings, values are objects and will be serialized to JSON by this method.
		 * @param	callback	Function accepting one parameter to receive a <code>QueryResult</code> object.
		 */
		public function set(data:Object, callback:Function):void
		{
			//var headers:Object = [];
			//headers["Content-Type"] = "application/json";
			var headers:Array = [];
			headers.push(new URLRequestHeader("Content-Type", "application/json"));
			
			_controller.doApiCall("/text", "POST", 
				function f(d:ApiData):void { setCallback(d, callback) }, 
				function f(d:ApiData):void { setCallback(d, callback) }, 
				headers, com.adobe.serialization.json.JSON.encode(data));
		}
		
		/**
		 * Handle result/fault from set call.
		 * @param	data		Accepts <code>ApiData</code> returned from api call.
		 * @param	callback	Function to receive <code>QueryResult</code> object with the result of the api call.
		 */
		protected function setCallback(data:ApiData, callback:Function):void
		{
			if (data.isFault())
			{
				if (data.statusCode == 400)
					callback(new QueryResult(QueryResult.BADREQUEST, data.data));
				else if (data.statusCode == 401)
					callback(new QueryResult(QueryResult.UNAUTHORIZED, data.data));
				else if (data.statusCode == 404)
					callback(new QueryResult(QueryResult.NOTFOUND, data.data));
				else
					callback(new QueryResult(ApiCallResult.UNKNOWN, data.data));
			}
			else
			{
				if (data.statusCode == 200)
					callback(new QueryResult(QueryResult.OK, data.data));
				else
					callback(new QueryResult(ApiCallResult.UNKNOWN, data.data));
			}
		}
		

	}
	
	
}