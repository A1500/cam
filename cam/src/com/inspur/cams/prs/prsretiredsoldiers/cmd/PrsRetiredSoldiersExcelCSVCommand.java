package com.inspur.cams.prs.prsretiredsoldiers.cmd;

import org.loushang.next.commons.nenum.EnumService;
import org.loushang.next.dao.DaoFactory;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.web.cmd.ExcelCSVCommand;

import com.inspur.cams.comm.dicm.IDicDao;

public class PrsRetiredSoldiersExcelCSVCommand extends ExcelCSVCommand {
	
	@Override
	protected String handleData(String colFieldName, Object val){
		String str = val.toString();
		System.out.println(str);
		ParameterSet pset = new ParameterSet();
		IDicDao dao = (IDicDao) DaoFactory.getDao("com.inspur.cams.comm.dicm.DicDao");
		DataSet ds = null;
		if("SEX".equals(colFieldName)) {
			String enumName = "COMM.SEX";
			EnumService service = getEnumService();
			str = service.getDescByValue(enumName, str);
			return str+"\t";
		}
		//民族
		//Ccom.inspur.cams.comm.dicm.DicQueryCmd
		if("NATION".equals(colFieldName)) {
			pset.clear();
			pset.setParameter("dic", "DIC_NATION");
			pset.setParameter("value", "CODE");
			pset.setParameter("text", "NAME");
			pset.setParameter("filterSql", " CODE ='"+str+"'");
			ds = dao.getDicMapList(pset);
			if(ds.getCount()>0){
				str = (String) ds.getRecord(0).get("text");
			}else{
				str = "汉族";
			}
			return str+"\t";
		}
		//士兵类型
		if("SOLDIERTYPE".equals(colFieldName)) {
			String enumName = "RETIREDSOLDIERTYPE.CODE";
			EnumService service = getEnumService();
			str = service.getDescByValue(enumName, str);
			return str+"\t";
		}
		//军区单位
		if("REGION".equals(colFieldName)) {
			pset.clear();
			pset.setParameter("dic", "DIC_MILITARY_REGION_CODE");
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
		
		//是否退档
		if("FLAG".equals(colFieldName)) {
			String enumName = "APPROVALSTATE.CODE";
			EnumService service = getEnumService();
			str = service.getDescByValue(enumName, str);
			return str+"\t";
		}
		
		return str+"\t";

	}
}
