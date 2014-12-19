package com.inspur.cams.bpt.manage.cmd;

import org.loushang.next.dao.DaoFactory;
import org.loushang.next.dao.EntityDao;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.web.cmd.BaseQueryCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.bpt.base.dao.jdbc.BptTemporaryHelpDao;
import com.inspur.cams.bpt.base.data.BptTemporaryHelp;
import com.inspur.cams.bpt.manage.domain.IBptGroupDomain;

/**
 * @title:BptTemporaryHelpQueryCommand
 * @description:
 * @author:
 * @since:2011-06-09
 * @version:1.0
*/
public class BptTemporaryHelpQueryCommand extends BaseQueryCommand{
	IBptGroupDomain service = ScaComponentFactory.getService(IBptGroupDomain.class,"bptGroupDomain/bptGroupDomain");
	public DataSet execute() {
		ParameterSet pset = getParameterSet();
		EntityDao<BptTemporaryHelp> dao = (EntityDao<BptTemporaryHelp>) DaoFactory
				.getDao("com.inspur.cams.bpt.base.dao.jdbc.BptTemporaryHelpDao");
		return dao.query(pset);
	}
	
	public DataSet queryTemporary(){
		ParameterSet pset = getParameterSet();
		DataSet ds = service.queryTemporary(pset);
		return ds;
	}
	
	public DataSet queryTemporaryHelp(){
		ParameterSet pset = getParameterSet();
		DataSet ds = service.queryTemporaryHelp(pset);
		return ds;
	}
	
	public DataSet queryUpdateTemporaryHelp(){
		ParameterSet pset = getParameterSet();
		DataSet ds = service.queryUpdateTemporaryHelp(pset);
		return ds;
	}
}
