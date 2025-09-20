package storage;

import java.sql.Timestamp;

public class StoredItemsBean {
	private String item_id;
	private String item_name;
	private int item_weight;
	private String s_id;
	private Timestamp stored_date;
	private Timestamp expire_date;
	
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
	public String getS_id() {
		return s_id;
	}
	public void setS_id(String s_id) {
		this.s_id = s_id;
	}
	public Timestamp getStored_date() {
		return stored_date;
	}
	public void setStored_date(Timestamp stored_date) {
		this.stored_date = stored_date;
	}
	public Timestamp getExpire_date() {
		return expire_date;
	}
	public void setExpire_date(Timestamp expire_date) {
		this.expire_date = expire_date;
	}
	
	
	
}
