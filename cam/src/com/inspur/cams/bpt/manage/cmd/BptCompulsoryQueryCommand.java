package com.inspur.cams.bpt.manage.cmd;

import org.loushang.next.dao.DaoFactory;
import org.loushang.next.dao.EntityDao;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.web.cmd.BaseQueryCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.bpt.base.dao.jdbc.BptCompulsoryDao;
import com.inspur.cams.bpt.base.data.BptCompulsory;
import com.inspur.cams.bpt.base.domain.IBptCompulsoryDomain;

/**
 * @title:BptCompulsoryQueryCommand
 * @description:
 * @author:
 * @since:2011-06-05
 * @version:1.0
 */
public class BptCompulsoryQueryCommand extends BaseQueryCommand {

	public DataSet execute() {
		ParameterSet pset = getParameterSet();
		EntityDao<BptCompulsory> dao = (EntityDao<BptCompulsory>) DaoFactory
				.getDao("com.inspur.cams.bpt.base.dao.jdbc.BptCompulsoryDao");
		return dao.query(pset);
	}

	/**
	 * 以家庭行政区划、姓名、性别、身份证号、民族为条件查询
	 */
	public DataSet queryCompulsory() {
		ParameterSet pSet = getParameterSet();
		BptCompulsoryDao bptCompulsoryDao = (BptCompulsoryDao) DaoFactory.getDao("com.inspur.cams.bpt.base.dao.jdbc.BptCompulsoryDao");
		DataSet dataSet = bptCompulsoryDao.queryCompulsory(pSet);
		return dataSet;
	}
	
	/**
	 * 修改查询
	 */
	public DataSet queryUpdateCompulsory(){
		ParameterSet pSet = getParameterSet();
		BptCompulsoryDao uCompulsoryDao = (BptCompulsoryDao) DaoFactory.getDao("com.inspur.cams.bpt.base.dao.jdbc.BptCompulsoryDao");
		return uCompulsoryDao.queryUpdateCompulsory(pSet);
	
		
	}
}
