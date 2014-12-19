package com.inspur.cams.drel.config.assistance.cmd;

import org.loushang.next.data.Record;
import org.loushang.next.web.cmd.BaseAjaxCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.comm.util.IdHelp;
import com.inspur.cams.drel.config.assistance.data.SamAssistanceItem;
import com.inspur.cams.drel.config.assistance.domain.ISamAssistanceItemDomain;

/**
 * @title:救助项目cmd
 * @description:
 * @author:
 * @since:2012-05-29
 * @version:1.0
 */
public class SamAssistanceItemCmd extends BaseAjaxCommand {
	private ISamAssistanceItemDomain service = ScaComponentFactory.getService(ISamAssistanceItemDomain.class, "samAssistanceItemDomain/samAssistanceItemDomain");
	public void save(){
		Record assistanceItemRecord=(Record) getParameter("assistanceItemRecord");
		SamAssistanceItem samAssistanceItem=(SamAssistanceItem) assistanceItemRecord.toBean(SamAssistanceItem.class);
		String itemCode=samAssistanceItem.getItemCode();
		if (itemCode==null||"".equals(itemCode)) {
			samAssistanceItem.setItemCode(IdHelp.getUUID32());
			service.insert(samAssistanceItem);
		}else{
			service.update(samAssistanceItem);
		}
	}
}
