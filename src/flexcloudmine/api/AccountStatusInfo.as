package flexcloudmine.api
{
	/** 
	 * Class contains information on account status.
	 */
	public class AccountStatusInfo extends ApiCallResult
	{
		/**
		 * The specified account exists and is valid.
		 */
		public static const OK:String = "OK";
		
		/**
		 * The specified account did not previously exist, is valid, and has been created.
		 */
		public static const CREATED:String = "CREATED";
		
		/**
		 * The specified account exists, but the password provided is incorrect.
		 * Can also mean the provided API key is invalid.
		 */
		public static const UNAUTHORIZED:String = "UNAUTHORIZED";
		
		/**
		 * The specified account is not valid - likely because the email address provided is not itself valid.
		 */
		public static const INVALID:String = "INVALID";
		
		public function AccountStatusInfo(status:String)
		{
			super(status);
		}
		
	}
}