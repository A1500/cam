package com.inspur.cams.drel.application.special.cmd;

import org.loushang.next.data.ParameterSet;
import org.loushang.next.data.Record;
import org.loushang.next.web.cmd.BaseAjaxCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.comm.util.BspUtil;
import com.inspur.cams.comm.util.DateUtil;
import com.inspur.cams.comm.util.IdHelp;
import com.inspur.cams.drel.application.special.domain.ISamSpecialAssPlanDomain;
import com.inspur.cams.drel.funds.release.data.SamReleaseSummary;


/**
* @Package com.inspur.cams.drel.application.special.cmd
* @Description: TODO 专项救助业务Cmd
* @author luguosui 
* @date 2012-5-17
 */
public class SamSpecialAssPlanCmd  extends BaseAjaxCommand {
	// 获取SCA组件
	private ISamSpecialAssPlanDomain samSpecialAssPlanDomain = ScaComponentFactory.getService(ISamSpecialAssPlanDomain.class, "SamSpecialAssPlanDomain/SamSpecialAssPlanDomain");
	/**
	* @Title: insertSpecialPlan
	* @Description: TODO(新增专项救助计划) void  
	* @throws
	* @author luguosui
	 */
	public void  insertSpecialPlan() {
		ParameterSet pSet=getParameterSet();
		this.setReturn("releaseId", samSpecialAssPlanDomain.insertSpecialPlan(pSet));
	}
	/**
	* @Title: executeSpecialPlan
	* @Description: TODO(实施救助计划、确认名称方法) void  
	* @throws
	* @author luguosui
	 */
	public void executeSpecialPlan() {
		ParameterSet pSet=getParameterSet();
		samSpecialAssPlanDomain.executeSpecialPlan(pSet);
	}
	/**
	* @Title: insertRes
	* @Description: TODO(专项救助选中救助对象确定插入明细方法) void  
	* @throws
	* @author luguosui
	 */
	public void insertReleaseDetail() {
		ParameterSet pSet=getParameterSet();
		samSpecialAssPlanDomain.insertReleaseDetail(pSet);
	}
	/**
	* @Title: insertAllReleaseDetail
	* @Description: TODO(专项救助符合调价的所有救助对象确定插入明细方法) void  
	* @throws
	* @author luguosui
	 */
	public void insertAllReleaseDetail() {
		ParameterSet pSet=getParameterSet();
		samSpecialAssPlanDomain.insertAllReleaseDetail(pSet);
	}
	/**
	* @Title: updateSpecialPlan
	* @Description: TODO(修改专项救助计划) void  
	* @throws
	* @author luguosui
	 */
	public void updateSpecialPlan() {
		ParameterSet pSet=getParameterSet();
		samSpecialAssPlanDomain.updateSpecialPlan(pSet);
	}
	/**
	* @Title: deleteSpecialPlan
	* @Description: TODO(删除专项救助计划) void  
	* @throws
	* @author luguosui
	 */
	public void deleteSpecialPlan() {
		ParameterSet pSet=getParameterSet();
		samSpecialAssPlanDomain.deleteSpecialPlan(pSet);
	}
	/**
	* @Title: updateReleaseDetail
	* @Description: TODO(修改专项计划明细方法) void  
	* @throws
	* @author luguosui
	 */
	public void updateReleaseDetail() {
		ParameterSet pSet=getParameterSet();
		samSpecialAssPlanDomain.updateReleaseDetail(pSet);
	}
	/**
	* @Title: insertReleaseSummary
	* @Description: TODO(新增名册) void  
	* @throws
	* @author luguosui
	 */
	public void insertReleaseSummary() {
		ParameterSet pSet=getParameterSet();
		samSpecialAssPlanDomain.insertReleaseSummary(pSet);
		
	}
}
