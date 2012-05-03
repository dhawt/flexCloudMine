package flexcloudmine
{
	import com.adobe.utils.ArrayUtil;
	
	import flash.net.URLRequestHeader;
	
	import flexcloudmine.api.AccountsApi;
	import flexcloudmine.api.JSONApi;
	import flexcloudmine.lib.Util;
	
	import mx.utils.ObjectUtil;

	/**
	 * Controller class provides methods for interacting with CM API calls.
	 */ 
	public class Controller
	{
		protected var _appId:String;
		protected var _apiKey:String;

		protected var _accountsApi:AccountsApi;
		protected var _jsonApi:JSONApi;
		
		/**
		 * Initialize a controller to interact with the given CloudMine app.
		 * @param appID		App id
		 * @param apiKey	Api key for interacting with CM APIs
		 */
		public function Controller(appId:String, apiKey:String)
		{
			_appId = appId;
			_apiKey = apiKey;
			
			_accountsApi = new AccountsApi(this);
			_jsonApi = new JSONApi(this);
		}
		
		/**
		 * Make an API call to the given app API endpoint. The endpoint is the resource-specifc portion of the URL.
		 * I.e., if the request is to be delivered to https://api.cloudmine.me/v1/app/{appid}/user/account, then
		 * the endpoint is considered to be "/user/account" (first slash character is optional).
		 * This call uses <code>CMUtil.invokeApiCall</code> to do the actual dirty work, but is helpful in that it will
		 * produce the correct (full) URL and provide the app ID and api Key as well.
		 * 
		 * @param endpoint	String value containing the endpoint
		 * @param method	HTTP Method (GET, PUT, etc)
		 * @param onResult	Callback function accepting <code>CMResultData</code> containing result data
		 * @param onFault	Callback function accepting <code>CMFaultData</code> containg fault data
		 * @param headers	HTTP headers, specified in Array.
		 * @param request	Object of name-value pairs used as parameters to the URL
		 */
		public function doApiCall(endpoint:String, method:String,
								  onResult:Function = null, onFault:Function = null,
								  headers:Array = null, request:Object = null):void
		{
			// Copy headers so we don't modify the original data (passed by reference):
			//var mergedHeaders:Object = ObjectUtil.copy(headers);	
			//mergedHeaders["X-CloudMine-ApiKey"] = _apiKey;
			var mergedHeaders:Array = headers;	
			mergedHeaders.push(new URLRequestHeader("X-CloudMine-ApiKey", _apiKey));

			// Add the endpoint to the root URL for cloudmine; add a '/' if we need to:
			var endpointURL:String = "https://api.cloudmine.me/v1/app/" + _appId; 
			endpointURL = endpointURL + ((endpoint.substr(0, 1) != '/') ? ("/" + endpoint) : endpoint); 
			
			Util.invokeApiCall(endpointURL, method, onResult, onFault, mergedHeaders, request);
		}
		
		/**
		 * Accessor for accounts API calls through embedded <code>AccountsApi</code> class.
		 * @returns	<code>AccountsApi</code> preconfigured to utilize this controller.
		 */
		public function get apiAccounts():AccountsApi { return _accountsApi; }
		
		/**
		 * Accessor for JSON API calls through embedded <code>JSONApi</code> class.
		 * @returns	<code>JSONApi</code> preconfigured to utilize this controller.
		 */
		public function get apiJson():JSONApi { return _jsonApi; }
	}
}