package com.inspur.comm.cqm.base.cmd;

import org.loushang.next.data.Record;
import org.loushang.next.web.cmd.BaseAjaxCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.comm.cqm.base.data.CqmUseCondition;
import com.inspur.comm.cqm.base.domain.ICqmUseConditionDomain;

/**
 * 自定义报表查询逻辑cmd
 * @author 
 * @date 2012-05-02
 */
public class CqmUseConditionCmd extends BaseAjaxCommand {

	private ICqmUseConditionDomain cqmUseConditionDomain = ScaComponentFactory
			.getService(ICqmUseConditionDomain.class, "cqmUseConditionDomain/cqmUseConditionDomain");
	
	// 增加
	public void insert() {
		Record record = (Record) getParameter("record");
		CqmUseCondition cqmUseCondition = (CqmUseCondition) record.toBean(CqmUseCondition.class);
		cqmUseConditionDomain.insert(cqmUseCondition);
	}

	// 修改
	public void update() {
		Record record = (Record) getParameter("record");
		CqmUseCondition cqmUseCondition = (CqmUseCondition) record.toBean(CqmUseCondition.class);
		cqmUseConditionDomain.update(cqmUseCondition);
	}
	
	// 删除
	public void delete() {
		String conditionId = (String) getParameter("conditionId");
		cqmUseConditionDomain.delete(conditionId);
	}
}