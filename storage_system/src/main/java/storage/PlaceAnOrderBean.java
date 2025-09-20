package storage;

import java.sql.Timestamp;

public class PlaceAnOrderBean {
	private String orderer_id;
	private String s_id;
	private String item_id;
	private String item_name;
	private int item_weight;
	private Timestamp ordered_date;
	private Timestamp ordered_period;
	private char confirm_status;
	public String getOrderer_id() {
		return orderer_id;
	}
	public void setOrderer_id(String orderer_id) {
		this.orderer_id = orderer_id;
	}
	public String getS_id() {
		return s_id;
	}
	public void setS_id(String s_id) {
		this.s_id = s_id;
	}
	public String getItem_id() {
		return item_id;
	}
	public void setItem_id(String item_id) {
		this.item_id = item_id;
	}
	public String getItem_name() {
		return item_name;
	}
	public void setItem_name(String item_name) {
		this.item_name = item_name;
	}
	public int getItem_weight() {
		return item_weight;
	}
	public void setItem_weight(int item_weight) {
		this.item_weight = item_weight;
	}
	public Timestamp getOrdered_date() {
		return ordered_date;
	}
	public void setOrdered_date(Timestamp ordered_date) {
		this.ordered_date = ordered_date;
	}
	public Timestamp getOrdered_period() {
		return ordered_period;
	}
	public void setOrdered_period(Timestamp ordered_period) {
		this.ordered_period = ordered_period;
	}
	public char getConfirm_status() {
		return confirm_status;
	}
	public void setConfirm_status(char confirm_status) {
		this.confirm_status = confirm_status;
	}
	
	
}
