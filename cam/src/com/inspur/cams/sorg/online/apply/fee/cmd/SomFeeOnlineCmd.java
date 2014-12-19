package com.inspur.cams.sorg.online.apply.fee.cmd;

import org.loushang.next.data.Record;
import org.loushang.next.web.cmd.BaseAjaxCommand;
import org.loushang.sca.ScaComponentFactory;
import com.inspur.cams.sorg.base.data.SomApply;
import com.inspur.cams.sorg.base.data.SomOrgan;
import com.inspur.cams.sorg.base.data.SomFee;
import com.inspur.cams.sorg.online.apply.fee.domain.ISomFeeOnlineDomain;

/**
 * 章程核准保存和修改
 * @author shgtch
 * @date 2011-10-8
 */
public class SomFeeOnlineCmd extends BaseAjaxCommand {

	private ISomFeeOnlineDomain somFeeOnlineDomain = ScaComponentFactory.getService(
			ISomFeeOnlineDomain.class, "somFeeOnlineDomain/somFeeOnlineDomain");

	// 插入
	public void insert() {
		Record somFeeRecord = (Record) getParameter("somFeeRecord");
		SomFee somFee = (SomFee) somFeeRecord.toBean(SomFee.class);
		Record somApplyRecord = (Record) getParameter("somApplyRecord");
		SomApply somApply = (SomApply) somApplyRecord.toBean(SomApply.class);
		Record somOrganRecord = (Record) getParameter("somOrganRecord");
		somApply.setSomOrgan((SomOrgan)somOrganRecord.toBean(SomOrgan.class));
		somFeeOnlineDomain.insertFeeApply(somApply, somFee);
	}

	// 更新
	public void update() {
		Record somFeeRecord = (Record) getParameter("somFeeRecord");
		SomFee somFee = (SomFee) somFeeRecord.toBean(SomFee.class);
		Record somApplyRecord = (Record) getParameter("somApplyRecord");
		SomApply somApply = (SomApply) somApplyRecord.toBean(SomApply.class);
		Record somOrganRecord = (Record) getParameter("somOrganRecord");
		somApply.setSomOrgan((SomOrgan)somOrganRecord.toBean(SomOrgan.class));
		somFeeOnlineDomain.updateFeeApply(somApply, somFee);
	}

}
