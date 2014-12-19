package com.inspur.cams.sorg.jxcheck.somjxcommonwealdetail.cmd;

import org.loushang.next.dao.DaoFactory;
import org.loushang.next.data.Record;
import org.loushang.next.web.cmd.BaseAjaxCommand;
import org.loushang.sca.transaction.Trans;

import com.inspur.cams.sorg.jxcheck.somjxcommonwealdetail.dao.SomJxCommonwealDetail;
import com.inspur.cams.sorg.jxcheck.somjxcommonwealdetail.dao.SomJxCommonwealDetailDao;
import com.inspur.sdmz.comm.util.IdHelp;

/**
 * @title:SomJxCommonwealDetailCommand
 * @description:
 * @author:
 * @since:2012-01-14
 * @version:1.0
*/
public class SomJxCommonwealDetailCommand extends BaseAjaxCommand{
	private SomJxCommonwealDetailDao dao = (SomJxCommonwealDetailDao) DaoFactory
			.getDao("com.inspur.cams.sorg.jxcheck.somjxcommonwealdetail.dao.SomJxCommonwealDetailDao");

	@Trans
	public void savePage10(){
		Record[] records = (Record[]) getParameter("records");
		String taskCode=(String) getParameter("taskCode");
		dao.deleteByTaskCode(taskCode);
		if(records!=null){
			for (int i = 0; i < records.length; i++) {
				SomJxCommonwealDetail  record = (SomJxCommonwealDetail) records[i].toBean(SomJxCommonwealDetail.class)	;
				record.setId(IdHelp.getUUID32());
				dao.insert(record);
			}
		}
	}
}
