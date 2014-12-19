package com.inspur.cams.drel.application.comm.domain;

import org.loushang.next.data.ParameterSet;
import org.loushang.sca.transaction.Trans;

/**
* @Package com.inspur.cams.drel.application.comm.domain
* @Description: TODO 
* @author luguosui 
* @date 2012-6-26
 */
public interface ISamApplyFromEnsureyDomain {
	/**
	* @Title: insertFromEnsurey
	* @Description: TODO(根据经济核对回填低保业务)  
	* @param set
	* @return String
	* @throws
	* @author luguosui
	 */
	@Trans
	public String insertFromEnsurey(ParameterSet set);

	/**
	* @Title: addCheck
	* @Description: TODO(审批时发起核对方法) void  
	* @param set
	* @throws
	* @author luguosui
	 */
	@Trans
	public void addCheck(ParameterSet set);


}
