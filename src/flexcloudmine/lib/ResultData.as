package flexcloudmine.lib
{
	import flash.events.Event;
	import flash.net.URLLoader;
	
	import mx.rpc.events.ResultEvent;

	public class ResultData extends ApiData
	{
		/**
		 * Construct object from specified ResultEvent or Event.
		 * @param	result	ResultEvent containing result data; set this to NULL if this should be constructed using the Event object instead
		 * @param	ev		Event containing result data; used if result == null.
		 */
		public function ResultData(result:ResultEvent, ev:Event = null)
		{
			if (result != null)
			{
			_status = result.statusCode;
			_data = decodeData(result.result as String);
			}
			else
			{
				var loader:URLLoader = ev.target as URLLoader;
				_status = NaN;
				_data = decodeData(loader.data as String);
			}
		}
		
		/**
		 * Returns false - this is not a fault object.
		 */
		public override function isFault():Boolean { return false; }

	}
}