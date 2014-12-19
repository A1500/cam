package com.inspur.cams.drel.mbalance.cmd;

import java.util.*;
import org.loushang.next.dao.*;
import org.loushang.next.data.*;
import org.loushang.next.web.cmd.*;

import com.inspur.cams.comm.util.BspUtil;
import com.inspur.cams.comm.util.DateUtil;
import com.inspur.cams.comm.util.IdHelp;
import com.inspur.cams.drel.mbalance.dao.jdbc.SamMStatusDao;
import com.inspur.cams.drel.mbalance.data.SamMStatus;

/**
 * @title:SamMedicalStatusCommand
 * @description:救助状态Command
 * @author:luguosui
 * @since:2011-06-01
 * @version:1.0
*/
public class SamMStatusCmd extends BaseAjaxCommand{
	private SamMStatusDao dao = (SamMStatusDao) DaoFactory
			.getDao("com.inspur.cams.drel.mbalance.dao.jdbc.SamMStatusDao");

	public void insert() {
		Record record = (Record) getParameter("records");
		SamMStatus dataBean=(SamMStatus)record.toBean(SamMStatus.class);
		dataBean.setStatusId(IdHelp.getUUID30());
		dao.insert(dataBean);
	}

	public void update() {
		Record record = (Record) getParameter("records");
		SamMStatus dataBean=(SamMStatus)record.toBean(SamMStatus.class);
		dao.updateAss(dataBean);
	}

	public void delete() {
		String[] delIds=(String[]) getParameter("delIds");
		dao.batchDelete(delIds);
	}
	//保存住院停助信息
	public void save() {
		Record record = (Record) getParameter("records");
		List<SamMStatus> list = new ArrayList<SamMStatus>();
		SamMStatus dataBean = (SamMStatus) record.toBean(SamMStatus.class);
		dataBean.setStatusId(IdHelp.getUUID30());
		dataBean.setModId(BspUtil.getCorpOrgan().getOrganId());
		dataBean.setModOrgan(BspUtil.getCorpOrgan().getOrganName());
		dataBean.setModTime(DateUtil.getTime());
		list.add(dataBean);
		dao.save(list);
	}
}
