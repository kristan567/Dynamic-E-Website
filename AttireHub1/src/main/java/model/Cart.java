package model;

public class Cart {
	private int cusId;
	private int productId;
	private int productQuantity;
	private int TotalPrice;
	
	public Cart(int cusId, int productId, int productQuantity, int TotalPrice){
		this.cusId = cusId;
		this.productId = productId;
		this.productQuantity = productQuantity;
		this.TotalPrice = TotalPrice;
	}
	
	public Cart() {}

	public int getCusId() {
		return cusId;
	}

	public void setCusId(int cusId) {
		this.cusId = cusId;
	}

	public int getProductId() {
		return productId;
	}

	public void setProductId(int productId) {
		this.productId = productId;
	}

	public int getProductQuantity() {
		return productQuantity;
	}

	public void setProductQuantity(int productQuantity) {
		this.productQuantity = productQuantity;
	}

	public int getTotalPrice() {
		return TotalPrice;
	}

	public void setTotalPrice(int totalPrice) {
		TotalPrice = totalPrice;
	}
	
	
}
