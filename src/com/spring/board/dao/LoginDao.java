package com.spring.board.dao;

import java.util.List;
import java.util.Map;

import com.spring.board.vo.BoardVo;
import com.spring.board.vo.LoginVo;
import com.spring.board.vo.PageVo;

public interface LoginDao {

	List<Map<String, String>> getlogin_id_pw(String id);

	int getloginAction(LoginVo loginVo);

	int getcheckIdCnt(LoginVo loginVo);

	int getjoinCnt(LoginVo loginVo);

	String getUsername(LoginVo loginVo);



	
	


}
