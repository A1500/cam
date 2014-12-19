package com.inspur.cams.marry.base.cmd;

import org.loushang.next.data.Record;
import org.loushang.next.web.cmd.BaseAjaxCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.marry.base.data.MrmOrganStandardApply;
import com.inspur.cams.marry.base.domain.IMrmOrganStandardApplyDomain;

/**
 * 婚姻登记机关等级评定标准业务表cmd
 * @author 
 * @date 2012-11-28
 */
public class MrmOrganStandardApplyCommand extends BaseAjaxCommand {

	private IMrmOrganStandardApplyDomain mrmOrganStandardApplyDomain = ScaComponentFactory
			.getService(IMrmOrganStandardApplyDomain.class, "mrmOrganStandardApplyDomain/mrmOrganStandardApplyDomain");
	
	// 增加
	public void insert() {
		Record record = (Record) getParameter("record");
		MrmOrganStandardApply mrmOrganStandardApply = (MrmOrganStandardApply) record.toBean(MrmOrganStandardApply.class);
		mrmOrganStandardApplyDomain.insert(mrmOrganStandardApply);
	}

	// 修改
	public void update() {
		Record record = (Record) getParameter("record");
		MrmOrganStandardApply mrmOrganStandardApply = (MrmOrganStandardApply) record.toBean(MrmOrganStandardApply.class);
		mrmOrganStandardApplyDomain.update(mrmOrganStandardApply);
	}
	
	// 删除
	public void delete() {
		String applyId = (String) getParameter("applyId");
		mrmOrganStandardApplyDomain.delete(applyId);
	}
	
}