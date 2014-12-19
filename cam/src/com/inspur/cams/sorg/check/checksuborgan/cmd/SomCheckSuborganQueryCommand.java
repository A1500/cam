package com.inspur.cams.sorg.check.checksuborgan.cmd;

import java.util.List;

import org.loushang.next.dao.DaoFactory;
import org.loushang.next.dao.EntityDao;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.web.cmd.BaseQueryCommand;

import com.inspur.cams.sorg.check.checkevent.data.SomCheckEvent;
import com.inspur.cams.sorg.check.checksuborgan.data.SomCheckSuborgan;
import com.inspur.cams.sorg.jxcheck.somjxfundpeople.dao.SomJxFundPeople;

/**
 * @title:分支、代表、办事、专项基金管理机构情况QueryCommand
 * @description:
 * @author:
 * @since:2012-01-07
 * @version:1.0
*/
public class SomCheckSuborganQueryCommand extends BaseQueryCommand{

	public DataSet execute() {
		ParameterSet pset = getParameterSet();
		EntityDao<SomCheckSuborgan> dao = (EntityDao<SomCheckSuborgan>) DaoFactory
				.getDao("com.inspur.cams.sorg.check.checksuborgan.dao.SomCheckSuborganDao");
		return dao.query(pset);
	}
	public DataSet queryNoPage(){
		ParameterSet pset = getParameterSet();
		EntityDao<SomJxFundPeople> dao = (EntityDao<SomJxFundPeople>) DaoFactory.getDao("com.inspur.cams.sorg.check.checksuborgan.dao.SomCheckSuborganDao");
		List<SomCheckEvent> list =  dao.queryNoPage(pset);
		DataSet ds = new DataSet();
		ds.fromListBean(list);
		return ds;
	}
}
