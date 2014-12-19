package com.inspur.cams.marry.base.dao.jdbc;

import org.loushang.next.commons.nenum.EnumService;
import org.loushang.next.web.cmd.ExcelCSVCommand;

/**
 * 枚举类型名称
 * @author houhaiqing
 * @data 12/05/15
 *
 */
public class MrmEnumDao extends ExcelCSVCommand {

	//性别
	public String toSex(String sex){
		String enumName = "COMM.SEX";
		EnumService service = getEnumService();
		String str = service.getDescByValue(enumName, sex);
		
		return str;
	}
}
