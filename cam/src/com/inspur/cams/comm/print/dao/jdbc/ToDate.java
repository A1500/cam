package com.inspur.cams.comm.print.dao.jdbc;

public class ToDate {
	public String todate(String rowName){
		return "nvl(substr("+rowName+",0,4),'     ')||'年'||nvl(substr("+rowName+",6,2),'   ')||'月'||nvl(substr("+rowName+",9,2),'   ')||'日' ";
	}
}
