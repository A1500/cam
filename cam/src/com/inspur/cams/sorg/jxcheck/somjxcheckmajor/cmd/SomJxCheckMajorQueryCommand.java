package com.inspur.cams.sorg.jxcheck.somjxcheckmajor.cmd;

import java.util.List;

import org.loushang.next.dao.DaoFactory;
import org.loushang.next.dao.EntityDao;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.web.cmd.BaseQueryCommand;

import com.inspur.cams.sorg.jxcheck.somjxcheckmajor.dao.SomJxCheckMajor;
import com.inspur.cams.sorg.jxcheck.somjxmajordetail.dao.SomJxMajorDetail;

/**
 * @title:SomJxCheckMajorQueryCommand
 * @description:
 * @author:
 * @since:2012-02-07
 * @version:1.0
*/
public class SomJxCheckMajorQueryCommand extends BaseQueryCommand{

	public DataSet execute() {
		ParameterSet pset = getParameterSet();
		EntityDao<SomJxCheckMajor> dao = (EntityDao<SomJxCheckMajor>) DaoFactory
				.getDao("com.inspur.cams.sorg.jxcheck.somjxcheckmajor.dao.SomJxCheckMajorDao");
		return dao.query(pset);
	}
	public DataSet queryNoPage(){
		ParameterSet pset = getParameterSet();
		EntityDao<SomJxCheckMajor> dao = (EntityDao<SomJxCheckMajor>) DaoFactory
		.getDao("com.inspur.cams.sorg.jxcheck.somjxcheckmajor.dao.SomJxCheckMajorDao");
		List<SomJxCheckMajor> list =  dao.queryNoPage(pset);
		DataSet ds = new DataSet();
		ds.fromListBean(list);
		return ds;
	}
}
