package controller.statemanagement;

public class SessionManagement {
	
	//check session attribute
	public Boolean checkUser(String userSession) {
		if(userSession != null && !userSession.isEmpty()) {
		 return true;
		}else {
			return false;
		}
	}

}
