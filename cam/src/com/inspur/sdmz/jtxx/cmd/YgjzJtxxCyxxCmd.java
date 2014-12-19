package com.inspur.sdmz.jtxx.cmd;

import org.loushang.next.dao.DaoFactory;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.data.Record;
import org.loushang.next.data.RecordSet;
import org.loushang.next.web.cmd.BaseAjaxCommand;

import com.inspur.sdmz.jtxx.dao.IYgjzJtxxCyxxDao;
import com.inspur.sdmz.jtxx.data.BaseinfoPeople;

public class YgjzJtxxCyxxCmd extends BaseAjaxCommand {
	IYgjzJtxxCyxxDao dao = (IYgjzJtxxCyxxDao) DaoFactory.getDao("com.inspur.sdmz.jtxx.dao.jdbc.YgjzJtxxCyxxDao");

	/**
	 * 查询家庭成员身份证重复
	 */
	  public void checkAdd() {

	    String dy=(String)getParameter("peopleId");//家庭ID
	    String sfzh=(String)getParameter("sfzh");//身份证

	    ParameterSet pset2= new ParameterSet();
	    pset2.setParameter("ID_CARD",sfzh);
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
	  
	  /**
	   * 根据身份证号码，查看人员已录入
	   */
	  public void checkByIdCard(){
		  String idCard=(String)getParameter("checkIdCard");
		  setReturn("getFamilyPhotoId",dao.checkByIdCard(idCard));
	  }
}

