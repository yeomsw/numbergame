package com.ksinformation.numbergame;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
@ToString
public class ResultDTO {
	
	private String memberId;
	private int gameCount;
	private String inputNum;
	private String result;
	private Date gameDate;
	
}
