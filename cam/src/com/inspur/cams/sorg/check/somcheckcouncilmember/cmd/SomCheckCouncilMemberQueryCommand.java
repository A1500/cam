package com.inspur.cams.sorg.check.somcheckcouncilmember.cmd;

import java.util.List;

import org.loushang.next.dao.DaoFactory;
import org.loushang.next.dao.EntityDao;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.web.cmd.BaseQueryCommand;

import com.inspur.cams.sorg.check.checkevent.data.SomCheckEvent;
import com.inspur.cams.sorg.check.somcheckcouncilmember.dao.SomCheckCouncilMember;
import com.inspur.cams.sorg.jxcheck.somjxfundpeople.dao.SomJxFundPeople;

/**
 * @title:SomCheckCouncilMemberQueryCommand
 * @description:
 * @author:
 * @since:2012-04-23
 * @version:1.0
*/
public class SomCheckCouncilMemberQueryCommand extends BaseQueryCommand{

	public DataSet execute() {
		ParameterSet pset = getParameterSet();
		EntityDao<SomCheckCouncilMember> dao = (EntityDao<SomCheckCouncilMember>) DaoFactory
				.getDao("com.inspur.cams.sorg.check.somcheckcouncilmember.dao.SomCheckCouncilMemberDao");
		return dao.query(pset);
	}
	public DataSet queryNoPage(){
		ParameterSet pset = getParameterSet();
		EntityDao<SomJxFundPeople> dao = (EntityDao<SomJxFundPeople>) DaoFactory.getDao("com.inspur.cams.sorg.check.somcheckcouncilmember.dao.SomCheckCouncilMemberDao");
		List<SomCheckEvent> list =  dao.queryNoPage(pset);
		DataSet ds = new DataSet();
		ds.fromListBean(list);
		return ds;
	}
}
