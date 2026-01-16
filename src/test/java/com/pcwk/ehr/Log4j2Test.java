package com.pcwk.ehr;

// import static org.junit.jupiter.api.Assertions.*;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.junit.jupiter.api.AfterEach;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Disabled;
import org.junit.jupiter.api.Test;

import com.google.gson.Gson;
import com.pcwk.ehr.cmn.MessageVO;


class Log4j2Test {
	final Logger log = LogManager.getLogger(getClass());
	
	
	@BeforeEach
	void setUp() throws Exception {
		log.debug("┌──────────────────────────┐");
		log.debug("│──setup───────────────────│");
		log.debug("└──────────────────────────┘");		
	}

	@AfterEach
	void tearDown() throws Exception {
		log.debug("┌──────────────────────────┐");
		log.debug("│─tearDown─────────────────│");
		log.debug("└──────────────────────────┘");		
	}
	
	@Test
	void jsonTest() {
		int flag = 1;
		String message = "등록 되었습니다";
		MessageVO messageVO = new MessageVO();
		messageVO.setFlag(flag);
		messageVO.setMessage(message);
		
		log.debug("3.message:{}",message);
		
		Gson gson=new Gson();
		String jsonString = gson.toJson(messageVO);
		log.debug("4.jsonString:{}\n:{}",jsonString);
		
	}

	@Test
	@Disabled
	void test() {
		log.debug("┌──────────────────────────┐");
		log.debug("│─test()                   │");
		log.debug("└──────────────────────────┘");	
		
		log.debug("debug");
		log.info("info");
		log.warn("warn");
		log.error("error");
		
	}

}
