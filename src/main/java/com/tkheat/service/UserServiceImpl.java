package com.tkheat.service;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.tkheat.dao.UserDao;
import com.tkheat.domain.Permission;
import com.tkheat.domain.UserMenu;
import com.tkheat.domain.Users;

@Service
public class UserServiceImpl implements UserService{

	@Autowired
	private UserDao userDao;

	@Override
	public Users userMenuSelectCount(Users users) {
		return userDao.userMenuSelectCount(users);
	}

	@Override
	public List<Users> usersMenuOkSelect(Users users) {
		return userDao.usersMenuOkSelect(users);
	}

	@Override
	public void userMenuDelete(Users users) {
		userDao.userMenuDelete(users);
	}

	@Override
	public void userMenuClick(Users users) {
		userDao.userMenuClick(users);
	}

	@Override
	public Users getLoginUser(Users users) {
		return userDao.getLoginUser(users);
	}
	
	//_로 구분해서 사용자가 선택한 메뉴의 이름과 링크를 분리
	public List<Users> menuList(Users users){
		List<Users> tabList = usersMenuOkSelect(users);
		List<Users> menuList = new ArrayList<>();
		for(int i=0; i<tabList.size(); i++) {
			Users tempMap = new Users();
			/*
//			String[] temp = tabList.get(i).getMenu_name().split("_");
//			String name = temp[0];
//			String link = temp[1];
			
			String[] tempLink = link.split("/");

			tempMap.setMenu_name(name);
			tempMap.setMenu_url(link);
			tempMap.setTab_id(tempLink[1]+tempLink[2]); 
			tempMap.setTab_idx(i);
*/
			menuList.add(tempMap);
		}
		
		
		return menuList;
	}

	@Override
	public Permission userLoginPermission(Users loginUser) {
		return userDao.userLoginPermission(loginUser);
	}

	@Override
	public void userLoginMenuSave(UserMenu userMenu) {
		userDao.userLoginMenuSave(userMenu);
	}

	@Override
	public List<UserMenu> userLoginMenuList(UserMenu userMenu) {
		return userDao.userLoginMenuList(userMenu);
	}

	@Override
	public void userLoginMenuRemove(UserMenu userMenu) {
		userDao.userLoginMenuRemove(userMenu);
	}

	@Override
	public void userLoginHisSave(Users users) {
		userDao.userLoginHisSave(users);
	}

}
