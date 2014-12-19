package com.inspur.cams.sorg.manage.cmd;

import java.util.*;
import org.loushang.next.dao.*;
import org.loushang.next.data.*;
import org.loushang.next.web.cmd.*;

import com.inspur.cams.comm.util.BspUtil;
import com.inspur.cams.comm.util.IdHelp;
import com.inspur.cams.sorg.base.dao.jdbc.SomChangeDao;
import com.inspur.cams.sorg.base.data.SomChange;

/**
 * 社会组织变更信息业务cmd
 * @author yanliangliang
 * @date 2011-7-13
 */
public class SomChangeCommand extends BaseAjaxCommand{
	private SomChangeDao dao = (SomChangeDao) DaoFactory
			.getDao("com.inspur.cams.sorg.base.dao.jdbc.SomChangeDao");

	public void insert() {
		Record record = (Record) getParameter("record");
		SomChange dataBean=(SomChange)record.toBean(SomChange.class);
		dao.insert(dataBean);
	}

	public void update() {
		Record record = (Record) getParameter("record");
		SomChange dataBean=(SomChange)record.toBean(SomChange.class);
		dao.update(dataBean);
	}

	public void delete() {
		String[] delIds=(String[]) getParameter("delIds");
		dao.batchDelete(delIds);
	}
	public void save() {
		// get the Record Array from UI
		Record[] records = (Record[]) getParameter("records");
		List<SomChange> list = new ArrayList<SomChange>();
		for (int i = 0; i < records.length; i++) {
			// convert record to entity bean
			SomChange dataBean = (SomChange) records[i].toBean(SomChange.class);
			list.add(dataBean);
		}

		dao.save(list);
	}
	/**
	 * 变更修改中增加一条变更信息
	 */
	public void UpdateForInsert(){
		Record record = (Record) getParameter("record");
		SomChange dataBean=(SomChange)record.toBean(SomChange.class);
		dataBean.setId(IdHelp.getUUID30());
		dataBean.setMorgArea(BspUtil.getCorpOrgan().getOrganCode());
		dataBean.setMorgName( BspUtil.getCorpOrgan().getOrganName());
		dataBean.setChangeStatus("0");
		dao.insert(dataBean);
	}
}
