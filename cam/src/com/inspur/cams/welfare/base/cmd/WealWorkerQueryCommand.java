package com.inspur.cams.welfare.base.cmd;

import org.loushang.next.dao.DaoFactory;
import org.loushang.next.dao.EntityDao;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.web.cmd.BaseQueryCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.sorg.query.domain.ISomAccountQueryDomain;
import com.inspur.cams.welfare.base.dao.support.WealFitStatusDao;
import com.inspur.cams.welfare.base.dao.support.WealWorkerDao;
import com.inspur.cams.welfare.base.data.WealWorker;
import com.inspur.cams.welfare.base.domain.IWealWorkerDomain;

/**
 * @title:WealWorkerQueryCommand
 * @description:
 * @author:
 * @since:2013-04-19
 * @version:1.0
*/
public class WealWorkerQueryCommand extends BaseQueryCommand{
	private IWealWorkerDomain service = ScaComponentFactory.getService(IWealWorkerDomain.class,"wealWorkerDomain/wealWorkerDomain");
	
	public DataSet execute() {
		ParameterSet pset = getParameterSet();
		EntityDao<WealWorker> dao = (EntityDao<WealWorker>) DaoFactory
				.getDao("com.inspur.cams.welfare.base.dao.support.WealWorkerDao");
		return dao.query(pset);
	}
	
	//社会福利企业员工基本信息查询
	public DataSet getWorker() {
		ParameterSet pset = getParameterSet();
		DataSet ds = service.getWorker(pset);
		return ds;
	} 
}
