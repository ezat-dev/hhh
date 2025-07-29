package com.tkheat.dao;

import java.util.List;

import com.tkheat.domain.Corp;
import com.tkheat.domain.Fac;
import com.tkheat.domain.Measure;
import com.tkheat.domain.Permission;
import com.tkheat.domain.Product;
import com.tkheat.domain.Standard;
import com.tkheat.domain.Users;

public interface ManagementDao {
	List<Users> getUserList(Users user); 
	
	List<Users> getBigPageList(); 
	
	List<Users> getSmallPageList(String page_big);

	Permission authorityUserSelect(Permission permission);

	void authorityUserSelectSave(Permission permission);
	
	
	List<Product> getProductList(Product product);
	
	Product productInsertDetail(Product product);
	
	void productInsertSave(Product product);
	
	void productUpdateSave(Product product);
	
	void productDelete(int prod_code);
	
	
	List<Corp> getCorpList(Corp corp); 
	
	Corp cutumInsertDetail(Corp corp);
	
	void cutumInsertSave(Corp corp);
	
	void cutumUpdateSave(Corp corp);
	
	void cutumDelete(int corp_code);
	
	
	List<Fac> getFacList(Fac fac);
	
	Fac facInsertDetail(Fac fac);
	
	void facInsertSave(Fac fac);
	
	void facUpdateSave(Fac fac);
	
	void facDelete(int fac_code);
	
	
	
	
	List<Measure> getMeasureList();
	
	void measureInsertSave(Measure measure);
	
	void measureUpdateSave(Measure measure);
	
	void measureDelete(int ter_code);
	
	Measure getMeasurmentDetail(Measure measure);
	
	
	
	List<Standard> getChimStandardList(Standard standard);
	
	Standard getChimStandardDetail(Standard standard);
	
	void chimStandardInsertSave(Standard standard);
	
	void chimStandardUpdateSave(Standard standard);
	
	void chimStandardDelete(int wstd_code);
	
	
	
	
	List<Standard> getGoStandardList(Standard standard);
	
	void insertUser(Users users);

	
}
