package com.inspur.cams.drel.application.special.domain;

import org.loushang.next.data.ParameterSet;
import org.loushang.sca.transaction.Trans;

import com.inspur.cams.drel.funds.release.data.SamReleaseSummary;


/**
* @Package com.inspur.cams.drel.application.special.domain
* @Description: TODO 专项救助业务domain接口
* @author luguosui 
* @date 2012-5-17
 */
public interface ISamSpecialAssPlanDomain {
	/**
	* @Title: executeSpecialPlan
	* @Description: TODO(实施救助计划)
	* @param pSet void  
	* @throws
	* @author luguosui
	 */
	@Trans
	public void executeSpecialPlan(ParameterSet pSet);
	/**
	* @Title: insertSpecialPlan
	* @Description: TODO(新增专项救助计划) void  
	* @param pSet
	* @throws
	* @author luguosui
	 */
	@Trans
	public String insertSpecialPlan(ParameterSet pSet);
	/**
	* @Title: updateSpecialPlan
	* @Description: TODO(修改专项救助计划)
	* @param set void  
	* @throws
	* @author luguosui
	 */
	@Trans
	public void updateSpecialPlan(ParameterSet set);

	/**
	* @Title: deleteSpecialPlan
	* @Description: TODO(删除专项救助计划) void  
	* @param set
	* @throws
	* @author luguosui
	 */
	@Trans
	public void deleteSpecialPlan(ParameterSet set);

	/**
	* @Title: insertRes
	* @Description: TODO(专项救助选中救助对象确定插入明细方法) void  
	* @param pSet
	* @throws
	* @author luguosui
	 */
	@Trans
	public void insertReleaseDetail(ParameterSet pSet);
	/**
	* @Title: insertAllReleaseDetail
	* @Description: TODO(专项救助符合调价的所有救助对象确定插入明细方法) void  
	* @param set
	* @throws
	* @author luguosui
	 */
	@Trans
	public void insertAllReleaseDetail(ParameterSet set);
	/**
	* @Title: updateReleaseDetail
	* @Description: TODO(修改专项计划明细方法) void  
	* @param set
	* @throws
	* @author luguosui
	 */
	@Trans
	public void updateReleaseDetail(ParameterSet set);
	/**
	* @Title: insertReleaseSummary
	* @Description: TODO(资金发放新增方法)
	* @param set
	* @param set void  
	* @throws
	* @author luguosui
	 */
	@Trans
	public void insertReleaseSummary(ParameterSet set);
	
}
