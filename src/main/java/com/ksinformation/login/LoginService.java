package com.ksinformation.login;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Service;

@Service
public class LoginService {
	
	@Autowired
	private MemberDAO memberDAO;
	
	public MemberDTO chkMember(MemberDTO memberDTO) {
		
		
		if(memberDAO.countByIdAndPassword(memberDTO)==1) {
			
			return memberDTO;
			
		}else {
			return null;
			
		}			
	}
}
