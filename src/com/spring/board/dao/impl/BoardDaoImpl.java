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
	
//	�Խ��� ��� ���� ǥ���ϱ����� sqlSession�� selectList�޼ҵ� ȣ�� List�� ������� �����Ѵ�.List<Dto(Vo)>
	@Override
	public List<BoardVo> selectBoardList(BoardVo boardVo) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.selectList("board.boardList",boardVo);
	}
	
//	�Խ��� �� ������ ���ϴ� ����
	@Override
	public int selectBoardCnt() throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("board.boardTotal");
	}
	
	//�󼼺���ȭ���� �����͸� DB�����ϴ� ����
	@Override
	public BoardVo selectBoard(BoardVo boardVo) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("board.boardView", boardVo);
	}
	
//	�۾��� �����͸� DB�� �Է��ϴ� ����
	@Override
	public int boardInsert(BoardVo boardVo) throws Exception {
		// TODO Auto-generated method stub
		System.out.println(boardVo.getBoardTitle());
		System.out.println(boardVo.getBoardComment());
		System.out.println(boardVo.getBoardType());
		return sqlSession.insert("board.boardInsert", boardVo);
	}
	
//	�ۼ����ϴ� �����͸� DB�� �����ϴ� ����
	@Override
	public int boardUpdate(BoardVo boardVo) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.update("board.boardUpdate", boardVo);
	}
	
//	�ۻ����ϱ� ���� DB�����͸� �����ϴ� ����
	@Override
	public int boardDelete(BoardVo boardVo) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.delete("board.boardDelete", boardVo);
	}
	
//	�۾��⶧ ��Ÿ���� �����ϱ� ���� ����
	@Override
	public List<Map<String, String>> getboardType(String String) {
		// TODO Auto-generated method stub
		return sqlSession.selectList("board.getboardType",String);
	}
	
}
