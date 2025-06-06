package com.tkheat.dao;

import java.util.List;

import javax.annotation.Resource;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.tkheat.domain.Permission;
import com.tkheat.domain.UserMenu;
import com.tkheat.domain.Users;

@Repository
public class UserDaoImpl implements UserDao{

	@Resource(name="session")
	private SqlSession sqlSession;
	
	@Override
	public Users userMenuSelectCount(Users users) {
		return sqlSession.selectOne("users.userMenuSelectCount",users);
	}

	@Override
	public List<Users> usersMenuOkSelect(Users users) {
		return sqlSession.selectList("users.usersMenuOkSelect",users);
	}

	@Override
	public void userMenuDelete(Users users) {
		sqlSession.delete("users.userMenuDelete", users);
	}

	@Override
	public void userMenuClick(Users users) {
		sqlSession.insert("users.userMenuClick", users);
	}

	@Override
	public Users getLoginUser(Users users) {
		return sqlSession.selectOne("users.getLoginUser", users);
	}

	@Override
	public Permission userLoginPermission(Users loginUser) {
		return sqlSession.selectOne("users.userLoginPermission", loginUser);
	}

	@Override
	public List<UserMenu> userLoginMenuList(UserMenu userMenu) {
		
		//4. 해당 유저의 메뉴리스트 조회		
		List<UserMenu> userMenuList = sqlSession.selectList("users.userMenuList",userMenu);
		
		return userMenuList;
	}

	@Override
	public void userLoginMenuSave(UserMenu userMenu) {

		int menuValue = 0;
		String checkValue = "";
		
		//1. 해당 유저의 메뉴카운트가 10개인지		
		menuValue = sqlSession.selectOne("users.userMenuCount",userMenu);
		//2. 해당 유저에 선택한 메뉴가 Y이면서 있는지
		checkValue = sqlSession.selectOne("users.userMenuCheck",userMenu);
		//3. 1,2번 둘다 해당안될경우 저장
		if(menuValue < 10) {
			if(checkValue == null) {
				sqlSession.insert("users.userLoginMenuSave",userMenu);				
			}else if("N".equals(checkValue)) {
				sqlSession.update("users.userLoginMenuUpdate",userMenu);
			}
		}
	}

	@Override
	public void userLoginMenuRemove(UserMenu userMenu) {
		sqlSession.update("users.userLoginMenuRemove",userMenu);
	}

	@Override
	public void userLoginHisSave(Users users) {
		sqlSession.insert("users.userLoginHisSave",users);
	}

}
