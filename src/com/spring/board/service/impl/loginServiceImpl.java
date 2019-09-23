package com.spring.board.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.board.dao.BoardDao;
import com.spring.board.dao.LoginDao;
import com.spring.board.service.boardService;
import com.spring.board.service.loginService;
import com.spring.board.vo.BoardVo;
import com.spring.board.vo.LoginVo;
import com.spring.board.vo.PageVo;

@Service
public class loginServiceImpl implements loginService{
	
	@Autowired
	LoginDao LoginDao;

	@Override
	public List<Map<String, String>> getlogin_id_pw(String id) throws Exception {
		// TODO Auto-generated method stub
		
		return LoginDao.getlogin_id_pw(id);
	}

	@Override
	public int getloginAction(LoginVo loginVo) {
		// TODO Auto-generated method stub
		return LoginDao.getloginAction(loginVo);
	}

	@Override
	public int getcheckIdCnt(LoginVo loginVo) {
		// TODO Auto-generated method stub
		return LoginDao.getcheckIdCnt(loginVo);
	}

	@Override
	public int getjoinCnt(LoginVo loginVo) {
		// TODO Auto-generated method stub
		return LoginDao.getjoinCnt(loginVo);
	}

	@Override
	public String getUsername(LoginVo loginVo) {
		// TODO Auto-generated method stub
		return LoginDao.getUsername(loginVo);
	}

	
	
	
	
	

	
}
