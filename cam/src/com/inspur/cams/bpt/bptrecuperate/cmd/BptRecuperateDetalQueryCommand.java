package com.inspur.cams.bpt.bptrecuperate.cmd;

import java.util.ArrayList;
import java.util.List;

import org.loushang.next.dao.DaoFactory;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.data.Record;
import org.loushang.next.web.cmd.BaseQueryCommand;

import com.inspur.cams.bpt.bptrecuperate.dao.jdbc.BptRecuperateDetailDao;

/**
 * @title:BptRecuperateDetalQueryCommand
 * @description:
 * @author:
 * @since:2011-11-11
 * @version:1.0
*/
public class BptRecuperateDetalQueryCommand extends BaseQueryCommand{

	public DataSet execute() {
		ParameterSet pset = getParameterSet();
		BptRecuperateDetailDao dao =  (BptRecuperateDetailDao) DaoFactory.getDao(BptRecuperateDetailDao.class);
		DataSet ds = dao.query(pset);
		int dsLength = ds.getCount();
		List<Record> list = new ArrayList<Record>();
		if(dsLength>0){
			for(int i=0;i<dsLength;i++){
				Record record = ds.getRecord(i);
				String birthday = (String)record.get("birthday");
				ParameterSet pset1 = new ParameterSet();
				pset1.setParameter("birthday", birthday);
				String age = (String)dao.queryAgeByBirthday(pset1).getRecord(0).get("AGE");
				record.set("age",age);
				list.add(record);
			}
		}
		DataSet resultDs = new DataSet();
		resultDs.getRecordSet().addAll(list);
		resultDs.setTotalCount(list.size());
		return resultDs;
	}
}
