package com.inspur.cams.marry.base.cmd;

import org.loushang.next.dao.DaoFactory;
import org.loushang.next.dao.EntityDao;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.web.cmd.BaseQueryCommand;
import com.inspur.cams.marry.base.dao.*;
import com.inspur.cams.marry.base.dao.jdbc.MrmExamScheduleDao;
import com.inspur.cams.marry.base.data.MrmExamSchedule;
import com.inspur.cams.marry.base.data.MrmQualificationExam;

/**
 * @title:MrmExamScheduleQueryCommand
 * @description:
 * @author:
 * @since:2011-12-05
 * @version:1.0
*/
public class MrmExamScheduleQueryCommand extends BaseQueryCommand{
	
	//private MrmExamScheduleDao mScheduleDao = new MrmExamScheduleDao();
	public DataSet execute() {
		ParameterSet pset = getParameterSet();
		MrmExamScheduleDao dao = (MrmExamScheduleDao) DaoFactory
				.getDao("com.inspur.cams.marry.base.dao.jdbc.MrmExamScheduleDao");
		EntityDao<MrmQualificationExam> qExamdao = (EntityDao<MrmQualificationExam>) DaoFactory
		.getDao("com.inspur.cams.marry.base.dao.jdbc.MrmQualificationExamDao");
		DataSet dSet = dao.query(pset);
		for (int i = 0; i < dSet.getCount(); i++) {
			String ksapId = dSet.getRecord(i).get("ksapId").toString();
			ParameterSet qePset = new ParameterSet();
			qePset.setParameter("ksapId", ksapId);
			DataSet qeDataSet = dao.sumExamSchedule(qePset);
			dSet.getRecord(i).set("ksbmPeonum", qeDataSet.getRecord(0).get("KSRS"));
		}
		
		return dSet;
	}
}
