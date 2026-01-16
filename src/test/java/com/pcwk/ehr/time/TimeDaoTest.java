package com.pcwk.ehr.time;

import static org.junit.jupiter.api.Assertions.*;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.junit.jupiter.api.AfterEach;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Disabled;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationContext;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit.jupiter.SpringExtension;

import com.pcwk.ehr.mapper.TimeMapper;
import com.pcwk.ehr.time.domain.TimeMapperVO;

@ExtendWith(SpringExtension.class)
@ContextConfiguration(locations = {
		"file:src/main/webapp/WEB-INF/spring/root-context.xml",
		"file:src/main/webapp/WEB-INF/spring/appServlet/servlet-context.xml"
})
class TimeDaoTest {

	final Logger log = LogManager.getLogger(getClass());

	@Autowired
	ApplicationContext  context;
	
	@Autowired
	TimeMapper timeMapper;
	
	TimeMapperVO timeVO;
	
	
	@BeforeEach
	void setUp() throws Exception {
		log.debug("┌──────────────────────────┐");
		log.debug("│──setup───────────────────│");
		log.debug("└──────────────────────────┘");		
		
		timeVO=new TimeMapperVO();
	}

	@Test
	void getDateTime() {
		log.debug("┌──────────────────────────┐");
		log.debug("│─getDateTime()            │");
		log.debug("└──────────────────────────┘");		
		
		String dateTime = timeMapper.getDateTime();
		log.debug("dateTime:{}",dateTime);
	}
	
	@Disabled
	@Test
	void doSelectOne() {
		log.debug("┌──────────────────────────┐");
		log.debug("│─doSelectOne()            │");
		log.debug("└──────────────────────────┘");	
		
		//param설정
		timeVO.setUserId("pcwk");
		timeVO.setPassword("4321a");
		
		//dao호출
		TimeMapperVO outVO=timeMapper.doSelectOne(timeVO);
		
		log.debug("outVO:{}",outVO);
		assertNotNull(outVO);
		
	}
	
	@AfterEach
	void tearDown() throws Exception {
		log.debug("┌──────────────────────────┐");
		log.debug("│─tearDown─────────────────│");
		log.debug("└──────────────────────────┘");			
	}

	@Disabled
	@Test
	void beans() {
		log.debug("┌──────────────────────────┐");
		log.debug("│─beans()                  │");
		log.debug("└──────────────────────────┘");
		
		log.debug("context:"+context);
		log.debug("timeMapper:"+timeMapper);
		
		assertNotNull(context);
		assertNotNull(timeMapper);
	}

}
