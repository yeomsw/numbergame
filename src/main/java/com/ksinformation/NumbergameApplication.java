package com.ksinformation;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

@SpringBootApplication(scanBasePackages = "com.ksinformation")
public class NumbergameApplication {

	public static void main(String[] args) {
		SpringApplication.run(NumbergameApplication.class, args);
		System.out.print("success");
	}

}
