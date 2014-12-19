package com.inspur.cams.bpt.bptinstitution.cmd;

import java.util.*;
import org.loushang.next.dao.*;
import org.loushang.next.data.*;
import org.loushang.next.web.cmd.*;
import org.loushang.sca.transaction.Trans;

import com.inspur.cams.bpt.bptinstitution.dao.jdbc.BptOtherprovideDao;
import com.inspur.cams.bpt.bptinstitution.data.BptOtherprovide;
import com.inspur.cams.comm.util.BspUtil;
import com.inspur.cams.comm.util.IdHelp;


/**
 * @title:BptOtherprovideCommand
 * @description:
 * @author:
 * @since:2011-12-05
 * @version:1.0
*/
public class BptOtherprovideCommand extends BaseAjaxCommand{
	private BptOtherprovideDao dao = (BptOtherprovideDao) DaoFactory
			.getDao("com.inspur.cams.bpt.bptinstitution.dao.jdbc.BptOtherprovideDao");
	@Trans
	public void insert() {
		Record record = (Record) getParameter("record");
		BptOtherprovide dataBean=(BptOtherprovide)record.toBean(BptOtherprovide.class);
		dataBean.setRegOrganCode(BspUtil.getOrganCode());
		dao.insert(dataBean);
	}
	@Trans
	public void update() {
		Record record = (Record) getParameter("record");
		BptOtherprovide dataBean=(BptOtherprovide)record.toBean(BptOtherprovide.class);
		dataBean.setRegOrganCode(BspUtil.getOrganCode());
		dao.update(dataBean);
	}
	@Trans
	public void delete() {
		String[] delIds=(String[]) getParameter("delIds");
		dao.batchDelete(delIds);
	}
	@Trans
	public void save() {
		// get the Record Array from UI
		Record[] records = (Record[]) getParameter("records");
		List<BptOtherprovide> list = new ArrayList<BptOtherprovide>();
		for (int i = 0; i < records.length; i++) {
			// convert record to entity bean
			BptOtherprovide dataBean = (BptOtherprovide) records[i].toBean(BptOtherprovide.class);
			dataBean.setRegOrganCode(BspUtil.getOrganCode());
			if ("".equals(records[i].get("id"))) {
				String id = IdHelp.getUUID30();
				dataBean.setId(id);
			}
			list.add(dataBean);
		}

		dao.save(list);
	}
}
