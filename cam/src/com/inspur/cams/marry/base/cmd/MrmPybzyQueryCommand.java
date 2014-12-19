package com.inspur.cams.marry.base.cmd;

import org.loushang.next.dao.DaoFactory;
import org.loushang.next.dao.EntityDao;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.data.Record;
import org.loushang.next.web.cmd.BaseQueryCommand;

import com.inspur.cams.marry.base.dao.jdbc.MrmRegisOrganInfoDao;
import com.inspur.cams.marry.base.data.MrmPybzy;

/**
 * @title:MrmPybzyQueryCommand
 * @description:
 * @author:
 * @since:2012-02-13
 * @version:1.0
 */
public class MrmPybzyQueryCommand extends BaseQueryCommand {

	@SuppressWarnings("unchecked")
	public DataSet execute() {
		ParameterSet pset = getParameterSet();
		EntityDao<MrmPybzy> dao = (EntityDao<MrmPybzy>) DaoFactory
				.getDao("com.inspur.cams.marry.base.dao.jdbc.MrmPybzyDao");
		
		EntityDao<MrmRegisOrganInfoDao> mrmRegisOrganInfoDao = (EntityDao<MrmRegisOrganInfoDao>) DaoFactory
		.getDao("com.inspur.cams.marry.base.dao.jdbc.MrmRegisOrganInfoDao");
		DataSet ds = dao.query(pset);
		Record record;
		ParameterSet param = new ParameterSet();
		DataSet mrmRegisDs;
		for(int i=0;i<ds.getCount();i++) {
			record = ds.getRecord(i);
			param.put("DEPT_CODE", record.get("organId"));
			mrmRegisDs = mrmRegisOrganInfoDao.query(param);
			if(mrmRegisDs.getCount() != 0) {
				record.set("deptName", mrmRegisDs.getRecord(0).get("name"));
			} else {
				record.set("deptName", "");
			}
			
		}
		return ds;
	}
}
