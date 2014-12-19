package com.inspur.cams.sorg.check.somcheckmajordetail.cmd;

import java.util.List;

import org.loushang.next.dao.DaoFactory;
import org.loushang.next.dao.EntityDao;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.web.cmd.BaseQueryCommand;

import com.inspur.cams.sorg.check.checkevent.data.SomCheckEvent;
import com.inspur.cams.sorg.check.somcheckmajordetail.dao.SomCheckMajorDetail;
import com.inspur.cams.sorg.jxcheck.somjxfundpeople.dao.SomJxFundPeople;

/**
 * @title:SomCheckMajorDetailQueryCommand
 * @description:
 * @author:
 * @since:2012-04-23
 * @version:1.0
*/
public class SomCheckMajorDetailQueryCommand extends BaseQueryCommand{

	public DataSet execute() {
		ParameterSet pset = getParameterSet();
		EntityDao<SomCheckMajorDetail> dao = (EntityDao<SomCheckMajorDetail>) DaoFactory
				.getDao("com.inspur.cams.sorg.check.somcheckmajordetail.dao.SomCheckMajorDetailDao");
		return dao.query(pset);
	}
	public DataSet queryNoPage(){
		ParameterSet pset = getParameterSet();
		EntityDao<SomCheckMajorDetail> dao = (EntityDao<SomCheckMajorDetail>) DaoFactory.getDao("com.inspur.cams.sorg.check.somcheckmajordetail.dao.SomCheckMajorDetailDao");
		List<SomCheckEvent> list =  dao.queryNoPage(pset);
		DataSet ds = new DataSet();
		ds.fromListBean(list);
		return ds;
	}
}
