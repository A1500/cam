package com.inspur.cams.sorg.base.cmd;

import org.loushang.next.data.Record;
import org.loushang.next.web.cmd.BaseAjaxCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.comm.util.BspUtil;
import com.inspur.cams.sorg.base.data.SomBorg;
import com.inspur.cams.sorg.base.data.SomBorgChange;
import com.inspur.cams.sorg.base.domain.ISomBorgDomain;

/**
 * 业务主管单位相应操作
 * @author yanliangliang
 * @date 2011-6-8
 */
public class SomBorgCmd extends BaseAjaxCommand {
	
	private ISomBorgDomain somBorgDomain = ScaComponentFactory.getService(ISomBorgDomain.class, "somBorgDomain/somBorgDomain");

	public void execute() {
		Record[] records = (Record[]) getParameter("records");
		for (int i = 0; i < records.length; i++) {
			SomBorg somBorg = (SomBorg) records[i].toBean(SomBorg.class);
			if (records[i].getState() == Record.STATE_NEW) {
				insert(somBorg);
			} else if (records[i].getState() == Record.STATE_MODIFIED) {
				update(somBorg);
			}
		}
	}

	/**
	 * 添加一个业务主管单位
	 */
	public void insert(SomBorg somBorg) {
		somBorgDomain.insert(somBorg);
	}

	/**
	 * 修改一个业务主管单位
	 */
	public void update(SomBorg somBorg) {
		somBorgDomain.update(somBorg);
	}

	/**
	 * 获取当前登录信息
	 */
	public void getOnLine() {
		String UserName = BspUtil.getEmpOrgan().getOrganName();
		String CorpName = BspUtil.getCorpOrgan().getOrganName();
		String CorpCode = BspUtil.getCorpOrgan().getOrganCode();
		String CorpType = BspUtil.getCorpOrgan().getOrganType();
		setReturn("UserName", UserName);
		setReturn("CorpName", CorpName);
		setReturn("CorpCode", CorpCode);
		setReturn("CorpType", CorpType);
	}
	
	public void delete() {
		String[] delIds=(String[]) getParameter("delIds");
		somBorgDomain.batchDelete(delIds);
	}

	/**
	 * 业务主管单位变更
	 */
	public void changeBorg() {
		Record record = (Record) getParameter("record");
		Record changeRecord = (Record) getParameter("changeRecord");
		SomBorg somBorg = (SomBorg) record.toBean(SomBorg.class);
		SomBorgChange somBorgChange = (SomBorgChange) changeRecord.toBean(SomBorgChange.class);
		somBorg.setSomBorgChange(somBorgChange);
		somBorgDomain.changeBorg(somBorg);
	}
}
