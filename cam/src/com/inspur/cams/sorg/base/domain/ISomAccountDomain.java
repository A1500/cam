package com.inspur.cams.sorg.base.domain;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.sca.transaction.Trans;

import com.inspur.cams.sorg.base.data.SomAccount;

/**
 * 社会组织账户domain接口
 * @author shgtch
 * @date 2011-5-11
 */
public interface ISomAccountDomain {

	/**
	 * 查询社会组织账户
	 * @param pset
	 * @return
	 */
	public DataSet query(ParameterSet pset);

	/**
	 * 增加社会组织账户
	 * @param somAccount
	 */
	@Trans
	public void insert(SomAccount somAccount);
	
	/**
	 * 更新社会组织账户
	 * @param somAccount
	 */
	@Trans
	public void update(SomAccount somAccount);
	
	/**
	 * 根据账户查询社会组织ID
	 * @param pset2011年5月26日9:28:20
	 * @return
	 */
	public String queryForQuery(ParameterSet pset);
	
	/**
	 * 根据taskCode删除方法
	 * @param taskCode
	 */
	@Trans
	public void del(String taskCode) ;
	
}
