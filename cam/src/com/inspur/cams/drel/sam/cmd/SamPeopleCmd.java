package com.inspur.cams.drel.sam.cmd;

import org.loushang.next.dao.DaoFactory;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.data.Record;
import org.loushang.next.data.RecordSet;
import org.loushang.next.web.cmd.BaseAjaxCommand;

import com.inspur.cams.comm.baseinfo.dao.IBaseinfoPeopleDao;
import com.inspur.cams.comm.baseinfo.data.BaseinfoPeople;


public class SamPeopleCmd extends BaseAjaxCommand {
	IBaseinfoPeopleDao dao = (IBaseinfoPeopleDao) DaoFactory.getDao("com.inspur.cams.comm.baseinfo.dao.IBaseinfoPeopleDao");
	
	/**
	 * 查询家庭成员身份证重复
	 */
	  public void checkAdd() {
 
	    String dy=(String)getParameter("peopleId");//家庭ID
	    String idCard=(String)getParameter("idCard");//身份证
     
	    ParameterSet pset2= new ParameterSet();
	    pset2.setParameter("ID_CARD",idCard);
	    DataSet dst = this.dao.query(pset2);//根据身份证查询库里的信息
	    
	    RecordSet recordSet = dst.getRecordSet();
	    for(int i=0; i<recordSet.size(); i++) {
	    	 Record rec = (Record)recordSet.get(i);
	    	 BaseinfoPeople ygjzjtxxcyxx=(BaseinfoPeople)rec.toBean(BaseinfoPeople.class);
	    	 if(ygjzjtxxcyxx.getPeopleId().equals(dy)) {//除去当前记录
	    		 recordSet.remove(i); 
			 }
	    }
	    if (dst.getCount() > 0)
	      setReturn("num", "true");
	  }
}
