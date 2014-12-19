package com.inspur.cams.drel.application.comm.cmd;

import org.loushang.next.data.ParameterSet;
import org.loushang.next.web.cmd.BaseAjaxCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.drel.application.comm.domain.ISamApplyFromEnsureyDomain;


/**
* @Package com.inspur.cams.drel.application.comm.cmd
* @Description: TODO 处理低保业务中从经济核对回填的业务
* @author luguosui 
* @date 2012-6-26
 */
public class SamApplyFromEnsureyCmd  extends BaseAjaxCommand {
	// 获取SCA组件
	private ISamApplyFromEnsureyDomain samApplyFromEnsureyDomain = ScaComponentFactory.getService(ISamApplyFromEnsureyDomain.class, "SamApplyFromEnsureyDomain/SamApplyFromEnsureyDomain");
	/**
	* @Title: insertFromEnsurey
	* @Description: TODO(根据经济核对回填低保业务) void  
	* @throws
	* @author luguosui
	 */
	public void insertFromEnsurey() {
		ParameterSet pSet=(ParameterSet)this.getParameterSet();
		String  applyId=samApplyFromEnsureyDomain.insertFromEnsurey(pSet);
		this.setReturn("applyId",applyId );
	}
	/**
	* @Title: addCheck
	* @Description: TODO(审批时发起核对方法) void  
	* @throws
	* @author luguosui
	 */
	public void addCheck() {
		ParameterSet pSet=(ParameterSet)this.getParameterSet();
		samApplyFromEnsureyDomain.addCheck(pSet);
	}
}
