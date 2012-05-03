package flexcloudmine.lib
{
	import com.adobe.serialization.json.JSON;
	import com.adobe.serialization.json.JSONParseError;

	/**
	 * Class providing helper functions for processing response data received from CM API calls.
	 * This class should not be instantiated directly - use CMResultData or CMFaultData instead.
	 */
	public class ApiData
	{
		protected var _status:int = NaN;
		protected var _data:Object = null;

		public function ApiData()
		{
		}
		
		/**
		 * Get status code of fault.
		 * @return	Integer HTTP status code
		 */
		public function get statusCode():int { return _status; }
		
		/**
		 * Get JSON-decoded data payload.
		 * @return	Object containing JSON-decoded data received from CM.
		 */
		public function get data():Object { return _data; }
		
		/**
		 * Return true if this contains fault data.  Override this in derived classes.
		 */
		public function isFault():Boolean { throw new Error("Must override in derived class."); }
		
		/**
		 * JSON-decode the provided string, provided it contains valid data.
		 * @param	data	JSON-encoded string with data
		 * @return	Decoded data
		 */	
		protected function decodeData(data:String):Object
		{
			var decData:Object = null; 
			try 
			{
				decData = com.adobe.serialization.json.JSON.decode(data);
			}
			catch (e:JSONParseError)
			{
				decData = "JSONParseError encountered";
			}
			finally
			{
				return decData;
			}
		}

	}
}