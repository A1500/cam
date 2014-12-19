package com.inspur.cams.dis.base.cmd;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.web.cmd.BaseQueryCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.dis.base.domain.IDisReliefBatchDetailDomain;
/**
 * @title:DisReliefInfoQueryCommand
 * @description:
 * @author:
 * @since:2012-10-12
 * @version:1.0
*/
public class DisReliefBatchDetailQueryCommand extends BaseQueryCommand{
	private IDisReliefBatchDetailDomain detailservice = ScaComponentFactory.getService(IDisReliefBatchDetailDomain.class,
		"disReliefBatchDetailDomain/disReliefBatchDetailDomain");
	
	public DataSet execute() {
		ParameterSet pset = getParameterSet();
		return detailservice.queryBatchDetailByDetailId(pset);
	}
	public DataSet query() {
		ParameterSet pset = getParameterSet();
		return detailservice.query(pset);
	}
	
	public DataSet queryBatchDetail(){
		ParameterSet pset = getParameterSet();
		return detailservice.queryBatchDetail(pset);
	}
	/**
	 * 查询批次（冬春生活，因灾死亡，灾区民房）
	 * @return
	 */
	public DataSet queryAssistanceBatch(){
		ParameterSet pset = getParameterSet();
		return detailservice.queryAssistanceBatch(pset);
	}
	/**
	 * 救灾批次明细查询
	 * @param pset
	 * @return
	 */
	public DataSet queryDetail(){
		ParameterSet pset = getParameterSet();
		return detailservice.queryDetail(pset);
	}
}
