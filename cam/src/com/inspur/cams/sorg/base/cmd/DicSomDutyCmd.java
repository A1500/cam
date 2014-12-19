package com.inspur.cams.sorg.base.cmd;

import java.util.ArrayList;
import java.util.List;

import org.loushang.next.data.Record;
import org.loushang.next.web.cmd.BaseAjaxCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.sorg.base.data.DicSomDuty;
import com.inspur.cams.sorg.base.domain.IDicSomDutyDomain;

/**
 * 社会组织职务cmd
 * @author Jiangzhaobao
 * @date 2011-6-18
 */
public class DicSomDutyCmd extends BaseAjaxCommand {
	
	private IDicSomDutyDomain somDutyDomain = ScaComponentFactory.getService(
			IDicSomDutyDomain.class, "dicSomDutyDomain/dicSomDutyDomain");

	public void saveDuty() {
		Record[] records = (Record[]) getParameter("somDutys");
		List<DicSomDuty> list = new ArrayList<DicSomDuty>();
		for (int i = 0; i < records.length; i++) {
			DicSomDuty somDuty = (DicSomDuty) records[i].toBean(DicSomDuty.class);
			list.add(somDuty);
		}
		somDutyDomain.save(list);
	}

}
