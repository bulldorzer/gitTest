package com.spring.board.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;

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
import com.spring.board.service.boardService;
import com.spring.board.vo.BoardVo;
import com.spring.board.vo.PageVo;
import com.spring.common.CommonUtil;

@Controller
public class BoardController {
	
	@Autowired 
	boardService boardService;
	
	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);
	
	//게시판뷰 가상주소
	@RequestMapping(value = "/board/boardList.do", method = RequestMethod.GET)
	public String boardList(Locale locale, Model model,PageVo pageVo, BoardVo boardVo ) throws Exception{
		
		
		
		
		int page = 1;
		
		
		if(boardVo.getSelectPageNo()==0) {    //<1>
			boardVo.setSelectPageNo(1);
		}
		if(boardVo.getRowCntPerPage()==0) {   //<2>
			boardVo.setRowCntPerPage(10);
		}
		
		List<Map<String,String>> boardType = new ArrayList<Map<String,String>>();
		boardType=boardService.getboardType("menu");
//		System.out.println(boardVo.getBoardTitle());
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
		
		return "board/boardList";
	}
	
	//상세보기뷰로 이동
	@RequestMapping(value = "/board/{code_id}/{boardNum}/boardView.do", method = RequestMethod.GET)
	public String boardView(Locale locale, Model model, BoardVo boardVo
			,@PathVariable("code_id")String code_id
			,@PathVariable("boardNum")int boardNum) throws Exception{
		
		System.out.println(boardVo.getCode_id());
		
		
		boardVo = boardService.selectBoard(boardVo);
		
		
		
		
		model.addAttribute("code_id", code_id);
		model.addAttribute("boardNum", boardNum);
		model.addAttribute("board", boardVo);
		
		return "board/boardView";
	}
	
	//글쓰기 뷰로  이동
	@RequestMapping(value = "/board/boardWrite.do", method = RequestMethod.GET)
	public String boardWrite(Locale locale, Model model) throws Exception{
		List<Map<String,String>> boardType = new ArrayList<Map<String,String>>();
		boardType=boardService.getboardType("menu");
		
		model.addAttribute("boardType", boardType);
		
		return "board/boardWrite";
	}
	
	//글쓰기 등록
	@RequestMapping(value = "/board/boardWriteAction.do", method = RequestMethod.POST)
	@ResponseBody
	public String boardWriteAction(Locale locale,BoardVo boardVo) throws Exception{
	
		HashMap<String, String> result = new HashMap<String, String>();
		CommonUtil commonUtil = new CommonUtil();
		
		int resultCnt = boardService.boardInsert(boardVo);
		
		result.put("success", (resultCnt > 0)?"Y":"N");
		String callbackMsg = commonUtil.getJsonCallBackString(" ",result);
		
		System.out.println("callbackMsg::"+callbackMsg);
		
		return callbackMsg;
	}
	
	//수정페이지로 이동
	@RequestMapping(value = "/board/{code_id}/{boardNum}/boardUpdate.do", method = RequestMethod.GET)
	public String boardUpdate(Locale locale, Model model, BoardVo boardVo
			,@PathVariable("code_id")String code_id
			,@PathVariable("boardNum")int boardNum) throws Exception{
		
		
		
		
		boardVo = boardService.selectBoard(boardVo);
		
		model.addAttribute("code_id", code_id);
		model.addAttribute("boardNum", boardNum);
		model.addAttribute("board", boardVo);
		
		
		return "board/boardUpdate";
	}
	
	@RequestMapping(value = "/board/boardUpdateAction.do", method = RequestMethod.POST)
	@ResponseBody
	public String boardUpdate(Locale locale, Model model, BoardVo boardVo) throws Exception{
		
		HashMap<String, String> result = new HashMap<String, String>();
		CommonUtil commonUtil = new CommonUtil();
		
		int resultCnt = boardService.boardUpdate(boardVo);
		
		result.put("success", (resultCnt > 0)?"Y":"N");
		String callbackMsg = commonUtil.getJsonCallBackString(" ",result);
		
		System.out.println("callbackMsg::"+callbackMsg);
		
		return callbackMsg;
		
	}
	
//	삭제실행문
	@RequestMapping(value = "/board/boardDeleteAction.do", method = RequestMethod.POST)
	@ResponseBody
	public String boardDelete(Locale locale, Model model, BoardVo boardVo) throws Exception{
		
		HashMap<String, String> result = new HashMap<String, String>();
		CommonUtil commonUtil = new CommonUtil();
		
		int resultCnt = boardService.boardDelete(boardVo);
		
		result.put("success", (resultCnt > 0)?"Y":"N");
		String callbackMsg = commonUtil.getJsonCallBackString(" ",result);
		
		System.out.println("callbackMsg::"+callbackMsg);
		
		return callbackMsg;
		
	}
	
}
