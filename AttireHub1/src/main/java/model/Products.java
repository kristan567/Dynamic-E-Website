package model;

public class Products{
	private int productId;
	private String productName;
	private int productPrice;
	private String description;
	private int productQty;
	private String productCategory;
	private String productBrand;
	private String gender;
	private String productImage;
	private String productDeals;
	
	
	public Products(int productId, String productName, int productPrice, String description, int productQty,
			String productCategory, String productBrand, String gender, String productImage, String productDeals) {
		super();
		this.productId = productId;
		this.productName = productName;
		this.productPrice = productPrice;
		this.description = description;
		this.productQty = productQty;
		this.productCategory = productCategory;
		this.productBrand = productBrand;
		this.gender = gender;
		this.productImage = productImage;
		this.productDeals = productDeals;
	}
	public int getProductId() {
		return productId;
	}
	public void setProductId(int productId) {
		this.productId = productId;
	}
	public String getProductName() {
		return productName;
	}
	public void setProductName(String productName) {
		this.productName = productName;
	}
	public int getProductPrice() {
		return productPrice;
	}
	public void setProductPrice(int productPrice) {
		this.productPrice = productPrice;
	}
	public String getDescription() {
		return description;
	}
	public void setDescription(String description) {
		this.description = description;
	}
	public int getProductQty() {
		return productQty;
	}
	public void setProductQty(int productQty) {
		this.productQty = productQty;
	}
	public String getProductCategory() {
		return productCategory;
	}
	public void setProductCategory(String productCategory) {
		this.productCategory = productCategory;
	}
	public String getProductBrand() {
		return productBrand;
	}
	public void setProductBrand(String productBrand) {
		this.productBrand = productBrand;
	}
	public String getGender() {
		return gender;
	}
	public void setGender(String gender) {
		this.gender = gender;
	}
	public String getProductImage() {
		return productImage;
	}
	public void setProductImage(String productImage) {
		this.productImage = productImage;
	}
	public String getProductDeals() {
		return productDeals;
	}
	public void setProductDeals(String productDeals) {
		this.productDeals = productDeals;
	}

	
	
	
}