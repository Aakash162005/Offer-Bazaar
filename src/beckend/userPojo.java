package beckend;

public class userPojo {
	
	static int uId;
	static String uName, uEmail, uContact;
	public static int getuId() {
		return uId;
	}
	public static void setuId(int uId) {
		userPojo.uId = uId;
	}
	public static String getuName() {
		return uName;
	}
	public static void setuName(String uName) {
		userPojo.uName = uName;
	}
	public static String getuEmail() {
		return uEmail;
	}
	public static void setuEmail(String uEmail) {
		userPojo.uEmail = uEmail;
	}
	public static String getuContact() {
		return uContact;
	}
	public static void setuContact(String uContact) {
		userPojo.uContact = uContact;
	}
	
	
	
}
