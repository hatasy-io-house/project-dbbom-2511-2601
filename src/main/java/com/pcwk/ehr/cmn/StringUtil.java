package com.pcwk.ehr.cmn;

import com.google.common.base.Strings;

public class StringUtil {

	/**
	 * value가 0이면 defaultValue로 변경
	 * @param value
	 * @param defaultValue
	 * @return int
	 */
	public static int nvlZero(int value, int defaultValue) {
		return (0==value)?defaultValue:value;
	}
	
	/**
	 * value가 null이면 defaultValue로 변경
	 * @param value
	 * @param defaultValue
	 * @return String
	 */
	public static String nvlString(String value, String defaultValue) {
		if(Strings.isNullOrEmpty(value)==true) {
			return defaultValue;
		}
		
		return value;
	}
	
	/**
	 * value null이면 ""를 return
	 * @param value
	 * @return String
	 */
	public static String nullToEmpty(String value) {
		return Strings.nullToEmpty(value);
	}
	
	
	
}
