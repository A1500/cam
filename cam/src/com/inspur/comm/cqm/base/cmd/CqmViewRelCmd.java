package com.inspur.comm.cqm.base.cmd;

import java.util.ArrayList;
import java.util.List;

import org.loushang.next.data.Record;
import org.loushang.next.web.cmd.BaseAjaxCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.comm.cqm.base.data.CqmViewRel;
import com.inspur.comm.cqm.base.domain.ICqmViewRelDomain;

/**
 * 自定义统计报表模型视图关系cmd
 * @author shgtch
 * @date 2012-03-16
 */
public class CqmViewRelCmd extends BaseAjaxCommand {

	private ICqmViewRelDomain cqmViewRelDomain = ScaComponentFactory
			.getService(ICqmViewRelDomain.class, "cqmViewRelDomain/cqmViewRelDomain");

	// 保存
	public void save() {
		Record[] cqmViewRelArr = (Record[]) getParameter("records");
		List<CqmViewRel> cqmViewRelList = new ArrayList<CqmViewRel>();
		for (int i = 0; i < cqmViewRelArr.length; i++) {
			cqmViewRelList.add((CqmViewRel) cqmViewRelArr[i].toBean(CqmViewRel.class));
		}
		cqmViewRelDomain.save(cqmViewRelList);
	}

	// 增加
	public void insert() {
		Record record = (Record) getParameter("record");
		CqmViewRel cqmViewRel = (CqmViewRel) record.toBean(CqmViewRel.class);
		cqmViewRelDomain.insert(cqmViewRel);
	}

	// 修改
	public void update() {
		Record record = (Record) getParameter("record");
		CqmViewRel cqmViewRel = (CqmViewRel) record.toBean(CqmViewRel.class);
		cqmViewRelDomain.update(cqmViewRel);
	}
	
	// 删除
	public void delete() {
		String relId = (String) getParameter("relId");
		cqmViewRelDomain.delete(relId);
	}
	
}