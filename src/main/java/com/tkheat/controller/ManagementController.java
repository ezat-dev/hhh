package com.tkheat.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.tkheat.domain.Corp;
import com.tkheat.domain.Fac;
import com.tkheat.domain.Measure;
import com.tkheat.domain.Permission;
import com.tkheat.domain.Product;
import com.tkheat.domain.Standard;
import com.tkheat.domain.Users;
import com.tkheat.service.ManagementService;

@Controller
public class ManagementController {

	@Autowired
	private ManagementService managementService;

	@RequestMapping(value = "/management/login", method = RequestMethod.GET)
	public String login(Users users) {
		return "/management/login.jsp";

	}

	@RequestMapping(value = "/management/sideBar", method = RequestMethod.GET)
	public String sideBar(Users users) {
		return "/include/sideBar.jsp";

	}

	//제품등록 - 화면로드
	@RequestMapping(value = "/management/productInsert", method = RequestMethod.GET)
	public String productInsert(Users users) {

		return "/management/productInsert.jsp";
	}	 


	//제품등록 - 제품 저장
	@RequestMapping(value = "/management/productInsert/productInsertSave", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> productInsertSave(
			@ModelAttribute Product product){
		Map<String, Object> rtnMap = new HashMap<String, Object>();

		System.out.println(product);

		//			 managementService.productInsertSave(product);

		rtnMap.put("data", product);

		return rtnMap;
	}


	//전체 제품 목록 조회
	@RequestMapping(value = "/management/productInsert/productList", method = RequestMethod.POST) 
	@ResponseBody 
	public Map<String, Object> getProductList() {
		Map<String, Object> rtnMap = new HashMap<String, Object>();

		List<Product> productList = managementService.getProductList();

		List<HashMap<String, Object>> rtnList = new ArrayList<HashMap<String, Object>>();
		for(int i=0; i<productList.size(); i++) {
			HashMap<String, Object> rowMap = new HashMap<String, Object>();
			rowMap.put("idx", (i+1));
			rowMap.put("prod_code", productList.get(i).getProd_code());
			rowMap.put("prod_date", productList.get(i).getProd_date());
			rowMap.put("corp_name", productList.get(i).getCorp_name());
			rowMap.put("prod_name", productList.get(i).getProd_name());
			rowMap.put("prod_no", productList.get(i).getProd_no());
			rowMap.put("prod_gyu", productList.get(i).getProd_gyu());
			rowMap.put("prod_jai", productList.get(i).getProd_jai());
			rowMap.put("tech_no", productList.get(i).getTech_no());
			rowMap.put("prod_danj", productList.get(i).getProd_danj());
			rowMap.put("prod_danw", productList.get(i).getProd_danw());
			rowMap.put("prod_dang", productList.get(i).getProd_dang());
			rowMap.put("prod_pg", productList.get(i).getProd_pg());
			rowMap.put("prod_gd3", productList.get(i).getProd_gd3());
			rowMap.put("prod_sg", productList.get(i).getProd_sg());

			rtnList.add(rowMap);
		}

		rtnMap.put("last_page",1);
		rtnMap.put("data",rtnList);

		return rtnMap; 
	}	 


	//거래처등록 - 화면로드
	@RequestMapping(value = "/management/cutumInsert", method = RequestMethod.GET)
	public String custumInsert(Users users) {

		return "/management/cutumInsert.jsp";
	}

	//전체 거래처목록 조회
	@RequestMapping(value = "/management/cutumInsert/list", method = RequestMethod.POST) 
	@ResponseBody 
	public Map<String, Object> getCorpList() {
		Map<String, Object> rtnMap = new HashMap<String, Object>();

		List<Corp> corpList = managementService.getCorpList();

		List<HashMap<String, Object>> rtnList = new ArrayList<HashMap<String, Object>>();
		for(int i=0; i<corpList.size(); i++) {
			HashMap<String, Object> rowMap = new HashMap<String, Object>();
			rowMap.put("idx", (i+1));
			rowMap.put("corp_gubn", corpList.get(i).getCorp_gubn());
			rowMap.put("corp_name", corpList.get(i).getCorp_name());
			rowMap.put("corp_name2", corpList.get(i).getCorp_name2());
			rowMap.put("corp_no", corpList.get(i).getCorp_no());
			rowMap.put("corp_tel", corpList.get(i).getCorp_tel());
			rowMap.put("corp_fax", corpList.get(i).getCorp_fax());
			rowMap.put("corp_boss", corpList.get(i).getCorp_boss());
			rowMap.put("corp_mast", corpList.get(i).getCorp_mast());
			rowMap.put("corp_plc", corpList.get(i).getCorp_plc());

			rtnList.add(rowMap);
		}

		rtnMap.put("last_page",1);
		rtnMap.put("data",rtnList);

		return rtnMap; 
	}


	//설비등록 - 화면로드
	@RequestMapping(value = "/management/facInsert", method = RequestMethod.GET)
	public String facInsert(Users users) {

		return "/management/facInsert.jsp";
	}	

	//전체 설비목록 조회
	@RequestMapping(value = "/management/facInsert/getFacList", method = RequestMethod.POST) 
	@ResponseBody 
	public Map<String, Object> getFacList() {
		Map<String, Object> rtnMap = new HashMap<String, Object>();

		List<Fac> facList = managementService.getFacList();

		List<HashMap<String, Object>> rtnList = new ArrayList<HashMap<String, Object>>();
		for(int i=0; i<facList.size(); i++) {
			HashMap<String, Object> rowMap = new HashMap<String, Object>();
			rowMap.put("idx", (i+1));
			rowMap.put("fac_no", facList.get(i).getFac_no());
			rowMap.put("fac_name", facList.get(i).getFac_name());
			rowMap.put("fac_gyu", facList.get(i).getFac_gyu());
			rowMap.put("fac_hyun", facList.get(i).getFac_hyun());
			rowMap.put("fac_yong", facList.get(i).getFac_yong());
			rowMap.put("fac_plc", facList.get(i).getFac_plc());
			rowMap.put("fac_able", facList.get(i).getFac_able());
			rowMap.put("fac_make", facList.get(i).getFac_make());
			rowMap.put("fac_cbuy", facList.get(i).getFac_cbuy());

			rtnList.add(rowMap);
		}

		rtnMap.put("last_page",1);
		rtnMap.put("data",rtnList);

		return rtnMap; 
	}


	//침탄로기준등록 - 화면로드
	@RequestMapping(value = "/management/chimStandard", method = RequestMethod.GET)
	public String chimStandard(Users users) {

		return "/management/chimStandard.jsp";
	}		 

	//침탄로 작업표준 조회
	@RequestMapping(value = "/management/chimStandardInsert/getChimStandardList", method = RequestMethod.POST) 
	@ResponseBody 
	public Map<String, Object> getChimStandardList() {
		Map<String, Object> rtnMap = new HashMap<String, Object>();

		List<Standard> chimStandardList = managementService.getChimStandardList();

		List<HashMap<String, Object>> rtnList = new ArrayList<HashMap<String, Object>>();
		for(int i=0; i<chimStandardList.size(); i++) {
			HashMap<String, Object> rowMap = new HashMap<String, Object>();
			rowMap.put("idx", (i+1));
			rowMap.put("corp_name", chimStandardList.get(i).getCorp_name());
			rowMap.put("prod_name", chimStandardList.get(i).getProd_name());
			rowMap.put("prod_no", chimStandardList.get(i).getProd_no());
			rowMap.put("prod_kijong", chimStandardList.get(i).getProd_kijong());
			rowMap.put("prod_jai", chimStandardList.get(i).getProd_jai());
			rowMap.put("prod_dang", chimStandardList.get(i).getProd_dang());
			rowMap.put("fac_code", chimStandardList.get(i).getFac_code());
			rowMap.put("tech_te", chimStandardList.get(i).getTech_te());

			rtnList.add(rowMap);
		}

		rtnMap.put("last_page",1);
		rtnMap.put("data",rtnList);

		return rtnMap; 
	}


	//작업자등록 - 화면로드
	@RequestMapping(value = "/management/userinsert", method = RequestMethod.GET)
	public String userinsert(Users users) {
		return "/management/userinsert.jsp";	       
	}

	//작업자등록 - 저장
	@RequestMapping(value = "/management/userinsert/save", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> insertUser(@RequestBody Users users) {
		Map<String, Object> rtnMap = new HashMap<>();
		try {
			managementService.insertUser(users); 
			rtnMap.put("status", "success");
			rtnMap.put("message", "사용자 등록 성공");
		} catch (Exception e) {
			e.printStackTrace();
			rtnMap.put("status", "error");
			rtnMap.put("message", "사용자 등록 실패: " + e.getMessage());
		}
		return rtnMap; 
	}

	//고주파로작업표준 - 화면로드
	@RequestMapping(value = "/management/goStandard", method = RequestMethod.GET)
	public String goStandard(Users users) {

		return "/management/goStandard.jsp";
	}	

	//고주파로 작업표준 조회
	@RequestMapping(value = "/management/goStandardInsert/getGoStandardList", method = RequestMethod.POST) 
	@ResponseBody 
	public Map<String, Object> getGoStandardList() {
		Map<String, Object> rtnMap = new HashMap<String, Object>();

		List<Standard> goStandardList = managementService.getGoStandardList();

		List<HashMap<String, Object>> rtnList = new ArrayList<HashMap<String, Object>>();
		for(int i=0; i<goStandardList.size(); i++) {
			HashMap<String, Object> rowMap = new HashMap<String, Object>();
			rowMap.put("idx", (i+1));
			rowMap.put("corp_name", goStandardList.get(i).getCorp_name());
			rowMap.put("prod_name", goStandardList.get(i).getProd_name());
			rowMap.put("prod_no", goStandardList.get(i).getProd_no());
			rowMap.put("prod_kijong", goStandardList.get(i).getProd_kijong());
			rowMap.put("prod_jai", goStandardList.get(i).getProd_jai());
			rowMap.put("prod_dang", goStandardList.get(i).getProd_dang());
			rowMap.put("fac_code", goStandardList.get(i).getFac_code());
			rowMap.put("tech_te", goStandardList.get(i).getTech_te());

			rtnList.add(rowMap);
		}

		rtnMap.put("last_page",1);
		rtnMap.put("data",rtnList);

		return rtnMap; 
	}




	//PLUG점검기준등록 - 화면로드
	@RequestMapping(value = "/management/plugInspection", method = RequestMethod.GET)
	public String plugInspection(Users users) {

		return "/management/plugInspection.jsp";
	}	







	/*
	 * //전체 제품목록 조회
	 * 
	 * @RequestMapping(value = "/management/authority/productList", method =
	 * RequestMethod.POST)
	 * 
	 * @ResponseBody public Map<String, Object> getproductList() { Map<String,
	 * Object> rtnMap = new HashMap<String, Object>();
	 * 
	 * List<Product> prodList = managementService.getProductList();
	 * 
	 * List<HashMap<String, Object>> rtnList = new ArrayList<HashMap<String,
	 * Object>>(); for(int i=0; i<prodList.size(); i++) { HashMap<String, Object>
	 * rowMap = new HashMap<String, Object>(); rowMap.put("idx", (i+1));
	 * rowMap.put("prod_no", prodList.get(i).getProd_no()); rowMap.put("prod_name",
	 * prodList.get(i).getProd_name()); rowMap.put("prod_gyu",
	 * prodList.get(i).getProd_gyu()); rowMap.put("prod_jai",
	 * prodList.get(i).getProd_jai()); rowMap.put("prod_model",
	 * prodList.get(i).getProd_model());
	 * 
	 * rtnList.add(rowMap); }
	 * 
	 * rtnMap.put("last_page",1); rtnMap.put("data",rtnList);
	 * 
	 * return rtnMap; }
	 */ 

	//사원별 권한등록 화면 로드
	@RequestMapping(value = "/management/authority", method = RequestMethod.GET)
	public String authority(Users users) {

		return "/management/authority.jsp";	       
	}

	//전체 사용자목록 조회
	@RequestMapping(value = "/management/authority/userList", method = RequestMethod.POST) 
	@ResponseBody 
	public Map<String, Object> getUserList() {
		Map<String, Object> rtnMap = new HashMap<String, Object>();

		List<Users> userList = managementService.getUserList();

		List<HashMap<String, Object>> rtnList = new ArrayList<HashMap<String, Object>>();
		for(int i=0; i<userList.size(); i++) {
			HashMap<String, Object> rowMap = new HashMap<String, Object>();
			rowMap.put("idx", (i+1));
			rowMap.put("user_no", userList.get(i).getUser_no());
			rowMap.put("user_buso", userList.get(i).getUser_buso());
			rowMap.put("user_code", userList.get(i).getUser_code());
			rowMap.put("user_jick", userList.get(i).getUser_jick());
			rowMap.put("user_name", userList.get(i).getUser_name());
			rowMap.put("user_jdate", userList.get(i).getUser_jdate());
			rowMap.put("user_ret", userList.get(i).getUser_ret());
			rtnList.add(rowMap);
		}

		rtnMap.put("last_page",1);
		rtnMap.put("data",rtnList);

		return rtnMap; 
	}

	//사원별 권한등록 사용자 선택
	@RequestMapping(value = "/management/authority/userSelect", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> authorityUserSelect(
			@RequestParam(required = false) int user_code){
		Map<String, Object> rtnMap = new HashMap<String, Object>();

		Permission permission = new Permission();
		permission.setUser_code(user_code);

		Permission selectPermission = managementService.authorityUserSelect(permission);

		rtnMap.put("data", selectPermission);

		return rtnMap;
	}


	//사원별 권한등록 사용자 선택 후 수정
	@RequestMapping(value = "/management/authority/userSelectSave", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> authorityUserSelectSave(@ModelAttribute Permission permission){
		Map<String, Object> rtnMap = new HashMap<String, Object>();

		managementService.authorityUserSelectSave(permission);

		return rtnMap;
	}	 


	//측정기기관리 - 화면로드
	@RequestMapping(value = "/management/measurement", method = RequestMethod.GET)
	public String measurement(Users users) {

		return "/management/measurement.jsp";
	}	



	//전체 제품 목록 조회
	@RequestMapping(value = "/management/measurement/measureList", method = RequestMethod.POST) 
	@ResponseBody 
	public Map<String, Object> getMeasureList() {
		Map<String, Object> rtnMap = new HashMap<String, Object>();

		List<Measure> measureList = managementService.getMeasureList();

		List<HashMap<String, Object>> rtnList = new ArrayList<HashMap<String, Object>>();
		for(int i=0; i<measureList.size(); i++) {
			HashMap<String, Object> rowMap = new HashMap<String, Object>();
			rowMap.put("idx", (i+1));
			rowMap.put("ter_use", measureList.get(i).getTer_use());
			rowMap.put("ter_name", measureList.get(i).getTer_name());
			rowMap.put("ter_code", measureList.get(i).getTer_code());
			rowMap.put("ter_end_gum", measureList.get(i).getTer_end_gum());
			rowMap.put("ter_next_gum", measureList.get(i).getTer_next_gum());
			rowMap.put("ter_gum", measureList.get(i).getTer_gum());
			rowMap.put("ter_model", measureList.get(i).getTer_model());
			rowMap.put("ter_buy", measureList.get(i).getTer_buy());
			rowMap.put("ter_bdate", measureList.get(i).getTer_bdate());
			rowMap.put("ter_bmon", measureList.get(i).getTer_bmon());

			rtnList.add(rowMap);
		}

		rtnMap.put("last_page",1);
		rtnMap.put("data",rtnList);

		return rtnMap; 
	}	






	//코일등록 - 화면로드
	@RequestMapping(value = "/management/coilInsert", method = RequestMethod.GET)
	public String coilInsert(Users users) {

		return "/management/coilInsert.jsp";
	}	

	//PLUG등록 화면 로드
	@RequestMapping(value = "/management/plugInsert", method = RequestMethod.GET)
	public String plugInsert(Users users) {

		return "/management/plugInsert.jsp";
	}		 

	@RequestMapping(value = "/management/authority/big_Page", method = RequestMethod.POST)
	@ResponseBody
	public List<Users> getBigPageList() {

		return managementService.getBigPageList(); 
	}

	@RequestMapping(value = "/management/authority/small_page", method = RequestMethod.POST)
	@ResponseBody
	public List<Users> getSmallPage(@RequestBody Map<String, String> requestData) {
		String pageBig = requestData.get("page_big"); 
		System.out.println("받은 page_big: " + pageBig);  


		return managementService.getSmallPageList(pageBig); 
	}




}

