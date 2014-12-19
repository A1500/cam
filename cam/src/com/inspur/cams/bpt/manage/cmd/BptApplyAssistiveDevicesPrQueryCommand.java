package com.inspur.cams.bpt.manage.cmd;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.web.cmd.BaseQueryCommand;
import org.loushang.sca.ScaComponentFactory;
import com.inspur.cams.bpt.base.domain.IBptApplyAssistiveDevicesPrDomain;
import com.inspur.cams.bpt.base.domain.IWfProcessBusinessDomain;

/**
 * @title:BptApplyAssistiveDevicesPrQueryCommand
 * @description:伤残辅助器械审批
 * @author:
 * @since:2011-06-07
 * @version:1.0
*/
public class BptApplyAssistiveDevicesPrQueryCommand extends BaseQueryCommand{

	/**
	 * 伤残辅助器械审批服务接口
	 */
	IBptApplyAssistiveDevicesPrDomain assistiveDevicesPrService = ScaComponentFactory.getService(IBptApplyAssistiveDevicesPrDomain.class,
	"bptApplyAssistiveDevicesPrDomain/bptApplyAssistiveDevicesPrDomain");
	
	/**
	 *  工作流信息的服务接口
	 */
	IWfProcessBusinessDomain processBusinessService = ScaComponentFactory.getService(IWfProcessBusinessDomain.class,
	"wfProcessBusinessDomain/wfProcessBusinessDomain");
	
	public DataSet execute() {
		ParameterSet pset = getParameterSet();
		return assistiveDevicesPrService.query(pset);
	}
	
	/**
	 * 查询伤残辅助器械审批
	 */
	public DataSet queryupdate(){
		ParameterSet pset = getParameterSet();
		DataSet	ds = assistiveDevicesPrService.query(pset);
		return ds;
	}
}
