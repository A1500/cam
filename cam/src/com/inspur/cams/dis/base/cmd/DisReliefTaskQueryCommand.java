package com.inspur.cams.dis.base.cmd;

import java.util.Iterator;

import org.loushang.next.dao.DaoFactory;
import org.loushang.next.dao.EntityDao;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.data.Record;
import org.loushang.next.web.cmd.BaseQueryCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.comm.diccity.data.DicCity;
import com.inspur.cams.dis.base.dao.support.DisReliefInfoDao;
import com.inspur.cams.dis.base.data.DisReliefInfo;
import com.inspur.cams.dis.base.domain.IDisReliefBatchDomain;
/**
 * @title:DisReliefInfoQueryCommand
 * @description:
 * @author:
 * @since:2012-10-12
 * @version:1.0
*/
public class DisReliefTaskQueryCommand extends BaseQueryCommand{
	private DisReliefInfoDao dao = (DisReliefInfoDao) DaoFactory
		.getDao("com.inspur.cams.dis.base.dao.support.DisReliefInfoDao"); 
	
	
	public DataSet execute() {
		ParameterSet pset = getParameterSet();
		DataSet ds= dao.queryTaskInfo(pset);
		return ds;
	}
}
