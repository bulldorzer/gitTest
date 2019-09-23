package com.spring.board.dao.impl;

import java.util.*;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.spring.board.dao.BoardDao;
import com.spring.board.vo.BoardVo;
import com.spring.board.vo.PageVo;

@Repository
public class BoardDaoImpl implements BoardDao{
	
	@Autowired
	private SqlSession sqlSession;
	
	
	@Override
	public String selectTest() throws Exception {
		// TODO Auto-generated method stub
		
		String a = sqlSession.selectOne("board.boardList");
		
		return a;
	}
	
//	게시판 모든 글을 표시하기위한 sqlSession의 selectList메소드 호출 List로 모든행을 저장한다.List<Dto(Vo)>
	@Override
	public List<BoardVo> selectBoardList(BoardVo boardVo) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.selectList("board.boardList",boardVo);
	}
	
//	게시판 글 갯수를 구하는 구문
	@Override
	public int selectBoardCnt() throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("board.boardTotal");
	}
	
	//상세보기화면의 데이터를 DB연동하는 구문
	@Override
	public BoardVo selectBoard(BoardVo boardVo) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("board.boardView", boardVo);
	}
	
//	글쓰기 데이터를 DB에 입력하는 구문
	@Override
	public int boardInsert(BoardVo boardVo) throws Exception {
		// TODO Auto-generated method stub
		System.out.println(boardVo.getBoardTitle());
		System.out.println(boardVo.getBoardComment());
		System.out.println(boardVo.getBoardType());
		return sqlSession.insert("board.boardInsert", boardVo);
	}
	
//	글수정하는 데이터를 DB에 수정하는 구문
	@Override
	public int boardUpdate(BoardVo boardVo) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.update("board.boardUpdate", boardVo);
	}
	
//	글삭제하기 위해 DB데이터를 삭제하는 구문
	@Override
	public int boardDelete(BoardVo boardVo) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.delete("board.boardDelete", boardVo);
	}
	
//	글쓰기때 글타입으 선택하기 위한 구문
	@Override
	public List<Map<String, String>> getboardType(String String) {
		// TODO Auto-generated method stub
		return sqlSession.selectList("board.getboardType",String);
	}
	
}
