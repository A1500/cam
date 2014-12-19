package com.inspur.cams.drel.sam.cmd;

import org.loushang.next.dao.DaoFactory;
import org.loushang.next.dao.EntityDao;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.data.Record;
import org.loushang.next.web.cmd.BaseQueryCommand;
import org.loushang.next.web.cmd.CommandContext;

import com.inspur.cams.comm.baseinfo.data.BaseinfoFamily;

/**
 * @title:SamBaseFamilyQueryCmd
 * @description:
 * @author:
 * @since:2011-04-18
 * @version:1.0
*/
public class SamBaseFamilyQueryCmd extends BaseQueryCommand{
	//-----jiang
	public DataSet execute() {
		ParameterSet pset = getParameterSet();
		EntityDao<BaseinfoFamily> dao = (EntityDao<BaseinfoFamily>) DaoFactory.getDao("com.inspur.cams.comm.baseinfo.dao.jdbc.BaseinfoFamilyDao");
		DataSet  dataset=dao.query(pset);
		return dao.query(pset);
	}
	public DataSet queryJtxx() {
		ParameterSet pset = getParameterSet();
	 
		//pset.setParameter("sfzh", sfzh);
		EntityDao<BaseinfoFamily> dao = (EntityDao<BaseinfoFamily>) DaoFactory.getDao("com.inspur.cams.comm.baseinfo.dao.jdbc.BaseinfoFamilyDao");
		
		DataSet  dataset=dao.query(pset);
		return dataset;
	}
	//查询家庭表信息 luguosui
	public DataSet queryFamily() {
		ParameterSet pset = getParameterSet();
		EntityDao<BaseinfoFamily> dao = (EntityDao<BaseinfoFamily>) DaoFactory.getDao("com.inspur.cams.comm.baseinfo.dao.jdbc.BaseinfoFamilyDao");
		DataSet  dataset=dao.query(pset);
		return dao.query(pset);
	}
}