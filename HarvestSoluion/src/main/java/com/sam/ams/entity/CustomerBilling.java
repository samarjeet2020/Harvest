package com.sam.ams.entity;

import java.io.Serializable;

public class CustomerBilling implements Serializable {
	private static final long serialVersionUID = 1L;


	

	
	String customerID;
	String customerName;
	String workType;
	String totalUnit;
	String chargePerUnit;
	String amount;
	String remarks;
	public String getCustomerID() {
		return customerID;
	}
	public void setCustomerID(String customerID) {
		this.customerID = customerID;
	}
	public String getCustomerName() {
		return customerName;
	}
	public void setCustomerName(String customerName) {
		this.customerName = customerName;
	}
	public String getWorkType() {
		return workType;
	}
	public void setWorkType(String workType) {
		this.workType = workType;
	}
	public String getTotalUnit() {
		return totalUnit;
	}
	public void setTotalUnit(String totalUnit) {
		this.totalUnit = totalUnit;
	}
	public String getChargePerUnit() {
		return chargePerUnit;
	}
	public void setChargePerUnit(String chargePerUnit) {
		this.chargePerUnit = chargePerUnit;
	}
	public String getAmount() {
		return amount;
	}
	public void setAmount(String amount) {
		this.amount = amount;
	}
	public String getRemarks() {
		return remarks;
	}
	public void setRemarks(String remarks) {
		this.remarks = remarks;
	}
	
	
	
	
}
