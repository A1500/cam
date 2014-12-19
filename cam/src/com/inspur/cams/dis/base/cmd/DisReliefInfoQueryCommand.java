package com.inspur.cams.dis.base.cmd;

import org.loushang.next.dao.DaoFactory;
import org.loushang.next.dao.EntityDao;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.web.cmd.BaseQueryCommand;

import com.inspur.cams.dis.base.dao.support.DisReliefInfoDao;
import com.inspur.cams.dis.base.data.DisReliefInfo;
/**
 * @title:DisReliefInfoQueryCommand
 * @description:
 * @author:
 * @since:2012-10-12
 * @version:1.0
*/
public class DisReliefInfoQueryCommand extends BaseQueryCommand{
	
	private DisReliefInfoDao dao = (DisReliefInfoDao) DaoFactory
		.getDao("com.inspur.cams.dis.base.dao.support.DisReliefInfoDao"); 
	public DataSet execute() {
		ParameterSet pset = getParameterSet();
		return dao.query(pset);
	}
	
	public DataSet queryList() {
		ParameterSet pset = getParameterSet();
		return dao.queryList(pset);
	}
	/**
	 * 获取各批次的核准信息及平均值
	 * @param pset
	 * @return
	 */
	public DataSet queryBatchGatherDate(){
		ParameterSet pset = getParameterSet();
		return dao.queryBatchGatherDate(pset);
	}
}
