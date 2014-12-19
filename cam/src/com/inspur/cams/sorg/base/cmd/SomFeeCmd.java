package com.inspur.cams.sorg.base.cmd;

import org.loushang.next.data.Record;
import org.loushang.next.web.cmd.BaseAjaxCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.sorg.base.data.SomApply;
import com.inspur.cams.sorg.base.data.SomFee;
import com.inspur.cams.sorg.base.data.SomRule;
import com.inspur.cams.sorg.base.domain.ISomFeeDomain;

/**
 * 会费备案保存和修改
 * @author shgtch
 * @date 2011-10-8
 */
public class SomFeeCmd extends BaseAjaxCommand {

	private ISomFeeDomain somFeeDomain = ScaComponentFactory.getService(ISomFeeDomain.class, "somFeeDomain/somFeeDomain");

	// 插入
	public void insert() {
		Record somFeeRecord = (Record) getParameter("somFeeRecord");
		SomFee somFee = (SomFee) somFeeRecord.toBean(SomFee.class);
		somFeeDomain.insert(somFee);
	}
	
	// 插入
	public void insertFeeAddApply() {
		Record somFeeRecord = (Record) getParameter("somFeeRecord");
		SomFee somFee = (SomFee) somFeeRecord.toBean(SomFee.class);
		somFeeDomain.insertFeeAddApply(somFee);
	}
	// 内网受理插入
	public void insertPre() {
		Record somFeeRecord = (Record) getParameter("somFeeRecord");
		SomFee somFee = (SomFee) somFeeRecord.toBean(SomFee.class);
		Record somApplyRecord = (Record) getParameter("somApplyRecord");
		SomApply somApply = (SomApply) somApplyRecord.toBean(SomApply.class);
		
		somFeeDomain.insertPre(somFee,somApply);
	}
	
	// 更新
	public void update() {
		Record somFeeRecord = (Record) getParameter("somFeeRecord");
		SomFee somFee = (SomFee) somFeeRecord.toBean(SomFee.class);
		somFeeDomain.update(somFee);
	}
	
	public void del() {
		String taskCode = (String) getParameter("taskCode");
		somFeeDomain.del(taskCode);
	}

}
