package model;

public class Orders {
	private int orderId;
	private int orderDate;
	private int orderCustomer;
	private int orderBill;
		
	public Orders() {
		// TODO Auto-generated constructor stub
	}
	
	public Orders(int orderId, int orderDate, int orderCustomer, int orderBill) {
		this.orderId =orderId;
		this.orderDate = orderDate;
		this.orderCustomer = orderCustomer;
		this.orderBill = orderBill;
		
	}
	
	public int getOrderId() {
		return orderId;
	}
	
	public void setOrderId(int orderId) {
		this.orderId = orderId;
	}
	
	public int getOrderDate() {
		return orderDate;
	}
	
	public void setOrderDate(int orderDate) {
		this.orderDate = orderDate;
	}
	
	public int getOrderCustomer() {
		return orderCustomer;
	}
	
	public void setOrderCustomer(int orderCustomer) {
		this.orderCustomer = orderCustomer;
	}
	
	public int getOrderBill() {
		return orderBill;
	}
	
	public void setOrderBill(int orderBill) {
		this.orderBill = orderBill;
	}
}
