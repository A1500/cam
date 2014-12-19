package com.inspur.cams.prs.prspoliciesregulations.domain;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.upload.MultipartRequestWrapper;
import org.loushang.sca.transaction.Trans;

import com.inspur.cams.prs.prspoliciesregulations.dao.PrsPoliciesRegulations;

/**
 * @title:IPrsPoliciesRegulationsDomain
 * @description:政策法规信息表
 * @author:jiangzhaobao
 * @since:2011年8月26日20:44:46
 * @version:1.0
*/
public interface IPrsPoliciesRegulationsDomain {
	/**
	 * 新增问题处理
	 */
	@Trans
	public void insertProblemDeal(ParameterSet pset,MultipartRequestWrapper wrapRequest);
	/**
	 * 修改问题处理
	 */
	@Trans
	public void update(PrsPoliciesRegulations bean);
	/**
	 * 查看问题处理
	 */
	@Trans
	public DataSet query(ParameterSet pset);
	/**
	 * 删除问题处理
	 */
	@Trans
	public void batchDelete(String[] delIds);
	
}
