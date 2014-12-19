package com.inspur.cams.bpt.manage.cmd;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.web.cmd.BaseQueryCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.bpt.base.domain.IBptApplyHistoryDomain;

/**
 * 审批历史记录查询类
 * @author zhanghui
 *
 */
public class BptApplyHistoryQueryCommand extends BaseQueryCommand {
	
	/**
	 * 审批记录历史服务接口
	 */
	IBptApplyHistoryDomain bptApplyHistoryService = ScaComponentFactory.getService(IBptApplyHistoryDomain.class,
	"BptApplyHistoryDomain/BptApplyHistoryDomain");
	
	/**
	 * 查询审批记录历史记录
	 * @return
	 */
	public DataSet query() {
		ParameterSet pset = getParameterSet();
		return bptApplyHistoryService.query(pset);
	}

}
