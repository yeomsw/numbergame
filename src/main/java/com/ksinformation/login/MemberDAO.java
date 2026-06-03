package com.ksinformation.login;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class MemberDAO {
	
	@Autowired
	private SqlSession sqlSession;
	
	public int countByIdAndPassword(MemberDTO memberDTO) {
		
		return sqlSession.selectOne("member.chkMember",memberDTO);		
	}
}
