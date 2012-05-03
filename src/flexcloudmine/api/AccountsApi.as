package flexcloudmine.api
{
	import flash.net.URLRequestHeader;
	
	import flexcloudmine.Controller;
	import flexcloudmine.lib.ApiData;
	import flexcloudmine.lib.Util;

	/**
	 * Methods for interacting with the CloudMine user account management API.
	 */
	public class AccountsApi
	{
		private var _controller:Controller;
		
		public function AccountsApi(controller:Controller)
		{
			_controller = controller;
		}
		
		/**
		 * Post the specified email/password credentials.
		 * @param	email		Email address of user
		 * @param	password	Password of user  
		 * @param	callback	Function accepting one parameter to receive a <code>AccountStatusInfo</code> object with the results of the call.
		 */
		public function post(email:String, password:String, callback:Function):void
		{
			//var headers:Object = [];
			//headers["Authorization"] = Util.getUserAuthValue(email, password);
			var headers:Array = [ new URLRequestHeader("Authorization", Util.getUserAuthValue(email, password)) ]; 
			_controller.doApiCall("/user/account", "POST", 
				function f(d:ApiData):void { postCallback(d, callback) }, 
				function f(d:ApiData):void { postCallback(d, callback) }, 
				headers);
		}
		
		/**
		 * Handle result/fault from post call.
		 * @param	data		Accepts <code>ApiData</code> returned from api call.
		 * @param	callback	Function to receive <code>AccountStatusInfo</code> object with the result of the api call.
		 */
		protected function postCallback(data:ApiData, callback:Function):void
		{
			if (data.isFault())
			{
				if (data.statusCode == 400)
					callback(new AccountStatusInfo(AccountStatusInfo.INVALID));
				else if (data.statusCode == 401)
					callback(new AccountStatusInfo(AccountStatusInfo.UNAUTHORIZED));
				else
					callback(new AccountStatusInfo(ApiCallResult.UNKNOWN));
			}
			else
			{
				if (data.statusCode == 200)
					callback(new AccountStatusInfo(AccountStatusInfo.OK));
				else if (data.statusCode == 201)
					callback(new AccountStatusInfo(AccountStatusInfo.CREATED));
				else
					callback(new AccountStatusInfo(ApiCallResult.UNKNOWN));
			}
		}
		
	}
}