package com.inspur.cams.welfare.comm.cmd;

import org.loushang.next.commons.nenum.EnumService;
import org.loushang.next.dao.DaoFactory;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.web.cmd.ExcelCSVCommand;

import com.inspur.cams.comm.dicm.IDicDao;

public class WealCSVCommand extends ExcelCSVCommand {
	ParameterSet pset = new ParameterSet();
	IDicDao dao = (IDicDao) DaoFactory.getDao("com.inspur.cams.comm.dicm.DicDao");
	EnumService service = getEnumService();
	String str = "";
	DataSet ds = null;
	
	@Override
	protected String handleData(String colFieldName, Object val){
		str=val.toString();
		
		//性别
		if("SEX".equals(colFieldName)) {
			String enumName = "COMM.SEX";
			str = service.getDescByValue(enumName, str);
			return str+"\t";
		}
		
		
		//经济性质
		if("ECONOMIC_NATURE_CODE".equals(colFieldName)) {
			pset.clear();
			pset.setParameter("dic", "WEAL_DIC_ECONOMICNATURE");
			pset.setParameter("value", "CODE");
			pset.setParameter("text", "NAME");
			pset.setParameter("filterSql", " CODE ='"+str+"'");
			ds = dao.getDicMapList(pset);
			if(ds.getCount()>0){
				str = (String) ds.getRecord(0).get("text");
			}else{
				str = "";
			}
			return str+"\t";
		}
		//金额列不添加\t,excel打开后数字较大可能出现科学计数法，可通过调整列宽显示完整
		//基本信息查询
		if("REG_FUND".equals(colFieldName)
				||"OPERATE_AREA".equals(colFieldName)
				||"WORKER_NUM".equals(colFieldName)
				||"DIS_NUM".equals(colFieldName)){
			return str;
		}
		
		return str+"\t";
	}
}
