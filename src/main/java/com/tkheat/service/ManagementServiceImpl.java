package com.tkheat.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.tkheat.dao.ManagementDao;
import com.tkheat.domain.Corp;
import com.tkheat.domain.Fac;
import com.tkheat.domain.Measure;
import com.tkheat.domain.Permission;
import com.tkheat.domain.Product;
import com.tkheat.domain.Standard;
import com.tkheat.domain.Users;

@Service
public class ManagementServiceImpl implements ManagementService {
	@Autowired
	private ManagementDao managementDao;
	
	@Override
	public List<Users> getUserList(Users user){
		return managementDao.getUserList(user);
	}
	@Override
	public List<Users> getBigPageList(){
		return managementDao.getBigPageList();
	}
	
	@Override
	public List<Users> getSmallPageList(String page_big) {  
		return managementDao.getSmallPageList(page_big);  
	}
	
	@Override
	public Permission authorityUserSelect(Permission permission) {
		return managementDao.authorityUserSelect(permission);
	}
	
	
	
	
	
	
	
	
	@Override
	public List<Product> getProductList(Product product){
		return managementDao.getProductList(product);
	}
	
	@Override
	public Product productInsertDetail(Product product) {
		return managementDao.productInsertDetail(product);
	}
	
	@Override
	public void productInsertSave(Product product) {
		managementDao.productInsertSave(product);
	}
	
	@Override
	public void productUpdateSave(Product product) {
		managementDao.productUpdateSave(product);
	}
	
	@Override
	public void productDelete(int prod_code) {
		managementDao.productDelete(prod_code);
	}
	
	
	
	
	
	@Override
	public List<Corp> getCorpList(Corp corp){
		return managementDao.getCorpList(corp);
	}
	
	@Override
	public Corp cutumInsertDetail(Corp corp) {
		return managementDao.cutumInsertDetail(corp);
	}
	
	@Override
	public void cutumInsertSave(Corp corp) {
		managementDao.cutumInsertSave(corp);
	}
	
	@Override
	public void cutumUpdateSave(Corp corp) {
		managementDao.cutumUpdateSave(corp);
	}
	
	@Override
	public void cutumDelete(int corp_code) {
		managementDao.cutumDelete(corp_code);
	}
	
	@Override
	public Measure getMeasurmentDetail(Measure measure) {
		return managementDao.getMeasurmentDetail(measure);
	}
	
	
	
	
	
	@Override
	public List<Fac> getFacList(Fac fac){
		return managementDao.getFacList(fac);
	}
	
	@Override
	public Fac facInsertDetail(Fac fac) {
		return managementDao.facInsertDetail(fac);
	}
	
	@Override
	public void facInsertSave(Fac fac) {
		managementDao.facInsertSave(fac);
	}
	
	@Override
	public void facUpdateSave(Fac fac) {
		managementDao.facUpdateSave(fac);
	}
	
	@Override
	public void facDelete(int fac_code) {
		managementDao.facDelete(fac_code);
	}
	
	
	
	
	
	
	@Override
	public List<Measure> getMeasureList(){
		return managementDao.getMeasureList();
	}
	
	@Override
	public void measureInsertSave(Measure measure) {
		managementDao.measureInsertSave(measure);
	}
	
	@Override
	public void measureUpdateSave(Measure measure) {
		managementDao.measureUpdateSave(measure);
	}
	
	@Override
	public void measureDelete(int ter_code) {
		managementDao.measureDelete(ter_code);
	}
	
	
	
	@Override
	public List<Standard> getChimStandardList(Standard standard){
		return managementDao.getChimStandardList(standard);
	}
	
	@Override
	public Standard getChimStandardDetail(Standard standard) {
		return managementDao.getChimStandardDetail(standard);
	}
	
	@Override
	public void chimStandardInsertSave(Standard standard) {
		managementDao.chimStandardInsertSave(standard);
	}
	
	@Override
	public void chimStandardUpdateSave(Standard standard) {
		managementDao.chimStandardUpdateSave(standard);
	}
	
	@Override
	public void chimStandardDelete(int wstd_code) {
		managementDao.chimStandardDelete(wstd_code);
	}
	
	@Override
	public List<Standard> getGoStandardList(Standard standard){
		return managementDao.getGoStandardList(standard);
	}
	
	
	
	
	@Override
    public void insertUser(Users users) {
        managementDao.insertUser(users); 
    
    }
	
	@Override
	public void updateUser(Users users) {
	    managementDao.updateUser(users);
	}
	
	@Override
    public Users userDetail(Users user) {
        return managementDao.userDetail(user);
    }

    @Override
    public void deleteUser(int user_code) {
    	managementDao.deleteUser(user_code);
    }
    
    @Override
    public void insertPermission(Permission permission) {
    	managementDao.insertPermission(permission); 
    }
    
    

    /**
     * 권한 저장 (INSERT/UPDATE 자동 판단)
     */
    @Override
    public void authorityUserSelectSave(Permission permission) {
        // 1. 해당 사용자의 권한 데이터 존재 여부 확인
        int count = managementDao.checkPermissionExists(permission.getUser_code());
        
        // 2. 존재하지 않으면 INSERT, 존재하면 UPDATE
        if (count == 0) {
            System.out.println("✅ PERMISSION 데이터 없음 → INSERT 실행 (user_code: " + permission.getUser_code() + ")");
            managementDao.insertPermission(permission);
        } else {
            System.out.println("✅ PERMISSION 데이터 있음 → UPDATE 실행 (user_code: " + permission.getUser_code() + ")");
            managementDao.updatePermission(permission);
        }
    }

    /**
     * 권한 존재 여부 확인
     */
    @Override
    public int checkPermissionExists(int user_code) {
        return managementDao.checkPermissionExists(user_code);
    }
}
