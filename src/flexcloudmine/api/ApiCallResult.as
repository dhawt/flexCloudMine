package flexcloudmine.api
{
	/**
	 * Base class containing data + information from an API call.
	 * Provides ability retain status info.  Extend this class to handle results from API methods.
	 */
	public class ApiCallResult
	{
		/**
		 * Status is unknown.
		 */
		public static const UNKNOWN:String = "UNKNOWN";
		
		private var _status:String;
		
		public function ApiCallResult(status:String)
		{
			_status = status;
		}
		
		/**
		 * Get the status information.
		 * @return	String describing status information.
		 */
		public function get status():String { return _status; }

	}
}