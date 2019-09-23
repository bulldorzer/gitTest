package com.spring.board.service;

import java.util.List;
import java.util.Map;

import com.spring.board.vo.BoardVo;
import com.spring.board.vo.LoginVo;
import com.spring.board.vo.PageVo;

public interface loginService {

	

	public List<Map<String, String>> getlogin_id_pw(String id) throws Exception;

	public int getloginAction(LoginVo loginVo);

	public int getcheckIdCnt(LoginVo loginVo);

	public int getjoinCnt(LoginVo loginVo);

	public String getUsername(LoginVo loginVo);



	

	
	
	
	

}
