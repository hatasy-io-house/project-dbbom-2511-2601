package com.pcwk.ehr.mapper;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;

import com.pcwk.ehr.time.domain.TimeMapperVO;

@Mapper
public interface TimeMapper {

	TimeMapperVO doSelectOne(TimeMapperVO parameter);

	@Select("SELECT SYSDATE FROM dual")
	String getDateTime();
}