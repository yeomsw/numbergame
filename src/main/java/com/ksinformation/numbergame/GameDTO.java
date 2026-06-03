package com.ksinformation.numbergame;

import java.sql.Date;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.List;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@AllArgsConstructor
@NoArgsConstructor
@Getter
@Setter
@ToString
public class GameDTO {
	
	private String memberId;
	private int point;
	private String hideNum;
	private int gameCount;
	//0未終了　1終了　
	private int gameActFlg;
	private int addPoint;
	
	private String message;
	
	private Date recCreateDate;
	private Date recUpdateDate;
	
	private List<ResultDTO> resultList;
	
	
}


