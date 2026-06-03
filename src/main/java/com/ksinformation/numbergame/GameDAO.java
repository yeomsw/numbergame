package com.ksinformation.numbergame;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.ksinformation.login.MemberDTO;

@Repository
public class GameDAO {
	
	@Autowired
	private SqlSession sqlSession;
	
	public GameDTO getPointInfo(MemberDTO memberDTO) {
		return sqlSession.selectOne("game.getPointInfo",memberDTO);
	}
	
	public void setHideNum(GameDTO gameDTO) {
		sqlSession.update("game.setHideNum",gameDTO);
	}
	
	public List<ResultDTO> getGameResult(MemberDTO memberDTO) {
		return sqlSession.selectList("game.getGameResult",memberDTO);
	}
	
	public void setPointInfo(GameDTO gameDTO) {
		sqlSession.update("game.setPointInfo",gameDTO);
	}
	
	public void setGameResult(ResultDTO resultDTO) {
		sqlSession.insert("game.setGameResult",resultDTO);
	}
}

