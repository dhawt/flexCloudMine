package flexcloudmine.lib
{
	import com.adobe.serialization.json.JSON;
	
	import mx.rpc.events.FaultEvent;

	public class FaultData extends ApiData
	{
		/**
		 * Construct object from specified FaultEvent.
		 */
		public function FaultData(fault:FaultEvent)
		{
			_status = fault.statusCode;
			_data = decodeData(fault.fault.content as String);
		}
		
		/**
		 * Returns true - this is a fault object after all.
		 */
		public override function isFault():Boolean { return true; }

	}
}