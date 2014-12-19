package com.inspur.cams.sorg.check.checkintermeeting.cmd;

import java.util.List;

import org.loushang.next.dao.DaoFactory;
import org.loushang.next.dao.EntityDao;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.web.cmd.BaseQueryCommand;

import com.inspur.cams.sorg.check.checkintermeeting.data.SomCheckInterMeeting;
import com.inspur.cams.sorg.jxcheck.somjxcheckintermeeting.dao.SomJxCheckInterMeeting;

/**
 * @title:SomCheckInterMeetingQueryCommand
 * @description:
 * @author:
 * @since:2012-01-07
 * @version:1.0
*/
public class SomCheckInterMeetingQueryCommand extends BaseQueryCommand{

	public DataSet execute() {
		ParameterSet pset = getParameterSet();
		EntityDao<SomCheckInterMeeting> dao = (EntityDao<SomCheckInterMeeting>) DaoFactory
				.getDao("com.inspur.cams.sorg.check.checkintermeeting.dao.SomCheckInterMeetingDao");
		return dao.query(pset);
	}
	public DataSet queryNoPage(){
		ParameterSet pset = getParameterSet();
		EntityDao<SomCheckInterMeeting> dao = (EntityDao<SomCheckInterMeeting>) DaoFactory
		.getDao("com.inspur.cams.sorg.check.checkintermeeting.dao.SomCheckInterMeetingDao");
		List<SomJxCheckInterMeeting> list =  dao.queryNoPage(pset);
		DataSet ds = new DataSet();
		ds.fromListBean(list);
		return ds;
	}
}
