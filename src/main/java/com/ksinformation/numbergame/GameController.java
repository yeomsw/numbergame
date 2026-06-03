package com.ksinformation.numbergame;

import javax.servlet.http.HttpSession;
import javax.websocket.Session;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.ksinformation.login.MemberDTO;

import javax.servlet.http.HttpServletResponse;


@Controller
public class GameController {
	
	@Autowired
	private GameService gameService;
	
	
	
	@GetMapping("/game-page")
	public String gamePage(Model model,HttpSession session, HttpServletResponse response) {
		
		setNoCache(response);
		
		if(session.getAttribute("loginMember")==null) {			
			return "redirect:/login-page";
			
		}else if(!model.containsAttribute("gameDTO")) {
			
			System.out.println("!model 동작");
			
			try {
				
				MemberDTO memberDTO = getLoginMember(session);
				GameDTO gameDTO = gameService.gameInit(memberDTO);
				model.addAttribute("gameDTO",gameDTO);
				System.out.println(gameDTO);
				return "gamePage";
								
			} catch (Exception e) {
				e.printStackTrace();
				return "redirect:/login-page";
			}
		} else {
			try {
				System.out.println("else문 출력");
				return "gamePage";
			}catch(Exception e){
				e.printStackTrace();
				return "redirect:/login-page";
			}
		}
	}
	
	@PostMapping("/play-game")
	public String playGame(GameDTO currentGameDTO,RedirectAttributes redirectAttributes,HttpSession session,@RequestParam("inputNum") String inputNum) {
		
		MemberDTO memberDTO = getLoginMember(session);
		
		try {
			GameDTO gameDTO = gameService.playGame(memberDTO, inputNum);
			System.out.println(gameDTO);
			redirectAttributes.addFlashAttribute("gameDTO", gameDTO);
		} catch (Exception e) {
			e.printStackTrace();	
			GameDTO gameDTO = gameService.gameInit(memberDTO);
			gameDTO.setMessage("データベースへの接続に失敗しました。");
			redirectAttributes.addFlashAttribute("gameDTO", gameDTO);
		}
		
		return "redirect:/game-page";
	}
	
	@GetMapping("/popup")
	public String popup(HttpSession session, Model model) {
		
		MemberDTO memberDTO = getLoginMember(session);
		GameDTO gameDTO = gameService.popupOpen(memberDTO);
		
		model.addAttribute("gameDTO",gameDTO);
		return "popupPage";
	}
	
	
	private MemberDTO getLoginMember(HttpSession session) {
		return (MemberDTO) session.getAttribute("loginMember");
	}
	
	private void setNoCache(HttpServletResponse response) {
		response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
	    response.setHeader("Pragma", "no-cache");
	    response.setDateHeader("Expires", 0);
	}	
	
}












