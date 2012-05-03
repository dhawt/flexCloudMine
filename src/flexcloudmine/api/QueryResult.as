package flexcloudmine.api
{
	public class QueryResult extends ApiCallResult
	{
		/**
		 * The query was ok.
		 */
		public static const OK:String = "OK";
		
		/**
		 * The provided API key is invalid.
		 */
		public static const UNAUTHORIZED:String = "UNAUTHORIZED";
		
		/**
		 * The body of the request isn't valid JSON.
		 */
		public static const BADREQUEST:String = "BADREQUEST";
		
		/**
		 * No data could be found for the given query, or the application ID doesn't exist.
		 */
		public static const NOTFOUND:String = "NOTFOUND";
		
		protected var _data:Object;
		
		/**
		 * Create a new result. 
		 * @param	status	Status string for result
		 * @param	data	Data related to query
		 */
		public function QueryResult(status:String, data:Object = null)
		{
			super(status);
			_data = data;
		}
		
		/**
		 * Stub...
		 */
		public function get data():Object { return _data; }
	}
}