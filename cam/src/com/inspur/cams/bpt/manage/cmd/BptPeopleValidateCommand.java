package com.inspur.cams.bpt.manage.cmd;

import org.loushang.next.dao.DaoFactory;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.data.Record;
import org.loushang.next.web.cmd.BaseAjaxCommand;

import com.inspur.cams.bpt.base.dao.jdbc.BptPeopleValidateDao;

/**
 * @title:BptPetitionCommand
 * @description:
 * @author:
 * @since:2011-05-25
 * @version:1.0
*/
public class BptPeopleValidateCommand extends BaseAjaxCommand{
	
	
	public void writeAble(){
		BptPeopleValidateDao dao = (BptPeopleValidateDao) DaoFactory
				.getDao("com.inspur.cams.bpt.base.dao.jdbc.BptPeopleValidateDao");
		String idCard = (String) getParameter("idCard");
		String objectType = (String) getParameter("objectType");
		Boolean isApply = (Boolean) getParameter("isApply");//判断是否是申请页面还是数据采集 申请页面时 不予认定也可以录入
		isApply=isApply==null?false:true;
		ParameterSet pset = new ParameterSet();
		pset.setParameter("idCard", idCard);
		pset.setParameter("objectType", objectType);
		DataSet ds = dao.validateBptPeople(pset);
		String[] ss=null;
		if(ds.getCount()>0){
			boolean b =true;
			for(int i=0 ;i<ds.getCount();i++){
				ss=getFlag(objectType,ds.getRecord(i));
				if("1".equals(ss[0])){
					if(isApply&&"6".equals(ss[1])){
						b =true;
					}else {
						b =false;
						break;
					}
				}else{
					continue;
				}
			}
			this.setReturn("wflag", b);
		}else {
			this.setReturn("wflag", true);
		}
	}
	
	public String[] getFlag(String objectType,Record r){
		String f="";
		String s="";
		if("1".equals(objectType)){
			f=(String)r.get("DISABILITY_FLAG");
			s=(String)r.get("DISABILITY_STATE_CODE");
		}else if("2".equals(objectType)){
			f=(String)r.get("DEPENDANT_FLAG");
			s=(String)r.get("DEPENDANT_STATE_CODE");
		}else if("41".equals(objectType)||"42".equals(objectType)){
			f=(String)r.get("DEMOBILIZED_FLAG");
			s=(String)r.get("DEMOBILIZED_STATE_CODE");
		}else if("51".equals(objectType)||"61".equals(objectType)){
			f=(String)r.get("WAR_FLAG");
			s=(String)r.get("WAR_STATE_CODE");
		}else if("81".equals(objectType)){
			f=(String)r.get("RETIRED_FLAG");
			s=(String)r.get("RETIRED_STATE_CODE");
		}else if("B1".equals(objectType)){
			f=(String)r.get("MARTYR_OFFSPRING_FLAG");
			s=(String)r.get("MARTYR_OFFSPRING_STATE_CODE");
		}
		String of=(String)r.get("object_flag");
		
		return new String[]{f,s};
	}
}
