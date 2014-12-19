package com.inspur.cams.drel.funds.release.cmd;

import java.io.UnsupportedEncodingException;

import org.loushang.next.commons.nenum.EnumService;
import org.loushang.next.dao.DaoFactory;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.web.cmd.ExcelCSVCommand;

import com.inspur.cams.comm.dicm.IDicDao;

public class SamReleaseCSVCommand extends ExcelCSVCommand {
	ParameterSet pset = new ParameterSet();
	IDicDao dao = (IDicDao) DaoFactory.getDao("com.inspur.cams.comm.dicm.DicDao");
	EnumService service = getEnumService();
	String str = "";
	DataSet ds = null;
	public SamReleaseCSVCommand() {
		try {
			getRequest().setCharacterEncoding("utf-8");
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}
	}
	@Override
	protected String handleData(String colFieldName, Object val){
		str=val.toString();

		//开户银行
		if("bank".equals(colFieldName)) {
			pset.clear();
			pset.setParameter("dic", "DIC_BANK");
			pset.setParameter("value", "CODE");
			pset.setParameter("text", "NAME");
			pset.setParameter("filterSql", " CODE ='"+str+"'");
			ds = dao.getDicMapList(pset);
			if(ds.getCount()>0){
				str = (String) ds.getRecord(0).get("text");
			}else{
				str = "";
			}
			return str;
		}
		//开户银行
		if("BANK".equals(colFieldName)) {
			pset.clear();
			pset.setParameter("dic", "DIC_BANK");
			pset.setParameter("value", "CODE");
			pset.setParameter("text", "NAME");
			pset.setParameter("filterSql", " CODE ='"+str+"'");
			ds = dao.getDicMapList(pset);
			if(ds.getCount()>0){
				str = (String) ds.getRecord(0).get("text");
			}else{
				str = "";
			}
			return str;
		}
		
		//民族
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
				str = "";
			}
			return str;
		}
		
		//民族
		if("ASSISTANCE_TYPE".equals(colFieldName)) {
			pset.clear();
			pset.setParameter("dic", "DIC_ASSITANCE_TYPE");
			pset.setParameter("value", "CODE");
			pset.setParameter("text", "NAME");
			pset.setParameter("filterSql", " CODE ='"+str+"'");
			ds = dao.getDicMapList(pset);
			if(ds.getCount()>0){
				str = (String) ds.getRecord(0).get("text");
			}else{
				str = "";
			}
			return str;
		}
		
		//主要致贫原因
		if("POVERTY_CAUSE".equals(colFieldName)) {
			String enumName = "SAM_CITY_PROVERTY_CAUSE";
			str = service.getDescByValue(enumName, str);
			return str;
		}
		
		//救助金计算方式
		if("ASSISTANCE_MODE".equals(colFieldName)) {
			String enumName = "SAM_ASSISTANCE_MODE";
			str = service.getDescByValue(enumName, str);
			return str;
		}
		
		//供养方式
		if("SUPPORT_WAY".equals(colFieldName)) {
			String enumName = "SAM.SUPPORT_WAY";
			str = service.getDescByValue(enumName, str);
			return str;
		}
		
		//性别
		if("SEX".equals(colFieldName)) {
			String enumName = "COMM.SEX";
			str = service.getDescByValue(enumName, str);
			return str;
		}
		//是否“三无”
		if("IS_THREE_NO".equals(colFieldName)) {
			String enumName = "COMM.YESORNO";
			str = service.getDescByValue(enumName, str);
			return str;
		}
		//是否保障对象
		if("IS_ASSISTANCE".equals(colFieldName)) {
			String enumName = "COMM.YESORNO";
			str = service.getDescByValue(enumName, str);
			return str;
		}
		//人员状态
		if("PERSONAL_STATS_TAG".equals(colFieldName)) {
			String enumName = "SAM_PERSONAL_STATS_TAG";
			str = service.getDescByValue(enumName, str);
			return str;
		}
		//健康状况
		if("HEALTH_CODE".equals(colFieldName)) {
			String enumName = "SAM_HEALTH_CODE";
			str = service.getDescByValue(enumName, str);
			return str;
		}
		//劳动能力
		if("LABOR_CAPACITY".equals(colFieldName)) {
			String enumName = "SAM_LABOR_CAPACITY";
			str = service.getDescByValue(enumName, str);
			return str;
		}
		//生活自理能力
		if("SELF_CARE_ABILITY".equals(colFieldName)) {
			String enumName = "SAM_SELF_CARE_ABILITY";
			str = service.getDescByValue(enumName, str);
			return str;
		}
		//属别
		if("BELONGING".equals(colFieldName)) {
			String enumName = "SAM_BELONGING";
			str = service.getDescByValue(enumName, str);
			return str;
		}
		//与户主关系
		if("RELATIONSHIP_TYPE".equals(colFieldName)) {
			pset.clear();
			pset.setParameter("dic", "DIC_RELATIONSHIP_TYPE");
			pset.setParameter("value", "CODE");
			pset.setParameter("text", "NAME");
			pset.setParameter("filterSql", " CODE ='"+str+"'");
			ds = dao.getDicMapList(pset);
			if(ds.getCount()>0){
				str = (String) ds.getRecord(0).get("text");
			}else{
				str = "";
			}
			return str;
		}
		//分类施保类别
		if("ASSISTANCE_CLASS".equals(colFieldName)) {
			pset.clear();
			pset.setParameter("dic", "SAM_ASSISTANCE_CLASS");
			pset.setParameter("value", "ASSISTANCE_CLASS_CODE");
			pset.setParameter("text", "ASSISTANCE_CLASS_NAME");
			pset.setParameter("filterSql", " ASSISTANCE_CLASS_CODE ='"+str+"'");
			ds = dao.getDicMapList(pset);
			if(ds.getCount()>0){
				str = (String) ds.getRecord(0).get("text");
			}else{
				str = "";
			}
			return str;
		}
		//分类施保类别
		if("ASSISTANCE_CLASS_MODE".equals(colFieldName)) {
			pset.clear();
			pset.setParameter("dic", "SAM_ASSISTANCE_CLASS");
			pset.setParameter("value", "ASSISTANCE_CLASS_CODE");
			pset.setParameter("text", "ASSISTANCE_CLASS_NAME");
			pset.setParameter("filterSql", " ASSISTANCE_CLASS_CODE ='"+str+"'");
			ds = dao.getDicMapList(pset);
			if(ds.getCount()>0){
				str = (String) ds.getRecord(0).get("text");
			}else{
				str = "";
			}
			return str;
		}
		//金额列不添加\t,excel打开后数字较大可能出现科学计数法，可通过调整列宽显示完整
		//综合查询
		if("PEOPLE_NUM".equals(colFieldName)
				||"ASSISTANCE_PEOPLE_NUM".equals(colFieldName)
				||"ASSISTANCE_MONEY".equals(colFieldName)
				||"ASSISTANCE_CLASS_MONEY".equals(colFieldName)
				||"INCOME_MONTH".equals(colFieldName)
				||"INCOME_YEAR".equals(colFieldName)){
			return str;
		}
		//补发明细查询
		if("assistancePeopleNum".equals(colFieldName)
				||"releaseMonSum".equals(colFieldName)
				||"name".equals(colFieldName)
				||"baseMon".equals(colFieldName)
				||"classMon".equals(colFieldName)
			){
			return str;
		}
		if("BEGIN_DATE".equals(colFieldName)){
			return str+"\t";
		}
		if("accountNumber".equals(colFieldName) || "ACCOUNT_NUMBER".equals(colFieldName)){
			return str+"\t";
		}
		if("cardNo".equals(colFieldName)){
			return str+"\t";
		}
		if("CARD_NO".equals(colFieldName)){
			return str+"\t";
		}
        if ("CHANGE_ITEM".equals(colFieldName)) {
            String enumName = "SAM_CHANGE_ITEM";
            str = service.getDescByValue(enumName, str);
            return str + "\t";
        }
		return str;
	}
}
