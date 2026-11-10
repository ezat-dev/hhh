package com.tkheat.domain;

public class FileFolder {

	private int folder_code;
	private Integer parent_code;	//null이면 최상위 폴더
	private String folder_name;
	private int sort_order;
	private String reg_user;
	private String reg_date;

	//조회용 부가 정보(쿼리 결과 전용)
	private int file_count;		//이 폴더에 직접 들어있는 파일 수
	private int sub_folder_count;	//이 폴더 바로 아래 하위폴더 수

	public int getFolder_code() {
		return folder_code;
	}

	public void setFolder_code(int folder_code) {
		this.folder_code = folder_code;
	}

	public Integer getParent_code() {
		return parent_code;
	}

	public void setParent_code(Integer parent_code) {
		this.parent_code = parent_code;
	}

	public String getFolder_name() {
		return folder_name;
	}

	public void setFolder_name(String folder_name) {
		this.folder_name = folder_name;
	}

	public int getSort_order() {
		return sort_order;
	}

	public void setSort_order(int sort_order) {
		this.sort_order = sort_order;
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

	public int getFile_count() {
		return file_count;
	}

	public void setFile_count(int file_count) {
		this.file_count = file_count;
	}

	public int getSub_folder_count() {
		return sub_folder_count;
	}

	public void setSub_folder_count(int sub_folder_count) {
		this.sub_folder_count = sub_folder_count;
	}
}
