package model;

import java.io.File;

import javax.servlet.http.Part;

import resources.MyConstants;

import java.io.IOException;
import java.io.InputStream;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;

public class Customers {
		private int cusCode;
	    private String cusName;
	    private String cusContact;
	    private String cusEmail;
	    private String cusPhoto;
	    private int verifiedBy;
	    private String imageUrlFromPart;
	    private String dob;
	    private String gender;
	    private String password;
	    
	    
	    
	    public Customers() {};
	    
		public Customers(int cusCode, String cusName, String cusContact, String cusEmail, String cusPhoto, int verifiedBy, Part part, String dob, String gender, String password) {
	        this.cusCode = cusCode;
	        this.cusName = cusName;
	        this.cusContact = cusContact;
	        this.cusEmail = cusEmail;
	        this.cusPhoto = cusPhoto;
	        this.verifiedBy = verifiedBy;
	        this.imageUrlFromPart = getimageUrl(part);
	        this.dob = dob;
	        this.gender = gender;
	        this.password = password;
	    }
		
	    public String getCusPhoto() {
			return cusPhoto;
		}

		public void setCusPhoto(String cusPhoto) {
			this.cusPhoto = cusPhoto;
		}

		public String getDob() {
			return dob;
		}

		public void setDob(String dob) {
			this.dob = dob;
		}

		public String getGender() {
			return gender;
		}

		public void setGender(String gender) {
			this.gender = gender;
		}

		public String getPassword() {
			return password;
		}

		public void setPassword(String password) {
			this.password = password;
		}

		public int getCusCode() {
	        return cusCode;
	    }

	    public void setCusCode(int cusCode) {
	        this.cusCode = cusCode;
	    }

	    public String getCusName() {
	        return cusName;
	    }

	    public void setCusName(String cusName) {
	        this.cusName = cusName;
	    }

	    public String getCusContact() {
	        return cusContact;
	    }

	    public void setCusContact(String cusContact) {
	        this.cusContact = cusContact;
	    }

	    public String getCusEmail() {
	        return cusEmail;
	    }

	    public void setCusEmail(String cusEmail) {
	        this.cusEmail = cusEmail;
	    }

	    public int getVerifiedBy() {
	        return verifiedBy;
	    }

	    public void setVerifiedBy(int verifiedBy) {
	        this.verifiedBy = verifiedBy;
	    }	  
	    
	    
	  
	    public String getimageUrl(Part part) {
	    	String savePath = MyConstants.IMAGE_DIR_SAVE_PATH;
	    	File fileSaveDir = new File(savePath);
	    	String imageUrlFromPart = null;
	    	
	    	if(!fileSaveDir.exists()) {
	    		fileSaveDir.mkdir();
	    		System.out.println("DIrectory bannio");
	    	}
	    	
	    	String contentDisp = part.getHeader("content-disposition");
	    	String[] items = contentDisp.split(";");
	    	for(String s : items) {
	    		if(s.trim().startsWith("filename")) {
	    			imageUrlFromPart = s.substring(s.indexOf("=") + 2, s.length()-1);
	    		}
	    	}
	    	
	    	if(imageUrlFromPart == null || imageUrlFromPart.isEmpty()) {
	    		imageUrlFromPart = "download.png";
	    	}
	    	return imageUrlFromPart;
	    }
	    
	    

		public String getImageUrlFromPart() {
			return imageUrlFromPart;
		}

		public void setImageUrlFromPart(Part part) {
			this.imageUrlFromPart = getimageUrl(part);
		}
}
