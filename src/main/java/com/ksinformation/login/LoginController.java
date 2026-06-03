package com.ksinformation.login;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
public class LoginController {
	
	@Autowired
	LoginService loginService;
	
	
	@GetMapping("/login-page")
	public String loginPage() {
	    return "loginPage"; 
	}
	
	@PostMapping("/login")
	public String login(MemberDTO memberDTO,Model model,HttpSession session) {
		
		try {
			if(loginService.chkMember(memberDTO)!=null) {
				session.setAttribute("loginMember", memberDTO);
				return "redirect:/game-page";
			}else {
				model.addAttribute("errmsg","会員IDとパスワードを確認してください");
				return "loginPage";
			}
		} catch (DataAccessException e) {
			e.printStackTrace();
			model.addAttribute("errmsg","データベースへの接続に失敗しました");
			return "loginPage";
		} catch(Exception e) {
			e.printStackTrace();
			model.addAttribute("errmsg","システムエラーが発生しました");
			return "loginPage";
		}
			
	}
	
	@PostMapping("/logout")
	public String logout(HttpSession session) {
	    session.invalidate();
	    return "redirect:/login-page";
	}
	
}







