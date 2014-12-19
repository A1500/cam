package com.inspur.cams.fis.util;

import org.loushang.next.commons.nenum.EnumService;
import org.loushang.next.dao.DaoFactory;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.web.cmd.ExcelCSVCommand;

import com.inspur.cams.comm.dicm.IDicDao;
/**
 * gird导出Excel用
 * @author YLL
 * @since 2013年5月30日
 */
public class FisCSVCommand extends ExcelCSVCommand {
	ParameterSet pset = new ParameterSet();
	IDicDao dao = (IDicDao) DaoFactory.getDao("com.inspur.cams.comm.dicm.DicDao");
	EnumService service = getEnumService();
	String str = "";
	DataSet ds = null;
	
	@Override
	protected String handleData(String colFieldName, Object val){
		str=val.toString();
		//优惠类型字典
		if("bank".equals(colFieldName)) {
			pset.clear();
			pset.setParameter("dic", "FIS_REDUCATION_TYPE");
			pset.setParameter("value", "REDUCATION_TYPE_ID");
			pset.setParameter("text", "REDUCATION_TYPE_NAME");
			pset.setParameter("filterSql", " CODE ='"+str+"'");
			ds = dao.getDicMapList(pset);
			if(ds.getCount()>0){
				str = (String) ds.getRecord(0).get("text");
			}else{
				str = "";
			}
			return str+"\t";
		}
		
		//死亡原因
		if("DEATH_CAUSE".equals(colFieldName)) {
			String enumName = "FIS.DEATH.CAUSE";
			str = service.getDescByValue(enumName, str);
			return str+"\t";
		}
		//骨灰去向
		if("ASHES_GO".equals(colFieldName)) {
			String enumName = "FIS.ASHES.GO";
			str = service.getDescByValue(enumName, str);
			return str+"\t";
		}
		
		//性别
		if("SEX".equals(colFieldName)) {
			String enumName = "COMM.SEX";
			str = service.getDescByValue(enumName, str);
			return str+"\t";
		}
		return str+"\t";
	}
}
