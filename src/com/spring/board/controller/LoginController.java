package com.spring.board.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;

import javax.servlet.http.*;

import org.codehaus.jackson.JsonProcessingException;
import org.codehaus.jackson.map.ObjectMapper;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.spring.board.HomeController;
import com.spring.board.controller.BoardController;
import com.spring.board.service.boardService;
import com.spring.board.service.loginService;
import com.spring.board.vo.BoardVo;
import com.spring.board.vo.LoginVo;
import com.spring.board.vo.PageVo;
import com.spring.common.CommonUtil;


@Controller
public class LoginController {
	
	@Autowired 
	loginService loginService;
	@Autowired 
	boardService boardService;
	
//	로그인 뷰이동 가상주소
	@RequestMapping(value = "/board/LoginView.do", method = {RequestMethod.GET})
	public String loginView(Locale locale, Model model,PageVo pageVo, LoginVo loginVo, HttpSession session ) throws Exception{
		
		
		
		
		return "board/LoginView";
	}
	
	//로그인 성공여부설정
	@RequestMapping(value = "/board/LoginViewAction.do", method = {RequestMethod.POST})
	@ResponseBody
	public String loginAction(Locale locale, Model model, LoginVo loginVo
			,HttpSession session) throws Exception{
		
		
		HashMap<String, String> result = new HashMap<String, String>();
	    CommonUtil commonUtil = new CommonUtil();
		
		int loginAction = loginService.getloginAction(loginVo);
		String user_name= loginService.getUsername(loginVo);
		
		if (loginAction==1) {
			session.setAttribute("loginVo", loginVo);
			session.setAttribute("USER_ID", loginVo.getUSER_ID() );
			session.setAttribute("USER_NAME", user_name);
		}
		
		result.put("success", (loginAction > 0)?"Y":"N");
		String callbackMsg = commonUtil.getJsonCallBackString(" ",result);
		
		System.out.println("callbackMsg:"+callbackMsg);
		System.out.println("resultCnt:"+loginAction);
		System.out.println(session.getAttribute(user_name));
		
		return callbackMsg ;
	}
	
	@RequestMapping(value = "/board/LoginBoardList.do", method = {RequestMethod.GET})
	public String LoginBoardList(Locale locale, Model model,PageVo pageVo, LoginVo loginVo, BoardVo boardVo
									,HttpSession session) throws Exception{
		
		//로그인 성공이후 게시판 나오게 하는 소스코드
		
//		System.out.println(loginVo.getUSER_ID()+","+loginVo.getUSER_PW());
//		System.out.println(session.getAttribute("USER_ID"));
		int page = 1;
		
		
		if(boardVo.getSelectPageNo()==0) {    //<1>
			boardVo.setSelectPageNo(1);
		}
		if(boardVo.getRowCntPerPage()==0) {   //<2>
			boardVo.setRowCntPerPage(10);
		}
		
		
		List<Map<String,String>> boardType = new ArrayList<Map<String,String>>();
		boardType=boardService.getboardType("menu");
		
		String code_id ="";
		String code_name ="";
		
		List<BoardVo> boardList = new ArrayList<BoardVo>();
		boardList = boardService.SelectBoardList(boardVo);
		
		int totalCnt = 0;
		totalCnt = boardService.selectBoardCnt();
		
		
		
		model.addAttribute("code_id", code_id);
		model.addAttribute("code_name", code_name);
		model.addAttribute("boardType", boardType);
		model.addAttribute("boardList", boardList);
		model.addAttribute("totalCnt", totalCnt);
		model.addAttribute("pageNo", page);
		
		
		return "board/LoginBoardList";
	}
	
//	JoinView가상주소
	@RequestMapping(value = "/board/JoinView.do", method = {RequestMethod.GET})
	public String JoinView(Locale locale, Model model,PageVo pageVo, LoginVo loginVo, HttpSession session ) throws Exception{
		
		List<Map<String,String>> USER_PHONE1 = new ArrayList<Map<String,String>>();
		USER_PHONE1=boardService.getboardType("phone");
		
		model.addAttribute("USER_PHONE1", USER_PHONE1);
		
		
		
		
		return "board/JoinView";
	}
	
//	중복확인실행문
	@RequestMapping(value = "/board/checkId.do", method = {RequestMethod.POST})
	@ResponseBody
	public String checkId(Locale locale, Model model, LoginVo loginVo
			,HttpSession session) throws Exception{
		
		
		HashMap<String, String> result = new HashMap<String, String>();
	    CommonUtil commonUtil = new CommonUtil();
		
		int checkIdCnt = loginService.getcheckIdCnt(loginVo);
		
		if (checkIdCnt==1) {
			session.setAttribute("loginVo", loginVo);
		}
		
		result.put("success", (checkIdCnt > 0)?"Y":"N");
		System.out.println(result.get("success"));
		String callbackMsg = commonUtil.getJsonCallBackString(" ",result);
		
		System.out.println("callbackMsg:"+callbackMsg);
		System.out.println("checkIdCnt:"+checkIdCnt);
		
		return callbackMsg ;
	}
	
	//Join 가상주소
	@RequestMapping(value = "/board/join.do", method = {RequestMethod.POST})
	@ResponseBody
	public String join(Locale locale, Model model, LoginVo loginVo, BoardVo boardVo
			,HttpSession session) throws Exception{
		
		
		HashMap<String, String> result = new HashMap<String, String>();
	    CommonUtil commonUtil = new CommonUtil();
		
		int joinCnt = loginService.getjoinCnt(loginVo);
		
		if (joinCnt==1) {
			session.setAttribute("loginVo", loginVo);
		}
		
		result.put("success", (joinCnt > 0)?"Y":"N");
		System.out.println(result.get("success"));
		String callbackMsg = commonUtil.getJsonCallBackString(" ",result);
		
		System.out.println("callbackMsg:"+callbackMsg);
		System.out.println("checkIdCnt:"+joinCnt);
		
		return callbackMsg ;
	}
	
	//로그인유지 상세보기
		@RequestMapping(value = "/board/{code_id}/{boardNum}/LoginboardView.do", method = RequestMethod.GET)
		public String boardView(Locale locale, Model model, BoardVo boardVo, LoginVo loginVo, HttpSession session
				,@PathVariable("code_id")String code_id
				,@PathVariable("boardNum")int boardNum) throws Exception{
			
//			System.out.println(boardVo.getCode_id());
//			System.out.println("getUSER_NAME "+boardVo.getUSER_NAME());
			
			boardVo = boardService.selectBoard(boardVo);
			
			
			
			
			
			
			model.addAttribute("code_id", code_id);
			model.addAttribute("boardNum", boardNum);
			model.addAttribute("board", boardVo);
			model.addAttribute("login", loginVo);
			
			
			return "board/LoginboardView";
		}
	
		//로그인유지 글쓰기 
		
		@RequestMapping(value = "/board/LoginboardWrite.do", method = RequestMethod.GET)
		public String LoginboardWrite(Locale locale, Model model,BoardVo boardVo, HttpSession session) throws Exception{
			List<Map<String,String>> boardType = new ArrayList<Map<String,String>>();
			boardType=boardService.getboardType("menu");
			
			System.out.println(boardVo.getUSER_NAME());
			
			model.addAttribute("boardType", boardType);
			
			
			return "board/LoginboardWrite";
		}
		
}
