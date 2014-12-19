package com.inspur.cams.bpt.manage.cmd;

import org.loushang.next.data.Record;
import org.loushang.next.web.cmd.BaseAjaxCommand;
import org.loushang.sca.ScaComponentFactory;
import org.loushang.sca.transaction.Trans;

import com.inspur.cams.bpt.base.data.BptApplyDisabilityNotice;
import com.inspur.cams.bpt.base.domain.IDisabilityNoticeDomain;

/**
 * 受理通知书添加
 */
public class BptApplyDisabilityNoticeCommand extends BaseAjaxCommand{
	
	/**
	 * 获得受理通知书服务接口
	 */
	private IDisabilityNoticeDomain disabilityNoticeService = ScaComponentFactory.getService(IDisabilityNoticeDomain.class,
	"disabilityNoticeDomain/disabilityNoticeDomain");
	
	/**
	 * 添加受理通知书
	 */
	@Trans
	public void update(){
		Record record = (Record) getParameter("DisabilityNoticeRecord");
		BptApplyDisabilityNotice dataBean = (BptApplyDisabilityNotice)record.toBean(BptApplyDisabilityNotice.class);
		disabilityNoticeService.update(dataBean);
	}
	
}