package com.spring.board.dao.impl;

import java.util.*;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.spring.board.dao.BoardDao;
import com.spring.board.dao.LoginDao;
import com.spring.board.vo.BoardVo;
import com.spring.board.vo.LoginVo;
import com.spring.board.vo.PageVo;

@Repository
public class LoginDaoImpl implements LoginDao{
	
	@Autowired
	private SqlSession sqlSession;

	@Override
	public List<Map<String, String>> getlogin_id_pw(String id) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public int getloginAction(LoginVo loginVo) {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("login.getloginAction",loginVo);
	}

	@Override
	public int getcheckIdCnt(LoginVo loginVo) {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("login.getcheckIdCnt",loginVo);
	}

	@Override
	public int getjoinCnt(LoginVo loginVo) {
		// TODO Auto-generated method stub
		return sqlSession.insert("login.getjoinCnt",loginVo);
	}

	@Override
	public String getUsername(LoginVo loginVo) {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("login.getUsername", loginVo);
	}
	
	
	
}
