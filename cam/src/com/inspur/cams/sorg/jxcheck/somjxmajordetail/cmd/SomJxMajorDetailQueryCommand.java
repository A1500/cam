package com.inspur.cams.sorg.jxcheck.somjxmajordetail.cmd;

import java.util.List;

import org.loushang.next.dao.DaoFactory;
import org.loushang.next.dao.EntityDao;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.web.cmd.BaseQueryCommand;

import com.inspur.cams.sorg.check.checkevent.data.SomCheckEvent;
import com.inspur.cams.sorg.jxcheck.somjxfundpeople.dao.SomJxFundPeople;
import com.inspur.cams.sorg.jxcheck.somjxmajordetail.dao.SomJxMajorDetail;

/**
 * @title:SomJxMajorDetailQueryCommand
 * @description:
 * @author:
 * @since:2012-02-07
 * @version:1.0
*/
public class SomJxMajorDetailQueryCommand extends BaseQueryCommand{

	public DataSet execute() {
		ParameterSet pset = getParameterSet();
		EntityDao<SomJxMajorDetail> dao = (EntityDao<SomJxMajorDetail>) DaoFactory
				.getDao("com.inspur.cams.sorg.jxcheck.somjxmajordetail.dao.SomJxMajorDetailDao");
		return dao.query(pset);
	}
	public DataSet queryNoPage(){
		ParameterSet pset = getParameterSet();
		EntityDao<SomJxMajorDetail> dao = (EntityDao<SomJxMajorDetail>) DaoFactory
		.getDao("com.inspur.cams.sorg.jxcheck.somjxmajordetail.dao.SomJxMajorDetailDao");
		List<SomJxMajorDetail> list =  dao.queryNoPage(pset);
		DataSet ds = new DataSet();
		ds.fromListBean(list);
		return ds;
	}
}
