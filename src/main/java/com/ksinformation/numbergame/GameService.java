package com.ksinformation.numbergame;

import java.sql.Date;
import java.time.LocalDate;
import java.util.List;
import java.util.Random;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;

import com.ksinformation.login.MemberDTO;
import com.ksinformation.numbergame.GameDTO;

@Service
public class GameService {
	
	@Autowired
	GameDAO gameDAO;
	
		
	public GameDTO gameInit(MemberDTO memberDTO) {
		
		GameDTO gameDTO = new GameDTO();
		gameDTO = gameDAO.getPointInfo(memberDTO);
		LocalDate today = LocalDate.now();
		
		if(!gameDTO.getRecUpdateDate().toLocalDate().isEqual(today)) {
			System.out.println("초기화및 hideNum변경");
			gameDTO.setGameActFlg(0);
			gameDTO.setGameCount(0);
			gameDTO.setHideNum(hideNum());
			gameDAO.setHideNum(gameDTO);
			gameDAO.setPointInfo(gameDTO);
		}
		
		
		if(gameDTO.getGameCount()!=0) {
			gameDTO.setResultList(gameDAO.getGameResult(memberDTO));
		}
		
		return gameDTO;
	}

	public GameDTO playGame(MemberDTO memberDTO, String inputNum) {
		
		GameDTO gameDTO = gameDAO.getPointInfo(memberDTO);
		gameDTO.setResultList(getGameResultList(memberDTO));//이부분 파라미터 memberId로 바꿔야함
		ResultDTO resultDTO = new ResultDTO();
		
		if(gameDTO.getGameCount()!=0) {
			gameDTO.setResultList(gameDAO.getGameResult(memberDTO));
		}
		
		int k = gameDTO.getGameCount();
		k++;
		gameDTO.setGameCount(k);
		resultDTO.setMemberId(memberDTO.getMemberId());
		resultDTO.setGameCount(k);
		resultDTO.setInputNum(inputNum);
		resultDTO.setResult(checkNum(gameDTO.getHideNum(),inputNum));
		resultDTO.setGameDate(java.sql.Date.valueOf(java.time.LocalDate.now()));
		
		if(resultDTO.getResult().equals("3S")){ 
			int point = gameDTO.getPoint();
			int temp = 0;
			if(k>=1&&k<=5) {
				temp = 1000;

			} else if(k>=6&&k<=7) {
				temp = 500;

			} else {
				temp = 200;
				
			}
			
			point+=temp;
			gameDTO.setPoint(point); 
			gameDTO.setGameActFlg(1);
			gameDTO.setMessage("成功しました。");
		}
		
		if(k==10&&!resultDTO.getResult().equals("3S")) {
			gameDTO.setGameActFlg(1);
			gameDTO.setMessage("失敗しました。");
		}
		
		gameDAO.setPointInfo(gameDTO);
		gameDAO.setGameResult(resultDTO);
		List<ResultDTO> list = gameDTO.getResultList();
		list.add(resultDTO);
		gameDTO.setResultList(list); 
		return gameDTO;
		
	}
	
	public GameDTO popupOpen(MemberDTO memberDTO) {
		
		GameDTO gameDTO = null;
		
		try {
			gameDTO = gameDAO.getPointInfo(memberDTO);
			//여기에 3S인지 판단하고 넣어야함
			
			List<ResultDTO> list = gameDAO.getGameResult(memberDTO);
			ResultDTO lastResult = list.get(list.size()-1);
			
			if(lastResult.getResult().equals("3S")) {
				int temp = 0;
				int k = gameDTO.getGameCount();
				
				if(k>=1&&k<=5) {
					temp = 1000;

				} else if(k>=6&&k<=7) {
					temp = 500;

				} else {
					temp = 200;
				}
				gameDTO.setAddPoint(temp);
				gameDTO.setMessage("成功しました");
				return gameDTO;
				
			}else {
				gameDTO.setAddPoint(0);
				gameDTO.setMessage("挑戦に失敗しました");
				return gameDTO;
			}
			

		} catch (Exception e) {
			e.printStackTrace();
		}
		return gameDTO;
	}
	
	
	private List<ResultDTO> getGameResultList(MemberDTO memberDTO){
		
		List result = gameDAO.getGameResult(memberDTO);
		
		return result;
	}
	
	private String hideNum() {
		Random random = new Random();
		int hideNum1,hideNum2,hideNum3;
		hideNum1 = random.nextInt(10);
		hideNum2 = random.nextInt(10);
		hideNum3 = random.nextInt(10);
		
		while(hideNum1==hideNum2||hideNum2==hideNum3||hideNum1==hideNum3) {
			
			hideNum2=random.nextInt(10);
			hideNum3=random.nextInt(10);
		}
		String hideNum = Integer.toString(hideNum1) + Integer.toString(hideNum2) + Integer.toString(hideNum3);
		return hideNum;
	}
	
	private String checkNum(String hideNum, String inputNum) {
		
		String result;
		int[] R = new int[3];
		int[] IN = new int[3];
		
		for(int i=0;i<3;i++) {
			R[i] = Integer.parseInt(String.valueOf(hideNum.charAt(i)));
			IN[i] = Integer.parseInt(String.valueOf(inputNum.charAt(i)));
		}
		
		int s = 0 ,b = 0;
		
		for(int i=0;i<3;i++) {
			for(int j=0;j<3;j++) {
				
				if(R[i]==IN[j]) {
					if(i==j) {
						s++;
					}else {
					 	b++;
					}
				}	 
			}	 	 
		}
		if(s==0&&b==0) {
			result = "はずれ";
		} else if(s>0&&b==0) {
			result = s+"S";
		} else if(s==0&&b>0) {
			result = b+"B";
		} else {
			result = s+"S"+b+"B";
		}
		
		return result;
	}
	
}
























