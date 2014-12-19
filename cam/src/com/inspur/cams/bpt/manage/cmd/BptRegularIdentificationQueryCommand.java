package com.inspur.cams.bpt.manage.cmd;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.web.cmd.BaseQueryCommand;
import org.loushang.sca.ScaComponentFactory;
import com.inspur.cams.bpt.base.domain.IBptRegularIdentificationDomain;

/**
 * @title:BptRegularIdentificationQueryCommand
 * @description:定期认证查询
 * @author:
 * @since:2011-05-27
 * @version:1.0
*/
public class BptRegularIdentificationQueryCommand extends BaseQueryCommand{
	
	private IBptRegularIdentificationDomain service = ScaComponentFactory.getService(IBptRegularIdentificationDomain.class,
	"bptRegularIdentificationDomain/bptRegularIdentificationDomain");
//查询认证信息
	public DataSet queryRegularIdentification(){
		ParameterSet pset = getParameterSet();
		DataSet ds =  service.queryRegularIdentification(pset);
		
		/*for(int i=0;i<ds.getCount();i++){
			String disabilityType = (String) ds.getRecord(0).get("DISABILITY_TYPE_CODE");
			String dependantType = (String) ds.getRecord(0).get("DEPENDANT_TYPE_CODE");
			String demobilizedType = (String) ds.getRecord(0).get("DEMOBILIZED_TYEP_CODE");
			String warType = (String) ds.getRecord(0).get("WAR_TYPE_CODE");
			String objectType = "";
			if (!"00".equals(disabilityType) && !"".equals(disabilityType)) {
				objectType += disabilityType+";";
			}
			if (!"00".equals(dependantType) && !"".equals(dependantType)) {
				objectType += dependantType+";";
			}
			if (!"00".equals(demobilizedType) && !"".equals(demobilizedType)) {
				objectType += demobilizedType+";";
			}
			if (!"00".equals(warType) && !"".equals(warType)) {
				objectType += warType+";";
			}
			
			if (objectType != null && !"".equals(objectType)) {
				String[] ot = objectType.split(";");
				String objectTypeContext=fObjectType(ot);
				ds.getRecord(i).set("objectTypeContext", objectTypeContext);
				ds.getRecord(i).set("objectTypes", objectType);
			}
		}*/
		return ds;
	}
/*	public String fObjectType(String[] ot){
		StringBuffer objectType= new StringBuffer();
		for (String s : ot) {
			if("11".endsWith(s)){
				objectType.append("残疾军人;");
			}else if("12".endsWith(s)){
				objectType.append("伤残国家机关工作人员;");
			}else if("13".endsWith(s)){
				objectType.append("伤残人民警察;");
			}else if("14".endsWith(s)){
				objectType.append("伤残民兵民工;");
			}else if("15".endsWith(s)){
				objectType.append("因战因公伤残人员;");
			}else if("21".endsWith(s)){
				objectType.append("烈士家属;");
			}else if("22".endsWith(s)){
				objectType.append("因公牺牲军人家属;");
			}else if("23".endsWith(s)){
				objectType.append("病故军人家属;");
			}else if("31".endsWith(s)){
				objectType.append("在乡退伍红军老战士;");
			}else if("32".endsWith(s)){
				objectType.append("在乡西路军红军老战士;");
			}else if("33".endsWith(s)){
				objectType.append("红军失散人员;");
			}else if("41".endsWith(s)){
				objectType.append("在乡复员军人;");
			}else if("42".endsWith(s)){
				objectType.append("带病回乡复员军人;");
			}else if("51".endsWith(s)){
				objectType.append("参战;");
			}else if("61".endsWith(s)){
				objectType.append("参试;");
			}
		}
		return objectType.toString();
	}*/
	
	
	
	/**
	 *查询定期认证人员信息 
	 */
	public DataSet queryRegIdenti(){
		ParameterSet pset = getParameterSet();
		DataSet ds = service.queryRegIdenti(pset);
		return ds;
	}
}
