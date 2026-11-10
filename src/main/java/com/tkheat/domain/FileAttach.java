package com.tkheat.domain;

public class FileAttach {

	private int file_code;
	private int folder_code;
	private String original_name;
	private String saved_name;
	private long file_size;
	private String reg_user;
	private String reg_date;

	public int getFile_code() {
		return file_code;
	}

	public void setFile_code(int file_code) {
		this.file_code = file_code;
	}

	public int getFolder_code() {
		return folder_code;
	}

	public void setFolder_code(int folder_code) {
		this.folder_code = folder_code;
	}

	public String getOriginal_name() {
		return original_name;
	}

	public void setOriginal_name(String original_name) {
		this.original_name = original_name;
	}

	public String getSaved_name() {
		return saved_name;
	}

	public void setSaved_name(String saved_name) {
		this.saved_name = saved_name;
	}

	public long getFile_size() {
		return file_size;
	}

	public void setFile_size(long file_size) {
		this.file_size = file_size;
	}

	public String getReg_user() {
		return reg_user;
	}

	public void setReg_user(String reg_user) {
		this.reg_user = reg_user;
	}

	public String getReg_date() {
		return reg_date;
	}

	public void setReg_date(String reg_date) {
		this.reg_date = reg_date;
	}
}
