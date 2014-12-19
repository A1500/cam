package com.inspur.cams.comm.excel;

import java.io.UnsupportedEncodingException;
import org.loushang.next.commons.nenum.EnumService;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.web.cmd.OutExcelCommand;

public class SamReleaseExcelCommand extends OutExcelCommand {
	ParameterSet pset = new ParameterSet();
	EnumService service = getEnumService();
	String str = "";
	DataSet ds = null;
	public SamReleaseExcelCommand() {
		try {
			getRequest().setCharacterEncoding("utf-8");
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}
	}
	@Override
	protected String handleData(String colFieldName, Object val){
		str=val.toString();
		return str;
	}
}
