package com.tkheat.dao;

import java.util.List;



import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.tkheat.domain.Corp;
import com.tkheat.domain.Fac;
import com.tkheat.domain.Measure;
import com.tkheat.domain.Permission;
import com.tkheat.domain.Product;
import com.tkheat.domain.Standard;
import com.tkheat.domain.Users;
@Repository
public class ManagementDaoImpl implements ManagementDao {
	 @Autowired
	 private SqlSession sqlSession;
	 
	 //사용자 리스트 조회
	 @Override
	 public List<Users> getUserList(Users user) {
		 return sqlSession.selectList("users.getUserList", user);
	 }
	 
	 @Override
	 public List<Users> getBigPageList() {
		 return sqlSession.selectList("users.getBigPageList");
	 }
	 
	 @Override
	 public List<Users> getSmallPageList(String page_big) {  
		 return sqlSession.selectList("users.getSmallPageList", page_big);  
	 }
	 
	 //사용자 권한 리스트 조회
	 @Override
	 public Permission authorityUserSelect(Permission permission) {
		 return sqlSession.selectOne("users.authorityUserSelect",permission);
	 }
	 
	 //사용자 권한 저장
	@Override
	public void authorityUserSelectSave(Permission permission) {
		sqlSession.update("users.authorityUserSelectSave", permission);
	}
	
	
	
	
	@Override
	 public List<Product> getProductList(Product product) {
		 return sqlSession.selectList("product.getProductList",product);
	 }
	
	@Override
	public Product productInsertDetail(Product product) {
		return sqlSession.selectOne("product.productInsertDetail",product);
	}
	
	//제품 등록 저장 - insert
	@Override
	public void productInsertSave(Product product) {
		sqlSession.insert("product.productInsertSave", product);
	}
	
	//제품 수정 - update
	@Override
	public void productUpdateSave(Product product) {
		sqlSession.update("product.productUpdateSave", product);
	}

	//제품 삭제 - delete
	@Override
	public void productDelete(int prod_code) {
		sqlSession.delete("product.productDelete", prod_code);
	}
	
	
	
	
	
	
	//거래처 리스트 조회
	@Override
	 public List<Corp> getCorpList(Corp corp) {
		 return sqlSession.selectList("corp.getCorpList", corp);
	 }
	//거래처 더블클릭 조회
	@Override
	public Corp cutumInsertDetail(Corp corp) {
		return sqlSession.selectOne("corp.cutumInsertDetail",corp);
	}
	
	//거래처 등록 저장 - insert
	@Override
	public void cutumInsertSave(Corp corp) {
		sqlSession.insert("corp.cutumInsertSave", corp);
	}
	
	//거래처 수정 - update
	@Override
	public void cutumUpdateSave(Corp corp) {
		sqlSession.update("corp.cutumUpdateSave", corp);
	}
	
	//거래처 삭제 - delete
	@Override
	public void cutumDelete(int corp_code) {
		sqlSession.delete("corp.cutumDelete", corp_code);
	}
	
	
	
	
	
	
	
	@Override
	 public List<Fac> getFacList(Fac fac) {
		 return sqlSession.selectList("fac.getFacList", fac);
	 }
	
	@Override
	public Fac facInsertDetail(Fac fac) {
		return sqlSession.selectOne("fac.facInsertDetail",fac);
	}
	
	//설비 등록 저장 - insert
	@Override
	public void facInsertSave(Fac fac) {
		sqlSession.insert("fac.facInsertSave", fac);
	}

	//설비 수정 - update
	@Override
	public void facUpdateSave(Fac fac) {
		sqlSession.update("fac.facUpdateSave", fac);
	}
	
	//거래처 삭제 - delete
	@Override
	public void facDelete(int fac_code) {
		sqlSession.delete("fac.facDelete", fac_code);
	}
	
	
	
	
	
	
	@Override
	 public List<Measure> getMeasureList() {
		 return sqlSession.selectList("measure.getMeasureList");
	 }
	
	//측정기기 등록 저장 - insert
	@Override
	public void measureInsertSave(Measure measure) {
		sqlSession.insert("measure.measureInsertSave", measure);
	}

	//측정기기 수정 - update
	@Override
	public void measureUpdateSave(Measure measure) {
		sqlSession.update("measure.measureUpdateSave", measure);
	}

	//측정기기 삭제 - delete
	@Override
	public void measureDelete(int ter_code) {
		sqlSession.delete("measure.measureDelete", ter_code);
	}

	//측정기기 더블클릭 정보 조회
	@Override
	public Measure getMeasurmentDetail(Measure measure) {
		return sqlSession.selectOne("measure.getMeasurmentDetail", measure);
	}
	
	
	
	
	
	
	
	@Override
	 public List<Standard> getChimStandardList(Standard standard) {
		 return sqlSession.selectList("standard.getChimStandardList",standard);
	 }
	
	@Override
	public Standard getChimStandardDetail(Standard standard) {
		return sqlSession.selectOne("standard.getChimStandardDetail",standard);
	}
	
	@Override
	public void chimStandardInsertSave(Standard standard) {
		sqlSession.insert("standard.chimStandardInsertSave", standard);
	}
	
	@Override
	public void chimStandardUpdateSave(Standard standard) {
		sqlSession.update("standard.chimStandardUpdateSave", standard);
	}

	@Override
	public void chimStandardDelete(int wstd_code) {
		sqlSession.delete("standard.chimStandardDelete", wstd_code);
	}
	
	
	
	
	
	// gubn으로 구분하기 때문에 같은 쿼리 사용
	@Override
	 public List<Standard> getGoStandardList(Standard standard) {
		 return sqlSession.selectList("standard.getChimStandardList",standard);
	 }
	
	 @Override
	    public void insertUser(Users users) {
	        sqlSession.insert("users.insertUser", users); 
	    }


	
}

