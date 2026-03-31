package com.tkheat.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.tkheat.domain.Permission;
import com.tkheat.domain.UserMenu;
import com.tkheat.domain.Users;
import com.tkheat.service.UserService;

@Controller
public class UserController {
	
	@Autowired
	private UserService userService;
	
	private static final Logger logger = LoggerFactory.getLogger(UserController.class);
	public static int USER_CODE = 0;
	
	/*사용자 로그인*/
	@RequestMapping(value="/user/login", method=RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> login(@ModelAttribute Users users, 
			HttpServletRequest request, HttpServletResponse response,
			HttpSession session) {
		 
		Map<String, Object> rtnMap = new HashMap<String, Object>();
		
		 if("".equals(users.getUser_id()) || users.getUser_id() == null){
			 rtnMap.put("data","아이디를 입력해주십시오!");
			 rtnMap.put("status","NG");
			 
			 return rtnMap;
		 }
		 
		 if("".equals(users.getUser_pwd()) || users.getUser_pwd() == null){
			 rtnMap.put("data","비밀번호를 입력해주십시오!");
			 rtnMap.put("status","NG");
			 
			 return rtnMap;
		 }
		
		//로그인을 클릭한 사용자의 아이디와 비밀번호가 같을 때
		Users loginUser = userService.getLoginUser(users);
		 
		 if(loginUser == null) {
			 rtnMap.put("data","등록되지 않은 사용자입니다.");
			 rtnMap.put("status","NG");
			 
			 return rtnMap;			 
		 }
		 
		 loginUser.setUser_ip(users.getUser_ip());
		 
		 userService.userLoginHisSave(loginUser);
		 
		 //로그인한 대상의 page정보 세션저장
		 Permission loginPermission = userService.userLoginPermission(loginUser);
		 session.setAttribute("loginUser",loginUser);
		 session.setAttribute("loginUserPage",loginPermission);
		 
		 USER_CODE = loginUser.getUser_code();
		 
		 rtnMap.put("data", loginUser);
		 rtnMap.put("status","OK");
		 rtnMap.put("loginUserPage", loginPermission);


		return rtnMap;
	}	
	
	 //로그인한 사용자의 메뉴셋팅
	 @RequestMapping(value = "/user/login/menuSetting", method = RequestMethod.POST) 
	 @ResponseBody 
	 public Map<String, Object> userLoginMenuSetting(HttpSession session) {
		 Map<String, Object> rtnMap = new HashMap<String, Object>();
		 
		 Permission pageData = (Permission)session.getAttribute("loginUserPage");
		 
		 rtnMap.put("data",pageData);
		 
		 return rtnMap;
	 }
	 
	 //로그인한 사용자의 메뉴저장
	 @RequestMapping(value = "/user/login/menuSave", method = RequestMethod.POST) 
	 @ResponseBody 
	 public Map<String, Object> userLoginMenuSave(
			 @RequestParam int user_code,
			 @RequestParam String menu_url,
			 @RequestParam String menu_name) {
		 Map<String, Object> rtnMap = new HashMap<String, Object>();
		 
		 UserMenu userMenu = new UserMenu();
		 userMenu.setUser_code(user_code);
		 userMenu.setMenu_url(menu_url);
		 userMenu.setMenu_name(menu_name);
		 
		 userService.userLoginMenuSave(userMenu);
		 
		 rtnMap.put("data","OK");
		 
		 return rtnMap;
	 }
	 
	 //로그인한 사용자의 메뉴저장
	 @RequestMapping(value = "/user/login/menuList", method = RequestMethod.POST) 
	 @ResponseBody 
	 public Map<String, Object> userLoginMenuList(
			 @RequestParam int user_code) {
		 Map<String, Object> rtnMap = new HashMap<String, Object>();
		 
		 UserMenu userMenu = new UserMenu();
		 userMenu.setUser_code(user_code);
		 
		 List<UserMenu> userMenuList = userService.userLoginMenuList(userMenu);
		 
		 rtnMap.put("data",userMenuList);
		 
		 return rtnMap;
	 }
	 
	 //로그인한 사용자의 메뉴저장
	 @RequestMapping(value = "/user/login/menuRemove", method = RequestMethod.POST) 
	 @ResponseBody 
	 public Map<String, Object> userLoginMenuRemove(
			 @RequestParam int user_code,
			 @RequestParam String menu_url) {
		 Map<String, Object> rtnMap = new HashMap<String, Object>();
		 
		 UserMenu userMenu = new UserMenu();
		 userMenu.setUser_code(user_code);
		 userMenu.setMenu_url(menu_url);
		 
		 userService.userLoginMenuRemove(userMenu);
		 
		 rtnMap.put("data","OK");
		 
		 return rtnMap;
	 }
	 
	 
	 //사용자 권한 유저info
	 @RequestMapping(value = "/user/info", method = RequestMethod.POST)
	 @ResponseBody
	 public Map<String, Object> getUserInfo(HttpSession session) {
	     Map<String, Object> result = new HashMap<>();
	     
	     // 세션에서 데이터 가져오기
	     Users loginUser = (Users) session.getAttribute("loginUser");
	     Permission loginPermission = (Permission) session.getAttribute("loginUserPage");

	 
	     if (loginUser != null) {
	         result.put("loginUser", loginUser);
	     }
	     if (loginPermission != null) {
	         result.put("loginUserPage", loginPermission);
	     }
	     
	     return result;
	 }
	 
	 
	 
	//로그아웃
	@RequestMapping(value="/user/logout", method=RequestMethod.GET)
	public String logout(HttpServletRequest request, HttpServletResponse response, HttpSession session) {
		Users users = (Users)session.getAttribute("loginUser");
		if(users != null) {
			session.removeAttribute("loginUser");
			session.invalidate();
		}
		return "redirect:/";
	}	
}

