package com.inspur.cams.marry.base.cmd;

import java.util.ArrayList;
import java.util.List;

import org.loushang.next.dao.DaoFactory;
import org.loushang.next.data.Record;
import org.loushang.next.web.cmd.BaseAjaxCommand;
import org.loushang.sca.transaction.Trans;

import com.inspur.cams.comm.util.IdHelp;
import com.inspur.cams.marry.base.dao.jdbc.MrmResourcesInfoDao;
import com.inspur.cams.marry.base.data.MrmRegisArea;
import com.inspur.cams.marry.base.data.MrmResourcesInfo;

/**
 * @title:MrmResourcesInfoCommand
 * @description:
 * @author:
 * @since:2011-11-28
 * @version:1.0
*/
public class MrmResourcesInfoCommand extends BaseAjaxCommand{
	private MrmResourcesInfoDao dao = (MrmResourcesInfoDao) DaoFactory
			.getDao("com.inspur.cams.marry.base.dao.jdbc.MrmResourcesInfoDao");
	@Trans
	public void insert() {
		Record record = (Record) getParameter("record");
		MrmResourcesInfo dataBean=(MrmResourcesInfo)record.toBean(MrmResourcesInfo.class);
		if("".equals(dataBean.getResourceId())|| dataBean.getResourceId()==null){
			dataBean.setResourceId(IdHelp.getUUID32());
		}
		dao.insert(dataBean);
	}
	@Trans
	public void update() {
		Record record = (Record) getParameter("record");
		MrmResourcesInfo dataBean=(MrmResourcesInfo)record.toBean(MrmResourcesInfo.class);
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
		List<MrmResourcesInfo> list = new ArrayList<MrmResourcesInfo>();
		for (int i = 0; i < records.length; i++) {
			// convert record to entity bean
			MrmResourcesInfo dataBean = (MrmResourcesInfo) records[i].toBean(MrmResourcesInfo.class);
			if("".equals(dataBean.getResourceId()) || dataBean.getResourceId()==null){
				dataBean.setResourceId(IdHelp.getUUID32());
			}
			list.add(dataBean);
		}

		dao.save(list);
	}
}
